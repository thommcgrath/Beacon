<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Ark\{Blueprint, Creature, Engram, GenericObject, LootContainer, Map, SpawnPoint, Template};

$object_id = null;
$objects = [];

if (isset($_GET['object_id'])) {
	// find object by its id
	$object_id = $_GET['object_id'];
} elseif (isset($_GET['class_string'])) {
	// find all objects matching this class string
	$database = BeaconCommon::Database();
	try {
		if (isset($_GET['workshop_id'])) {
			$results = $database->Query('SELECT object_id, label, mods.name AS mod_name FROM ark.blueprints INNER JOIN ark.mods ON (blueprints.mod_id = mods.mod_id) WHERE class_string = $1 AND ABS(mods.workshop_id) = $2 ORDER BY blueprints.label;', $_GET['class_string'], abs($_GET['workshop_id']));
		} else {
			$results = $database->Query('SELECT object_id, label, mods.name AS mod_name FROM ark.blueprints INNER JOIN ark.mods ON (blueprints.mod_id = mods.mod_id) WHERE class_string = $1 ORDER BY blueprints.label;', $_GET['class_string']);
		}
		if ($results->RecordCount() === 1) {
			$object_id = $results->Field('object_id');
		} else {
			while (!$results->EOF()) {
				$objects[] = [
					'id' => $results->Field('object_id'),
					'label' => $results->Field('label'),
					'mod_name' => $results->Field('mod_name')
				];
				$results->MoveNext();
			}
		}
	} catch (Exception $err) {
	}
}

if (is_null($object_id) === false && BeaconCommon::IsUUID($object_id)) {
	$correct_path = '/object/' . urlencode($object_id);
	if ($_SERVER['REQUEST_URI'] !== $correct_path) {
		header('Location: ' . $correct_path, true, 301);
		exit;
	}
} elseif (count($objects) > 0) {
	echo '<h1>' . htmlentities($_GET['class_string']) . ' Disambiguation</h1>';
	echo '<ul>';
	foreach ($objects as $obj) {
		echo '<li><a href="/object/' . urlencode($obj['id']) . '">' . htmlentities($obj['label']) . '</a> <span class="text-lighter">(' . htmlentities($obj['mod_name']) . ')</span></li>';
	}
	echo '</ul>';
	exit;
} else {
	http_response_code(404);
	echo 'Object not found';
	exit;
}

$obj = BeaconCommon::ResolveObjectIdentifier($object_id);
if (is_null($obj)) {
	http_response_code(404);
	echo 'Object not found';
	exit;
}

BeaconTemplate::SetTitle($obj->Label());

$properties = [
	'Mod' => '[' . $obj->ContentPackName() . '](/mods/' . urlencode($obj->ContentPackSteamId()) . ')'
];
$tags = $obj->Tags();
if (count($tags) > 0) {
	$links = [];
	foreach ($tags as $tag) {
		$links[] = '[' . ucwords(str_replace('_', ' ', $tag)) . '](/tags/' . urlencode($tag) . ')';
	}
	$properties['Tags'] = implode(', ', $links);
}

if ($obj instanceof Blueprint) {
	PrepareBlueprintTable($obj, $properties);
}

if ($obj instanceof Creature) {
	$type = 'Creature';
	PrepareCreatureTable($obj, $properties);
} elseif ($obj instanceof Engram) {
	$type = 'Engram';
	PrepareEngramTable($obj, $properties);
} elseif ($obj instanceof LootContainer) {
	$type = 'Loot Container';
	PrepareLootSourceTable($obj, $properties);
} elseif ($obj instanceof Template) {
	$type = 'Template';
	PreparePresetTable($obj, $properties);
} elseif ($obj instanceof SpawnPoint) {
	$type = 'Spawn Point';
	PrepareSpawnPointTable($obj, $properties);
}

$parser = new Parsedown();

