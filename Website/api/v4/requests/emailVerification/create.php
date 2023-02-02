<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode};

function handle_request(array $context): APIResponse {
	$email = $context['pathParameters']['email'];
	if (BeaconEmail::IsEmailValid($email) === false) {
		return APIResponse::NewJsonError('Malformed email address', $email, 400);
	}
	
	$body = Core::BodyAsJson();
	$params = [];
	if (isset($body['code'])) {
		$code = $body['code'];
		$verification = EmailVerificationCode::Fetch($email);
		if (is_null($verification) === false && $verification->CheckCode($code)) {
			return APIResponse::NewJSON($verification, 200);
		}
		return APIResponse::NewJSONError('Incorrect verification code', $body, 400);
	}
	if (isset($body['key'])) {
		$params['key'] = $body['key'];
	}
	
	$verification = EmailVerificationCode::Create($email, $params);
	return APIResponse::NewJson($verification, 201);
}

?>
