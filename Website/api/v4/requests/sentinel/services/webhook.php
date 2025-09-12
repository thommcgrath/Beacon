<?php

use BeaconAPI\v4\{Core, Response};
use BeaconAPI\v4\Sentinel\{LogMessage, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$serviceId = $context['pathParameters']['serviceId'];
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
	$webhookName = $body['webhook'] ?? '';
	$parameterValues = $body['parameters'] ?? [];
	if (empty($webhookName) || is_array($parameterValues) === false || (count($parameterValues) > 0 && BeaconCommon::IsAssoc($parameterValues) === false)) {
		return Response::NewJsonError(message: 'Incorrect request object. Expected webhook and parameters.', httpStatus: 400, code: 'badRequestBody', details: ['webhook' => $webhookName, 'parameters' => $parameterValues]);
	}

	try {
		$service = Service::Fetch($serviceId);
		if (is_null($service)) {
			return Response::NewJsonError(message: 'Serviced not found', httpStatus: 404, code: 'notFound', details: ['serviceId' => $serviceId]);
		}

		$expectedSignature = $service->Sign($stringToSign, 'sha256');
		if (isset($_SERVER['HTTP_X_BEACON_TOKEN'])) {
			$authScheme = 'HmacSHA256';
			$testSignature = $_SERVER['HTTP_X_BEACON_TOKEN'];
		} elseif (isset($_SERVER['HTTP_AUTHORIZATION'])) {
			list($authScheme, $testSignature) = explode(' ', $_SERVER['HTTP_AUTHORIZATION'], 2);
		} else {
			$authScheme = 'HmacSHA256';
			$testSignature = 'DEADBEEF';
		}
		if (strtolower($authScheme) !== 'hmacsha256' || strtolower($expectedSignature) !== strtolower($testSignature)) {
			return Response::NewJsonError(message: 'Service not found', httpStatus: 404, code: 'notFound', details: ['serviceId' => $serviceId, 'scheme' => $authScheme, 'expectedSignature' => $expectedSignature, 'sentSignature' => $testSignature]);
		}

		$rows = $database->Query('SELECT DISTINCT script_id, name, script_event_id, arguments FROM sentinel.active_scripts WHERE service_id = $1 AND context = $2 AND keyword = $3;', $serviceId, LogMessage::EventWebhook, $webhookName);
		if ($rows->RecordCount() === 0) {
			return Response::NewJsonError(message: 'No matching webhooks', httpStatus: 404, code: 'notFound', details: ['webhook' => $webhookName]);
		}

		$database->BeginTransaction();
		while (!$rows->EOF()) {
			$parameters = [];
			$parameterDefinitions = json_decode($rows->Field('arguments'), true);

			foreach ($parameterDefinitions as $definition) {
				$parameterName = $definition['name'];
				$parameters[$parameterName] = $definition['default'];
			}
			foreach ($parameterValues as $parameterName => $parameterValue) {
				if (array_key_exists($parameterName, $parameters)) {
					$parameters[$parameterName] = $parameterValue;
				}
			}

			$eventData = [
				'scriptId' => $rows->Field('script_id'),
				'scriptName' => $rows->Field('name'),
				'scriptEventId' => $rows->Field('script_event_id'),
				'timestamp' => $now->format('Y-m-d H:i:s.v'),
				'arguments' => (object)$parameters,
				'event' => LogMessage::EventWebhook,
			];

			$database->Query('INSERT INTO sentinel.service_event_queue (service_id, queue_time, version, event_data) VALUES ($1, CURRENT_TIMESTAMP, $2, $3);', $serviceId, 1, json_encode($eventData));

			$rows->MoveNext();
		}
		$database->Commit();
	} catch (Exception $err) {
		if ($database->InTransaction()) {
			$database->ResetTransactions();
		}
		return Response::NewJsonError(code: 'internalServerError', httpStatus: 500, message: $err->getMessage());
	}

	return Response::NewNoContent();
}

?>
