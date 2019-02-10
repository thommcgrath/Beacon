#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$mods = BeaconMod::GetPullMods();
if (count($mods) == 0) {
	exit;
}

foreach ($mods as $mod) {
	try {
		PullMod($mod);
	} catch (Exception $e) {
		SendAlert($mod, 'Exception: ' . $e->getMessage());
	}
}

function PullMod(BeaconMod $mod) {
	$mod_description = $mod->Name() . ' (' . $mod->ModID() . ')';
	$mod_id = $mod->ModID();
	
	$http = curl_init($mod->PullURL());
	curl_setopt($http, CURLOPT_RETURNTRANSFER, true);
	$body = curl_exec($http);
	$status = curl_getinfo($http, CURLINFO_HTTP_CODE);
	$content_type = curl_getinfo($http, CURLINFO_CONTENT_TYPE);
	curl_close($http);
	
	if ($status != 200) {
		SendAlert($mod, 'Failed with HTTP status ' . $status . '.');
		return;
	}
	
	if ($content_type === null) {
		SendAlert($mod, 'Did not include Content-Type header.');
		return;
	}
	
	$hash = md5($body);
	if ($mod->LastPullHash() !== null) {
		$last_hash = $mod->LastPullHash();
		if (strtolower($hash) === strtolower($last_hash)) {
			// no changes
			return;
		}
	}
	
	switch ($content_type) {
	case 'application/json':
		$engrams = json_decode($body, true);
		if ($engrams === false) {
			SendAlert($mod, 'Could not parse JSON content.');
		}
		break;
	case 'text/csv':
		$lines = explode("\n", $body);
		$headers = str_getcsv(array_shift($lines));
		$engrams = array();
		foreach ($lines as $line) {
			$engram = array();
			foreach (str_getcsv($line) as $key => $field) {
				$engram[$headers[$key]] = $field;
			}
			$engram = array_filter($engram);
			$engrams[] = $engram;
		}
		break;
	default:
		SendAlert($mod, 'Unexpected content type: ' . $content_type . '.');
		return;
	}
	
	if (BeaconCommon::IsAssoc($engrams)) {
		// single
		$engrams = array($engrams);
	}
	
	// get the distinct workshop ids for each item
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($engrams as $engram) {
		if (!BeaconCommon::HasAllKeys($engram, 'path', 'label', 'availability', 'can_blueprint')) {
			$database->Rollback();
			SendAlert($mod, 'An engram is missing keys.');
			return;
		}
		
		$path = $engram['path'];
		$label = $engram['label'];
		$availability_keys = $engram['availability'];
		$can_blueprint = BeaconCommon::BooleanValue($engram['can_blueprint']);
		$harvestable = isset($engram['harvestable']) ? BeaconCommon::BooleanValue($engram['harvestable']) : false;
		
		$availability = 0;
		if (is_string($availability_keys)) {
			$availability_keys = explode(',', $availability_keys);
		}
		if (is_array($availability_keys)) {
			foreach ($availability_keys as $key) {
				$key = strtolower(trim($key));
				if ($key === 'island') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_ISLAND;
				}
				if ($key === 'scorched') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_SCORCHED;
				}
				if ($key === 'center') {
					$availability = $availability | BeaconMaps::TheCenter;
				}
				if ($key === 'ragnarok') {
					$availability = $availability | BeaconMaps::Ragnarok;
				}
				if (($key === 'abberation') || ($key === 'aberration')) {
					$availability = $availability | BeaconMaps::Aberration;
				}
				if ($key === 'extinction') {
					$availability = $availability | BeaconMaps::Extinction;
				}
			}
		}
		if ($availability === 0) {
			$database->Rollback();
			SendAlert($mod, 'Engram ' . $path . ' does not have an availability.');
			return;
		}
		
		$results = $database->Query('SELECT mod_id FROM engrams WHERE path = $1;', $path);
		if ($results->RecordCount() == 1) {
			// update
			if ($results->Field('mod_id') !== $mod_id) {
				$database->Rollback();
				SendAlert($mod, 'Engram ' . $path . ' belongs to another mod.');
				return;
			}
			$database->Query('UPDATE engrams SET label = $2, availability = $3, can_blueprint = $4, harvestable = $5 WHERE path = $1;', $path, $label, $availability, $can_blueprint, $harvestable);
		} else {
			// new
			$database->Query('INSERT INTO engrams (path, label, availability, can_blueprint, mod_id, harvestable) VALUES ($1, $2, $3, $4, $5, $6);', $path, $label, $availability, $can_blueprint, $mod_id, $harvestable);
		}
	}
	$database->Query('UPDATE mods SET last_pull_hash = $2 WHERE mod_id = $1;', $mod_id, $hash);
	$database->Commit();
}

function SendAlert(BeaconMod $mod, string $message) {
	$message_with_name = $mod->Name() . ' (' . $mod->WorkshopID() . '): ' . $message;
	if (getenv('SSH_CLIENT')) {
		echo "$message_with_name\n";
	} else {
		BeaconCommon::PostSlackMessage($message_with_name);
		
		$fields = array(
			'mod_id' => $mod->WorkshopID(),
			'message' => $message
		);
		
		$http = curl_init($mod->PullURL());
		curl_setopt($http, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($http, CURLOPT_POSTFIELDS, $fields);
		curl_exec($http);
		curl_close($http);
	}
}

?>