echo '<h1><span class="object_type">' . htmlentities($type) . '</span> ' . htmlentities($obj->Label()) . (is_null($obj->AlternateLabel()) ? '' : '<br><span class="subtitle">AKA ' . htmlentities($obj->AlternateLabel()) . '</span>') . '</h1>';
if ($obj instanceof LootContainer && $obj->Experimental()) {
	echo '<p class="notice-block notice-warning">This loot source is considered experimental. Some data on this page, such as the spawn code, may not be accurate.</p>';
}
echo '<table id="object_details" class="generic">';
foreach ($properties as $key => $value) {
	echo '<tr><td class="label">' . htmlentities($key) . '</td><td class="break-code">' . $parser->text($value) . '</td></tr>';
}
echo '</table>';

function PrepareBlueprintTable(Blueprint $blueprint, array &$properties) {
	$properties['Class'] = $blueprint->ClassString();
	
	$maps = Map::Search(['mask' => $blueprint->Availability()], true);
	$properties['Map Availability'] = Map::Names($maps);
	
	$relatedIds = $blueprint->RelatedObjectIDs();
	$relatedItems = [];
	foreach ($relatedIds as $id) {
		$blueprint = Blueprint::Fetch($id);
		if (is_null($blueprint)) {
			$obj = GenericObject::Fetch($id);
			if (is_null($obj)) {
				continue;
			}
			$relatedItems[] = MarkdownLinkToObject($obj);
		} else {
			$relatedItems[] = MarkdownLinkToObject($blueprint);
		}
	}
	if (count($relatedItems) > 0) {
		$properties['Related Objects'] = implode(', ', $relatedItems);
	}
}

function PrepareCreatureTable(Creature $creature, array &$properties) {
	$incubationTime = $creature->IncubationTimeSeconds();
	if (!is_null($incubationTime)) {
		$properties['Incubation Time'] = BeaconCommon::SecondsToEnglish($incubationTime);
	}
	$matureTime = $creature->MatureTimeSeconds();
	if (!is_null($matureTime)) {
		$properties['Mature Time'] = BeaconCommon::SecondsToEnglish($matureTime);
	}
	$minMatingInterval = $creature->MinMatingIntervalSeconds();
	$maxMatingInterval = $creature->MaxMatingIntervalSeconds();
	if (is_null($minMatingInterval) == false && is_null($maxMatingInterval) == false) {
		$properties['Mating Cooldown'] = BeaconCommon::SecondsToEnglish($minMatingInterval, false, 3600) . ' to ' . BeaconCommon::SecondsToEnglish($maxMatingInterval, false, 3600);
	}
	
	$properties['Spawn Code'] = '`' . $creature->SpawnCode() . '`';
}

function PrepareEngramTable(Engram $engram, array &$properties) {
	if (is_null($engram->ItemID()) == false) {
		$properties['Item ID'] = $engram->ItemID();
	}
	
	$properties['Spawn Code'] = '`' . $engram->SpawnCode() . '`';
	
	if (is_null($engram->StackSize()) == false) {
		$properties['Stack Size'] = $engram->StackSize();
	}
	
	$properties['Blueprintable'] = $engram->IsTagged('blueprintable') ? 'Yes' : 'No';
	$properties['Harvestable'] = $engram->IsTagged('harvestable') ? 'Yes' : 'No';
	
	if (is_null($engram->EntryString()) == false) {
		$properties['Unlock Code'] = '`cheat unlockengram "Blueprint\'' . $engram->Path() . '\'"`';
		$properties['Engram Specifier'] = $engram->EntryString();
		
		if (is_null($engram->RequiredPoints())) {
			$properties['Required Points'] = 'Tek';
		} else {
			$properties['Required Points'] = $engram->RequiredPoints();
		}
		
		if (is_null($engram->RequiredLevel())) {
			$properties['Required Level'] = 'Tek';
		} else {
			$properties['Required Level'] = $engram->RequiredLevel();
		}
	}
	
	$recipe = ExpandRecipe($engram);
	if (is_null($recipe) == false) {
		$properties['Crafting'] = $recipe;
	}
}

