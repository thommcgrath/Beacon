<?php

use BeaconAPI\v4\{Core, ServiceToken, Response};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	if ($userId !== Core::UserId()) {
		return Response::NewJsonError('Forbidden.', 403);
	}
	
	$tokenData = Core::BodyAsJson();
	$accessToken = $tokenData['accessToken'];
	$provider = $tokenData['provider'];
	$type = $tokenData['type'];
	$providerSpecific = $tokenData['providerSpecific'];
	
	if ($type !== 'Static') {
		return Response::NewJsonError('Only static tokens can be saved at this endpoint.', 400);
	}
	
	$provider = ServiceToken::CleanupProvider($provider);
	$token = ServiceToken::StoreStatic($userId, $provider, $accessToken, $providerSpecific);
	if (is_null($token)) {
		return Response::NewJsonError('Static token was not saved.', 500);
	}
	return Response::NewJson($token->JSON(true), 200);
}

?>
