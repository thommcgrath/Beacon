<?php

use BeaconAPI\v4\{Core, ServiceToken, Response};

function handleRequest(array $context): Response {
	$tokenId = $context['pathParameters']['tokenId'];
	
	$token = ServiceToken::Fetch($tokenId);
	if (is_null($token)) {
		return Response::NewJsonError('Token not found', $tokenId, 404);
	}
	if ($token->UserId() !== Core::UserId()) {
		return Response::NewJsonError('Forbidden.', 403);
	}
	
	if ($token->Delete()) {
		return Response::NewNoContent();
	} else {
		return Response::NewJsonError('Token was not deleted.', 500);
	}
}

?>
