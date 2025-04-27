<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage, PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$body = Core::BodyAsJson();
	if (is_array($body) === false || BeaconCommon::HasAllKeys($body, 'scriptId', 'parameters') === false || BeaconCommon::HasAnyKeys($body, 'characterId', 'tribeId', 'dinoId', 'serviceId') === false) {
		return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. Must include scriptId, parameters, and a target identifier.');
	}

	$now = new DateTimeImmutable('now', new DateTimeZone('GMT'));
	$eventData = [
		'scriptId' => $body['scriptId'],
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'parameters' => [],
	];
	foreach ($body['parameters'] as $key => $value) {
		if (is_string($value) === false || empty($value) === false) {
			$eventData['parameters'][$key] = $value;
		}
	}

	$database = BeaconCommon::Database();
	$scriptId = $body['scriptId'];
	$rows = $database->Query('SELECT scripts.context, scripts.name, scripts.parameters FROM sentinel.scripts INNER JOIN sentinel.script_permissions ON (scripts.script_id = script_permissions.script_id AND script_permissions.user_id = $1) WHERE scripts.script_id = $2 AND (script_permissions.permissions & $3) = $3;', Core::UserId(), $scriptId, PermissionBits::Membership);
	if ($rows->RecordCount() === 1) {
		$eventData['event'] = $rows->Field('context');
		$eventData['scriptName'] = $rows->Field('name');
		$parameters = json_decode($rows->Field('parameters'), true);
		foreach ($parameters as $parameter) {
			$parameterName = $parameter['name'];
			$parameterValue = $body['parameters'][$parameterName] ?? null;
			switch ($parameter['type']) {
			case 'String':
				if (trim(strval($parameterValue)) === '') {
					$parameterValue = null;
				}
				break;
			}
			$eventData['parameters'][$parameterName] = $parameterValue ?? $parameter['default'];
		}
		$eventData['parameters'] = (object) $eventData['parameters'];
	} else {
		return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'Script not found');
	}

	if (isset($body['serviceId'])) {
		$rows = $database->Query('SELECT services.cluster_id FROM sentinel.services INNER JOIN sentinel.service_permissions ON (services.service_id = service_permissions.service_id AND service_permissions.user_id = $1) WHERE services.service_id = $2 AND (service_permissions.permissions & $3) = $3;', Core::UserId(), $body['serviceId'], PermissionBits::ControlServices);
		if ($rows->RecordCount() === 1) {
			$serviceId = $body['serviceId'];
			$clusterId = $rows->Field('cluster_id');
		} else {
			return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'Service not found');
		}
	} elseif (isset($body['characterId'])) {
		$rows = $database->Query('SELECT services.service_id, services.cluster_id FROM sentinel.characters INNER JOIN sentinel.services ON (characters.service_id = services.service_id) INNER JOIN sentinel.service_permissions ON (services.service_id = service_permissions.service_id AND service_permissions.user_id = $1) WHERE characters.character_id = $2 AND (service_permissions.permissions & $3) = $3;', Core::UserId(), $body['characterId'], PermissionBits::ControlServices);
		if ($rows->RecordCount() === 1) {
			$serviceId = $rows->Field('service_id');
			$clusterId = $rows->Field('cluster_id');
			$eventData['characterId'] = $body['characterId'];
		} else {
			return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'Character not found');
		}
	} elseif (isset($body['tribeId'])) {
		$rows = $database->Query('SELECT services.service_id, services.cluster_id FROM sentinel.tribes INNER JOIN sentinel.services ON (tribes.service_id = services.service_id) INNER JOIN sentinel.service_permissions ON (services.service_id = service_permissions.service_id AND service_permissions.user_id = $1) WHERE tribes.tribe_id = $2 AND (service_permissions.permissions & $3) = $3;', Core::UserId(), $body['tribeId'], PermissionBits::ControlServices);
		if ($rows->RecordCount() === 1) {
			$serviceId = $rows->Field('service_id');
			$clusterId = $rows->Field('cluster_id');
			$eventData['tribeId'] = $body['tribeId'];
		} else {
			return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'Tribe not found');
		}
	} elseif (isset($body['dinoId'])) {
		$rows = $database->Query('SELECT services.service_id, services.cluster_id FROM sentinel.dinos INNER JOIN sentinel.services ON (dinos.service_id = services.service_id) INNER JOIN sentinel.service_permissions ON (services.service_id = service_permissions.service_id AND service_permissions.user_id = $1) WHERE dinos.dino_id = $2 AND (service_permissions.permissions & $3) = $3;', Core::UserId(), $body['dinoId'], PermissionBits::ControlServices);
		if ($rows->RecordCount() === 1) {
			$serviceId = $rows->Field('service_id');
			$clusterId = $rows->Field('cluster_id');
			$eventData['dinoId'] = $body['dinoId'];
		} else {
			return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'Dino not found');
		}
	}

	try {
		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.service_event_queue (service_id, cluster_id, queue_time, version, event_data) VALUES ($1, $2, CURRENT_TIMESTAMP, $3, $4);', $serviceId, $clusterId, 1, json_encode($eventData));
		$database->Commit();
	} catch (Exception $err) {
		return Response::NewJsonError(code: 'internalServerError', httpStatus: 500, message: $err->getMessage());
	}

	return Response::NewNoContent();
}

?>
