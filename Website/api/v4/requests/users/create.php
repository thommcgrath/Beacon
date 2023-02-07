<?php

use BeaconAPI\v4\{Application,Core, EmailVerificationCode, Response, User, UserGenerator};

$requiredScopes = [];

function handleRequest(array $context): Response {
	if (Core::IsJsonContentType() === false) {
		return Response::NewJsonError('Send a JSON payload', null, 400);
	}
	
	$payload = Core::BodyAsJson();
		
	// Check application
	if (BeaconCommon::HasAllKeys($payload, 'clientId', 'expiration', 'nonce', 'signature') === false) {
		return Response::NewJsonError('Send clientId, expiration, nonce, and signature properties for authentication.', $payload, 400);
	}
	
	$clientId = strtolower($payload['clientId']);
	$app = Application::Fetch($clientId);
	if (is_null($app)) {
		return Response::NewJsonError('Invalid clientId', $payload, 400);
	}
	if ($app->HasScope(Application::kScopeUserWrite) === false) {
		return Response::NewJsonError('Client does not have the ' . Application::kScopeUserWrite . ' scope', $payload, 403);
	}
	$clientSecret = $app->Secret();
	
	$expiration = filter_var($payload['expiration'], FILTER_VALIDATE_INT);
	if ($expiration === false) {
		return Response::NewJsonError('Expiration should be a unix timestamp', $payload, 400);
	} else if ($expiration < time()) {
		return Response::NewJsonError('Request has expired', $payload, 400);
	} else if ($expiration > time() + 120) {
		return Response::NewJsonError('Expiration should not be more than 120 seconds into the future', $payload, 400);	
	}
	$nonce = $payload['nonce'];
	
	$computedHash = strtolower(hash('sha3-512', "{$clientId}:{$expiration}:{$nonce}:{$clientSecret}"));
	$sentHash = strtolower($payload['signature']);
	if ($computedHash !== $sentHash) {
		return Response::NewJsonError('Signature does not match', $payload, 400);
	}
	
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