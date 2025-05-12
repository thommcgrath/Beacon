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

	$requestId = BeaconUUID::v4();
	$payload = [
		'requestId' => $requestId,
		'type' => 'giveItem',
		'specimenId' => $character->SpecimenId(),
		'itemPath' => '/Game/Extinction/CoreBlueprints/Weapons/PrimalItem_WeaponEmptyCryopod.PrimalItem_WeaponEmptyCryopod',
		'quantity' => 1,
		'customItemData' => $dino->CryopodData(),
	];

	$metadata = [
		'characterId' => $characterId,
		'dinoId' => $dinoId,
		'playerId' => $character->PlayerId(),
		'tribeId' => $character->TribeId(),
	];

	$placeholders = [
		'characterName' => $character->Name(),
		'dinoName' => $dino->DescriptiveName(),
	];
	$templates = [
		'en' => 'Dino `{dinoName}` was restored to `{characterName}`.',
	];
	$messages = [];
	foreach ($service->Languages() as $language) {
		$messages[$language] = LogMessage::ReplacePlaceholders($templates[$language], $placeholders);
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($payload));

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('UPDATE sentinel.dinos SET is_dead = FALSE, is_frozen = TRUE WHERE dino_id = $1;', $dinoId);
	LogMessage::Create(serviceId: $serviceId, eventName: LogMessage::EventDinoRestored, type: LogMessage::LogTypeGameplay, level: LogMessage::LogLevelInfo, messages: $messages, metadata: $metadata);
	$database->Commit();

	return Response::NewJson([
		'requestId' => $requestId,
	], 200);
}
