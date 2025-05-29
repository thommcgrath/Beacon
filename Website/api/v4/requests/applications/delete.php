<?php

use BeaconAPI\v4\{Application, Core, Response, User};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeAppsDelete;
}

function handleRequest(array $context): Response {
	$user = Core::User();
	$body = Core::BodyAsJson();
	$applicationId = $body['applicationId'];
	$authCode = $body['authCode'];
	$app = Application::Fetch($applicationId);
	if (is_null($app) || $app->UserId() !== $user->UserId()) {
		return Response::NewJsonError('Application not found', null, 404);
	}

	if ($user->Verify2FACode($authCode, true, User::VerifyWithAuthenticators) === false) {
		return Response::NewJsonError(message: 'The provided code is not correct for any of your authenticators.', code: 'invalidAuthCode', httpStatus: 403);
	}

	try {
		$app->Delete();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('Internal server error', null, 500);
	}
}

?>
