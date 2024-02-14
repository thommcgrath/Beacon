<?php

use BeaconAPI\v4\{ContentPack, Core, RCONCommand, Template, TemplateSelector};
use BeaconAPI\v4\Ark;
use BeaconAPI\v4\SDTD;
use BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\Palworld;

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
$completeArchive = new Archiver('Complete', true, $lastDatabaseUpdate->getTimestamp());
BuildMainFile($completeArchive, null);

// Need to find the mods that have changes since the last run
$packs = ContentPack::Search(['isIncludedInDeltas' => true, 'isConfirmed' => true], true);
$packIds = [];
foreach ($packs as $pack) {
	$packIds[$pack->ContentPackId()] = $pack;
	switch ($pack->GameId()) {
	case 'Ark':
		BuildArkContentPackFile($completeArchive, null, $pack);
		break;
	case '7DaysToDie':
		Build7DTDContentPackFile($completeArchive, null, $pack);
		break;
	case 'ArkSA':
		BuildArkSAContentPackFile($completeArchive, null, $pack);
		break;
	case 'Palworld':
		BuildPalworldContentPackFile($completeArchive, null, $pack);
		break;
	}
}

// And delta archive
$deltaArchive = null;
if ($buildDeltas) {
	$deltaArchive = new Archiver($deltaLabel, false, $lastDatabaseUpdate->getTimestamp());
	BuildMainFile($deltaArchive, $since);

	$rows = $database->Query("SELECT DISTINCT content_pack_id FROM public.content_update_times WHERE last_update > $1;", $since->format('Y-m-d H:i:s'));
	while (!$rows->EOF()) {
		if (array_key_exists($rows->Field('content_pack_id'), $packIds) === false) {
			$rows->MoveNext();
			continue;
		}

		$pack = $packIds[$rows->Field('content_pack_id')];
		if ($pack->IsIncludedInDeltas() === false || $pack->IsConfirmed() === false) {
			$rows->MoveNext();
			continue;
		}

		switch ($pack->GameId()) {
		case 'Ark':
			BuildArkContentPackFile($deltaArchive, $since, $pack);
			break;
		case '7DaysToDie':
			Build7DTDContentPackFile($deltaArchive, $since, $pack);
			break;
		case 'ArkSA':
			BuildArKSAContentPackFile($deltaArchive, $since, $pack);
			break;
		case 'Palworld':
			BuildPalworldContentPackFile($deltaArchive, $since, $pack);
			break;
		}

		$rows->MoveNext();
	}
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
		'Ark' => [
			'contentPack' => $contentPack
		]
	]);
}

function Build7DTDContentPackFile(Archiver $archive, ?DateTime $since, ContentPack $contentPack): void {
	BuildFile([
		'archive' => $archive,
		'class' => '7DaysToDie/ContentPack',
		'since' => $since,
		'7DaysToDie' => [
			'contentPack' => $contentPack
		]
	]);
}

function BuildArkSAContentPackFile(Archiver $archive, ?DateTime $since, ContentPack $contentPack): void {
	BuildFile([
		'archive' => $archive,
		'class' => 'ArkSA/ContentPack',
		'since' => $since,
		'ArkSA' => [
			'contentPack' => $contentPack
		]
	]);
}

