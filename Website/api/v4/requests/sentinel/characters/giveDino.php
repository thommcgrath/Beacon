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
		return Response::NewJsonError(message: 'Character ID must be a UUID', httpStatus: 404, code: 'notFound');
	}

	$body = Core::BodyAsJson();
	if (!isset($body['dinoPath']) || empty($body['dinoPath'])) {
		return Response::NewJsonError(message: 'Must provide at least dinoPath.', httpStatus: 400, code: 'badDinoPath');
	}
	$dinoPath = $body['dinoPath'];

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

	$now = new DateTimeImmutable();
	$event = [
		'event' => 'dinoCreated',
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'characterId' => $characterId,
		'dinoPath' => $dinoPath,
	];

	$whitelist = [
		'name',
		'level',
		'age',
		'isFemale',
		'isSterilized',
		'colors',
		'stats',
		'traits',
		'imprint',
	];
	foreach ($whitelist as $key) {
		if (isset($body[$key]) === false) {
			continue;
		}

		$value = $body[$key];
		switch ($key) {
		case 'name':
			if (is_string($value) === false) {
				return Response::NewJsonError(message: 'Name must be a string', httpStatus: 400, code: 'invalidName');
			}
			break;
		case 'level':
			if ($value < 1) {
				return Response::NewJsonError(message: 'Valid level must be greater than 1', httpStatus: 400, code: 'invalidLevel');
			}
			break;
		case 'age':
			if ($value < 0 || $value > 1) {
				return Response::NewJsonError(message: 'Valid age range is 0-1', httpStatus: 400, code: 'invalidAge');
			}
			break;
		case 'imprint':
			if ($value < 0 || $value > 1) {
				return Response::NewJsonError(message: 'Valid imprint range is 0-1', httpStatus: 400, code: 'invalidImprint');
			}
			break;
		case 'isFemale':
			if ($value !== true && $value !== false) {
				return Response::NewJsonError(message: 'isFemale must be a boolean', httpStatus: 400, code: 'invalidGender');
			}
			break;
		case 'isSterilized':
			if ($value !== true && $value !== false) {
				return Response::NewJsonError(message: 'isSterilized must be a boolean', httpStatus: 400, code: 'invalidSterilized');
			}
			break;
		case 'colors':
			$colors = $value;
			if (is_array($colors) === false || count($colors) !== 6) {
				return Response::NewJsonError(message: 'colors expects an array of 6 color numbers', httpStatus: 400, code: 'invalidColors');
			}
			foreach ($colors as $colorNum) {
				if (is_int($colorNum) === false) {
					return Response::NewJsonError(message: 'colors expects an array of 6 color numbers', httpStatus: 400, code: 'invalidColors');
				}
			}
			break;
		case 'traits':
			$traits = $value;
			if (is_array($traits) === false) {
				return Response::NewJsonError(message: 'traits expects an array of trait names', httpStatus: 400, code: 'invalidTraits');
			}
			foreach ($traits as $trait) {
				if (is_string($trait) === false) {
					return Response::NewJsonError(message: 'traits expects an array of trait names', httpStatus: 400, code: 'invalidTraits');
				}
			}
			break;
		case 'stats':
			$stats = $value;
			if (is_array($stats) === false) {
				return Response::NewJsonError(message: 'stats expects an object of with keys 0-11 and values 0-255', httpStatus: 400, code: 'invalidStats');
			}
			foreach ($stats as $statIndex => $statPoints) {
				$statInt = intval($statIndex);
				if ($statInt < 0 || $statInt > 11 || is_int($statPoints) === false || $statPoints < 0 || $statPoints > 255) {
					return Response::NewJsonError(message: 'stats expects an object of with keys 0-11 and values 0-255', httpStatus: 400, code: 'invalidStats');
				}
			}
			$value = (object) $value;
			break;
		}

		$event[$key] = $value;
	}

	// Add it to the event queue
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$rows = $database->Query('INSERT INTO sentinel.service_event_queue (service_id, version, event_data) VALUES ($1, $2, $3) RETURNING queue_id;', $serviceId, 1, json_encode($event, JSON_UNESCAPED_SLASHES));
	$database->Commit();

	return Response::NewJson([
		'requestId' => $rows->Field('queue_id'),
	], 200);
}
