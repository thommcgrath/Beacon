<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage, PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$scriptEventId = $context['pathParameters']['scriptEventId'];
	if (BeaconUUID::Validate($scriptEventId) === false) {
		return Response::NewJsonError(code: 'badEventId', httpStatus: 400, message: 'scriptEventId must be a UUID.');
	}

	$body = Core::BodyAsJson();
	if (is_array($body) === false) {
		$body = [];
	}

	$serviceId = $body['serviceId'] ?? '';
	if (BeaconUUID::Validate($serviceId) === false) {
		return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. serviceId is empty or not a UUID.');
	}

	$service = Service::Fetch($serviceId);
	if (is_null($service) || Service::TestSentinelPermissions($serviceId, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices) === false) {
		return Response::NewJsonError(code: 'serviceNotFound', httpStatus: 404, message: 'Service not found.');
	}

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT name, menu_text, context, parameters, parameter_values FROM sentinel.active_scripts WHERE service_id = $1 AND script_event_id = $2 LIMIT 1;', $serviceId, $scriptEventId);
	if ($rows->RecordCount() !== 1) {
		return Response::NewJsonError(code: 'eventNotFound', httpStatus: 404, message: 'Script event does not exist.');
	}
	$context = $rows->Field('context');
	$scriptName = $rows->Field('name');
	$menuText = $rows->Field('menu_text');
	$parameterDefinitions = json_decode($rows->Field('parameters'), true);
	$parameterValues = json_decode($rows->Field('parameter_values'), true);

	$parameters = [];
	foreach ($parameterDefinitions as $definition) {
		$parameters[$definition['name']] = $definition['default'];
	}
	foreach ($parameterValues as $parameterName => $value) {
		if (array_key_exists($parameterName, $parameters)) {
			$parameters[$parameterName] = $value;
		}
	}
	$parameterOverrides = $body['parameters'] ?? [];
	foreach ($parameterOverrides as $parameterName => $value) {
		if (array_key_exists($parameterName, $parameters) && (is_string($value) === false || empty($value) === false)) {
			$parameters[$parameterName] = $value;
		}
	}

	$now = new DateTimeImmutable('now', new DateTimeZone('GMT'));
	$user = Core::User();
	$eventData = [
		'scriptEventId' => $scriptEventId,
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'parameters' => (object)$parameters,
		'event' => $context,
		'userId' => $user->UserId(),
		'username' => $user->Username(true),
		'scriptName' => $scriptName,
		'menuText' => $menuText,
	];

	switch ($context) {
	case LogMessage::EventManualCharacterScript:
		$characterId = $body['characterId'] ?? '';
		if (BeaconUUID::Validate($characterId) === false) {
			return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. characterId is empty or not a UUID.');
		}
		$rows = $database->Query('SELECT service_id FROM sentinel.characters WHERE character_id = $1;', $characterId);
		if ($rows->RecordCount() !== 1 || $rows->Field('service_id') !== $serviceId) {
			return Response::NewJsonError(code: 'targetNotFound', httpStatus: 404, message: 'Character not found.');
		}
		$eventData['characterId'] = $characterId;
		break;
	case LogMessage::EventManualDinoScript:
		$dinoId = $body['dinoId'] ?? '';
		if (BeaconUUID::Validate($dinoId) === false) {
			return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. dinoId is empty or not a UUID.');
		}
		$rows = $database->Query('SELECT service_id FROM sentinel.dinos WHERE dino_id = $1;', $dinoId);
		if ($rows->RecordCount() !== 1 || $rows->Field('service_id') !== $serviceId) {
			return Response::NewJsonError(code: 'targetNotFound', httpStatus: 404, message: 'Dino not found.');
		}
		$eventData['dinoId'] = $dinoId;
		break;
	case LogMessage::EventManualServiceScript:
		break;
	case LogMessage::EventManualTribeScript:
		$tribeId = $body['tribeId'] ?? '';
		if (BeaconUUID::Validate($tribeId) === false) {
			return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. tribeId is empty or not a UUID.');
		}
		$rows = $database->Query('SELECT service_id FROM sentinel.tribes WHERE tribe_id = $1;', $tribeId);
		if ($rows->RecordCount() !== 1 || $rows->Field('service_id') !== $serviceId) {
			return Response::NewJsonError(code: 'targetNotFound', httpStatus: 404, message: 'Tribe not found.');
		}
		$eventData['tribeId'] = $tribeId;
		break;
	default:
		return Response::NewJsonError(code: 'badContext', httpStatus: 500, message: 'Unknown event context.');
	}

	$database->BeginTransaction();
	$database->Query('INSERT INTO sentinel.service_event_queue (service_id, queue_time, version, event_data) VALUES ($1, CURRENT_TIMESTAMP, $2, $3);', $serviceId, 1, json_encode($eventData));
	$database->Commit();

	return Response::NewNoContent();
}

?>