function BuildPalworldContentPackFile(Archiver $archive, ?DateTime $since, ContentPack $contentPack): void {
	BuildFile([
		'archive' => $archive,
		'class' => 'Palworld/ContentPack',
		'since' => $since,
		'Palworld' => [
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
		'isIncludedInDeltas' => true,
		'isConfirmed' => true
	];
	if ($isComplete === false) {
		$filters['lastUpdate'] = $since->getTimestamp();
	}

	$payloads = [];

	switch ($class) {
	case 'Main':
		// Deletions in the first payload(s)
		if ($isComplete === false) {
			$deletions = Core::Deletions(-1, $since);
			$organizedDeletions = [];
			foreach ($deletions as $deletion) {
				$gameId = $deletion['gameId'];
				$group = $deletion['group'];
				if ($gameId === 'Ark' && ($group === 'presets' || $group === 'preset_modifiers')) {
					$gameId = 'Common';
				} else {
					unset($deletion['gameId']);
				}
				$organizedDeletions[$gameId][] = $deletion;
			}
			foreach ($organizedDeletions as $gameId => $gameDeletions) {
				$payloads[] = [
					'gameId' => $gameId,
					'deletions' => $gameDeletions,
				];
			}
		}

		$payloads[] = [
			'gameId' => 'Ark',
			'colors' => Ark\Color::Search($filters, true),
			'colorSets' => Ark\ColorSet::Search($filters, true),
			'contentPacks' => ContentPack::Search([...$filters, 'gameId' => 'Ark'], true),
			'events' => Ark\Event::Search($filters, true),
			'gameVariables' => Ark\GameVariable::Search($filters, true)
		];

		$payloads[] = [
			'gameId' => 'Common',
			'templates' => Template::Search($filters, true),
			'templateSelectors' => TemplateSelector::Search($filters, true),
			'rconCommands' => RCONCommand::Search($filters, true),
		];

		$payloads[] = [
			'gameId' => '7DaysToDie',
			'contentPacks' => ContentPack::Search([...$filters, 'gameId' => '7DaysToDie'], true),
		];

		$payloads[] = [
			'gameId' => 'ArkSA',
			'colors' => ArkSA\Color::Search($filters, true),
			'colorSets' => ArkSA\ColorSet::Search($filters, true),
			'contentPacks' => ContentPack::Search([...$filters, 'gameId' => 'ArkSA'], true),
			'events' => ArkSA\Event::Search($filters, true),
			'gameVariables' => ArkSA\GameVariable::Search($filters, true)
		];

		$payloads[] = [
			'gameId' => 'Palworld',
			'contentPacks' => ContentPack::Search([...$filters, 'gameId' => 'Palworld'], true),
			'gameVariables' => Palworld\GameVariable::Search($filters, true)
		];

		$localName = 'Main.json';
		break;
	case 'Ark/Mod':
		$pack = $settings['Ark']['contentPack'];
		$filters['contentPackId'] = $pack->ContentPackId();

		$payloads[] = [
			'gameId' => 'Ark',
			'configOptions' => Ark\ConfigOption::Search($filters, true),
			'creatures' => Ark\Creature::Search($filters, true),
			'engrams' => Ark\Engram::Search($filters, true),
			'lootDrops' => Ark\LootDrop::Search($filters, true),
			'lootDropIcons' => Ark\LootDropIcon::Search($filters, true),
			'maps' => Ark\Map::Search($filters, true),
			'spawnPoints' => Ark\SpawnPoint::Search($filters, true)
		];

		$localName = "{$pack->ContentPackId()}.json";
		break;
	case '7DaysToDie/ContentPack':
		$pack = $settings['7DaysToDie']['contentPack'];
		$filters['contentPackId'] = $pack->ContentPackId();

		$payloads[] = [
			'gameId' => '7DaysToDie',
			'configOptions' => SDTD\ConfigOption::Search($filters, true),
		];

		$localName = "{$pack->ContentPackId()}.json";
		break;
	case 'ArkSA/ContentPack':
		$pack = $settings['ArkSA']['contentPack'];
		$filters['contentPackId'] = $pack->ContentPackId();

		$payloads[] = [
			'gameId' => 'ArkSA',
			'configOptions' => ArkSA\ConfigOption::Search($filters, true),
			'creatures' => ArkSA\Creature::Search($filters, true),
			'engrams' => ArkSA\Engram::Search($filters, true),
			'lootDrops' => ArkSA\LootDrop::Search($filters, true),
			'lootDropIcons' => ArkSA\LootDropIcon::Search($filters, true),
			'maps' => ArkSA\Map::Search($filters, true),
			'spawnPoints' => ArkSA\SpawnPoint::Search($filters, true)
		];

		$localName = "{$pack->ContentPackId()}.json";
		break;
	case 'Palworld/ContentPack':
		$pack = $settings['Palworld']['contentPack'];
		$filters['contentPackId'] = $pack->ContentPackId();

		$payloads[] = [
			'gameId' => 'Palworld',
			'configOptions' => Palworld\ConfigOption::Search($filters, true)
		];

		$localName = "{$pack->ContentPackId()}.json";
		break;
	default:
		throw new Exception("Unknown class {$class}");
	}

	foreach ($payloads as $payloadNum => $payload) {
		$numValues = 0;
		$keys = array_keys($payload);
		foreach ($keys as $key) {
			if ($key === 'gameId') {
				continue;
			}

			$list = $payload[$key];
			if (is_array($list) === false) {
				$numValues++;
				continue;
			}

			if (count($list) === 0) {
				unset($payload[$key]);
			} else {
				$numValues++;
			}
		}
		if ($numValues === 0) {
			unset($payloads[$payloadNum]);
		} else {
			$payloads[$payloadNum] = $payload;
		}
	}
	$payloads = array_values($payloads);
	if (count($payloads) === 0) {
		return;
	}

	$fileContents = json_encode(['payloads' => $payloads]);
	$archive->AddFile($localName, $fileContents);
}

class Archiver {
	protected $label;
	protected $archive;
	protected $path;
	protected $manifest;

	public function __construct(string $label, bool $isFull, int $timestamp) {
		$this->label = $label;
		$this->path = tempnam(sys_get_temp_dir(), $label) . '.tar';
		$this->archive = new PharData($this->path);
		$this->manifest = [
			'version' => 7,
			'isFull' => $isFull,
			'timestamp' => $timestamp,
			'files' => []
		];
	}

	public function GetManifestValue(string $key): mixed {
		if (array_key_exists($key, $this->manifest)) {
			return $this->manifest[$key];
		} else {
			return null;
		}
	}

	public function SetManifestValue(string $key, mixed $value): void {
		$this->manifest[$key] = $value;
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
