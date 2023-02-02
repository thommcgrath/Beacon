<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:read');

function handleRequest(array $context): APIResponse {
	$applicationId = $context['pathParameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return APIResponse::NewJSONError('Application not found', null, 404);
	}
		
	return APIResponse::NewJSON($app, 200);
}

?>
