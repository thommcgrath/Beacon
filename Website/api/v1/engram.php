<?php

// Anybody can GET information about any engram without authorization. Other
// actions require authentication.

require(dirname(__FILE__) . '/loader.php');

$engram_class = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'GET':
	if ($engram_class === null) {
		// list engrams
		if (isset($_GET['mod_id'])) {
			$engrams = BeaconEngram::GetByModID($_GET['mod_id']);
		} else {
			$engrams = BeaconEngram::GetAll();
		}
		BeaconAPI::ReplySuccess($engrams);
	} else {
		// specific engram(s)
		$engrams = BeaconEngram::GetByClass($engram_class);
		if (count($engrams) === 0) {
			BeaconAPI::ReplyError('No engram found', null, 404);
		}
		if (BeaconAPI::ObjectCount() == 1) {
			BeaconAPI::ReplySuccess($engrams[0]);
		} else {
			BeaconAPI::ReplySuccess($engrams);
		}
	}
	break;
case 'PUT':
case 'POST':
	BeaconAPI::Authorize();
	if ($engram_class !== null) {
		BeaconAPI::ReplyError('Do not specify a class when saving engrams.');
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
	
	// get the distinct workshop ids for each item
	$workshop_ids = array();
	foreach ($items as $item) {
		if (!BeaconCommon::HasAllKeys($item, 'class', 'label', 'mod_id', 'availability', 'can_blueprint')) {
			BeaconAPI::ReplyError('Not all keys are present.', $item);
		}
		
		$workshop_id = $item['mod_id'];
		if (in_array($workshop_id, $workshop_ids) === false) {
			$workshop_ids[] = $workshop_id;
		}
	}
	
	// get mod ids from workshop ids
	$mod_ids = array();
	$results = $database->Query('SELECT mod_id, user_id, workshop_id FROM mods WHERE confirmed = TRUE AND workshop_id = ANY($1);', '{' . implode(',', $workshop_ids) . '}');
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Mod ' . $results->Field('workshop_id') . ' does not belong to you.');
		}
		
		$mod_ids[$results->Field('workshop_id')] = $results->Field('mod_id');
		
		$results->MoveNext();
	}
	
	// start inserting
	$database->BeginTransaction();
	foreach ($items as $item) {
		$workshop_id = $item['mod_id'];
		if (!array_key_exists($workshop_id, $mod_ids)) {
			$database->Rollback();
			BeaconAPI::ReplyError('Mod ' . $workshop_id . ' does not exist.');
		}
		$mod_id = $mod_ids[$workshop_id];
		$class = $item['class'];
		$label = $item['label'];
		$availability_keys = $item['availability'];
		$can_blueprint = $item['can_blueprint'];
		
		$availability = 0;
		if (is_array($availability_keys)) {
			foreach ($availability_keys as $key) {
				$key = strtolower(trim($key));
				if ($key === 'island') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_ISLAND;
				}
				if ($key === 'scorched') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_SCORCHED;
				}
			}
		}
		if ($availability === 0) {
			$database->Rollback();
			BeaconAPI::ReplyError('Availability for class ' . $class . ' cannot be zero.');
		}
		
		$results = $database->Query('SELECT mod_id FROM engrams WHERE classstring = $1;', $class);
		if ($results->RecordCount() == 1) {
			// update
			if ($results->Field('mod_id') !== $mod_id) {
				$database->Rollback();
				BeaconAPI::ReplyError('Class ' . $class . ' already belongs to another mod.');
			}
			$database->Query('UPDATE engrams SET label = $2, availability = $3, can_blueprint = $4 WHERE classstring = $1;', $class, $label, $availability, $can_blueprint);
		} else {
			// new
			$database->Query('INSERT INTO engrams (classstring, label, availability, can_blueprint, mod_id) VALUES ($1, $2, $3, $4, $5);', $class, $label, $availability, $can_blueprint, $mod_id);
		}
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (($engram_class === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$engram_class = BeaconAPI::Body();
	}
	if (($engram_class === null) || ($engram_class === '')) {
		BeaconAPI::ReplyError('No engram specified');
	}
	
	$results = $database->Query('SELECT mods.user_id, engrams.classstring FROM engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id) WHERE engrams.classstring = ANY($1);', '{' . $engram_class . '}');
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Engram does not belong to you.');
		}
		$results->MoveNext();
	}
		
	$database->BeginTransaction();
	$database->Query('DELETE FROM engrams WHERE classstring = ANY($1);', '{' . $engram_class . '}');
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>