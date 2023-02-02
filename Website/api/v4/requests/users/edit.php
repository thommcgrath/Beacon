<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode, User};
Core::Authorize('user:write');

function handleRequest(array $context): APIResponse {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return APIResponse::NewJSONError('User not found', $identifier, 404);
	}
	
	if ($user->UserId() !== Core::UserId()) {
		return APIResponse::NewJSONError('Forbidden', $identifier, 403);
	}
	
	try {
		$body = Core::BodyAsJson();
		
		$email = $body['email'] ?? null;
		if (empty($email) === false) {
			$verificationCode = $body['verificationCode'] ?? null;
			if (empty($verificationCode)) {
				return APIResponse::NewJSONError('Missing verification code', $body, 400);
			}
			
			$emailVerification = EmailVerificationCode::Fetch($email);
			if (is_null($emailVerification) || $emailVerification->CheckCode($verificationCode) === false) {
				return APIResponse::NewJSONError('Incorrect verification code', $body, 400);
			}
		}
		
		$user->Edit($body);
		if (empty($emailVerification) === false) {
			$emailVerification->Delete();
		}
		return APIResponse::NewJSON($user, 200);
	} catch (Exception $err) {
		return APIResponse::NewJSONError($err->getMessage(), $body, 400);
	}
}

?>
