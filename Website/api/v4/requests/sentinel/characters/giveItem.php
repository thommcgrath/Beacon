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

	$body = Core::BodyAsJson();
	if (BeaconCommon::HasAllKeys($body, 'itemPath', 'quantity') === false) {
		return Response::NewJsonError(message: 'Must provide at least itemPath and quantity values.', httpStatus: 400, code: 'missingKeys');
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

	$now = new DateTimeImmutable();
	$event = [
		'event' => 'itemGiven',
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'characterId' => $characterId,
	];

	$whitelist = [
		'itemPath',
		'quantity',
		'quality',
		'asBlueprint',
		'minRandomQuality',
		'respectStatClamps',
		'itemRating',
	];
	foreach ($whitelist as $key) {
		if (isset($body[$key]) === false) {
			continue;
		}

		switch ($key) {
		case 'quantity':
			if ($body[$key] < 1 || $body[$key] > 1000000) {
				return Response::NewJsonError(message: 'Valid quantity range is 1-1000000', httpStatus: 400, code: 'invalidQuantity');
			}
			break;
		case 'quality':
			if ($body[$key] < 0 || $body[$key] > 100) {
				return Response::NewJsonError(message: 'Valid quality range is 0-100', httpStatus: 400, code: 'invalidQuality');
			}
			break;
		case 'itemPath':
			if (preg_match('/\/.+\/([^\/\.]+)\.\1(_C)?/i', $body[$key]) !== 1) {
				return Response::NewJsonError(message: 'Item path is not well formed', httpStatus: 400, code: 'invalidPath');
			}
			break;
		case 'minRandomQuality':
			if ($body[$key] < 0 || $body[$key] > 1) {
				return Response::NewJsonError(message: 'Valid quality range is 0-100', httpStatus: 400, code: 'invalidQuality');
			}
			break;
		}

		$event[$key] = $body[$key];
	}

	$whitelist = [
		'genericQuality' => 0,
		'armor' => 1,
		'durability' => 2,
		'damage' => 3,
		'ammo' => 4,
		'hypothermal' => 5,
		'weight' => 6,
		'hyperthermal' => 7,
	];
	$stats = [];
	foreach ($whitelist as $stat => $index) {
		if (isset($body[$stat]) === false) {
			continue;
		}

		if ($body[$key] < 0 || $body[$key] > 1000000) {
			return Response::NewJsonError(message: 'Stats do not go that high or low', httpStatus: 400, code: 'invalidStat');
		}

		$stats[] = [
			'index' => $index,
			'value' => $body[$stat],
		];
	}
	if (count($stats) > 0) {
		$event['stats'] = $stats;
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
