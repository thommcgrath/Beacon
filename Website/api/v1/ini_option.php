<?php

require(dirname(__FILE__) . '/loader.php');

$object_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'GET':
	if ($object_id === null) {
		// list engrams
		if (isset($_GET['mod_id'])) {
			$configs = BeaconConfigLine::Get($_GET['mod_id']);
		} else {
			$configs = BeaconConfigLine::Get();
		}
		BeaconAPI::ReplySuccess($configs);
	} else {
		// specific engram(s)
		$configs = BeaconConfigLine::Get($object_id);
		if (count($configs) === 0) {
			BeaconAPI::ReplyError('No ini option found', null, 404);
		}
		if (count($configs) == 1) {
			BeaconAPI::ReplySuccess($configs[0]);
		} else {
			BeaconAPI::ReplySuccess($configs);
		}
	}
	break;
case 'PUT':
case 'POST':
	BeaconAPI::Authorize();
	if ($object_id !== null) {
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
		if (!BeaconCommon::HasAllKeys($item, 'object_id', 'mod_id', 'label', 'file', 'header', 'key', 'value_type', 'max_allowed', 'description', 'default_value')) {
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
	$configs = array();
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
		
		$config_id = $item['object_id'];
		$config_label = $item['label'];
		$config_key = $item['key'];
		$config_header = $item['header'];
		$config_file = $item['file'];
		$config_type = $item['value_type'];
		$config_max = is_null($item['max_allowed']) ? null : (intval($item['max_allowed']) > 0 ? intval($item['max_allowed']) : null);
		$config_description = $item['description'];
		$config_default = $item['default_value'];
		
		$results = $database->Query('SELECT mod_id FROM ini_options WHERE object_id = $1;', $config_id);
		try {
			if ($results->RecordCount() == 1) {
				// update
				if ($results->Field('mod_id') !== $mod_id) {
					$database->Rollback();
					BeaconAPI::ReplyError('Config ' . $config_id . ' already belongs to another mod.');
				}
				$database->Query('UPDATE ini_options SET label = $2, file = $3, header = $4, key = $5, value_type = $6, max_allowed = $7, description = $8, default_value = $9 WHERE object_id = $1;', $config_id, $config_label, $config_file, $config_header, $config_key, $config_type, $config_max, $config_description, $config_default);
			} else {
				// new
				$database->Query('INSERT INTO ini_options (object_id, label, file, header, key, value_type, max_allowed, description, default_value, mod_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);', $config_id, $config_label, $config_file, $config_header, $config_key, $config_type, $config_max, $config_description, $config_default, $mod_id);
			}
		} catch (Exception $e) {
			BeaconAPI::ReplyError('Unable to save config option: ' . $e->getMessage(), $item);
		}
		
		$config = BeaconConfigLine::Get($config_id);
		if (!is_null($config) && count($config) == 1) {
			$configs[] = $config[0];
		}
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess($configs);
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (($object_id === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$object_id = BeaconAPI::Body();
	}
	if (($object_id === null) || ($object_id === '')) {
		BeaconAPI::ReplyError('No engram specified');
	}
	
	$results = $database->Query('SELECT mods.user_id, ini_options.object_id FROM ini_options INNER JOIN mods ON (ini_options.mod_id = mods.mod_id) WHERE ini_options.object_id = ANY($1);', '{' . $object_id . '}');
	$objects = array();
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Engram does not belong to you.');
		}
		$objects[] = $results->Field('object_id');
		$results->MoveNext();
	}
		
	$database->BeginTransaction();
	$database->Query('DELETE FROM ini_options WHERE object_id = ANY($1);', '{' . implode(',', $objects) . '}');
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	break;
}

?>