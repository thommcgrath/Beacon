<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Character, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$characterId = $context['pathParameters']['characterId'];
	if (BeaconCommon::IsUUID($characterId) === false) {
		return Response::NewJsonError(message: 'Character ID must be a UUID', httpStatus: 400, code: 'invalidCharacterId');
	}

	$character = Character::Fetch($characterId);
	if (is_null($character)) {
		return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
	}

	$serviceId = $character->ServiceId();
	$service = Service::Fetch($serviceId);
	if (is_null($service)) {
		return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
	}

	if (Service::TestSentinelPermissions($serviceId, Core::UserId()) === false) {
		return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound');
	}

	if ($service->IsConnected() === false) {
		return Response::NewJsonError(message: 'Service not connected', httpStatus: 412, code: 'serviceNotConnected');
	}

	$requestId = BeaconUUID::v4();
	$payload = [
		'requestId' => $requestId,
		'type' => 'locate',
		'specimenId' => $character->SpecimenId(),
	];

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($payload));

	return Response::NewJson([
		'requestId' => $requestId,
	], 200);
}
