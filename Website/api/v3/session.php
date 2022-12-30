<?php

// All session operations require authentication

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::Authorize(BeaconAPI::AUTH_PERMISSIVE);
$user = BeaconAPI::User();
$user_id = $user->UserID();

$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'GET':
	// retrieve session object
	$session_id = BeaconAPI::ObjectID();
	$session = BeaconSession::GetBySessionID($session_id);
	if (($session === null) || ($session->UserID() !== $user_id) || $user->CanSignIn() === false) {
		BeaconAPI::ReplyError('Session not found', [
			'code' => 'NOT_FOUND'
		], 404);
	}
	
	$obj = $session->jsonSerialize();
	$obj['totp_secret'] = $user->Get2FASecret();
	BeaconAPI::ReplySuccess($obj);
	
	break;
case 'POST':
	// create a session, returns a session object
	if (is_null($user) || $user->CanSignIn() === false) {
		BeaconAPI::ReplyError('Invalid user', [
			'code' => 'USER_DISABLED'
		], 400);
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
		BeaconAPI::ReplyError('Verification needed', [
			'code' => '2FA_ENABLED'
		], 403);
	}
	
	if (is_null($device_id) === false) {
		if ($trust === true) {
			$user->TrustDevice($device_id);
		} else if ($trust === false) {
			$user->UntrustDevice($device_id);
		}
	}
	
	BeaconAPI::ReplySuccess($session);
	
	break;
case 'DELETE':
	// delete a session
	
	$session_id = BeaconAPI::ObjectID();
	$session = BeaconSession::GetBySessionID($session_id);
	if (($session === null) || ($session->UserID() !== $user_id) || $session->User()->CanSignIn() === false) {
		BeaconAPI::ReplyError('Session not found', [
			'code' => 'NOT_FOUND'
		], 404);
	}
	
	$session->Delete();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>