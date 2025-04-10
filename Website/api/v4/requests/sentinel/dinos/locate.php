<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Dino, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelSubscriptionRead;
	$requiredScopes[] = Application::kScopeSentinelServicesWrite;
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

	if (Service::TestUserPermissions($serviceId, Core::UserId()) === false) {
		return Response::NewJsonError(message: 'Dino not found', httpStatus: 404, code: 'notFound');
	}

	if ($service->IsConnected() === false) {
		return Response::NewJsonError(message: 'Service not connected', httpStatus: 412, code: 'serviceNotConnected');
	}

	$requestId = BeaconUUID::v4();
	$idParts = $dino->DinoNumberParts();
	$payload = [
		'requestId' => $requestId,
		'type' => 'locate',
		'dinoId1' => $idParts[0],
		'dinoId2' => $idParts[1],
	];

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($payload));

	return Response::NewJson([
		'requestId' => $requestId,
	], 200);
}
