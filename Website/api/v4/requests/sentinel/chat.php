<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$command = Core::BodyAsJSON();
	if (array_key_exists('message', $command) === false) {
		return Response::NewJsonError(code: 'missingMessage', message: 'Must include a message value.', details: $command, httpStatus: 400);
	}
	$chatMessage = $command['message'];
	$senderName = $command['senderName'] ?? 'Server';
	$database = BeaconCommon::Database();

	$userId = Core::UserId();
	if (array_key_exists('serviceId', $command)) {
		$serviceId = $command['serviceId'];
		if (ApproveService($serviceId, $userId, PermissionBits::Membership, $database) === false) {
			return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on service {$serviceId}.", details: $command, httpStatus: 403);
		}

		$originType = 'WebService';
		$originId = $serviceId;
	} elseif (array_key_exists('groupId', $command)) {
		$groupId = $command['groupId'];
		if (ApproveGroup($groupId, $userId, PermissionBits::Membership, $database) === false) {
			return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on group {$groupId}.", details: $command, httpStatus: 403);
		}

		if (is_null($database)) {
			$database = BeaconCommon::Database();
		}

		$rows = $database->Query('SELECT services.service_id FROM sentinel.group_services INNER JOIN sentinel.services ON (group_services.service_id = services.service_id) WHERE group_services.group_id = $1;', $groupId);
		while (!$rows->EOF()) {
			$serviceId = $rows->Field('service_id');
			if (ApproveService($serviceId, $userId, PermissionBits::Membership, $database) === false) {
				return Response::NewJsonError(code: 'forbidden', message: "You do not have the correct permissions on service {$serviceId}.", details: $command, httpStatus: 403);
			}
			$rows->MoveNext();
		}

		$originType = 'WebGroup';
		$originId = $groupId;
	} else {
		return Response::NewJsonError(code: 'missingTargetId', message: 'Command must include serviceId or groupId.', details: $command, httpStatus: 400);
	}

	$now = microtime(true);
	$messageId = BeaconUUID::v7($now * 1000);
	$senderInfo = [
		'pusherSocketId' => BeaconPusher::SocketIdFromHeaders(),
		'userId' => $userId,
	];

	$database->BeginTransaction();
	$database->Query('INSERT INTO sentinel.chat_message_queue (message_id, origin_type, origin_id, sender_name, sender_info, scope, message_content, message_time) VALUES ($1, $2, $3, $4, $5, $6, $7, TO_TIMESTAMP($8));', $messageId, $originType, $originId, $senderName, json_encode($senderInfo, JSON_UNESCAPED_SLASHES), 'Global', $chatMessage, $now);
	$database->Commit();

	return Response::NewNoContent();
}

function ApproveService(string $serviceId, string $userId, int $requiredPermissions, BeaconDatabase $database): bool {
	$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $serviceId, $userId);
	$permissions = $rows->RecordCount() === 1 ? $rows->Field('permissions') : 0;
	return ($permissions & $requiredPermissions) === $requiredPermissions;
}

function ApproveGroup(string $groupId, string $userId, int $requiredPermissions, BeaconDatabase $database): bool {
	$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $groupId, $userId);
	$permissions = $rows->RecordCount() === 1 ? $rows->Field('permissions') : 0;
	return ($permissions & $requiredPermissions) === $requiredPermissions;
}

?>
