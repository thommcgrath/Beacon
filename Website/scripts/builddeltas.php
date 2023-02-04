#!/usr/bin/php -q
<?php

$options = getopt('', ['delta_version:', 'force']);

if (array_key_exists('delta_version', $options) === false) {
	echo "Specify the delta version with --delta_version\n";
	exit;
} elseif (is_numeric($options['delta_version']) === false) {
	echo "Delta version should be an integer.\n";
	exit;
}
$delta_version = filter_var($options['delta_version'], FILTER_VALIDATE_INT);
switch ($delta_version) {
case 7:
	// Don't change $api_version, it affects how the Ark namespace behaves in v3 and lower.
	break;
case 6:
	$api_version = 3;
	break;
case 5:
	$api_version = 2;
	break;
default:
	echo "Delta version $delta_version is not known.\n";
	exit;
}

$force = array_key_exists('force', $options);

// More memory is needed
ini_set('memory_limit','1024M');

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$apiRoot = dirname(__FILE__, 2) . '/api';

$database = BeaconCommon::Database();
$sem = sem_get(crc32($database->DatabaseName() . $delta_version), 1);
if (sem_acquire($sem) === false) {
	echo "Could not acquire semaphore\n";
	exit;
}

define('MIN_VERSION', 99999999);

$database->BeginTransaction();
$rows = $database->Query('UPDATE ark.mods SET include_in_deltas = TRUE WHERE include_in_deltas = FALSE AND confirmed = TRUE AND (SELECT COUNT(object_id) FROM ark.objects WHERE objects.mod_id = mods.mod_id) > 0 RETURNING mod_id;');
if ($rows->RecordCount() > 0) {
	$database->Commit();
} else {
	$database->Rollback();
}

$lastDatabaseUpdate = BeaconCommon::NewestUpdateTimestamp();
$cutoff = new DateTime();
$cutoff->sub(new DateInterval('PT15M'));

if ($force == false && $lastDatabaseUpdate >= $cutoff) {
	$ready = clone $lastDatabaseUpdate;
	$ready->add(new DateInterval('PT15M'));
	echo "Database has changes that will be ready at " . $ready->format('Y-m-d H:i:s') . " UTC if nothing else changes.\n";
	sem_release($sem);
	exit;
}

$required_versions = [$delta_version];
$results = $database->Query("SELECT file_id, version FROM update_files WHERE created = $1 AND type = 'Delta';", $lastDatabaseUpdate->format('Y-m-d H:i:sO'));
if ($results->RecordCount() > 0) {
	while (!$results->EOF()) {
		$version = $results->Field('version');
		if (in_array($version, $required_versions)) {
			if (($key = array_search($version, $required_versions)) !== false) {
				unset($required_versions[$key]);
			}
			echo "Version {$version} already prepared.\n";
		}
		$results->MoveNext();
	}
}
if (count($required_versions) == 0) {
	echo "All deltas have been produced.\n";
	sem_release($sem);
	exit;
}

$cdn = BeaconCDN::DeltasZone();
foreach ($required_versions as $version) {
	echo "Building delta for version {$version}...\n";
	
	switch ($version) {
	case 7:
		include("{$apiRoot}/v4/includes/builddeltas.php");
		break;
	default:
		$completeData = DataForVersion($version, null);
		if ($version === 5) {
			$completeData['timestamp'] = $lastDatabaseUpdate->format('Y-m-d H:i:s');
		} else {
			$completeData['timestamp'] = $lastDatabaseUpdate->getTimestamp();
		}
		
		$results = $database->Query('SELECT MAX(created) AS since FROM update_files WHERE version = $1 AND type = \'Delta\';', $version);
		if (is_null($results->Field('since')) == false) {
			$since = new DateTime($results->Field('since'));
			
			$deltaData = DataForVersion($version, $since);
			if ($version === 5) {
				$deltaData['timestamp'] = $lastDatabaseUpdate->format('Y-m-d H:i:s');
			} else {
				$deltaData['timestamp'] = $lastDatabaseUpdate->getTimestamp();
			}
		} else {
			$deltaData = null;
		}
		
		$prefix = '/v' . $version;
		$timestamp = $lastDatabaseUpdate->format('U');
		if (BeaconCommon::InProduction() == false) {
			$prefix .= '/' . BeaconCommon::EnvironmentName();
			$timestamp += rand(-1800,1800);
		}
		
		$completeUrl = $prefix . '/Complete.beacondata?t=' . $timestamp . '&bcdn_filename=Complete.beacondata';
		$completeContent = gzencode(json_encode($completeData));
		$completeSize = strlen($completeContent);
		try {
			$cdn->PutFile($completeUrl, $completeContent);
		} catch (Exception $err) {
			$database->Rollback();
			echo "Unable to upload {$completeUrl}\n";
			echo $err->getMessage() . "\n";
			continue 2;
		}
		
		if (is_null($deltaData) == false) {
			$deltaUrl = $prefix . '/' . $lastDatabaseUpdate->format('YmdHis') . '.beacondata?bcdn_filename=' . $lastDatabaseUpdate->format('YmdHis') . '.beacondata';
			$deltaContent = gzencode(json_encode($deltaData));
			$deltaSize = strlen($deltaContent);
			try {
				$cdn->PutFile($deltaUrl, $deltaContent);
			} catch (Exception $err) {
				$database->Rollback();
				echo "Unable to upload {$deltaUrl}\n";
				echo $err->getMessage() . "\n";
				continue 2;
			}
		} else {
			$deltaUrl = $compelteUrl;
			$deltaSize = $completeSize;
		}
		break;
	}
	
	$database->BeginTransaction();
	$rows = $database->Query("SELECT file_id FROM public.update_files WHERE version = $1 AND type = 'Complete';", $version);
	if ($rows->RecordCount() == 1) {
		$database->Query("UPDATE public.update_files SET created = $2, path = $3, size = $4 WHERE file_id = $1;", $rows->Field('file_id'), $lastDatabaseUpdate->format('Y-m-d H:i:sO'), $completeUrl, $completeSize);
	} else {
		$database->Query("INSERT INTO public.update_files (created, version, path, size, type) VALUES ($1, $2, $3, $4, 'Complete');", $lastDatabaseUpdate->format('Y-m-d H:i:sO'), $version, $completeUrl, $completeSize);
	}
	$database->Query("INSERT INTO public.update_files (created, version, path, size, type) VALUES ($1, $2, $3, $4, 'Delta');", $lastDatabaseUpdate->format('Y-m-d H:i:sO'), $version, $deltaUrl, $deltaSize);
	$database->Commit();
	
	echo "Delta for version {$version} uploaded to {$deltaUrl}\n";
}

