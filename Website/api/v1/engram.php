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
			$engrams = BeaconEngram::Get($_GET['mod_id']);
		} else {
			$engrams = BeaconEngram::Get();
		}
		BeaconAPI::ReplySuccess($engrams);
	} else {
		// specific engram(s)
		$engrams = BeaconEngram::Get($engram_class);
		if (count($engrams) === 0) {
			BeaconAPI::ReplyError('No engram found', null, 404);
		}
		if (count($engrams) == 1) {
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
	$mod_ids = array();
	foreach ($items as $item) {
		if (!BeaconCommon::HasAllKeys($item, 'path', 'label', 'mod_id', 'availability')) {
			BeaconAPI::ReplyError('Not all keys are present.', $item);
		}
		
		if (is_int($item['mod_id'])) {
			$workshop_id = $item['mod_id'];
			if (in_array($workshop_id, $workshop_ids) === false) {
				$workshop_ids[] = $workshop_id;
			}
		} elseif (BeaconCommon::IsUUID($item['mod_id'])) {
			$mod_id = $item['mod_id'];
			if (in_array($mod_id, $mod_ids) === false) {
				$mod_ids[] = $mod_id;
			}
		}
	}
	
	if (count($workshop_ids) > 0 && count($mod_ids) > 0) {
		$results = $database->Query('SELECT DISTINCT mod_id, workshop_id FROM mods WHERE confirmed = TRUE AND user_id = $1 AND (workshop_id = ANY($2) OR mod_id = ANY($3));', BeaconAPI::UserID(), '{' . implode(',', $workshop_ids) . '}', '{' . implode(',', $mod_ids) . '}');
	} elseif (count($workshop_ids) > 0) {
		$results = $database->Query('SELECT DISTINCT mod_id, workshop_id FROM mods WHERE confirmed = TRUE AND user_id = $1 AND workshop_id = ANY($2);', BeaconAPI::UserID(), '{' . implode(',', $workshop_ids) . '}');
	} elseif (count($mod_ids) > 0) { 
		$results = $database->Query('SELECT DISTINCT mod_id, workshop_id FROM mods WHERE confirmed = TRUE AND user_id = $1 AND mod_id = ANY($2);', BeaconAPI::UserID(), '{' . implode(',', $mod_ids) . '}');
	} else {
		BeaconAPI::ReplyError('No mods specified.', null);
	}
	if ($results->RecordCount() == 0) {
		BeaconAPI::ReplyError('No authorized mods found.', null);
	}
	
	$mods = array();
	while (!$results->EOF()) {
		$mods[$results->Field('workshop_id')] = $results->Field('mod_id');
		$results->MoveNext();
	}
	
	// start inserting
	$engrams = array();
	$database->BeginTransaction();
	foreach ($items as $item) {
		if (BeaconCommon::IsUUID($item['mod_id'])) {
			$mod_id = $item['mod_id'];
			if (!in_array($mod_id, $mods)) {
				continue;
			}
		} else {
			if (!array_key_exists($item['mod_id'], $mods)) {
				continue;
			}
			$mod_id = $mods[$item['mod_id']];
		}
		
		$path = $item['path'];
		$label = $item['label'];
		$availability = 0;
		$availability_keys = null;
		
		$tags = array();
		if (isset($item['tags'])) {
			if (is_string($item['tags'])) {
				$item_tags = explode(',', $item['tags']);
			} elseif (is_array($item['tags'])) {
				$item_tags = $item['tags'];
			} else {
				$item_tags = array();
			}
			foreach ($item['tags'] as $tag) {
				$tags[] = BeaconObject::NormalizeTag($tag);
			}
		} else {
			if (isset($item['can_blueprint']) && BeaconCommon::BooleanValue($item['can_blueprint'])) {
				$tags[] = 'blueprintable';
			}
			if (isset($item['harvestable']) && BeaconCommon::BooleanValue($item['harvestable'])) {
				$tags[] = 'harvestable';
			}
		}
		$tags = '{' . implode(',', $tags) . '}';
		
		if (array_key_exists('availability', $item)) {
			if (is_int($item['availability'])) {
				$availability = $item['availability'];
			} elseif (is_array($item['availability'])) {
				$availability_keys = $item['availability'];
			}
		}
		if (array_key_exists('environments', $item) && is_array($item['environments'])) {
			$availability_keys = $item['environments'];
		}
		
		if (is_array($availability_keys)) {
			foreach ($availability_keys as $key) {
				$key = strtolower(trim($key));
				if ($key === 'island') {
					$availability = $availability | BeaconMaps::TheIsland;
				}
				if ($key === 'scorched') {
					$availability = $availability | BeaconMaps::ScorchedEarth;
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
			BeaconAPI::ReplyError('Availability for class ' . $path . ' cannot be zero.');
		}
		
		$results = $database->Query('SELECT mod_id FROM engrams WHERE path = $1;', $path);
		if ($results->RecordCount() == 1) {
			// update
			if ($results->Field('mod_id') !== $mod_id) {
				$database->Rollback();
				BeaconAPI::ReplyError('Class ' . $path . ' already belongs to another mod.');
			}
			$database->Query('UPDATE engrams SET label = $2, availability = $3, tags = $4 WHERE path = $1;', $path, $label, $availability, $tags);
		} else {
			// new
			$database->Query('INSERT INTO engrams (path, label, availability, tags, mod_id) VALUES ($1, $2, $3, $4, $5, $6);', $path, $label, $availability, $tags, $mod_id);
		}
		
		$engram = BeaconEngram::Get($path);
		if (!is_null($engram) && count($engram) == 1) {
			$engrams[] = $engram[0];
		}
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess($engrams);
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (($engram_class === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$engram_class = BeaconAPI::Body();
	}
	if (($engram_class === null) || ($engram_class === '')) {
		BeaconAPI::ReplyError('No engram specified');
	}
	
	$results = $database->Query('SELECT mods.user_id, engrams.path FROM engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id) WHERE MD5(LOWER(engrams.path)) = ANY($1);', '{' . $engram_class . '}');
	$paths = array();
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Engram does not belong to you.');
		}
		$paths[] = $results->Field('path');
		$results->MoveNext();
	}
		
	$database->BeginTransaction();
	$database->Query('DELETE FROM engrams WHERE path = ANY($1);', '{' . implode(',', $paths) . '}');
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>
