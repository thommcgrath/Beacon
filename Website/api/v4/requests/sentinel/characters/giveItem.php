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

	$requestId = BeaconUUID::v4();
	$specimenId = $character->SpecimenId();
	$payload = [
		'requestId' => $requestId,
		'type' => 'giveItem',
		'specimenId' => $specimenId,
	];
	$metadata = [
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

		$metadata[$key] = $body[$key];
		$payload[$key] = $body[$key];
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
		$payload['stats'] = $stats;
		$metadata['stats'] = $stats;
	}

	$messageTime = microtime(true);
	$messageId = BeaconUUID::v7($messageTime * 1000);
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO sentinel.service_logs (message_id, service_id, type, log_time, event_name, level, analyzer_status, metadata) VALUES ($1, $2, $3, TO_TIMESTAMP($4), $5, $6, $7, $8);', $messageId, $serviceId, 'Gameplay', $messageTime, 'itemGiven', 'Informational', 'Skipped', json_encode($metadata));
	$languages = $service->Languages();
	$itemPath = $metadata['itemPath'];
	$pathParts = explode('/', $itemPath);
	$classPart = $pathParts[count($pathParts) - 1];
	list($namespace, $classString) = explode('.', $classPart, 2);
	$placeholders = [
		'characterName' => $character->Name(),
		'quantity' => $metadata['quantity'],
		'itemClass' => $classString . '_C',
	];
	foreach ($languages as $language) {
		switch ($language) {
		default:
			$messageTemplate = '`{characterName}` was given {quantity}x `{itemClass}`';
			break;
		}
		$message = $messageTemplate;
		foreach ($placeholders as $placeholder => $value) {
			$message = str_replace('{' . $placeholder . '}', $value, $message);
		}
		$database->Query('INSERT INTO sentinel.service_log_messages (message_id, language, message) VALUES ($1, $2, $3);', $messageId, $language, $message);
	}
	$database->Commit();

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($payload));

	$socketId = BeaconPusher::SocketIdFromHeaders();
	$events = [];
	$eventBody = '';
	$event = new BeaconChannelEvent(channelName: BeaconPusher::SentinelChannelName('services', $serviceId), eventName: 'logsUpdated', body: $eventBody, socketId: $socketId);
	$eventSignature = $event->Signature();
	if (array_key_exists($eventSignature, $events) === false) {
		$events[$eventSignature] = $event;
	}
	$event = new BeaconChannelEvent(channelName: BeaconPusher::SentinelChannelName('characters', $characterId), eventName: 'logsUpdated', body: $eventBody, socketId: $socketId);
	$eventSignature = $event->Signature();
	if (array_key_exists($eventSignature, $events) === false) {
		$events[$eventSignature] = $event;
	}
	$rows = $database->Query('SELECT group_id FROM sentinel.group_services WHERE service_id = $1;', $serviceId);
	while (!$rows->EOF()) {
		$groupId = $rows->Field('group_id');

		$event = new BeaconChannelEvent(channelName: BeaconPusher::SentinelChannelName('groups', $groupId), eventName: 'logsUpdated', body: $eventBody, socketId: $socketId);
		$eventSignature = $event->Signature();
		if (array_key_exists($eventSignature, $events) === false) {
			$events[$eventSignature] = $event;
		}

		$rows->MoveNext();
	}
	BeaconPusher::SharedInstance()->SendEvents(array_values($events));

	return Response::NewJson([
		'requestId' => $requestId,
	], 200);
}
