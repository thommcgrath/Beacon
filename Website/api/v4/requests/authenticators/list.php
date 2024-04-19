<?php

use BeaconAPI\v4\{Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['userId'] = Core::UserId();

	$authenticators = Authenticator::Search($filters);
	return Response::NewJson($authenticators, 200);
}

?>
