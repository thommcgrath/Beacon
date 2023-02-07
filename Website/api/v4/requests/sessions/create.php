<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Response, Core, Session, User};

$requiredScopes = [];

// To issue a token, both the client and the user need to be positively identified
// This can either be done with the username and password, or with OAuth.
// For OAuth, the redemption request will include the client id and secret
// For password, we cannot simply include the secret so a challenge is needed.
	
function handleRequest(array $context): Response {
	$obj = Core::BodyAsJson();
	if (BeaconCommon::HasAllKeys($obj, 'email', 'password', 'client_id', 'signature')) {
		// Password auth
		$database = BeaconCommon::Database();
		try {
			$user = User::Fetch($obj['email']);
			if (is_null($user)) {
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			$application = Application::Fetch($obj['client_id']);
			if (is_null($application)) {
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			if ($application->HasScope('password_auth') === false) {
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			$client_secret = $application->Secret();
			
			$database->BeginTransaction();
			$rows = $database->Query("SELECT challenge FROM user_challenges WHERE user_id = $1;", $user->UserId());
			if ($rows->RecordCount() !== 1) {
				$database->Rollback();
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			$challenge = $rows->Field('challenge');
			$signature_contents = strtolower($user->UserId() . ':' . $challenge . ':' . $client_secret);
			$computed_signature = base64_encode(hash('sha3-512', $signature_contents, true));
			if ($computed_signature !== $obj['signature']) {
				$database->Rollback();
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
			}
			
			if ($user->TestPassword($obj['password']) === false) {
				$database->Rollback();
				return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 401);
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
						return Response::NewJsonError('Verification needed', ['code' => '2FA_ENABLED'], 403);
					}
				}
				
				if ($user->Verify2FACode($verification_code) === false) {
					$database->Rollback();
					return Response::NewJsonError('Verification needed', ['code' => '2FA_ENABLED'], 403);
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
			
			return Response::NewJson($session, 201);
		} catch (Exception $err) {
			if ($database->InTransaction()) {
				$database->ResetTransactions();
			}
			return Response::NewJsonError('Internal server error', ['code' => 'EXCEPTION', 'message' => $err->getMessage()], 500);
		}
	} else if (BeaconCommon::HasAllKeys($obj, 'grant_type', 'redirect_uri', 'code', 'client_id', 'client_secret')) {
		// OAuth
		if ($obj['grant_type'] !== 'authorization_code') {
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}
		$session = ApplicationAuthFlow::Redeem($obj['client_id'], $obj['client_secret'], $obj['redirect_uri'], $obj['code']);
		if (is_null($session)) {
			return Response::NewJsonError('Invalid code', ['code' => 'INVALID_CODE'], 400);
		}
		return Response::NewJson($session, 201);
	} else {
		return Response::NewJsonError('Invalid authorization parameters', null, 401);
	}
}

?>