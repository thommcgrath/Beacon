#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

define('MIN_VERSION', 99999999);

$database = BeaconCommon::Database();
$last_database_update = BeaconCommon::NewestUpdateTimestamp();
$cutoff = new DateTime();
$cutoff->sub(new DateInterval('PT15M'));

if ($last_database_update >= $cutoff) {
	echo "Database has changes that will be ready soon.\n";
	exit;
}

$required_versions = [5];
$results = $database->Query('SELECT file_id, version FROM update_files WHERE created = $1 AND type = \'Delta\';', $last_database_update->format('Y-m-d H:i:sO'));
if ($results->RecordCount() > 0) {
	while (!$results->EOF()) {
		$version = $results->Field('version');
		if (in_array($version, $required_versions)) {
			if (($key = array_search($version, $required_versions)) !== false) {
				unset($required_versions[$key]);
			}
			echo "Version " . $version . " already prepared.\n";
		}
		$results->MoveNext();
	}
}
if (count($required_versions) == 0) {
	echo "All deltas have been produced.\n";
	exit;
}

foreach ($required_versions as $version) {
	echo "Building delta for version $version...\n";
	
	$full_data = DataForVersion($version, null);
	$full_data['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
	
	$results = $database->Query('SELECT MAX(created) AS since FROM update_files WHERE version = $1 AND type = \'Delta\';', $version);
	if (is_null($results->Field('since')) == false) {
		$since = new DateTime($results->Field('since'));
		
		$delta_data = DataForVersion($version, $since);
		$delta_data['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
	} else {
		$delta_data = null;
	}
	
	$prefix = '/v' . $version;
	if (BeaconCommon::InProduction() == false) {
		$prefix .= '/' . BeaconCommon::EnvironmentName();
	}
	
	$database->BeginTransaction();
	
	$full_path = $prefix . '/Complete.beacondata?t=' . $last_database_update->format('U') . '&bcdn_filename=Complete.beacondata';
	$full_prepared = gzencode(json_encode($full_data));
	$full_size = strlen($full_prepared);
	if (UploadFile($full_path, $full_prepared) === false) {
		echo "Unable to upload $full_path\n";
		$database->Rollback();
		continue;
	}
	
	if (is_null($delta_data) == false) {
		$delta_path = $prefix . '/' . $last_database_update->format('YmdHis') . '.beacondata?bcdn_filename=' . $last_database_update->format('YmdHis') . '.beacondata';
		$delta_prepared = gzencode(json_encode($delta_data));
		$delta_size = strlen($delta_prepared);
		if (UploadFile($delta_path, $delta_prepared) === false) {
			echo "Unable to upload $delta_path\n";
			$database->Rollback();
			continue;
		}
	} else {
		$delta_path = $full_path;
		$delta_size = strlen($full_prepared);
	}
	
	$results = $database->Query('SELECT file_id FROM update_files WHERE version = $1 AND type = \'Complete\';', $version);
	if ($results->RecordCount() == 1) {
		$database->Query('UPDATE update_files SET created = $2, path = $3, size = $4 WHERE file_id = $1;', $results->Field('file_id'), $last_database_update->format('Y-m-d H:i:sO'), $full_path, $full_size);
	} else {
		$database->Query('INSERT INTO update_files (created, version, path, size, type) VALUES ($1, $2, $3, $4, \'Complete\');', $last_database_update->format('Y-m-d H:i:sO'), $version, $full_path, $full_size);
	}
	$database->Query('INSERT INTO update_files (created, version, path, size, type) VALUES ($1, $2, $3, $4, \'Delta\');', $last_database_update->format('Y-m-d H:i:sO'), $version, $delta_path, $delta_size);
	$database->Commit();
	
	echo "Delta for version $version uploaded to $delta_path\n";
}

exit;

function DataForVersion(int $version, $since) {
	return array(
		'loot_sources' => BeaconLootSource::GetAll(MIN_VERSION, $since, true),
		'loot_source_icons' => BeaconLootSourceIcon::GetAll(MIN_VERSION, $since, true),
		'engrams' => BeaconEngram::GetAll(MIN_VERSION, $since, true),
		'presets' => BeaconPreset::GetAll(MIN_VERSION, $since, true),
		'preset_modifiers' => BeaconPresetModifier::GetAll(MIN_VERSION, $since, true),
		'creatures' => BeaconCreature::GetAll(MIN_VERSION, $since, true),
		'diets' => BeaconDiet::GetAll(MIN_VERSION, $since, true),
		'help_topics' => BeaconHelpTopic::GetAll($since),
		'game_variables' => BeaconGameVariable::GetAll($since),
		'mods' => BeaconMod::GetLive($since),
		'deletions' => BeaconObject::Deletions(MIN_VERSION, $since),
		'ini_options' => BeaconConfigLine::GetAll(MIN_VERSION, $since),
		'spawn_points' => BeaconSpawnPoint::GetAll(MIN_VERSION, $since),
		'maps' => BeaconMap::GetAll($since),
		'events' => BeaconEvent::GetAll($since),
		'colors' => BeaconColor::GetAll($since),
		'beacon_version' => $version,
		'is_full' => is_null($since) ? true : false,
		'min_version' => 0
	);
}

function UploadFile(string $path, string $data) {
	if (substr($path, 0, 1) === '/') {
		$path = substr($path, 1);
	}
	$url = 'https://ny.storage.bunnycdn.com/beacon-updates/' . $path;
	
	$headers = [
		'AccessKey: ' . BeaconCommon::GetGlobal('BunnyCDN_Deltas_Password'),
		'Content-Type: application/octet-stream'
	];
	
	$curl = curl_init($url);
	curl_setopt($curl, CURLOPT_HEADER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'PUT');
	curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_BINARYTRANSFER, true);
	
	$response = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	return $status === 201;
}

?>