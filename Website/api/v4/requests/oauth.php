<?php

use BeaconAPI\v4\{Core, OAuth, Response};

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$provider = $context['pathParameters']['provider'];
	
	$oauth = OAuth::Lookup($userId, $provider);
	if ($oauth && $oauth->Test(true)) {
		return Response::NewJson($oauth);
	} else {
		return Response::NewJsonError('Token not found.', null, 404);
	}
}

?>
