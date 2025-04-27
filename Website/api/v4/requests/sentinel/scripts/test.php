<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$body = Core::BodyAsJson();
	if (is_array($body) === false || BeaconCommon::HasAllKeys($body, 'context', 'language', 'parameters', 'code') === false) {
		return Response::NewJsonError(code: 'missingKeys', httpStatus: 400, message: 'Missing keys. Must include context, language, parameters, and code.');
	}

	$language = $body['language'];
	if ($language !== 'JavaScript' && $language !== 'Simple') {
		return Response::NewJsonError(code: 'unsupportedLanguage', httpStatus: 400, message: 'The script language is not supported.');
	}

	$context = $body['context'];
	if (in_array($context, LogMessage::Events) === false) {
		return Response::NewJsonError(code: 'invalidContext', httpStatus: 400, message: 'The supplied context is not valid.');
	}

	$parameters = $body['parameters'];
	if (is_array($parameters) === false) {
		return Response::NewJsonError(code: 'badParameters', httpStatus: 400, message: 'Paramters must be an array.');
	}
	foreach ($parameters as $parameter => $value) {
		if ((is_numeric($value) || is_string($value) || is_bool($value)) === false) {
			return Response::NewJsonError(code: 'badParameters', httpStatus: 400, message: 'Parameter values must be numbers, strings, or boolean.');
		}
	}

	$requestId = BeaconCommon::GenerateUUID();
	$obj = [
		'requestId' => $requestId,
		'userId' => Core::UserId(),
		'context' => $context,
		'language' => $language,
		'parameters' => (object) $parameters,
		'code' => $body['code'],
	];
	switch ($context) {
	case 'chat':
		$obj['chatType'] = $body['chatType'] ?? 'normal';
		break;
	case 'playerJoined':
		$obj['connectionType'] = $body['connectionType'] ?? 'normal';
		break;
	case 'dinoDied':
	case 'playerDied':
	case 'structureDestroyed':
		$obj['attackerType'] = $body['attackerType'] ?? 'wildDino';
		break;
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.queue.testScript', json_encode($obj));

	return Response::NewJson(['requestId' => $requestId], 200);
}

?>
