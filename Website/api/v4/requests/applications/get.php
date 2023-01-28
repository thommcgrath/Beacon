<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:read');

function handle_request(array $context): APIResponse {
	$applicationId = $context['path_parameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return APIResponse::NewJSONError('Application not found', null, 404);
	}
		
	return APIResponse::NewJSON($app, 200);
}

?>
