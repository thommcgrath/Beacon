<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$method = BeaconAPI::Method();
$database = ConnectionManager::BeaconDatabase();
$user_id = BeaconAPI::ObjectID();

switch ($method) {
case 'PUT':
case 'POST':
	if ($user_id !== null) {
		BeaconAPI::ReplyError('Do not specify a user when creating users.');
	}
	
	if (BeaconAPI::ContentType() !== 'application/json') {
		BeaconAPI::ReplyError('Send a JSON payload');
	}
	
	$payload = BeaconAPI::JSONPayload();
	if (ZirconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
	} else {
		// multiple
		$items = $payload;
	}
	
	$database->BeginTransaction();
	foreach ($items as $item) {
		if (!ZirconCommon::HasAllKeys($item, 'user_id', 'public_key')) {
			$database->Rollback();
			BeaconAPI::ReplyError('Not all keys are present.', $item);
		}
	
		$user_id = $item['user_id'];
		$public_key = $item['public_key'];
		
		$results = $database->Query('SELECT public_key FROM users WHERE user_id = $1;', $user_id);
		if ($results->RecordCount() == 1) {
			$database->Rollback();
			BeaconAPI::ReplyError('User ' . $user_id . 'already exists');
		}
		
		// Prepare the public key if necessary
		if (substr($public_key, 0, 26) == '-----BEGIN PUBLIC KEY-----') {
			// Ready for use
		} else {
			// Needs conversion
			$public_key = hex2bin($public_key);
			$public_key = trim(chunk_split(base64_encode($public_key), 64, "\n"));
			$public_key = "-----BEGIN PUBLIC KEY-----\n$public_key\n-----END PUBLIC KEY-----";
		}
		
		$database->Query('INSERT INTO users (user_id, public_key) VALUES ($1, $2);', $user_id, $public_key);
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'GET':
	if ($user_id === null) {
		BeaconAPI::ReplyError('Listing users is not allowed', null, 405);
	}
	
	$results = $database->Query('SELECT user_id, public_key FROM users WHERE user_id = ANY($1);', '{' . $user_id . '}');
	if ($results->RecordCount() == 0) {
		BeaconAPI::ReplyError('User does not exist.', null, 404);
	}
	
	$users = array();
	while (!$results->EOF()) {
		$users[] = array(
			'user_id' => $results->Field('user_id'),
			'public_key' => $results->Field('public_key')
		);
		$results->MoveNext();
	}
	
	if (count($users) == 1) {
		BeaconAPI::ReplySuccess($users[0]);
	} else {
		BeaconAPI::ReplySuccess($users);
	}
	
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