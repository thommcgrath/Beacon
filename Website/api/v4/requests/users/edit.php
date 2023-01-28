<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode, User};
Core::Authorize('user:write');

function handle_request(array $context): APIResponse {
	$identifier = $context['path_parameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return APIResponse::NewJSONError('User not found', $identifier, 404);
	}
	
	if ($user->UserId() !== Core::UserId()) {
		return APIResponse::NewJSONError('Forbidden', $identifier, 403);
	}
	
	$body = Core::BodyAsJson();
	if (isset($body['username']) && empty($body['username']) === false) {
		$user->SetUsername($body['username']);	
	}
	if (isset($body['email']) && empty($body['email']) === false) {
		if (isset($body['verification_code']) === false || empty($body['verification_code'])) {
			return APIResponse::NewJSONError('Missing verification code', $payload, 400);
		}
		
		$email = $body['email'];
		$verification_code = $body['verification_code'];
		
		if (EmailVerificationCode::IsEmailVerified($email, $verification_code) === false) {
			return APIResponse::NewJSONError('Incorrect verification code', $body, 400);
		}
		
		$user->SetEmailAddress($email);
	}
	
	$user->Commit();
	
	return APIResponse::NewJSON($user, 200);
}

?>
