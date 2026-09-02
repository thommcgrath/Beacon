<?php

use BeaconAPI\v4\{Application, Authenticator, Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersCredentials;
}

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$authenticatorId = $context['pathParameters']['authenticatorId'];
	$authenticator = Authenticator::Fetch($authenticatorId);
	if (is_null($authenticator) || $authenticator->UserId() !== $userId) {
		return Response::NewJsonError('Application not found', null, 404);
	}

	$obj = Core::BodyAsJson();
	try {
		$authenticator->Edit($obj);
		return Response::NewJson($authenticator, 200);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
