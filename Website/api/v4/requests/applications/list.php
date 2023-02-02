<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:read');

function handleRequest(array $context): APIResponse {
	$filters = $_GET;
	$filters['userId'] = Core::UserId();
		
	return APIResponse::NewJSON(Application::Search($filters), 200);
}

?>
