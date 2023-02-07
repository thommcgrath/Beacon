<?php

use BeaconAPI\v4\{Response, Core, Project, User};

function handleRequest(array $context): Response {
	$database = BeaconCommon::Database();
	$public_only = true;
	$filters = $_GET;
	$filters['deleted'] = false;
	if ($context['routeKey'] === 'GET /users/{userId}/projects') {
		$filters['userId'] = $context['pathParameters']['userId'];
		if ($context['pathParameters']['userId'] === Core::UserId()) {
			$public_only = false;
		}
	}
	if ($public_only) {
		$filters['published'] = 'Approved';	
	}
	
	$results = Project::Search($filters);
	return Response::NewJson($results, 200);
}

?>