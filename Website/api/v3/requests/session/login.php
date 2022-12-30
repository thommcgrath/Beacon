<?php

BeaconAPI::Authorize(BeaconAPI::AUTH_PERMISSIVE);
	
function handle_request(array $context): void {
	$user = BeaconAPI::User();
	if (is_null($user) || $user->CanSignIn() === false) {
		BeaconAPI::ReplyError('Invalid user', ['code' => 'USER_DISABLED'], 400);
	}
	
	$obj = BeaconAPI::JSONPayload();
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
	
	$session = BeaconSession::Create($user, $verification_code);
	if (is_null($session)) {
		BeaconAPI::ReplyError('Verification needed', ['code' => '2FA_ENABLED'], 403);
	}
	
	if (is_null($device_id) === false) {
		if ($trust === true) {
			$user->TrustDevice($device_id);
		} else if ($trust === false) {
			$user->UntrustDevice($device_id);
		}
	}
	
	BeaconAPI::ReplySuccess($session);
}

?>