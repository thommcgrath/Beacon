<?php

// All session operations require authentication

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::Authorize();
$user_id = BeaconAPI::UserID();

$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'GET':
	// retrieve session object
	$session_id = BeaconAPI::ObjectID();
	$session = BeaconSession::GetBySessionID($session_id);
	if (($session === null) || ($session->UserID() !== $user_id) || $session->User()->CanSignIn() === false) {
		BeaconAPI::ReplyError('Session not found', null, 404);
	}
	
	BeaconAPI::ReplySuccess($session);
	
	break;
case 'POST':
	// create a session, returns a session object
	$user = \BeaconUser::GetByUserID($user_id);
	if (is_null($user) || $user->CanSignIn() === false) {
		BeaconAPI::ReplyError('Invalid user', null, 400);
	}
	
	$session = BeaconSession::Create($user);
	BeaconAPI::ReplySuccess($session);
	
	break;
case 'DELETE':
	// delete a session
	
	$session_id = BeaconAPI::ObjectID();
	$session = BeaconSession::GetBySessionID($session_id);
	if (($session === null) || ($session->UserID() !== $user_id) || $session->User()->CanSignIn() === false) {
		BeaconAPI::ReplyError('Session not found', null, 404);
	}
	
	$session->Delete();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>