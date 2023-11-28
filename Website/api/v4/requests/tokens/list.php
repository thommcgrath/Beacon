<?php

use BeaconAPI\v4\{Core, ServiceToken, Response};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	$authenticatedAsUser = ($userId === Core::UserId());

	$provider = null;
	if (isset($_GET['provider'])) {
		$provider = $_GET['provider'];
	}

	$tokenId = null;
	if (isset($_GET['tokenId'])) {
		$tokenId = $_GET['tokenId'];
	}

	$tokens = ServiceToken::Lookup(userId: $userId, provider: $provider, tokenId: $tokenId);
	$json = [];
	foreach ($tokens as $token) {
		try {
			$token->Refresh();
			$json[] = $token->JSON($authenticatedAsUser);
		} catch (Exception $err) {
		}
	}
	return Response::NewJson($json, 200);
}

?>
