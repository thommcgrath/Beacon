<?php

use BeaconAPI\v4\{Response, Core, EmailVerificationCode};

function handleRequest(array $context): Response {
	$email = $context['pathParameters']['email'];
	if (BeaconEmail::IsEmailValid($email) === false) {
		return Response::NewJsonError('Malformed email address', $email, 400);
	}
	
	$body = Core::BodyAsJson();
	$params = [];
	if (isset($body['code'])) {
		$code = $body['code'];
		$verification = EmailVerificationCode::Fetch($email);
		if (is_null($verification) === false && $verification->CheckCode($code)) {
			return Response::NewJson($verification, 200);
		}
		return Response::NewJsonError('Incorrect verification code', $body, 400);
	}
	if (isset($body['key'])) {
		$params['key'] = $body['key'];
	}
	
	$verification = EmailVerificationCode::Create($email, $params);
	return Response::NewJson($verification, 201);
}

?>
