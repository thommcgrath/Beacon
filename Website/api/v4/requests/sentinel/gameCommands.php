<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$commands = [];
	$command = Core::BodyAsJSON();
	if (BeaconCommon::IsAssoc($command)) {
		$commands[] = $command;
	} elseif (is_array($command)) {
		$commands = $command;
	} else {
		return Response::NewJsonError(code: 'badRequest', message: 'Must send a JSON object or array of objects.', details: $command, httpStatus: 400);
	}
	if (count($commands) === 0) {
		return Response::NewJsonError(code: 'noObjects', message: 'No objects to delete.', httpStatus: 400);
	}

	$whitelist = ['admin', 'chat', 'locate', 'renamePlayer', 'giveItem'];
	$permissions = [
		'admin' => PermissionBits::ControlServices,
		'chat' => PermissionBits::Membership,
		'locate' => PermissionBits::ControlServices,
		'renamePlayer' => PermissionBits::ControlServices,
		'giveItem' => PermissionBits::ControlServices,
	];
	$approvedServiceIds = [];
	$approvedGroupIds = [];
	$approvedCommands = [];
	$database = null;
	$userId = Core::UserId();
	foreach ($commands as $command) {
		if (BeaconCommon::IsAssoc($command) === false) {
			return Response::NewJsonError(code: 'badRequest', message: 'Array member is not a JSON object.', details: $command, httpStatus: 400);
		}

		if (BeaconCommon::HasAnyKeys($command, 'serviceId', 'groupId') === false) {
			return Response::NewJsonError(code: 'badRequest', message: 'Command must include serviceId or groupId.', details: $command, httpStatus: 400);
		}

		if (BeaconCommon::HasAllKeys($command, 'type') === false) {
			return Response::NewJsonError(code: 'badRequest', message: 'Command must include a type key.', details: $command, httpStatus: 400);
		}

		if (array_key_exists($command['type'], $permissions) === false) {
			return Response::NewJsonError(code: 'badRequest', message: 'Command type is not valid.', details: $command, httpStatus: 400);
		}

		if (array_key_exists('serviceId', $command)) {
			$serviceId = $command['serviceId'];
			if (ApproveService($serviceId, $userId, $permissions[$command['type']], $approvedServiceIds, $database) === false) {
				return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on service {$serviceId}.", details: $command, httpStatus: 403);
			}

			$approvedCommands[] = $command;
		} elseif (array_key_exists('groupId', $command)) {
			$groupId = $command['groupId'];
			if (ApproveGroup($groupId, $userId, $permissions[$command['type']], $approvedGroupIds, $database) === false) {
				return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on group {$groupId}.", details: $command, httpStatus: 403);
			}

			if (is_null($database)) {
				$database = BeaconCommon::Database();
			}

			$rows = $database->Query('SELECT services.service_id FROM sentinel.group_services INNER JOIN sentinel.services ON (group_services.service_id = services.service_id) WHERE group_services.group_id = $1;', $groupId);
			while (!$rows->EOF()) {
				$serviceId = $rows->Field('service_id');
				if (ApproveService($serviceId, $userId, $permissions[$command['type']], $approvedServiceIds, $database) === false) {
					return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on service {$serviceId}.", details: $command, httpStatus: 403);
				}

				unset($command['groupId']);
				$command['serviceId'] = $serviceId;
				$approvedCommands[] = $command;
				$rows->MoveNext();
			}
		}
	}

	$chatLogTranslations = [
		'en' => 'Server said: `{message}`',
	];

	$events = [];
	$socketId = BeaconPusher::SocketIdFromHeaders();
	foreach ($approvedCommands as $command) {
		$serviceId = strtolower($command['serviceId']);
		unset($command['serviceId']);

		if ($command['type'] === 'chat') {
			if ($database->InTransaction() === false) {
				$database->BeginTransaction();
			}

			$messageId = BeaconUUID::v7();
			$languageCode = $command['languageCode'] ?? 'en';
			$senderName = ($command['senderName'] ?? 'Server');
			$message = $command['message'];
			$metadata = [
				'originalMessage' => $message,
				'originalLanguage' => $languageCode,
				'senderName' => $senderName,
				'userId' => $userId,
			];
			$database->Query('INSERT INTO sentinel.service_logs (message_id, service_id, log_time, event_name, level, analyzer_status, metadata, type) VALUES ($1, $2, CURRENT_TIMESTAMP, $3, $4, $5, $6, $7);', $messageId, $serviceId, 'chat', 'Informational', 'Skipped', json_encode($metadata), 'Gameplay');
			$database->Query('INSERT INTO sentinel.service_log_messages (message_id, language, message) VALUES ($1, $2, $3);', $messageId, $languageCode, str_replace('{message}', $message, $chatLogTranslations[$languageCode]));

			$eventBody = [
				'originalMessage' => $message,
				'senderName' => $senderName,
				'translations' => [
					$languageCode => $message,
				],
				'userId' => $userId,
			];
			$event = new BeaconChannelEvent(channelName: 'sentinel.services.' . str_replace('-', '', $serviceId), eventName: 'chatMessage', body: $eventBody, socketId: $socketId);
			$eventSignature = $event->Signature();
			if (array_key_exists($eventSignature, $events) === false) {
				$events[$eventSignature] = $event;
			}

			$rows = $database->Query('SELECT group_id FROM sentinel.group_services WHERE service_id = $1;', $serviceId);
			while (!$rows->EOF()) {
				$groupId = $rows->Field('group_id');

				$event = new BeaconChannelEvent(channelName: 'sentinel.groups.' . str_replace('-', '', $groupId), eventName: 'chatMessage', body: $eventBody, socketId: $socketId);
				$eventSignature = $event->Signature();
				if (array_key_exists($eventSignature, $events) === false) {
					$events[$eventSignature] = $event;
				}

				$rows->MoveNext();
			}
		}

		BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($command));
	}
	if ($database->InTransaction() === true) {
		$database->Commit();
	}

	BeaconPusher::SharedInstance()->SendEvents(array_values($events));

	return Response::NewNoContent();
}

function ApproveService(string $serviceId, string $userId, int $requiredPermissions, array &$approvedServiceIds, ?BeaconDatabase &$database): bool {
	if (array_key_exists($serviceId, $approvedServiceIds)) {
		$permissions = $approvedServiceIds[$serviceId];
	} else {
		if (is_null($database)) {
			$database = BeaconCommon::Database();
		}
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $serviceId, $userId);
		$permissions = $rows->RecordCount() === 1 ? $rows->Field('permissions') : 0;
		$approvedServiceIds[$serviceId] = $permissions;
	}
	return ($permissions & $requiredPermissions) === $requiredPermissions;
}

function ApproveGroup(string $groupId, string $userId, int $requiredPermissions, array &$approvedGroupIds, ?BeaconDatabase &$database): bool {
	if (array_key_exists($groupId, $approvedGroupIds)) {
		$permissions = $approvedGroupIds[$groupId];
	} else {
		if (is_null($database)) {
			$database = BeaconCommon::Database();
		}
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $groupId, $userId);
		$permissions = $rows->RecordCount() === 1 ? $rows->Field('permissions') : 0;
		$approvedGroupIds[$groupId] = $permissions;
	}
	return ($permissions & $requiredPermissions) === $requiredPermissions;
}

?>
