<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:write');

function handle_request(array $context): APIResponse {
	$applicationId = $context['path_parameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return APIResponse::NewJSONError('Application not found', null, 404);
	}
	
	$obj = Core::BodyAsJson();
	try {
		$app->Edit($obj);
		return ApiResponse::NewJson($app, 200);
	} catch (Exception $err) {
		return ApiResponse::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
