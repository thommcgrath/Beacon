<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
$database = BeaconCommon::Database();
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
	if (BeaconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
	} else {
		// multiple
		$items = $payload;
	}
	
	$database->BeginTransaction();
	foreach ($items as $item) {
		if (!BeaconCommon::HasAllKeys($item, 'user_id', 'public_key')) {
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
		
		$database->Query('INSERT INTO users (user_id, public_key) VALUES ($1, $2);', $user_id, BeaconEncryption::PublicKeyToPEM($public_key));
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'GET':
	if (is_null(BeaconAPI::ObjectID())) {
		BeaconAPI::Authorize();
		BeaconAPI::ReplySuccess(BeaconUser::GetByUserID(BeaconAPI::UserID()));
	} else {
		// legacy support
		$identifiers = explode(',', BeaconAPI::ObjectID());
		$users = array();
		foreach ($identifiers as $identifier) {
			if (BeaconCommon::IsUUID($identifier)) {
				$user = BeaconUser::GetByUserID($identifier);
			}
			if (!is_null($user)) {
				// don't use the regular method that includes lots of values
				$users[] = array(
					'user_id' => $user->UserID(),
					'public_key' => $user->PublicKey()
				);
			}
		}
		if (count($users) == 1) {
			BeaconAPI::ReplySuccess($users[0]);
		} else {
			BeaconAPI::ReplySuccess($users);
		}
	}
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if ($user_id !== BeaconAPI::UserID()) {
		BeaconAPI::ReplyError('Cannot delete another user.');
	}
	
	$database->BeginTransaction();
	$database->Query('DELETE FROM documents WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Query('DELETE FROM mods WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Query('DELETE FROM users WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}