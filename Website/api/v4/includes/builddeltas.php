<?php

use BeaconAPI\v4\{Core, Template, TemplateSelector};
use BeaconAPI\v4\Ark\{Color, ColorSet, ConfigOption, ContentPack, Creature, Engram, Event, GameVariable, LootDrop, LootDropIcon, Map, SpawnPoint};

$root = "/v{$version}";
if (BeaconCommon::InProduction() == false) {
	$root .= '/' . BeaconCommon::EnvironmentName();
}

$deltaLabel = '';
$buildDeltas = false;
$since = null;
$rows = $database->Query('SELECT MAX(created) AS since FROM update_files WHERE version = $1;', $version);
if (is_null($rows->Field('since')) == false) {
	$since = new DateTime($rows->Field('since'));
	$buildDeltas = true;
	$deltaLabel = $lastDatabaseUpdate->format('YmdHis');
} else {
	$since = new DateTime('2000-01-01 00:00:00');
}

// Start getting the archive ready
$completeArchive = new Archiver('Complete');
BuildMainFile($completeArchive, null);

// And delta archive
$deltaArchive = null;
if ($buildDeltas) {
	$deltaArchive = new Archiver($deltaLabel);
	BuildMainFile($deltaArchive, $since);
}

// Need to find the mods that have changes since the last run
$rows = $database->Query("SELECT mod_id FROM ark.mod_update_times WHERE last_update > $1;", $since->format('Y-m-d H:i:s'));
while (!$rows->EOF()) {
	$pack = ContentPack::Fetch($rows->Field('mod_id'));
	if ($pack->IsIncludedInDeltas() === false) {
		$rows->MoveNext();
		continue;
	}
	
	BuildArkContentPackFile($completeArchive, null, $pack);
	
	if ($buildDeltas) {
		BuildArkContentPackFile($deltaArchive, $since, $pack);
	}
	
	$rows->MoveNext();
}

$completeUrl = $completeArchive->Upload($cdn, $root, 'Complete.beacondata');
$completeSize = $completeArchive->Size();
if ($buildDeltas) {
	$deltaUrl = $deltaArchive->Upload($cdn, $root, "{$deltaLabel}.beacondata");
	$deltaSize = $deltaArchive->Size();
} else {
	$deltaUrl = $completeUrl;
	$deltaSize = $completeSize;
}

// End, functions below

function BuildMainFile(Archiver $archive, ?DateTime $since): void {
	BuildFile([
		'archive' => $archive,
		'class' => 'Main',
		'since' => $since
	]);
}

function BuildArkContentPackFile(Archiver $archive, ?DateTime $since, ContentPack $contentPack): void {
	BuildFile([
		'archive' => $archive,
		'class' => 'Ark/Mod',
		'since' => $since,
		'ark' => [
			'contentPack' => $contentPack
		]
	]);
}

function BuildFile(array $settings): void {
	global $lastDatabaseUpdate, $database, $root, $version;
	
	$archive = $settings['archive'] ?? null;
	$since = $settings['since'] ?? null;
	$class = $settings['class'] ?? null;
	
	if (is_null($class)) {
		throw new Exception('Missing class variable in settings');
	}
	
	$isComplete = is_null($since);
	$isMain = $class === 'Main';
	
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
	
	$file = [
		'timestamp' => $lastDatabaseUpdate->getTimestamp(),
		'isFull' => true,
		'version' => $version
	];
	
	$ark = [];
	$common = [];
	
	switch ($class) {
	case 'Main':
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
		
		if ($isComplete === false) {
			$deletions = Core::Deletions(-1, $since);
			if (count($deletions) > 0) {
				$file['deletions'] = $deletions;
			}
		}
		
		$localName = 'Main.beacondata';
		break;
	case 'Ark/Mod':
		$pack = $settings['ark']['contentPack'];
		$filters['contentPackId'] = $pack->ContentPackId();
		
		$ark = [
			'configOptions' => ConfigOption::Search($filters, true),
			'creatures' => Creature::Search($filters, true),
			'engrams' => Engram::Search($filters, true),
			'lootDrops' => LootDrop::Search($filters, true),
			'lootDropIcons' => LootDropIcon::Search($filters, true),
			'maps' => Map::Search($filters, true),
			'spawnPoints' => SpawnPoint::Search($filters, true)
		];
		
		$packName = BeaconCommon::SanitizeFilename($pack->Name());
		$localName = "$packName.beacondata";
		break;
	default:
		throw new Exception("Unknown class {$class}");
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
		return;
	}
	
	$fileContents = json_encode($file);
	$archive->AddFile($localName, $fileContents);
}

class Archiver {
	protected $label;
	protected $archive;
	protected $path;
	protected $manifest;
	
	public function __construct(string $label) {
		$this->label = $label;
		$this->path = tempnam(sys_get_temp_dir(), $label) . '.tar';
		$this->archive = new PharData($this->path);
		$this->manifest = [
			'files' => []
		];
	}
	
	public function AddFile(string $localPath, string $content, bool $first = false): void {
		$this->archive->addFromString($localPath, $content);
		if ($first) {
			array_unique($this->manifest['files'], $localPath);
		} else {
			$this->manifest['files'][] = $localPath;
		}
	}
	
	public function Upload(BeaconCDN $cdn, string $parent, string $filename): string {
		$this->archive->addFromString('Manifest.json', json_encode($this->manifest));
		$this->archive->compress(Phar::GZ);
		
		$filenameUrl = urlencode($filename);
		$time = filemtime("{$this->path}.gz");
		$cdn->PutFile("{$parent}/{$filenameUrl}", file_get_contents("{$this->path}.gz"));
		
		return "{$parent}/{$filenameUrl}?bcdn_filename={$filenameUrl}&t={$time}";
	}
	
	public function Size(): int {
		if (file_exists("{$this->path}.gz")) {
			return filesize("{$this->path}.gz");
		} else if (file_exists($this->path)) {
			return filesize($this->path);
		} else {
			return 0;
		}
	}
	
	public function __destruct() {
		if (file_exists($this->path)) {
			unlink($this->path);
		}
		if (file_exists("{$this->path}.gz")) {
			unlink("{$this->path}.gz");
		}
	}
}

?>
