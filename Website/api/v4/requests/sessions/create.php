<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Response, Core, Session, User};

$requiredScopes = [Application::kScopePasswordAuth];
$authScheme = Core::kAuthSchemeDigest;

// To issue a token, both the client and the user need to be positively identified
// This can either be done with the username and password, or with OAuth.
// For OAuth, the redemption request will include the client id and secret
// For password, we cannot simply include the secret so a challenge is needed.
	
function handleRequest(array $context): Response {
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	} else {
		$obj = [
			'email' => $_POST['email'] ?? '',
			'password' => $_POST['password'] ?? '',
			'verification_code' => $_POST['verification_code'] ?? null,
			'trust' => $_POST['trust'] ?? null,
			'device_id' => $_POST['device_id'] ?? null
		];
	}
	
	if (BeaconCommon::HasAllKeys($obj, 'email', 'password') === false) {
		return Response::NewJsonError('Must include email and password parameters', null, 400);
	}
	
	// Password auth
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		
		$user = User::Fetch($obj['email']);
		if (is_null($user)) {
			$database->Rollback();
			return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 400);
		}
		
		if ($user->TestPassword($obj['password']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Authorization failed', ['code' => 'BAD_LOGIN'], 400);
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
		
		$application = Core::Application();
		$session = Session::Create($user, $application);
		Core::SetSession($session);
		$database->Commit();
		
		return Response::NewJson($session, 201);
	} catch (Exception $err) {
		if ($database->InTransaction()) {
			$database->ResetTransactions();
		}
		return Response::NewJsonError('Internal server error', ['code' => 'EXCEPTION', 'message' => $err->getMessage()], 500);
	}
}

?>