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
		if ($provider === ServiceToken::ProviderNitrado) {
			try {
				$curl = curl_init('https://api.nitrado.net/token');
				curl_setopt($curl, CURLOPT_HTTPHEADER, [
					'Authorization: Bearer ' . $accessToken,
				]);
				curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
				$response = curl_exec($curl);
				$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
				curl_close($curl);

				switch ($status) {
				case 200:
					$parsedResponse = json_decode($response, true);
					if (in_array('service', $parsedResponse['data']['token']['scopes']) === false) {
						return Response::NewJsonError('The long life token is valid, but is missing the "service" scope that Beacon requires.', null, 400);
					}
					$providerSpecific['user'] = $parsedResponse['data']['token']['user'];
					break;
				case 401:
					return Response::NewJsonError('The long life token is not valid. Double check the Nitrado website, as the beginning of the token can wrap to another line.', null, $status);
					break;
				case 403:
					return Response::NewJsonError('Nitrado\'s CloudFlare proxy has blocked the request. This is not your fault.	Unfortunately, there is not anything that can be done to solve this.', null, $status);
					break;
				case 429:
					return Response::NewJsonError('Nitrado\'s rate limit has been reached. Please try again later.', null, $status);
					break;
				case 503:
					return Response::NewJsonError('Nitrado is currently offline for maintenance.', null, $status);
					break;
				default:
					return Response::NewJsonError("Unexpected HTTP #{$status} response from Nitrado.", $response, $status);
					break;
				}
			} catch (Exception $err) {
				return Response::NewJsonError($err->getMessage() ?: 'Unhandled exception checking Nitrado token', null, 400);
			}
		}
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
