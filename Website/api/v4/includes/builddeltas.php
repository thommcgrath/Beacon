<?php

use BeaconAPI\v4\{Template, TemplateSelector};
use BeaconAPI\v4\Ark\{Color, ColorSet, ConfigOption, ContentPack, Creature, Engram, Event, GameVariable, LootContainer, LootContainerIcon, Map, SpawnPoint};

// Build the complete files
UploadFiles(null);

// And the delta files
UploadFiles($lastDatabaseUpdate);

function UploadFiles(DateTime|null $since): void {
	global $cdn, $database, $lastDatabaseUpdate;
	$timestamp = $lastDatabaseUpdate->format('YmdHis');
	$buildTime = $lastDatabaseUpdate->format('Y-m-d H:i:s');
	
	if (is_null($since)) {
		$label = 'complete';
		$type = "Complete";
	} else {
		$label = $timestamp;
		$type = "Delta";
	}
	
	$root = "v7";
	if (BeaconCommon::InProduction() == false) {
		$root .= '/' . BeaconCommon::EnvironmentName();
	}
	
	$first = true;
	
	$subfiles = [];
	$packs = ContentPack::Search([], true);
	foreach ($packs as $pack) {
		$packId = $pack->ContentPackId();
		$steamId = $pack->SteamId();
		$packData = BuildFile($since, $packId);
		if (is_null($packData) === false) {
			try {
				$packDataSize = strlen($packData);
				$path = "/{$root}/{$label}/ark/{$steamId}.beacondata";
				$cdn->PutFile($path, $packData);
				$path .= "?bcdn_filename={$label}-Ark-{$steamId}.beacondata";
				$subfiles[] = $path;
				/*echo "$path: $packDataSize\n";
				if ($first === true && $packDataSize < 300) {
					echo gzdecode($packData) . "\n";
					$first = false;
				}*/
				$database->Query("INSERT INTO public.update_files (version, type, path, created, size) VALUES ($1, $2, $3, $4, $5);", 7, $type, $path, $buildTime, $packDataSize);
			} catch (Exception $err) {
				echo "Could not upload: " . $err->getMessage() . "\n";
				continue;	
			}
		}
	}
	
	$mainData = BuildFile($since, null, $subfiles);
	if (is_null($mainData) === false) {
		try {
			$mainDataSize = strlen($mainData);
			//echo "$path: $mainDataSize\n";
			$path = "/{$root}/{$label}/main.beacondata";
			$cdn->PutFile($path, $mainData);
			$path .= "?bcdn_filename={$label}-Main.beacondata";
			$database->Query("INSERT INTO public.update_files (version, type, path, created, size) VALUES ($1, $2, $3, $4, $5);", 7, $type, $path, $buildTime, $mainDataSize);
		} catch (Exception $err) {
			echo "Could not upload: " . $err->getMessage() . "\n";
		}
		
	}
}

function BuildFile(DateTime|null $since, string|null $contentPackId, array|null $subfiles = null): ?string {
	global $lastDatabaseUpdate;
	
	$filters = [];
	if (is_null($since) === false) {
		$filters['lastUpdate'] = $since->format('Y-m-d H:i:s');
	}
	if (is_null($contentPackId) === false) {
		$filters['contentPackId'] = $contentPackId;
	}
	
	$file = [
		'timestamp' => $lastDatabaseUpdate->getTimestamp(),
		'isFull' => true,
		'deltaFormat' => 7
	];
	if (is_null($subfiles) === false) {
		$file['subfiles'] = $subfiles;
	}
	
	$ark = [];
	$common = [];
	
	if (is_null($contentPackId)) {
		$ark = [
			'colors' => Color::Search($filters, true),
			'colorSets' => ColorSet::Search($filters, true),
			'contentPacks' => ContentPack::Search($filters, true),
			'events' => Event::Search($filters, true)
		];
		
		$common = [
			'templates' => Template::Search($filters, true),
			'templateSelectors' => TemplateSelector::Search($filters, true)
		];
	} else {
		$ark = [
			'configOptions' => ConfigOption::Search($filters, true),
			'creatures' => Creature::Search($filters, true),
			'engrams' => Engram::Search($filters, true),
			'gameVariables' => GameVariable::Search($filters, true),
			'lootContainers' => LootContainer::Search($filters, true),
			'lootContainerIcons' => LootContainerIcon::Search($filters, true),
			'maps' => Map::Search($filters, true),
			'spawnPoints' => SpawnPoint::Search($filters, true)
		];
	}
	
	$totalItems = 0;
	
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
	
	if ($totalItems === 0) {
		return null;
	}
	
	return gzencode(json_encode($file));
}

?>
