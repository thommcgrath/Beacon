<?php

use BeaconAPI\v4\{Response, Core, EmailVerificationCode, User, UserGenerator};

function handleRequest(array $context): Response {
	if (Core::IsJsonContentType() === false) {
		return Response::NewJsonError('Send a JSON payload', null, 400);
	}
	
	$payload = Core::BodyAsJson();
	$email = $payload['email'] ?? null;
	$emailVerification = null;
	if (empty($email) === false) {
		$verificationCode = $payload['verificationCode'] ?? null;
		if (empty($verificationCode)) {
			return Response::NewJsonError('Missing verification code', $payload, 400);
		}
		
		$emailVerification = EmailVerificationCode::Fetch($email);
		if (is_null($emailVerification) || $emailVerification->CheckCode($verificationCode) === false) {
			return Response::NewJsonError('Incorrect verification code', $payload, 400);
		}
	}
	
	if (isset($payload['userId'])) {
		return Response::NewJsonError('Do not include user id', $payload, 400);
	}
	
	if ($context['routeKey'] === 'PUT /users/{userId}') {
		$userId = $context['pathParameters']['userId'];
		$user = User::Fetch($userId);
		if (is_null($user) === false) {
			return Response::NewJsonError('User already exists', $payload, 400);
		}
	}
	
	try {
		$user = User::Create($payload);
		if (empty($emailVerification) === false) {
			$emailVerification->Delete();
		}
		return Response::NewJson($user, 201);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $payload, 500);
	}
}

?>