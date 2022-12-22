<?php

// All session operations require authentication

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::Authorize();
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
	if (is_null($obj) === false && isset($obj['verification_code'])) {
		$verification_code = (string) $obj['verification_code'];
	}
	
	$session = BeaconSession::Create($user, $verification_code);
	if (is_null($session)) {
		BeaconAPI::ReplyError('Verification needed', [
			'code' => '2FA_ENABLED'
		], 403);
	}
	$obj = $session->jsonSerialize();
	$obj['totp_secret'] = $user->Get2FASecret();
	BeaconAPI::ReplySuccess($obj);
	
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