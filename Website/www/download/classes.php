<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
}

$min_version = array_key_exists('version', $_GET) ? intval($_GET['version']) : 0;

$database = BeaconCommon::Database();

if ($min_version >= 10100000) {
	$beacon_version = 4;
	$values = array(
		'loot_sources' => BeaconLootSource::GetAll($min_version, $since),
		'loot_source_icons' => BeaconLootSourceIcon::GetAll($min_version, $since),
		'engrams' => BeaconEngram::GetAll($min_version, $since),
		'presets' => BeaconPreset::GetAll($min_version, $since),
		'preset_modifiers' => BeaconPresetModifier::GetAll($min_version, $since),
		'creatures' => BeaconCreature::GetAll($min_version, $since),
		'diets' => BeaconDiet::GetAll($min_version, $since),
		'help_topics' => BeaconHelpTopic::GetAll($since),
		'game_variables' => BeaconGameVariable::GetAll($since),
		'mods' => BeaconMod::GetLive(),
		'deletions' => BeaconObject::Deletions($min_version, $since)
	);
} elseif ($min_version > 33) {
	$beacon_version = 3;
	$values = array(
		'loot_sources' => BeaconLootSource::GetAll($min_version, $since),
		'engrams' => BeaconEngram::GetAll($min_version, $since),
		'presets' => BeaconPreset::GetAll($min_version, $since),
		'preset_modifiers' => BeaconPresetModifier::GetAll($min_version, $since),
		'creatures' => BeaconCreature::GetAll($min_version, $since),
		'diets' => BeaconDiet::GetAll($min_version, $since),
		'help_topics' => BeaconHelpTopic::GetAll($since),
		'game_variables' => BeaconGameVariable::GetAll($since),
		'mods' => BeaconMod::GetLive(),
		'deletions' => BeaconObject::Deletions($min_version, $since)
	);
	
	$icons = BeaconLootSourceIcon::GetAll();
	$icon_map = array();
	foreach ($icons as $icon) {
		$icon_map[$icon->ObjectID()] = $icon->IconData(true);
	}
	
	$loot_sources = $values['loot_sources'];
	$converted_loot_sources = array();
	foreach ($loot_sources as $loot_source) {
		$arr = $loot_source->jsonSerialize();
		$arr['icon'] = $icon_map[$arr['icon']];
		$arr['kind'] = 'Standard';
		unset($arr['experimental'], $arr['notes']);
		$converted_loot_sources[] = $arr;
	}
	$values['loot_sources'] = $converted_loot_sources;
} else {
	// legacy style
	
	$values = array();
	$beacon_version = 2;
	
	$icons = BeaconLootSourceIcon::GetAll();
	$icon_map = array();
	foreach ($icons as $icon) {
		$icon_map[$icon->ObjectID()] = bin2hex($icon->IconData(false));
	}
	
	$values['loot_sources'] = array('additions' => array(), 'removals' => array());
	$loot_sources = BeaconLootSource::GetAll($min_version, $since);
	foreach ($loot_sources as $loot_source) {
		$values['loot_sources']['additions'][] = array(
			'class' => $loot_source->ClassString(),
			'label' => $loot_source->Label(),
			'kind' => 'Standard',
			'mask' => $loot_source->Availability() & 3,
			'availability' => $loot_source->Availability(),
			'mult_min' => $loot_source->MultiplierMin(),
			'mult_max' => $loot_source->MultiplierMax(),
			'uicolor' => $loot_source->UIColor(),
			'icon_hex' => $icon_map[$loot_source->IconID()],
			'sort' => $loot_source->SortOrder(),
			'version' => $loot_source->MinVersion(),
			'use_blueprints' => 0
		);
	}
	$deleted_loot_sources = BeaconLootSource::Deletions($min_version, $since);
	foreach ($deleted_loot_sources as $loot_source) {
		$values['loot_sources']['removals'][] = $loot_source['object_id'];
	}
	
	$values['engrams'] = array('additions' => array(), 'removed_paths' => array());
	$engrams = BeaconEngram::GetAll($min_version, $since);
	foreach ($engrams as $engram) {
		$values['engrams']['additions'][] = array(
			'class' => $engram->ClassString(),
			'path' => $engram->Path(),
			'label' => $engram->Label(),
			'availability' => $engram->Availability(),
			'blueprint' => $engram->CanBlueprint() ? 1 : 0,
			'version' => $engram->MinVersion()
		);
	}
	$deleted_engrams = BeaconEngram::Deletions($min_version, $since);
	foreach ($deleted_engrams as $engram) {
		$values['engrams']['removed_paths'][] = $engram['tag'];
	}
	
	$values['presets'] = array('additions' => array(), 'removals' => array());
	$presets = BeaconPreset::GetAll($min_version, $since);
	foreach ($presets as $preset) {
		$values['presets']['additions'][] = array(
			'id' => $preset->ObjectID(),
			'label' => $preset->Label(),
			'contents' => $preset->Contents(true)
		);
	}
	$deleted_presets = BeaconPreset::Deletions($min_version, $since);
	foreach ($deleted_presets as $preset) {
		$values['presets']['removals'][] = $preset['object_id'];
	}
}

$results = $database->Query("SELECT MAX(stamp) AS stamp FROM ((SELECT MAX(last_update) AS stamp FROM objects WHERE min_version <= $1) UNION (SELECT MAX(action_time) AS stamp FROM deletions WHERE min_version <= $1) UNION (SELECT MAX(last_update) AS stamp FROM help_topics) UNION (SELECT MAX(last_update) AS stamp FROM game_variables)) AS merged;", $min_version);
$last_database_update = new DateTime($results->Field("stamp"), new DateTimeZone('UTC'));

$values['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
$values['beacon_version'] = $beacon_version;
$values['is_full'] = ($since === null) ? 1 : 0;
$values['min_version'] = $min_version;

$body = json_encode($values, JSON_PRETTY_PRINT);
$hash = md5($body);

header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="BeaconData' . $last_database_update->format('YmdHis') . '.json"');
header('Content-MD5: ' . $hash);
header('Cache-Control: no-cache');
echo $body;
exit;

?>
