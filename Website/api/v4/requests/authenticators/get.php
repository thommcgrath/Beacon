<?php

use BeaconAPI\v4\{Application, Authenticator, Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersCredentials;
}

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$authenticatorId = $context['pathParameters']['authenticatorId'];
	$authenticator = Authenticator::Fetch($authenticatorId);
	if ($authenticator && $authenticator->UserId() === $userId) {
		return Response::NewJson($authenticator, 200);
	} else {
		return Response::NewJsonError('Authenticator not found', null, 404);
	}
}

?>
