<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode, User, UserGenerator};

function handleRequest(array $context): APIResponse {
	if (Core::IsJsonContentType() === false) {
		return APIResponse::NewJSONError('Send a JSON payload', null, 400);
	}
	
	$payload = Core::BodyAsJson();
	$email = $payload['email'] ?? null;
	$emailVerification = null;
	if (empty($email) === false) {
		$verificationCode = $payload['verificationCode'] ?? null;
		if (empty($verificationCode)) {
			return APIResponse::NewJSONError('Missing verification code', $payload, 400);
		}
		
		$emailVerification = EmailVerificationCode::Fetch($email);
		if (is_null($emailVerification) || $emailVerification->CheckCode($verificationCode) === false) {
			return APIResponse::NewJSONError('Incorrect verification code', $payload, 400);
		}
	}
	
	if (isset($payload['userId'])) {
		return APIResponse::NewJSONError('Do not include user id', $payload, 400);
	}
	
	if ($context['routeKey'] === 'PUT /users/{userId}') {
		$userId = $context['pathParameters']['userId'];
		$user = User::Fetch($userId);
		if (is_null($user) === false) {
			return APIResponse::NewJSONError('User already exists', $payload, 400);
		}
	}
	
	try {
		$user = User::Create($payload);
		if (empty($emailVerification) === false) {
			$emailVerification->Delete();
		}
		return APIResponse::NewJSON($user, 201);
	} catch (Exception $err) {
		return APIResponse::NewJSONError($err->getMessage(), $payload, 500);
	}
}

?>