<?php

use BeaconAPI\v4\{Response, Application, Core};

Core::Authorize('apps:read');

function handleRequest(array $context): Response {
	$applicationId = $context['pathParameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return Response::NewJsonError('Application not found', null, 404);
	}
		
	return Response::NewJson($app, 200);
}

?>
