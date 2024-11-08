<?php

use BeaconAPI\v4\{Response, Application, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeAppsRead;
}

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['userId'] = Core::UserId();

	return Response::NewJson(Application::Search($filters), 200);
}

?>
