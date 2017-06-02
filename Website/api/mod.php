<?php

// All mod operations require authentication

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

BeaconAPI::Authorize();
$user_id = BeaconAPI::UserID();

$workshop_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = ConnectionManager::BeaconDatabase();

switch ($method) {
case 'GET':
	if ($workshop_id === null) {
		$mods = BeaconMod::GetAll($user_id);
		BeaconAPI::ReplySuccess($mods);
	} else {
		$mods = BeaconMod::GetByWorkshopID($user_id, $workshop_id);
		if (count($mods) == 0) {
			BeaconAPI::ReplyError('Mod not found', null, 404);
		}
		
		if (isset($_GET['action']) && strtolower($_GET['action']) === 'confirm') {
			foreach ($mods as $mod) {
				$mod->AttemptConfirmation();
			}
		}
		
		if (BeaconAPI::ObjectCount() == 1) {
			BeaconAPI::ReplySuccess($mods[0]);
		} else {
			BeaconAPI::ReplySuccess($mods);
		}
	}
	
	break;
case 'PUT':
case 'POST':
	if ($workshop_id !== null) {
		BeaconAPI::ReplyError('Do not specify a class when registering mods.');
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
		if (!ZirconCommon::HasAllKeys($item, 'mod_id')) {
			$database->Rollback();
			BeaconAPI::ReplyError('Not all keys are present.', $item);
		}
		$workshop_id = $item['mod_id'];
	
		$results = $database->Query('SELECT user_id FROM mods WHERE workshop_id = $1 AND user_id = $2;', $workshop_id, $user_id);
		if ($results->RecordCount() == 1) {
			$database->Rollback();
			BeaconAPI::ReplyError('Mod ' . $workshop_id . ' is already registered.');
		}
		
		$workshop_id = ZirconWorkshopItem::Load($workshop_id);
		if ($workshop_id === null) {
			$database->Rollback();
			BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not found on Ark Workshop.');
		}
		
		try {
			$database->Query('INSERT INTO mods (workshop_id, name, user_id) VALUES ($1, $2, $3);', $workshop_id, $item->Name(), $user_id);
		} catch (\ZirconQueryException $e) {
			$database->Rollback();
			BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not registered: ' . $e->getMesage());
		}
	}
	$database->Commit();
		
	BeaconAPI::ReplySuccess();
	
	break;
case 'DELETE':
	if ($workshop_id === null) {
		BeaconAPI::ReplyError('No mod id.');
	}
	
	$results = $database->Query('SELECT user_id FROM mods WHERE workshop_id = $1;', $workshop_id);
	if ($results->RecordCount() == 0) {
		BeaconAPI::ReplyError('Mod is not registered.');
	}
	
	if ($results->Field('user_id') !== $user_id) {
		BeaconAPI::ReplyError('Mod is registered to a different user.');
	}
	
	$database->BeginTransaction();
	$database->Query('DELETE FROM mods WHERE workshop_id = $1;', $workshop_id);
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', $method, 405);
	break;
}

?>