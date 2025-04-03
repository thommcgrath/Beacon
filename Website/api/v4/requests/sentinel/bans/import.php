<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, PermissionBits};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelSubscriptionRead;
	$requiredScopes[] = Application::kScopeSentinelServicesWrite;
}

function handleRequest(array $context): Response {
	if (isset($context['pathParameters']['serviceId'])) {
		$isService = true;
		$serviceId = $context['pathParameters']['serviceId'];
		if (BeaconCommon::IsUUID($serviceId) === false) {
			return Response::NewJsonError(message: 'That\'s not a Beacon Sentinel server ID.', httpStatus: 400);
		}
	} elseif (isset($context['pathParameters']['groupId'])) {
		$isService = false;
		$groupId = $context['pathParameters']['groupId'];
		if (BeaconCommon::IsUUID($groupId) === false) {
			return Response::NewJsonError(message: 'That\'s not a Beacon Sentinel group ID.', httpStatus: 400);
		}
	} else {
		return Response::NewJsonError(message: 'Internal Server Error', httpStatus: 500);
	}

	$userId = Core::UserId();
	$serviceIds = [];
	$database = BeaconCommon::Database();
	if ($isService) {
		$rows = $database->Query('SELECT services.service_id, services.is_connected FROM sentinel.service_permissions INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE services.service_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) > 0;', $serviceId, $userId, PermissionBits::ControlServices);
		if ($rows->RecordCount() !== 1) {
			return Response::NewJsonError(message: 'You do not have access to this service.', httpStatus: 403, code: 'forbidden');
		}
		if ($rows->Field('is_connected')) {
			$serviceIds[] = $serviceId;
		}
	} else {
		$rows = $database->Query('SELECT service_permissions.service_id, services.is_connected FROM sentinel.service_permissions INNER JOIN sentinel.group_services ON (service_permissions.service_id = group_services.service_id) INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE group_services.group_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) > 0;', $groupId, $userId, PermissionBits::ControlServices);
		if ($rows->RecordCount() === 0) {
			return Response::NewJsonError(message: 'You do not have access to this group.', httpStatus: 403, code: 'forbidden');
		}
		while (!$rows->EOF()) {
			if ($rows->Field('is_connected')) {
				$serviceIds[] = $rows->Field('service_id');
			}
			$rows->MoveNext();
		}
	}

	$rawText = Core::Body();
	$rawText = str_replace("\r\n", "\n", $rawText);
	$rawText = str_replace("\r", "\n", $rawText);
	$lines = explode("\n", $rawText);
	$bans = [];
	$now = time();
	foreach ($lines as $line) {
		if (preg_match('/^(0002[0-9A-Fa-f]{28})(,(.*?))??(,(\d+))?$/', $line, $matches) !== 1) {
			continue;
		}

		$epicId = $matches[1];
		if (isset($matches[3]) && empty($matches[3]) === false) {
			$comments = 'Imported ban for ' . $matches[3];
		} else {
			$comments = 'Imported ban';
		}
		if (isset($matches[5]) && empty($matches[5]) === false) {
			$expiration = intval($matches[5]);
		} else {
			$expiration = null;
		}
		if ($expiration === 0) {
			$expiration = null;
		}
		if (is_null($expiration) === false && $expiration <= $now) {
			// Already expired, skip it
			continue;
		}

		$ban = [
			'playerId' => $epicId,
			'comments' => $comments,
			'expiration' => $expiration,
		];
		if ($isService) {
			$ban['serviceId'] = $serviceId;
		} else {
			$ban['groupId'] = $groupId;
		}
		$bans[] = $ban;
	}

	if (count($bans) === 0) {
		return Response::NewJsonError(message: 'No non-expired bans found.', httpStatus: 400, code: 'noValidLines');
	}

	// Remember the bans for each affected server
	$previousPlayers = [];
	foreach ($serviceIds as $id) {
		$playerIds = [];
		$rows = $database->Query('SELECT DISTINCT player_identifiers.identifier FROM sentinel.active_bans INNER JOIN sentinel.player_identifiers ON (active_bans.player_id = player_identifiers.player_id) WHERE active_bans.service_id = $1;', $id);
		while (!$rows->EOF()) {
			$playerIds[] = $rows->Field('identifier');
			$rows->MoveNext();
		}
		$previousPlayers[$id] = $playerIds;
	}

	// Commit the bans
	$database->BeginTransaction();
	try {
		foreach ($bans as $ban) {
			if ($isService) {
				$database->Query('INSERT INTO sentinel.service_bans (service_id, player_id, expiration, comments) VALUES ($1, sentinel.get_player_id($2, TRUE), TO_TIMESTAMP($3), $4) ON CONFLICT (service_id, player_id) DO NOTHING;', $serviceId, $ban['playerId'], $ban['expiration'], $ban['comments']);
			} else {
				$database->Query('INSERT INTO sentinel.group_bans (group_id, player_id, expiration, issued_by, issuer_comments) VALUES ($1, sentinel.get_player_id($2, TRUE), TO_TIMESTAMP($3), $4, $5) ON CONFLICT (group_id, player_id) DO NOTHING;', $groupId, $ban['playerId'], $ban['expiration'], $userId, $ban['comments']);
			}
		}
	} catch (Exception $err) {
		$database->Rollback();
		return Response::NewJsonError(message: 'Something went wrong.', httpStatus: 500, code: 'serverError');
	}
	$database->Commit();

	// Now we can look figure out which bans are actually new
	foreach ($serviceIds as $id) {
		$newPlayerIds = [];
		$rows = $database->Query('SELECT DISTINCT player_identifiers.identifier FROM sentinel.active_bans INNER JOIN sentinel.player_identifiers ON (active_bans.player_id = player_identifiers.player_id) WHERE active_bans.service_id = $1;', $id);
		while (!$rows->EOF()) {
			$newPlayerIds[] = $rows->Field('identifier');
			$rows->MoveNext();
		}

		$delta = array_diff($newPlayerIds, $previousPlayers[$id]);
		if (count($delta) === 0) {
			continue;
		}

		foreach ($delta as $epicId) {
			$message = [
				'type' => 'admin',
				'command' => 'banplayer ' . $epicId,
			];
			BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $id . '.gameCommand', json_encode($message));
		}
	}

	return Response::NewNoContent();
}

?>
