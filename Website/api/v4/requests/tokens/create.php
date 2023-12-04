<?php

use BeaconAPI\v4\{Core, ServiceToken, Response};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	if ($userId !== Core::UserId()) {
		return Response::NewJsonError('Forbidden.', null, 403);
	}

	$tokenData = Core::BodyAsJson();
	$accessToken = $tokenData['accessToken'];
	$provider = ServiceToken::CleanupProvider($tokenData['provider']);
	$type = $tokenData['type'];
	$token = null;

	switch ($type) {
	case ServiceToken::TypeStatic:
		$providerSpecific = $tokenData['providerSpecific'];
		try {
			$token = ServiceToken::StoreStatic($userId, $provider, $accessToken, $providerSpecific, false);
			if (is_null($token)) {
				return Response::NewJsonError('Static token was not saved.', null, 500);
			}
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage() ?: 'Unhandled exception saving static token', null, 400);
		}
		break;
	case ServiceToken::TypeOAuth:
		$refreshToken = $tokenData['refreshToken'];
		try {
			$token = ServiceToken::ImportOAuth($userId, $provider, $accessToken, $refreshToken);
			if (is_null($token)) {
				return Response::NewJsonError('Token was not imported. The refresh token may be expired.', null, 400);
			}
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage() ?: 'Unhandled exception saving OAuth token', null, 400);
		}
		break;
	default:
		return Response::NewJsonError("Unknown provider {$provider}.", null, 400);
	}

	return Response::NewJson($token->JSON(true), 200);
}

?>
