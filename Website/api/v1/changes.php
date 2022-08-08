<?php

require(dirname(__FILE__) . '/loader.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
}

$min_version = array_key_exists('version', $_GET) ? intval($_GET['version']) : 0;
$time = \Ark\GenericObject::LastUpdate($min_version);

$arr = array(
	'timestamp' => $time->format('Y-m-d H:i:s'),
	'schema_version' => 3,
	'is_full' => ($since === null) ? true : false,
	'loot_sources' => \Ark\LootSource::GetAll($min_version, $since),
	'engrams' => \Ark\Engram::GetAll($min_version, $since),
	'creatures' => \Ark\Creature::GetAll($min_version, $since),
	'diets' => \Ark\Diet::GetAll($min_version, $since),
	'help_topics' => BeaconHelpTopic::GetAll($since),
	'expired_records' => \Ark\GenericObject::Deletions($min_version, $since)
);

header('Content-Type: application/json');
header('Cache-Control: no-cache');
echo json_encode($arr, JSON_PRETTY_PRINT);

?>
