<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode};

function handle_request(array $context): APIResponse {
	$email = $context['path_parameters']['email'];
	if (BeaconEmail::IsEmailValid($email) === false) {
		return APIResponse::NewJSONError('Malformed email address', $email, 400);
	}
	
	$key = null;
	$body = Core::BodyAsJSON();
	if (isset($body['code'])) {
		$code = $body['code'];
		$verification = EmailVerificationCode::Fetch($email);
		if (is_null($verification) === false && $verification->CheckCode($code)) {
			return APIResponse::NewJSON($verification, 200);
		}
	}
	if (isset($body['key'])) {
		$key = $body['key'];
	}
	
	$verification = EmailVerificationCode::Create($email, $key);
	return APIResponse::NewJSON($verification, 201);
}

?>
