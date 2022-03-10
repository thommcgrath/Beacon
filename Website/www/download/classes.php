<?php

$api_version = 1;
require(dirname(__FILE__, 3) . '/framework/loader.php');

$request_method = strtoupper($_SERVER['REQUEST_METHOD']);
if ($request_method == 'OPTIONS') {
	header('Access-Control-Allow-Origin: *');
	header('Access-Control-Allow-Methods: GET, OPTIONS');
	header('Access-Control-Max-Age: 1728000');
	header('Content-Type: text/plain; charset=utf-8');
	header('Content-Length: 0');
	http_response_code(204);
	exit;
} elseif ($request_method != 'GET') {
	http_response_code(405);
	echo '<h1>Method not allowed</h1>';
	exit;
}

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range');
header('Access-Control-Expose-Headers: Content-Length,Content-Range');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
}

if (isset($_GET['version'])) {
	if ((string)(int)$_GET['version'] == $_GET['version']) {
		$min_version = intval($_GET['version']);
	} else {
		$min_version = BeaconCommon::VersionToBuildNumber($_GET['version']);
	}
} else {
	$min_version = 0;
}

$database = BeaconCommon::Database();
$last_database_update = BeaconCommon::NewestUpdateTimestamp($min_version);

$from_cache = true;
$cache_key = md5('classes' . serialize($_GET) . serialize($last_database_update));
$cached = BeaconCache::Get($cache_key);
if (is_null($cached)) {
	$from_cache = false;
	if ($min_version >= 10100000) {
		$beacon_version = 4;
		$values = array(
			'loot_sources' => \Ark\LootSource::GetAll($min_version, $since, true),
			'loot_source_icons' => \Ark\LootSourceIcon::GetAll($min_version, $since, true),
			'engrams' => \Ark\Engram::GetAll($min_version, $since, true),
			'presets' => \Ark\Preset::GetAll($min_version, $since, true),
			'preset_modifiers' => \Ark\PresetModifier::GetAll($min_version, $since, true),
			'creatures' => \Ark\Creature::GetAll($min_version, $since, true),
			'diets' => \Ark\Diet::GetAll($min_version, $since, true),
			'help_topics' => BeaconHelpTopic::GetAll($since),
			'game_variables' => \Ark\GameVariable::GetAll($since),
			'mods' => \Ark\Mod::GetLive(),
			'deletions' => \Ark\GenericObject::Deletions($min_version, $since),
			'ini_options' => \Ark\ConfigLine::GetAll($min_version, $since),
			'spawn_points' => \Ark\SpawnPoint::GetAll($min_version, $since)
		);
	} elseif ($min_version > 33) {
		$beacon_version = 3;
		$values = array(
			'loot_sources' => \Ark\LootSource::GetAll($min_version, $since, true),
			'engrams' => \Ark\Engram::GetAll($min_version, $since, true),
			'presets' => \Ark\Preset::GetAll($min_version, $since, true),
			'preset_modifiers' => \Ark\PresetModifier::GetAll($min_version, $since, true),
			'creatures' => \Ark\Creature::GetAll($min_version, $since, true),
			'diets' => \Ark\Diet::GetAll($min_version, $since, true),
			'help_topics' => BeaconHelpTopic::GetAll($since),
			'game_variables' => \Ark\GameVariable::GetAll($since),
			'mods' => \Ark\Mod::GetLive(),
			'deletions' => \Ark\GenericObject::Deletions($min_version, $since)
		);
		
		$icons = \Ark\LootSourceIcon::GetAll();
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
		
		$icons = \Ark\LootSourceIcon::GetAll();
		$icon_map = array();
		foreach ($icons as $icon) {
			$icon_map[$icon->ObjectID()] = bin2hex($icon->IconData(false));
		}
		
		$values['loot_sources'] = array('additions' => array(), 'removals' => array());
		$loot_sources = \Ark\LootSource::GetAll($min_version, $since, true);
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
		$deleted_loot_sources = \Ark\LootSource::Deletions($min_version, $since);
		foreach ($deleted_loot_sources as $loot_source) {
			$values['loot_sources']['removals'][] = $loot_source['object_id'];
		}
		
		$values['engrams'] = array('additions' => array(), 'removed_paths' => array());
		$engrams = \Ark\Engram::GetAll($min_version, $since, true);
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
		$deleted_engrams = \Ark\Engram::Deletions($min_version, $since);
		foreach ($deleted_engrams as $engram) {
			$values['engrams']['removed_paths'][] = $engram['tag'];
		}
		
		$values['presets'] = array('additions' => array(), 'removals' => array());
		$presets = \Ark\Preset::GetAll($min_version, $since, true);
		foreach ($presets as $preset) {
			$values['presets']['additions'][] = array(
				'id' => $preset->ObjectID(),
				'label' => $preset->Label(),
				'contents' => $preset->Contents(true)
			);
		}
		$deleted_presets = \Ark\Preset::Deletions($min_version, $since);
		foreach ($deleted_presets as $preset) {
			$values['presets']['removals'][] = $preset['object_id'];
		}
	}
	
	$values['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
	$values['beacon_version'] = $beacon_version;
	$values['is_full'] = ($since === null) ? 1 : 0;
	$values['min_version'] = $min_version;
	
	$body = json_encode($values, JSON_PRETTY_PRINT);
	$hash = md5($body);
	
	$cached = array(
		'md5' => $hash,
		'filename' => 'BeaconData' . $last_database_update->format('YmdHis') . '.json',
		'body' => gzencode($body, 9)
	);
	try {
		BeaconCache::Set($cache_key, $cached, 3600);
	} catch (Exception $e) {
	}
}

header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="' . $cached['filename'] . '"');
header('Content-MD5: ' . $cached['md5']);
header('Cache-Control: no-cache');
if (BeaconCommon::CompressedResponseAllowed()) {
	header('Content-Encoding: gzip');
	echo $cached['body'];
} else {
	echo gzdecode($cached['body']);
}
exit;

?>
