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
	BeaconAPI::Authenticate();
	BeaconAPI::ReplySuccess(BeaconUser::GetByUserID(BeaconAPI::UserID()));	
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