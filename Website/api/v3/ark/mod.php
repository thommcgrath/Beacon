<?php

// All mod operations require authentication

require(dirname(__FILE__, 2) . '/loader.php');

BeaconAPI::Authorize();
$user_id = BeaconAPI::UserID();

$workshop_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'GET':
	if (is_null($workshop_id)) {
		$mods = Ark\Mod::GetAll($user_id);
		BeaconAPI::ReplySuccess($mods);
	} else {
		$mods = Ark\Mod::GetByWorkshopID($user_id, $workshop_id);
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
	if (BeaconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
	} else {
		// multiple
		$items = $payload;
	}
	
	$mods = array();
	$database->BeginTransaction();
	foreach ($items as $item) {
		if (BeaconCommon::HasAllKeys($item, 'mod_id') === false) {
			$database->Rollback();
			BeaconAPI::ReplyError('Not all keys are present.', $item);
		}
		$workshop_id = $item['mod_id'];
		if (is_numeric($workshop_id) === false) {
			$database->Rollback();
			BeaconAPI::ReplyError('Mod ID must be numeric.', $item);
		}
		$workshop_id = abs(intval($workshop_id));
		$pull_url = null;
		if (isset($item['pull_url'])) {
			$pull_url = filter_var($item['pull_url'], FILTER_VALIDATE_URL, FILTER_FLAG_SCHEME_REQUIRED | FILTER_FLAG_HOST_REQUIRED);
			if ($pull_url === false) {
				$database->Rollback();
				BeaconAPI::ReplyError('Pull URL is not valid.', $item['pull_url']);
			}
			if (substr($pull_url, 0, 4) !== 'http') {
				$database->Rollback();
				BeaconAPI::ReplyError('Must use http or https urls.', $item['pull_url']);
			}
		}
	
		$results = $database->Query('SELECT mod_id, user_id, confirmed FROM mods WHERE ABS(workshop_id) = $1;', $workshop_id);
		if ($results->RecordCount() == 1) {
			$mod_user_id = $results->Field('user_id');
			$mod_uuid = $results->Field('mod_id');
			$mod_confirmed = $results->Field('confirmed');
			if ($mod_confirmed && $mod_user_id !== $user_id) {
				$database->Rollback();
				BeaconAPI::ReplyError('Mod belongs to another user.');
			}
			
			try {
				$database->Query('UPDATE mods SET pull_url = $2 WHERE mod_id = $1;', $mod_uuid, $pull_url);
			} catch (\BeaconQueryException $e) {
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not updated: ' . $e->getMessage());
			}
		} else {
			$workshop_item = BeaconWorkshopItem::Load($workshop_id);
			if ($workshop_item === null) {
				$database->Rollback();
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not found on Ark Workshop.');
			}
			
			try {
				$results = $database->Query('INSERT INTO mods (workshop_id, name, user_id, pull_url, min_version) VALUES ($1, $2, $3, $4, 10500000) RETURNING mod_id;', $workshop_id, $workshop_item->Name(), $user_id, $pull_url);
				$mod_uuid = $results->Field('mod_id');
			} catch (BeaconQueryException $e) {
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not registered: ' . $e->getMessage());
			}
		}
		
		$mods[] = Ark\Mod::GetByModID($mod_uuid);
	}
	$database->Commit();
		
	BeaconAPI::ReplySuccess($mods);
	
	break;
case 'DELETE':
	if (($workshop_id === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$workshop_id = BeaconAPI::Body();
	}
	if (($workshop_id === null) || ($workshop_id === '')) {
		BeaconAPI::ReplyError('No mod specified');
	}
	
	$mods = Ark\Mod::GetByWorkshopID($user_id, $workshop_id);
	if (count($mods) == 0) {
		BeaconAPI::ReplyError('No mods found.', null, 404);
	}
	
	$database->BeginTransaction();
	foreach ($mods as $mod) {
		$mod->Delete();
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', $method, 405);
	break;
}

?>