<?php

use BeaconAPI\v4\{Response, Application, Core};

$requiredScopes[] = 'apps:write';
$requiredScopes[] = 'apps:read';

function handleRequest(array $context): Response {
	$applicationId = $context['pathParameters']['applicationId'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== Core::UserId()) {
		return Response::NewJsonError('Application not found', null, 404);
	}
	
	try {
		$app->Delete();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('Internal server error', null, 500);
	}
}

?>
