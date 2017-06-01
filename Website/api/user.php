<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$method = BeaconAPI::Method();
$database = ConnectionManager::BeaconDatabase();
$user_id = BeaconAPI::ObjectID();
if (($user_id === null) || (!ZirconCommon::IsUUID($user_id))) {
	BeaconAPI::ReplyError('No user specified.');
}

switch ($method) {
case 'PUT':
case 'POST':
	$results = $database->Query('SELECT public_key FROM users WHERE user_id = $1;', $user_id);
	if ($results->RecordCount() == 1) {
		BeaconAPI::ReplyError('User already exists');
	}
	
	BeaconAPI::RequireKeys('public_key');
	$request = BeaconAPI::JSONPayload();
	$public_key = $request['public_key'];
	
	// Prepare the public key if necessary
	if (substr($public_key, 0, 26) == '-----BEGIN PUBLIC KEY-----') {
		// Ready for use
	} else {
		// Needs conversion
		$public_key = hex2bin($public_key);
		$public_key = trim(chunk_split(base64_encode($public_key), 64, "\n"));
		$public_key = "-----BEGIN PUBLIC KEY-----\n$public_key\n-----END PUBLIC KEY-----";
	}
	
	$database->BeginTransaction();
	$database->Query('INSERT INTO users (user_id, public_key) VALUES ($1, $2);', $user_id, $public_key);
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'GET':
	$results = $database->Query('SELECT public_key FROM users WHERE user_id = $1;', $user_id);
	if ($results->RecordCount() == 0) {
		BeaconAPI::ReplyError('User does not exist.', null, 404);
	}
	
	BeaconAPI::ReplySuccess(array('public_key' => $results->Field('public_key')));
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if ($user_id !== BeaconAPI::UserID()) {
		BeaconAPI::ReplyError('Cannot delete another user.');
	}
	
	$database->BeginTransaction();
	$database->Query('DELETE FROM users WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}