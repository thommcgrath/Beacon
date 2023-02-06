<?php

use BeaconAPI\v4\{Response, Application, Core};

Core::Authorize('apps:write');

function handleRequest(array $context): Response {
	$applicationId = $context['pathParameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return Response::NewJsonError('Application not found', null, 404);
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