sem_release($sem);
exit;

function DataForVersion(int $version, $since): array {
	$arr = null;
	switch ($version) {
	case 6:
		$arr = [
			'deletions' => is_null($since) ? [] : BeaconAPI::Deletions(MIN_VERSION, $since),
			'ark' => [
				'loot_sources' => Ark\LootSource::GetAll(MIN_VERSION, $since, true),
				'loot_source_icons' => Ark\LootSourceIcon::GetAll(MIN_VERSION, $since, true),
				'engrams' => Ark\Engram::GetAll(MIN_VERSION, $since, true),
				'creatures' => Ark\Creature::GetAll(MIN_VERSION, $since, true),
				'game_variables' => Ark\GameVariable::GetAll($since),
				'mods' => Ark\Mod::GetLive($since),
				'ini_options' => Ark\ConfigLine::GetAll(MIN_VERSION, $since),
				'spawn_points' => Ark\SpawnPoint::GetAll(MIN_VERSION, $since),
				'maps' => Ark\Map::GetAll($since),
				'events' => Ark\Event::GetAll($since),
				'colors' => Ark\Color::GetAll($since),
				'color_sets' => Ark\ColorSet::GetAll($since)
			],
			'common' => [
				'help_topics' => BeaconHelpTopic::GetAll($since),
				'templates' => \BeaconAPI\Template::GetAll(MIN_VERSION, $since),
				'template_selectors' => BeaconAPI\TemplateSelector::GetAll(MIN_VERSION, $since)
			],
			'beacon_version' => $version,
			'is_full' => is_null($since) ? true : false,
			'min_version' => 0
		];
		break;
	case 5:
		$arr = [
			'loot_sources' => Ark\LootSource::GetAll(MIN_VERSION, $since, true),
			'loot_source_icons' => Ark\LootSourceIcon::GetAll(MIN_VERSION, $since, true),
			'engrams' => Ark\Engram::GetAll(MIN_VERSION, $since, true),
			'presets' => Ark\Preset::GetAll(MIN_VERSION, $since, true),
			'preset_modifiers' => Ark\PresetModifier::GetAll(MIN_VERSION, $since, true),
			'creatures' => Ark\Creature::GetAll(MIN_VERSION, $since, true),
			'diets' => Ark\Diet::GetAll(MIN_VERSION, $since, true),
			'help_topics' => BeaconHelpTopic::GetAll($since),
			'game_variables' => Ark\GameVariable::GetAll($since),
			'mods' => Ark\Mod::GetLive($since),
			'deletions' => Ark\GenericObject::Deletions(MIN_VERSION, $since),
			'ini_options' => Ark\ConfigLine::GetAll(MIN_VERSION, $since),
			'spawn_points' => Ark\SpawnPoint::GetAll(MIN_VERSION, $since),
			'maps' => Ark\Map::GetAll($since),
			'events' => Ark\Event::GetAll($since),
			'colors' => Ark\Color::GetAll($since),
			'color_sets' => Ark\ColorSet::GetAll($since),
			'beacon_version' => $version,
			'is_full' => is_null($since) ? true : false,
			'min_version' => 0
		];
		break;
	}
	return $arr;
}

?>