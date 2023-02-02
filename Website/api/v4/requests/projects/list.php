<?php

use BeaconAPI\v4\{APIResponse, Core, Project, User};

function handleRequest(array $context): APIResponse {
	$database = BeaconCommon::Database();
	$user_id = Core::Authenticated() ? Core::UserId() : null;
	
	$public_only = true;
	$filters = $_GET;
	$filters['deleted'] = false;
	if ($context['routeKey'] === 'GET /users/{userId}/projects') {
		$filters['user_id'] = $context['pathParameters']['userId'];
		if ($context['pathParameters']['userId'] === $user_id) {
			$public_only = false;
		}
	}
	if ($public_only) {
		$filters['published'] = 'Approved';	
	}
	
	$results = Project::Search($filters);
	return APIResponse::NewJSON($results, 200);
}

?>