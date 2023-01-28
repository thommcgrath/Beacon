<?php

use BeaconAPI\v4\{Application, APIResponse, Core, Session, User};

// To issue a token, both the client and the user need to be positively identified
// This can either be done with the username and password, or with OAuth.
// For OAuth, the redemption request will include the client id and secret
// For password, we cannot simply include the secret so a challenge is needed.
	
function handle_request(array $context): APIResponse {
	$obj = Core::BodyAsJSON();
	if (BeaconCommon::HasAllKeys($obj, 'email', 'password', 'client_id', 'signature')) {
		// Password auth
		$database = BeaconCommon::Database();
		try {
			$user = User::Fetch($obj['email']);
			if (is_null($user)) {
				return APIResponse::NewJSONError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			$application = Application::Fetch($obj['client_id']);
			if ($application->HasScope('password_auth') === false) {
				return APIResponse::NewJSONError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			if ($application->DecryptSecret() === false) {
				return APIResponse::NewJSONError('Internal server error', ['code' => 'BAD_SECRET'], 500);
			}
			$client_secret = $application->Secret();
			
			$database->BeginTransaction();
			$rows = $database->Query("SELECT challenge FROM user_challenges WHERE user_id = $1;", $user->UserId());
			if ($rows->RecordCount() !== 1) {
				$database->Rollback();
				return APIResponse::NewJSONError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			$challenge = $rows->Field('challenge');
			$signature_contents = strtolower($user->UserId() . ':' . $challenge . ':' . $client_secret);
			$computed_signature = base64_encode(hash('sha3-512', $signature_contents, true));
			if ($computed_signature !== $obj['signature']) {
				$database->Rollback();
				return APIResponse::NewJSONError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			if ($user->TestPassword($obj['password']) === false) {
				$database->Rollback();
				return APIResponse::NewJSONError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			if ($user->Is2FAProtected()) {
				$verification_code = null;
				$device_id = null;
				$trust = null;
				
				if (isset($obj['verification_code'])) {
					$verification_code = (string) $obj['verification_code'];
				}
				if (isset($obj['trust'])) {
					$trust = filter_var($obj['trust'], FILTER_VALIDATE_BOOLEAN);
				}
				if (isset($obj['device_id'])) {
					$device_id = (string) $obj['device_id'];
				}
				if (empty($verification_code)) {
					if (empty($device_id) === false) {
						$verification_code = $device_id;
					} else {
						$database->Rollback();
						return APIResponse::NewJSONError('Verification needed', ['code' => '2FA_ENABLED'], 403);
					}
				}
				
				if ($user->Verify2FACode($verification_code) === false) {
					$database->Rollback();
					return APIResponse::NewJSONError('Verification needed', ['code' => '2FA_ENABLED'], 403);
				}
				
				if (empty($device_id) === false) {
					if ($trust === true) {
						$user->TrustDevice($device_id);
					} else if ($trust === false) {
						$user->UntrustDevice($device_id);
					}
				}
			}
			
			$database->Query("DELETE FROM user_challenges WHERE user_id = $1 AND challenge = $2;", $user->UserId(), $challenge);
			$session = Session::Create($user, $application);
			$database->Commit();
			
			return APIResponse::NewJSON($session, 201);
		} catch (Exception $err) {
			if ($database->InTransaction()) {
				$database->ResetTransactions();
			}
			return APIResponse::NewJSONError('Internal server error', ['code' => 'EXCEPTION', 'message' => $err->getMessage()], 500);
		}
	} else if (BeaconCommon::HasAllKeys($obj, 'grant_type', 'redirect_uri', 'code', 'client_id', 'client_secret')) {
		// OAuth
	} else {
		return APIResponse::NewJSONError('Invalid authorization parameters', null, 401);
	}
	
	
	/*$user = Core::User();
	if (is_null($user) || $user->CanSignIn() === false) {
		return APIResponse::NewJSONError('Invalid user', ['code' => 'USER_DISABLED'], 400);
	}
	
	$obj = Core::BodyAsJSON();
	$verification_code = null;
	$device_id = null;
	$trust = null;
	if (is_null($obj) === false) {
		if (isset($obj['verification_code'])) {
			$verification_code = (string) $obj['verification_code'];
		}
		if (isset($obj['trust'])) {
			$trust = filter_var($obj['trust'], FILTER_VALIDATE_BOOLEAN);
		}
		if (isset($obj['device_id'])) {
			$device_id = (string) $obj['device_id'];
		}
	}
	if (is_null($verification_code) && is_null($device_id) === false) {
		$verification_code = $device_id;
	}
	
	$session = Session::CreateForUser($user, $verification_code);
	if (is_null($session)) {
		return APIResponse::NewJSONError('Verification needed', ['code' => '2FA_ENABLED'], 403);
	}
	
	if (is_null($device_id) === false) {
		if ($trust === true) {
			$user->TrustDevice($device_id);
		} else if ($trust === false) {
			$user->UntrustDevice($device_id);
		}
	}
	
	return APIResponse::NewJSON($session, 201);*/
}

?>