<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, Group};

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

		if (in_array($command['type'], $whitelist) === false) {
			return Response::NewJsonError(code: 'badRequest', message: 'Command type is not valid.', details: $command, httpStatus: 400);
		}

		if (array_key_exists('serviceId', $command)) {
			$serviceId = $command['serviceId'];
			if (approveService($serviceId, $userId, $approvedServiceIds, $database)) {
				$approvedCommands[] = $command;
			} else {
				return Response::NewJsonError(code: 'forbidden', message: 'You do not have permission to control this service.', details: $command, httpStatus: 403);
			}
		} elseif (array_key_exists('groupId', $command)) {
			$groupId = $command['groupId'];
			if (in_array($groupId, $approvedGroupIds) === false) {
				if (is_null($database)) {
					$database = BeaconCommon::Database();
				}

				$rows = $database->Query('SELECT services.service_id FROM sentinel.group_services INNER JOIN sentinel.services ON (group_services.service_id = services.service_id) WHERE group_services.group_id = $1 AND services.deleted = FALSE;', $groupId);
				while (!$rows->EOF()) {
					$serviceId = $rows->Field('service_id');
					if (approveService($serviceId, $userId, $approvedServiceIds, $database)) {
						unset($command['groupId']);
						$command['serviceId'] = $serviceId;
						$approvedCommands[] = $command;
					} else {
						return Response::NewJsonError(code: 'forbidden', message: 'You do not have permission to control a service in this group.', details: $command, httpStatus: 403);
					}
					$rows->MoveNext();
				}

				$approvedGroupIds[] = $groupId;
			}
		}
	}

	foreach ($approvedCommands as $command) {
		$serviceId = strtolower($command['serviceId']);
		unset($command['serviceId']);
		BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($command));
	}

	return Response::NewNoContent();
}

function approveService(string $serviceId, string $userId, array &$approvedServiceIds, ?BeaconDatabase &$database) {
	if (in_array($serviceId, $approvedServiceIds)) {
		return true;
	}

	if (is_null($database)) {
		$database = BeaconCommon::Database();
	}

	$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $serviceId, $userId);
	if ($rows->RecordCount() === 0 || ($rows->Field('permissions') & Service::ServicePermissionControl) === 0) {
		return false;
	}
	$approvedServiceIds[] = $serviceId;
	return true;
}

?>
