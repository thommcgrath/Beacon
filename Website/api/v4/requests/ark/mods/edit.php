<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
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
	
	$mods = [];
	$database = \BeaconCommon::Database();
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
	
		$results = $database->Query('SELECT mod_id, user_id, confirmed FROM ark.mods WHERE ABS(workshop_id) = $1;', $workshop_id);
		if ($results->RecordCount() === 1) {
			$mod_user_id = $results->Field('user_id');
			$mod_uuid = $results->Field('mod_id');
			$mod_confirmed = $results->Field('confirmed');
			if ($mod_confirmed && $mod_user_id !== $user_id) {
				$database->Rollback();
				BeaconAPI::ReplyError('Mod belongs to another user.');
			}
			
			try {
				$database->Query('UPDATE ark.mods SET pull_url = $2 WHERE mod_id = $1;', $mod_uuid, $pull_url);
			} catch (\BeaconQueryException $e) {
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not updated: ' . $e->getMessage());
			}
		} else {
			$workshop_item = BeaconWorkshopItem::Load($workshop_id);
			if (is_null($workshop_item)) {
				$database->Rollback();
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not found on Ark Workshop.');
			}
			
			try {
				$results = $database->Query('INSERT INTO ark.mods (workshop_id, name, user_id, pull_url, min_version) VALUES ($1, $2, $3, $4, 10500000) RETURNING mod_id;', $workshop_id, $workshop_item->Name(), $user_id, $pull_url);
				$mod_uuid = $results->Field('mod_id');
			} catch (BeaconQueryException $e) {
				BeaconAPI::ReplyError('Mod ' . $workshop_id . ' was not registered: ' . $e->getMessage());
			}
		}
		
		$mods[] = Ark\Mod::GetByModID($mod_uuid);
	}
	$database->Commit();
		
	BeaconAPI::ReplySuccess($mods);
}

?>