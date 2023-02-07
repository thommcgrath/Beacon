<?php

use BeaconAPI\v4\{Response, Core, EmailVerificationCode};

$requiredScopes = [];
$authScheme = Core::kAuthSchemeDigest;

function handleRequest(array $context): Response {
	$email = $context['pathParameters']['email'];
	if (BeaconEmail::IsEmailValid($email) === false) {
		return Response::NewJsonError('Malformed email address', $email, 400);
	}
	
	$code = EmailVerificationCode::Fetch($email);
	if (empty($code)) {
		return Response::NewJsonError('Verification not started', $email, 404);
	}
	
	if (isset($_GET['key'])) {
		$code->DecryptCode($_GET['key']);
	}
	
	return Response::NewJson($code, 200);
}

?>
