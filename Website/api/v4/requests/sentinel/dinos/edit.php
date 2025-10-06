<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Dino, PermissionBits, Service};

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

	if ($service->IsConnected() === false) {
		return Response::NewJsonError(message: 'Service not connected', httpStatus: 412, code: 'serviceNotConnected');
	}

	$requestId = BeaconUUID::v4();
	$idParts = $dino->DinoNumberParts();
	$payload = [
		'requestId' => $requestId,
		'type' => 'editDino',
		'dinoId1' => $idParts[0],
		'dinoId2' => $idParts[1],
	];

	$changesMade = false;
	$body = Core::BodyAsJson();
	$whitelist = ['isSterilized', 'isFemale'];
	foreach ($whitelist as $key) {
		if (array_key_exists($key, $body)) {
			$payload[$key] = $body[$key];
			$changesMade = true;
		}
	}

	if (!$changesMade) {
		return Response::NewJsonError(message: 'Object does not contain any approved values', httpStatus: 400, code: 'noApprovedKeys');
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($payload));

	return Response::NewJson([
		'requestId' => $requestId,
	], 200);
}
