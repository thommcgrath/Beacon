<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Character, Dino, LogMessage, PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$dinoId = $context['pathParameters']['dinoId'];
	if (BeaconCommon::IsUUID($dinoId) === false) {
		return Response::NewJsonError(message: 'Dino ID must be a UUID', httpStatus: 400, code: 'invalidDinoId');
	}

	$dino = Dino::Fetch($dinoId);
	if (is_null($dino)) {
		return Response::NewJsonError(message: 'Dino not found', httpStatus: 404, code: 'notFound');
	}

	$serviceId = $dino->ServiceId();
	$service = Service::Fetch($serviceId);
	if (is_null($service)) {
		return Response::NewJsonError(message: 'Dino not found', httpStatus: 404, code: 'notFound');
	}

	if (Service::TestSentinelPermissions($serviceId, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices) === false) {
		return Response::NewJsonError(message: 'Dino not found', httpStatus: 404, code: 'notFound');
	}

	if ($dino->RestoreEligible() === false) {
		return Response::NewJsonError(message: 'Restore is not available for this dino', httpStatus: 412, code: 'restoreNotAvailable');
	}

	$body = Core::BodyAsJson();
	if (BeaconCommon::HasAllKeys($body, 'characterId') === false) {
		return Response::NewJsonError(message: 'Missing character', httpStatus: 400, code: 'characterNotSpecified');
	}

	$characterId = $body['characterId'];
	if (BeaconCommon::IsUUID($characterId) === false) {
		return Response::NewJsonError(message: 'Character ID must be a UUID', httpStatus: 400, code: 'invalidCharacterId');
	}
	$character = Character::Fetch($characterId);
	if (is_null($character)) {
		return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
	}

	if ($character->ServiceId() !== $dino->ServiceId()) {
		// Need to switch to this service, but checking permission of the dino was still important
		$serviceId = $character->ServiceId();
		$service = Service::Fetch($serviceId);
		if (is_null($service)) {
			return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
		}

		if (Service::TestSentinelPermissions($serviceId, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices) === false) {
			return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
		}
	}

	if ($service->IsConnected() === false) {
		return Response::NewJsonError(message: 'Service not connected', httpStatus: 412, code: 'serviceNotConnected');
	}

	$now = new DateTimeImmutable();
	$event = [
		'event' => 'dinoRestored',
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'dinoId' => $dinoId,
		'characterId' => $characterId,
	];

	// Add it to the event queue
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$rows = $database->Query('INSERT INTO sentinel.service_event_queue (service_id, version, event_data) VALUES ($1, $2, $3) RETURNING queue_id;', $serviceId, 1, json_encode($event, JSON_UNESCAPED_SLASHES));
	$database->Commit();

	return Response::NewJson([
		'requestId' => $rows->Field('queue_id'),
	], 200);
}
