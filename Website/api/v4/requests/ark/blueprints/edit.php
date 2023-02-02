<?php

// This endpoint can retrieve, save, and delete any blueprint type.
// It is most useful for mod editing. As such, its usage will be a little
// non-standard. GET actions are public, POST/PUT actions require
// authentication. There is no DELETE action, those are handled as part of
// POST/PUT.

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$database = \BeaconCommon::Database();
	$user_id = BeaconAPI::UserID();
	$blueprints = BeaconAPI::JSONPayload();
	$engrams = [];
	$creatures = [];
	$spawn_points = [];
	$loot_sources = [];
	$deletions = [];
	
	if (array_key_exists('engrams', $blueprints)) {
		$engrams = $blueprints['engrams'];
	}
	if (array_key_exists('creatures', $blueprints)) {
		$creatures = $blueprints['creatures'];
	}
	if (array_key_exists('spawn_points', $blueprints)) {
		$spawn_points = $blueprints['spawn_points'];
	}
	if (array_key_exists('loot_sources', $blueprints)) {
		$loot_sources = $blueprints['loot_sources'];
	}
	if (array_key_exists('deletions', $blueprints)) {
		$temp = $blueprints['deletions'];
		foreach ($temp as $object_id) {
			if (BeaconCommon::IsUUID($object_id) === false) {
				BeaconAPI::ReplyError('Deleted object is not a v4 UUID.', $object_id, 400);
			}
			
			$deletions[] = $object_id;
		}
	}
	
	$mod_ids = [];
	GetModIDs($mod_ids, $engrams);
	GetModIDs($mod_ids, $creatures);
	GetModIDs($mod_ids, $spawn_points);
	GetModIDs($mod_ids, $loot_sources);
	
	if (count($deletions) > 0) {
		// Although this looks like a potential for SQL injection, BeaconCommon::IsUUID validated and cleaned up the values.
		$rows = $database->Query('SELECT DISTINCT mod_id FROM ark.blueprints WHERE object_id IN (\'' . implode('\',\'', $deletions) . '\');');
		while (!$rows->EOF()) {
			$mod_id = $rows->Field('mod_id');
			if (in_array($mod_id, $mod_ids) === false) {
				$mod_ids[] = $mod_id;
			}
			$rows->MoveNext();
		}
	}
	
	if (count($mod_ids) === 0) {
		// What?
		BeaconAPI::ReplyError('No changes were made.', 400);
	}
	
	// Now confirm that the user has write permission for all the mods.
	$rows = $database->Query('SELECT mod_id, user_id, min_version FROM ark.mods WHERE mod_id IN (\'' . implode('\',\'', $mod_ids) . '\');');
	$versions = [];
	while (!$rows->EOF()) {
		if ($rows->Field('user_id') !== $user_id) {
			BeaconAPI::ReplyError('You are not authorized to edit this mod.', $mod_ids);
		}
		
		$mod_id = $rows->Field('mod_id');
		$versions[$mod_id] = intval($rows->Field('min_version'));
		$rows->MoveNext();
	}
	if (count($versions) != count($mod_ids)) {
		// At least one mod is missing
		BeaconAPI::ReplyError('One or more mod UUIDs are not known to Beacon.', $mod_ids);
	}
	
	$database->BeginTransaction();
	if (count($engrams) > 0) {
		foreach ($engrams as $values) {
			try {
				if (isset($values['min_version'])) {
					$values['min_version'] = max($values['min_version'], $versions[$values['mod']['id']]);
				} else {
					$values['min_version'] = $versions[$values['mod']['id']];
				}
				$obj = Ark\Engram::FromJSON($values);
				$obj->Save();
			} catch (Exception $err) {
				$database->Rollback();
				BeaconAPI::ReplyError('There was an error saving an object: ' . $err->getMessage(), $values, 500);
			}
		}
	}
	if (count($creatures) > 0) {
		foreach ($creatures as $values) {
			try {
				if (isset($values['min_version'])) {
					$values['min_version'] = max($values['min_version'], $versions[$values['mod']['id']]);
				} else {
					$values['min_version'] = $versions[$values['mod']['id']];
				}
				$obj = Ark\Creature::FromJSON($values);
				$obj->Save();
			} catch (Exception $err) {
				$database->Rollback();
				BeaconAPI::ReplyError('There was an error saving an object: ' . $err->getMessage(), $values, 500);
			}
		}
	}
	if (count($spawn_points) > 0) {
		foreach ($spawn_points as $values) {
			try {
				if (isset($values['min_version'])) {
					$values['min_version'] = max($values['min_version'], $versions[$values['mod']['id']]);
				} else {
					$values['min_version'] = $versions[$values['mod']['id']];
				}
				$obj = Ark\SpawnPoint::FromJSON($values);
				$obj->Save();
			} catch (Exception $err) {
				$database->Rollback();
				BeaconAPI::ReplyError('There was an error saving an object: ' . $err->getMessage(), $values, 500);
			}
		}
	}
	if (count($loot_sources) > 0) {
		foreach ($loot_sources as $values) {
			try {
				if (isset($values['min_version'])) {
					$values['min_version'] = max($values['min_version'], $versions[$values['mod']['id']]);
				} else {
					$values['min_version'] = $versions[$values['mod']['id']];
				}
				$obj = Ark\LootSource::FromJSON($values);
				$obj->Save();
			} catch (Exception $err) {
				$database->Rollback();
				BeaconAPI::ReplyError('There was an error saving an object: ' . $err->getMessage(), $values, 500);
			}
		}
	}
	if (count($deletions) > 0) {
		$rows = $database->Query('SELECT blueprints.tableoid::regclass AS tablename, blueprints.object_id FROM ark.blueprints WHERE blueprints.object_id IN (\'' . implode('\',\'', $deletions) . '\');');
		while (!$rows->EOF()) {
			$database->Query('DELETE FROM ' . $rows->Field('tablename') . ' WHERE object_id = $1;', $rows->Field('object_id'));
			$rows->MoveNext();
		}
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess('', 204);
}

function GetModIDs(array &$mod_ids, array $blueprints) {
	foreach ($blueprints as $blueprint) {
		if (isset($blueprint['mod']['id']) === false) {
			BeaconAPI::ReplyError('Blueprint is missing mod id.', $blueprint, 400);
		}
		
		$mod_id = $blueprint['mod']['id'];
		if (BeaconCommon::IsUUID($mod_id) === false) {
			BeaconAPI::ReplyError('Blueprint mod id is not a v4 UUID.', $blueprint, 400);
		}
		
		if (in_array($mod_id, $mod_ids) === false) {
			$mod_ids[] = $mod_id;
		}
	}
}

?>