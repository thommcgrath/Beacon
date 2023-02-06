<?php

function handleRequest(array $context): Response {
	$database = \BeaconCommon::Database();
	$min_version = BeaconCommon::MinVersion();
	
	$values = null;
	if (isset($_GET['mod_id'])) {
		$mod_id = $_GET['mod_id'];
		if (BeaconCommon::IsUUID($mod_id) === false) {
			BeaconAPI::ReplyError('mod_id should be a v4 UUID', $_GET['mod_id'], 400);
		}
		$values['mod_id'] = $mod_id;
		$rows = $database->Query('SELECT MAX(ark.blueprints.last_update) AS last_update FROM ark.blueprints WHERE ark.blueprints.mod_id = $1 AND ark.blueprints.min_version <= $2;', $mod_id, $min_version);
	} else {
		$rows = $database->Query('SELECT MAX(ark.blueprints.last_update) AS last_update FROM ark.blueprints WHERE ark.blueprints.min_version <= $1;', $min_version);
	}
	if (is_null($rows->Field('last_update'))) {
		$timestamp = new DateTime();
	} else {
		$timestamp = new DateTime($rows->Field('last_update'));
	}
	
	$since = null;
	if (isset($_GET['since'])) {
		try {
			$since = new DateTime($_GET['since']);
		} catch (Exception $err) {
			BeaconAPI::ReplyError('Unable to parse timestamp', $err->getMessage(), 400);
		}
	}
	
	$engrams = Ark\Engram::Get($values, $min_version, $since, true);
	$creatures = Ark\Creature::Get($values, $min_version, $since, true);
	$spawn_points = Ark\SpawnPoint::Get($values, $min_version, $since, true);
	$loot_sources = Ark\LootSource::Get($values, $min_version, $since, true);
	
	BeaconAPI::ReplySuccess([
		'timestamp' => $timestamp->format('Y-m-d H:i:sO'),
		'engrams' => $engrams,
		'creatures' => $creatures,
		'spawn_points' => $spawn_points,
		'loot_sources' => $loot_sources
	]);
}

?>