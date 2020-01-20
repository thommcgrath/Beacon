<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
}

if (isset($_GET['version'])) {
	if ((string)(int)$_GET['version'] == $_GET['version']) {
		$min_version = intval($_GET['version']);
	} else {
		if (preg_match('/^(\d+)\.(\d+)(\.(\d+))?(([ab\.]+)(\d+))?$/', $_GET['version'], $matches) == 1) {
			$major_version = intval($matches[1]);
			$minor_version = intval($matches[2]);
			if (isset($matches[3])) {
				$bug_version = intval($matches[4]);
			} else {
				$bug_version = 0;
			}
			$stage_code = 3;
			$non_release_version = 0;
			if (isset($matches[5])) {
				$non_release_version = intval($matches[7]);
				switch ($matches[6]) {
				case 'a':
					$stage_code = 1;
					break;
				case 'b':
					$stage_code = 2;
					break;
				case '.':
					break;
				default:
					$stage_code = 0;
					break;
				}
			}
			$min_version = ($major_version * 10000000) + ($minor_version * 100000) + ($bug_version * 1000) + ($stage_code * 100) + $non_release_version;
		} else {
			$min_version = 0;
		}
	}
} else {
	$min_version = 0;
}

$database = BeaconCommon::Database();
$results = $database->Query("SELECT MAX(stamp) AS stamp FROM ((SELECT MAX(objects.last_update) AS stamp FROM objects INNER JOIN mods ON (objects.mod_id = mods.mod_id) WHERE objects.min_version <= $1 AND mods.confirmed = TRUE) UNION (SELECT MAX(action_time) AS stamp FROM deletions WHERE min_version <= $1) UNION (SELECT MAX(last_update) AS stamp FROM help_topics) UNION (SELECT MAX(last_update) AS stamp FROM game_variables)) AS merged;", $min_version);
$last_database_update = new DateTime($results->Field("stamp"), new DateTimeZone('UTC'));

$cache_key = md5('classes' . serialize($_GET) . serialize($last_database_update));
$cached = BeaconCache::Get($cache_key);
if (is_null($cached)) {
	if ($min_version >= 10100000) {
		$beacon_version = 4;
		$values = array(
			'loot_sources' => BeaconLootSource::GetAll($min_version, $since, true),
			'loot_source_icons' => BeaconLootSourceIcon::GetAll($min_version, $since, true),
			'engrams' => BeaconEngram::GetAll($min_version, $since, true),
			'presets' => BeaconPreset::GetAll($min_version, $since, true),
			'preset_modifiers' => BeaconPresetModifier::GetAll($min_version, $since, true),
			'creatures' => BeaconCreature::GetAll($min_version, $since, true),
			'diets' => BeaconDiet::GetAll($min_version, $since, true),
			'help_topics' => BeaconHelpTopic::GetAll($since),
			'game_variables' => BeaconGameVariable::GetAll($since),
			'mods' => BeaconMod::GetLive(),
			'deletions' => BeaconObject::Deletions($min_version, $since),
			'ini_options' => BeaconConfigLine::GetAll($min_version, $since),
			'spawn_points' => BeaconSpawnPoint::GetAll($min_version, $since)
		);
	} elseif ($min_version > 33) {
		$beacon_version = 3;
		$values = array(
			'loot_sources' => BeaconLootSource::GetAll($min_version, $since, true),
			'engrams' => BeaconEngram::GetAll($min_version, $since, true),
			'presets' => BeaconPreset::GetAll($min_version, $since, true),
			'preset_modifiers' => BeaconPresetModifier::GetAll($min_version, $since, true),
			'creatures' => BeaconCreature::GetAll($min_version, $since, true),
			'diets' => BeaconDiet::GetAll($min_version, $since, true),
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
		$loot_sources = BeaconLootSource::GetAll($min_version, $since, true);
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
		$engrams = BeaconEngram::GetAll($min_version, $since, true);
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
		$presets = BeaconPreset::GetAll($min_version, $since, true);
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
	
	$values['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
	$values['beacon_version'] = $beacon_version;
	$values['is_full'] = ($since === null) ? 1 : 0;
	$values['min_version'] = $min_version;
	
	$body = json_encode($values, JSON_PRETTY_PRINT);
	$hash = md5($body);
	
	$cached = array(
		'md5' => $hash,
		'filename' => 'BeaconData' . $last_database_update->format('YmdHis') . '.json',
		'body' => $body
	);
	BeaconCache::Set($cache_key, $cached, 3600);
}

header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="' . $cached['filename'] . '"');
header('Content-MD5: ' . $cached['md5']);
header('Cache-Control: no-cache');
echo $cached['body'];
exit;

?>