function PrepareLootSourceTable(LootContainer $lootContainer, array &$properties) {
	$properties['Multipliers'] = sprintf('%F - %F', $lootContainer->MultiplierMin(), $lootContainer->MultiplierMax());
	$properties['Spawn Code'] = '`' . $lootContainer->SpawnCode() . '`';
}

function PreparePresetTable(Template $preset, array &$properties) {
}

function PrepareSpawnPointTable(SpawnPoint $spawnPoint, array &$properties) {
	$spawns = $spawnPoint->Spawns();
	$limits = $spawnPoint->Limits();
	if (is_null($limits)) {
		$limits = [];
	} else {
		$temp = [];
		foreach ($limits as $limit) {
			$temp[$limit['creatureId']] = $limit['maxPercentage'];
		}
		$limits = $temp;
		unset($temp);
	}
	
	if (is_null($spawns)) {
		return;
	}
	
	$uniqueCreatures = [];
	foreach ($spawns as $set) {
		$entries = $set['entries'];
		foreach ($entries as $entry) {
			$creatureId = $entry['creatureId'];
			if (in_array($creatureId, $uniqueCreatures)) {
				continue;
			}
			$uniqueCreatures[] = $creatureId;
		}
	}
	
	$creatures = [];
	foreach ($uniqueCreatures as $creatureId) {
		$creature = Creature::Fetch($creatureId);
		$label = MarkdownLinkToObject($creature);
		if (array_key_exists($creatureId, $limits)) {
			$label .= ' (Max ' . BeaconCommon::FormatFloat($limits[$creatureId] * 100, 0) . '%)';
		}
		$creatures[] = $label;
	}
	
	sort($creatures);
	$properties['Spawns'] = implode(', ', $creatures);
	
	$populationData = $spawnPoint->Populations();
	if (count($populationData) > 0) {
		$populations = ['<table class="generic auto-width"><thead class="smaller"><tr><th class="min-width">Map</th><th class="text-right min-width low-priority">Num Nodes</th><th class="text-right min-width low-priority">Pop Per Node</th><th class="text-right min-width low-priority">Target Pop</th></thead>', '<tbody>'];
		foreach ($populationData as $map_id => $pop) {
			$map = Map::Fetch($map_id);
			$nodeCount = $pop['instances'];
			$targetPop = $pop['targetPopulation'];
			$avgPerNode = round($targetPop / $nodeCount);
			$nodeCount = number_format($nodeCount);
			$targetPop = number_format($targetPop);
			$avgPerNode = number_format($avgPerNode);
			$populations[] = "<tr><td><span class=\"nowrap\">{$map->Label()}</span><div class=\"row-details\">Nodes: {$nodeCount}, Pop Per Node {$avgPerNode}, Target Pop: {$targetPop}</div></td><td class=\"text-right low-priority\">{$nodeCount}</td><td class=\"text-right low-priority\">{$avgPerNode}</td><td class=\"text-right low-priority\">{$targetPop}</td></tr>";
		}
		$populations[] = '</tbody>';
		$populations[] = '</table>';
		$properties['Populations'] = implode("\n", $populations);
	}
	
	unset($properties['Spawn Code']);
}

function ExpandRecipe(Engram $engram, bool $asArray = false, int $level = 1, int $multiplier = 1): null|string|array {
	$recipe = $engram->Recipe();
	if (is_null($recipe) || is_array($recipe) == false || $level > 6) {
		return null;
	}
	
	$lines = [];
	foreach ($recipe as $ingredient) {
		$engramId = $ingredient['engramId'];
		$quantity = $ingredient['quantity'] * $multiplier;
		$exact = $ingredient['exact'];
		
		$object = Engram::Fetch($engramId);
		$lines[] = '- <span class="crafting_quantity">' . number_format($quantity) . 'x</span> ' . MarkdownLinkToObject($object);
	}
	
	if ($asArray) {
		return $lines;
	}
	return implode("\n", $lines);
}

function MarkdownLinkToObject(GenericObject $obj) {
	return '[' . $obj->Label() . '](/object/' . urlencode($obj->UUID()) . ')';
}

?>