<?php

use BeaconAPI\v4\{Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$authenticatorId = $context['pathParameters']['authenticatorId'];
	$authenticator = Authenticator::Fetch($authenticatorId);
	if ($authenticator && $authenticator->UserId() === $userId) {
		return Response::NewJson($authenticator, 200);
	} else {
		return Response::NewJsonError('Authenticator not found', null, 404);
	}
}

?>
