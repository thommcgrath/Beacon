<?php

require(dirname(__FILE__) . '/loader.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
}

$min_version = array_key_exists('version', $_GET) ? intval($_GET['version']) : 0;
$time = BeaconObject::LastUpdate($min_version);

$arr = array(
	'timestamp' => $time->format('Y-m-d H:i:s'),
	'schema_version' => 3,
	'is_full' => ($since === null) ? true : false,
	'loot_sources' => BeaconLootSource::GetAll($min_version, $since),
	'engrams' => BeaconEngram::GetAll($min_version, $since),
	'creatures' => BeaconCreature::GetAll($min_version, $since),
	'diets' => array(),
	'expired_records' => BeaconObject::Deletions($min_version, $since)
);

header('Content-Type: application/json');
echo json_encode($arr, JSON_PRETTY_PRINT);

?>