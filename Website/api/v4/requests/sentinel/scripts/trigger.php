<?php

use BeaconAPI\v4\{Core, Response};
use BeaconAPI\v4\Sentinel\{LogMessage, PermissionBits, ScriptWebhook};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$scriptWebhookId = $context['pathParameters']['scriptWebhookId'];
	$database = BeaconCommon::Database();
	$nonce = floor(time() / 30);
	$requestMethod = strtoupper(Core::Method());
	$body = trim(Core::Body());
	$stringToSign = "{$requestMethod}\n{$nonce}\n{$body}";
	$now = new DateTimeImmutable('now', new DateTimeZone('GMT'));

	$body = json_decode($body, true);
	if ($body === false) {
		return Response::NewJsonError(message: 'Could not parse JSON', httpStatus: 400, code: 'jsonParseError');
	}

	try {
		$database->BeginTransaction();
		$rows = $database->Query('SELECT DISTINCT service_id, script_id, revision_id, script_event_id, name, arguments, properties FROM sentinel.active_scripts WHERE context = $1 AND keyword = $2;', LogMessage::EventWebhook, $scriptWebhookId);
		if ($rows->RecordCount() === 0) {
			$database->Rollback();
			return Response::NewJsonError(message: 'Webhook not found', httpStatus: 404, code: 'notFound', details: ['scriptWebhookId' => $scriptWebhookId]);
		}

		while (!$rows->EOF()) {
			$properties = json_decode($rows->Field('properties'), true);
			$accessKey = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($properties['accessKey'])));
			var_dump($accessKey);
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
				$database->Rollback();
				return Response::NewJsonError(message: 'Webhook not found', httpStatus: 404, code: 'notFound', details: ['scriptWebhookId' => $scriptWebhookId]);
			}

			$arguments = [];
			$argumentDefinitions = json_decode($rows->Field('arguments'), true);
			$requestValues = $body['arguments'] ?? $body['parameters'] ?? [];

			foreach ($argumentDefinitions as $definition) {
				$argumentName = $definition['name'];
				$arguments[$argumentName] = $definition['default'];
			}
			foreach ($requestValues as $argumentName => $argumentValue) {
				if (array_key_exists($argumentName, $arguments)) {
					$arguments[$argumentName] = $argumentValue;
				}
			}

			$eventData = [
				'scriptId' => $rows->Field('script_id'),
				'scriptName' => $rows->Field('name'),
				'scriptEventId' => $rows->Field('script_event_id'),
				'timestamp' => $now->format('Y-m-d H:i:s.v'),
				'arguments' => (object)$arguments,
				'event' => LogMessage::EventWebhook,
			];

			$database->Query('INSERT INTO sentinel.service_event_queue (service_id, queue_time, version, event_data) VALUES ($1, CURRENT_TIMESTAMP, $2, $3);', $rows->Field('service_id'), 1, json_encode($eventData));

			$rows->MoveNext();
		}

		$database->Commit();
	} catch (Exception $err) {
		return Response::NewJsonError(code: 'internalServerError', httpStatus: 500, message: $err->getMessage());
	}

	return Response::NewNoContent();
}

?>
