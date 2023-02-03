<?php

use BeaconAPI\v4\{Template, TemplateSelector};
use BeaconAPI\v4\Ark\{Color, ColorSet, ConfigOption, ContentPack, Creature, Engram, Event, GameVariable, LootContainer, LootContainerIcon, Map, SpawnPoint};

$buildDeltas = false;
$since = null;
$rows = $database->Query('SELECT MAX(created) AS since FROM update_files WHERE version = $1;', 7);
if (is_null($rows->Field('since')) == false) {
	$since = new DateTime($rows->Field('since'));
	$buildDeltas = true;
} else {
	$since = new DateTime('2000-01-01 00:00:00');
}

echo "Looking for changes since " . $since->format('Y-m-d H:i:s') . "\n";

// Need to find the mods that have changes since the last run
$rows = $database->Query("SELECT mod_id FROM ark.mod_update_times WHERE last_update > $1;", $since->format('Y-m-d H:i:s'));
$updatedModIds = [];
while (!$rows->EOF()) {
	$updatedModIds[] = $rows->Field('mod_id');
	$rows->MoveNext();
}

$deltaUrls = [];
foreach ($updatedModIds as $modId) {
	$pack = ContentPack::Fetch($modId);
	if ($pack->IsIncludedInDeltas() === false) {
		continue;
	}
	
	BuildDataFile($pack, null);
	if ($buildDeltas) {
		$deltaUrl = BuildDataFile($pack, $since);
		$deltaUrls[] = $deltaUrl;
	}
}

$rows = $database->Query("SELECT path FROM public.update_files WHERE type = 'Complete' AND version = 7 AND path != '/v7/dev/Complete/Main.beacondata?bcdn_filename=Complete-Main.beacondata';");
$completeUrls = [];
while (!$rows->EOF()) {
	$completeUrls[] = $rows->Field('path');
	$rows->MoveNext();
}

$completeMainUrl = BuildDataFile(null, null, $completeUrls);
if ($buildDeltas) {
	$deltaMainUrl = BuildDataFile(null, $since, $deltaUrls);
}

return;

function BuildDataFile(?ContentPack $pack, ?DateTime $since, ?array $subfiles = null): ?string {
	global $lastDatabaseUpdate, $database;
	
	$isComplete = is_null($since);
	$isMain = is_null($pack);
	
	if ($isComplete) {
		$label = 'Complete';
		$type = "Complete";
	} else {
		$label = $lastDatabaseUpdate->format('YmdHis');
		$type = "Delta";
	}
	
	$filters = [
		'isIncludedInDeltas' => true
	];
	if ($isComplete === false) {
		$filters['lastUpdate'] = $since->format('Y-m-d H:i:s');
	}
	if ($isMain === false) {
		$filters['contentPackId'] = $pack->ContentPackId();
	}
	
	$file = [
		'timestamp' => $lastDatabaseUpdate->getTimestamp(),
		'isFull' => true,
		'version' => 7
	];
	
	$root = "/v7";
	if (BeaconCommon::InProduction() == false) {
		$root .= '/' . BeaconCommon::EnvironmentName();
	}
	$root .= "/{$label}";
	
	$ark = [];
	$common = [];
	
	if ($isMain) {
		$ark = [
			'colors' => Color::Search($filters, true),
			'colorSets' => ColorSet::Search($filters, true),
			'contentPacks' => ContentPack::Search($filters, true),
			'events' => Event::Search($filters, true),
			'gameVariables' => GameVariable::Search($filters, true)
		];
		
		$common = [
			'templates' => Template::Search($filters, true),
			'templateSelectors' => TemplateSelector::Search($filters, true)
		];
		
		$path = "{$root}/Main.beacondata";
		$filename = "{$label}-Main.beacondata";
	} else {
		$ark = [
			'configOptions' => ConfigOption::Search($filters, true),
			'creatures' => Creature::Search($filters, true),
			'engrams' => Engram::Search($filters, true),
			'lootContainers' => LootContainer::Search($filters, true),
			'lootContainerIcons' => LootContainerIcon::Search($filters, true),
			'maps' => Map::Search($filters, true),
			'spawnPoints' => SpawnPoint::Search($filters, true)
		];
		
		$steamId = $pack->SteamId();
		$path = "{$root}/Ark/{$steamId}.beacondata";
		$filename = "{$label}-Ark-{$steamId}.beacondata";
	}
	
	$totalItems = 0;
	if (is_null($subfiles) === false) {
		$totalItems = count($subfiles);
	}
	
	$sections = [
		'ark' => $ark,
		'common' => $common
	];
	foreach ($sections as $sectionName => $groups) {
		foreach ($groups as $groupName => $members) {
			if (count($members) === 0) {
				continue;
			}
			
			if (array_key_exists($sectionName, $file) === false) {
				$file[$sectionName] = [];
			}
			
			$file[$sectionName][$groupName] = $members;
			$totalItems += count($members);
		}
	}
	
	if (is_null($subfiles) === false) {
		$file['subfiles'] = $subfiles;
	}
	
	if ($totalItems === 0) {
		return null;
	}
	
	$fileContents = gzencode(json_encode($file));
	$fileSize = strlen($fileContents);
	
	try {
		//$cdn->PutFile($path, $fileContents);
		$path = "{$path}?bcdn_filename={$filename}";
		echo "Uploaded $path\n";
		$database->Query("DELETE FROM public.update_files WHERE version = $1 AND type = $2 AND path = $3;", 7, $type, $path);
		$database->Query("INSERT INTO public.update_files (version, type, path, created, size) VALUES ($1, $2, $3, $4, $5);", 7, $type, $path, $lastDatabaseUpdate->format('Y-m-d H:i:s'), $fileSize);
	} catch (Exception $err) {
		echo "Could not upload: " . $err->getMessage() . "\n";
		return null;
	}
	
	return $path;
}

?>
