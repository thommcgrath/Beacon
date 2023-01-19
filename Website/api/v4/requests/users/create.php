<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode, User};

function handle_request(array $context): APIResponse {
	if (Core::IsJSONContentType() === false) {
		return APIResponse::NewJSONError('Send a JSON payload', null, 400);
	}
	
	$payload = Core::BodyAsJSON();
	$email = null;
	if (isset($payload['email']) && empty($payload['email']) === false) {
		if (isset($payload['verification_code']) === false) {
			return APIResponse::NewJSONError('Missing verification code', $payload, 400);
		}
		
		$email = $payload['email'];
		$verification_code = $payload['verification_code'];
		if (EmailVerificationCode::IsEmailVerified($email, $verification_code) === false) {
			return APIResponse::NewJSONError('Incorrect verification code', $payload, 400);
		}
	}
	
	if (isset($payload['user_id'])) {
		return APIResponse::NewJSONError('Do not include user id', $payload, 400);
	}
	
	if ($context['route_key'] === 'PUT /users/{userId}') {
		$user_id = $context['path_parameters']['userId'];
		$user = User::Fetch($user_id);
		if (is_null($user) === false) {
			return APIResponse::NewJSONError('User already exists', $payload, 400);
		}
	} else {
		$user_id = BeaconCommon::GenerateUUID();
	}
	
	if (isset($payload['public_key']) === false || empty($payload['public_key'])) {
		return APIResponse::NewJSONError('Missing public key', $payload, 400);
	}
	
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		$user = new User($user_id);
		$user->SetPublicKey(BeaconEncryption::PublicKeyToPEM($payload['public_key']));
		$user->SetDecryptedUsercloudKey(User::GenerateUsercloudKey());
		if (is_null($email) === false) {
			$user->SetEmailAddress($email);
			$user->SetUsername($payload['username']);
			$user->SetPrivateKey($payload['private_key'], $payload['private_key_salt'], $payload['private_key_iterations']);
			EmailVerificationCode::Clear($email);
		}
		$user->Commit();
		$user = User::Fetch($user_id); // Reload the object
		$database->Commit();
		return APIResponse::NewJSON($user, 201);
	} catch (Exception $err) {
		$database->Rollback();
		return APIResponse::NewJSONError($err->getMessage(), $payload, 500);
	}
}

?>