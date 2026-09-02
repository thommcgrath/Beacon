<?php

use BeaconAPI\v4\{Application, Authenticator, Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersCredentials;
}

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['userId'] = Core::UserId();

	$authenticators = Authenticator::Search($filters);
	return Response::NewJson($authenticators, 200);
}

?>
