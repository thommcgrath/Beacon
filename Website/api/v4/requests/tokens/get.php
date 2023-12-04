<?php

use BeaconAPI\v4\{Core, ServiceToken, Response};

function handleRequest(array $context): Response {
	$tokenId = $context['pathParameters']['tokenId'];

	$token = ServiceToken::Fetch($tokenId);
	if (is_null($token)) {
		return Response::NewJsonError('Token not found', $tokenId, 404);
	}
	$authenticatedAsUser = (Core::UserId() === $token->UserId());

	try {
		$token->Refresh();
	} catch (Exception $err) {
		$token->MarkNeedsReplacing();
	}

	return Response::NewJson($token->JSON($authenticatedAsUser), 200);
}

?>
