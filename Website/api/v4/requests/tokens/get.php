<?php

use BeaconAPI\v4\{Core, OAuth, Response};

function handleRequest(array $context): Response {
	$tokenId = $context['pathParameters']['tokenId'];
	$authenticatedAsUser = (Core::UserId() === Core::UserId());
	
	$token = OAuth::Fetch($tokenId);
	if (is_null($token)) {
		return Response::NewJsonError('Token not found', $tokenId, 404);
	}
	
	$token->Refresh();
	
	return Response::NewJson($token->JSON($authenticatedAsUser), 200);
}

?>
