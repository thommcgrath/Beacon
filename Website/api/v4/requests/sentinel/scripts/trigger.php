<?php

use BeaconAPI\v4\{Core, Response};
use BeaconAPI\v4\Sentinel\{PermissionBits, ScriptWebhook};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$scriptWebhookId = $context['pathParameters']['scriptWebhookId'];
	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT script_webhooks.script_id, script_webhooks.user_id, script_webhooks.access_key, scripts.context, scripts.name FROM sentinel.script_webhooks INNER JOIN sentinel.scripts ON (script_webhooks.script_id = scripts.script_id) WHERE script_webhooks.webhook_id = $1;', $scriptWebhookId);
	if ($rows->RecordCount() === 0) {
		return Response::NewJsonError(message: 'Webhook not found', httpStatus: 404, code: 'notFound', details: ['scriptWebhookId' => $scriptWebhookId]);
	}
	$userId = $rows->Field('user_id');

	$accessKey = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($rows->Field('access_key'))));
	$requestMethod = strtoupper(Core::Method());
	$body = trim(Core::Body());
	$nonce = floor(time() / 30);
	$stringToSign = "{$requestMethod}\n{$nonce}\n{$body}";
	$computedSignature = hash_hmac('sha256', $stringToSign, $accessKey);
	if (isset($_SERVER['HTTP_X_BEACON_TOKEN'])) {
		$authScheme = 'HmacSHA256';
		$testHash = $_SERVER['HTTP_X_BEACON_TOKEN'];
	} elseif (isset($_SERVER['HTTP_AUTHORIZATION'])) {
		list($authScheme, $testHash) = explode(' ', $_SERVER['HTTP_AUTHORIZATION'], 2);
	} else {
		$authScheme = 'HmacSHA256';
		$testHash = 'DEADBEEF';
	}

	if (strtolower($authScheme) !== 'hmacsha256' || strtolower($computedSignature) !== strtolower($testHash)) {
		return Response::NewJsonError(message: 'Webhook not found', httpStatus: 404, code: 'notFound', details: ['scriptWebhookId' => $scriptWebhookId]);
	}

	$body = json_decode($body, true);
	if ($body === false) {
		return Response::NewJsonError(message: 'Could not parse JSON', httpStatus: 400, code: 'jsonParseError');
	}

	if (!isset($body['parameters'])) {
		return Response::NewJsonError(message: 'Missing parameters', httpStatus: 400, code: 'missingParameters');
	}

	$context = $rows->Field('context');
	$scriptName = $rows->Field('name');
	$now = new DateTimeImmutable('now', new DateTimeZone('GMT'));
	$eventData = [
		'scriptId' => $rows->Field('script_id'),
		'timestamp' => $now->format('Y-m-d H:i:s.v'),
		'parameters' => [],
		'event' => $context,
		'scriptName' => $scriptName,
	];
	foreach ($body['parameters'] as $key => $value) {
		if (is_string($value) === false || empty($value) === false) {
			$eventData['parameters'][$key] = $value;
		}
	}

	switch ($context) {
	case 'serviceScriptRun':
		if (!isset($body['serviceId'])) {
			return Response::NewJsonError(message: 'Missing serviceId', httpStatus: 400, code: 'missingTargetId');
		}

		$serviceId = $body['serviceId'];
		$targetRows = $database->Query('SELECT service_permissions.service_id, services.cluster_id FROM sentinel.service_permissions INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE service_permissions.service_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) = $3;', $serviceId, $userId, PermissionBits::ControlServices);
		break;
	case 'characterScriptRun':
		if (!isset($body['characterId'])) {
			return Response::NewJsonError(message: 'Missing characterScriptRun', httpStatus: 400, code: 'missingTargetId');
		}

		$characterId = $body['characterId'];
		$eventData['characterId'] = $characterId;
		$targetRows = $database->Query('SELECT characters.service_id, services.cluster_id FROM sentinel.characters INNER JOIN sentinel.service_permissions ON (characters.service_id = service_permissions.service_id) INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE characters.character_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) = $3;', $characterId, $userId, PermissionBits::ControlServices);
		break;
	case 'dinoScriptRun':
		if (!isset($body['dinoId'])) {
			return Response::NewJsonError(message: 'Missing dinoScriptRun', httpStatus: 400, code: 'missingTargetId');
		}

		$dinoId = $body['dinoId'];
		$eventData['dinoId'] = $dinoId;
		$targetRows = $database->Query('SELECT dinos.service_id, services.cluster_id FROM sentinel.dinos INNER JOIN sentinel.service_permissions ON (dinos.service_id = service_permissions.service_id) INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE dinos.dino_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) = $3;', $dinoId, $userId, PermissionBits::ControlServices);
		break;
	case 'tribeScriptRun':
		if (!isset($body['tribeId'])) {
			return Response::NewJsonError(message: 'Missing tribeScriptRun', httpStatus: 400, code: 'missingTargetId');
		}

		$tribeId = $body['tribeId'];
		$eventData['tribeId'] = $tribeId;
		$targetRows = $database->Query('SELECT tribes.service_id, services.cluster_id FROM sentinel.tribes INNER JOIN sentinel.service_permissions ON (tribes.service_id = service_permissions.service_id) INNER JOIN sentinel.services ON (service_permissions.service_id = services.service_id) WHERE tribes.tribe_id = $1 AND service_permissions.user_id = $2 AND (service_permissions.permissions & $3) = $3;', $tribeId, $userId, PermissionBits::ControlServices);
		break;
	default:
		return Response::NewJsonError(message: 'Unknown script context', httpStatus: 400, code: 'invalidContext');
	}

	if ($targetRows->RecordCount() === 0) {
		return Response::NewJsonError(message: 'The user which owns the webhook does not have ControlServices permission on the target service.', httpStatus: 403, code: 'forbidden');
	}

	$serviceId = $targetRows->Field('service_id');
	$clusterId = $targetRows->Field('cluster_id');

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
