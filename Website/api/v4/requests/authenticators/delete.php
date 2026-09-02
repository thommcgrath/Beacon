<?php

use BeaconAPI\v4\{Application, Authenticator, Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersCredentials;
}

function handleRequest(array $context): Response {
	$user = Core::User();
	$body = Core::BodyAsJson();
	$authenticatorId = $body['authenticatorId'];
	$authCode = $body['authCode'];

	if (Authenticator::VerifyCode($user, $authCode, Authenticator::VerifyOptionAllowTOTP) === false) {
		return Response::NewJsonError(message: 'The provided code is not correct for any of your authenticators Backup codes are not allowed here.', code: 'invalidAuthCode', httpStatus: 403);
	}

	try {
		Authenticator::RemoveAuthenticator($user, $authenticatorId);
		return Response::NewJson('Authenticator was deleted.', 200);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
