<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode};

function handle_request(array $context): APIResponse {
	$email = $context['path_parameters']['email'];
	if (BeaconEmail::IsEmailValid($email) === false) {
		return APIResponse::NewJSONError('Malformed email address', $email, 400);
	}
	
	$code = EmailVerificationCode::Fetch($email);
	if (empty($code)) {
		return APIResponse::NewJsonError('Verification not started', $email, 404);
	}
	
	if (isset($_GET['key'])) {
		$code->DecryptCode($_GET['key']);
	}
	
	return APIResponse::NewJSON($code, 200);
}

?>
