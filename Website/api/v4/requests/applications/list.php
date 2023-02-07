<?php

use BeaconAPI\v4\{Response, Application, Core};

$requiredScopes[] = 'apps:read';

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['userId'] = Core::UserId();
		
	return Response::NewJson(Application::Search($filters), 200);
}

?>
