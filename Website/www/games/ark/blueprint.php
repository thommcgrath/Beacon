<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\Ark\{Blueprint, Creature, Engram, GenericObject, LootDrop, Map, SpawnPoint};

$objects = [];

$useModUrl = false;
if (isset($_GET['objectId'])) {
	// find object by its id
	$object = Blueprint::Fetch($_GET['objectId']);
	if (is_null($object) === false) {
		$objects[] = $object;
	}
	$useModUrl = true;
} elseif (isset($_GET['classString'])) {
	// find all objects matching this class string
	$database = BeaconCommon::Database();
	try {
		$filters = [
			'classString' => $_GET['classString']
		];
		if (isset($_GET['contentPackId'])) {
			$contentPackId = trim($_GET['contentPackId']);
			if (BeaconUUID::Validate($contentPackId)) {
				$filters['contentPackId'] = $contentPackId;
			} elseif (filter_var($contentPackId, FILTER_VALIDATE_INT, ['options' => ['min_range' => -9223372036854775808, 'max_range' => 9223372036854775807]])) {
				$filters['contentPackMarketplaceId'] = $contentPackId;
			}
			$useModUrl = true;
		}
		
		$objects = Blueprint::Search($filters, true);
	} catch (Exception $err) {
	}
}

if (count($objects) === 0) {
	http_response_code(404);
	echo 'Object not found';
	exit;
}

/*
If there are multiple results, we need to determine if they belong to the same mod or not.
If they do, we show them all on the same page. If not, we allow the user to choose between mods
*/

$contentPackNames = [];
foreach ($objects as $object) {
	$contentPackNames[$object->ContentPackMarketplaceId()] = $object->ContentPackName();
}
if (count($contentPackNames) > 1) {
	$classString = $objects[0]->ClassString();
	BeaconTemplate::SetCanonicalPath('/Games/Ark/' . urlencode($classString));
	$title = 'Disambiguation for class ' . $classString;
	BeaconTemplate::SetTitle($title);
	echo '<h1>' . htmlentities($title) . '</h1>';
	echo '<p>The class ' . htmlentities($classString) . ' was found in multiple mods.</p>';
	echo '<ul>';
	foreach ($contentPackNames as $marketplaceId => $name) {
		echo '<li><a href="/Games/Ark/Mods/' . htmlentities(urlencode($marketplaceId)) . '/' . htmlentities(urlencode($classString)) . '">' . htmlentities($name) . '</a>';
	}
	echo '</ul>';
	exit;
}

BeaconTemplate::SetCanonicalPath('/Games/Ark/Mods/' . $objects[0]->ContentPackMarketplaceId() . '/' . urlencode($objects[0]->ClassString()));

$titleClass = 'h1';
if (count($objects) === 1) {
	BeaconTemplate::SetTitle($objects[0]->Label());
} else {
	$title = 'Multiple objects for class ' . $objects[0]->ClassString();
	BeaconTemplate::SetTitle($title);
	echo '<h1>' . htmlentities($title) . '</h1>';
	$titleClass = 'h2';
}

$parser = new Parsedown();
foreach ($objects as $object) {
	$objectGroup = '';
	switch ($object->ObjectGroup()) {
	case 'creatures':
		$type = 'Creature';
		$objectGroup = 'Creatures';
		$obj = Creature::Fetch($object->ObjectId());
		break;
	case 'engrams':
		$type = 'Engram';
		$objectGroup = 'Engrams';
		$obj = Engram::Fetch($object->ObjectId());
		break;
	case 'lootDrops':
		$type = 'Loot Drop';
		$objectGroup = 'LootDrops';
		$obj = LootDrop::Fetch($object->ObjectId());
		break;
	case 'spawnPoints':
		$type = 'Spawn Point';
		$objectGroup = 'SpawnPoints';
		$obj = SpawnPoint::Fetch($object->ObjectId());
		break;
	default:
		continue;
	}
	
	$properties = [
		'Mod' => '[' . $obj->ContentPackName() . '](/Games/Ark/Mods/' . urlencode($obj->ContentPackMarketplaceId()) . '/' . urlencode($objectGroup) . ')'
	];
	$tags = $obj->Tags();
	if (count($tags) > 0) {
		$links = [];
		foreach ($tags as $tag) {
			$tagInfo = Blueprint::ConvertTag($tag);
			$links[] = '[' . $tagInfo['human'] . '](/Games/Ark/Tags/' . urlencode($tagInfo['url']) . '/' . urlencode($objectGroup) . ')';
		}
		$properties['Tags'] = implode(', ', $links);
	}
	
	if ($obj instanceof Blueprint) {
		PrepareBlueprintTable($obj, $properties);
	}
	if ($obj instanceof Creature) {
		PrepareCreatureTable($obj, $properties);
	}
	if ($obj instanceof Engram) {
		PrepareEngramTable($obj, $properties);
	}
	if ($obj instanceof LootDrop) {
		PrepareLootDropTable($obj, $properties);
	}
	if ($obj instanceof SpawnPoint) {
		PrepareSpawnPointTable($obj, $properties);
	}
	
	echo '<' . $titleClass . '><span class="object_type">' . htmlentities($type) . '</span> ' . htmlentities($obj->Label()) . (is_null($obj->AlternateLabel()) ? '' : '<br><span class="subtitle">AKA ' . htmlentities($obj->AlternateLabel()) . '</span>') . '</' . $titleClass . '>';
	if ($obj instanceof LootDrop && $obj->Experimental()) {
		echo '<p class="notice-block notice-warning">This loot drop is considered experimental. Some data on this page, such as the spawn code, may not be accurate.</p>';
	}
	echo '<table id="object_details" class="generic">';
	foreach ($properties as $key => $value) {
		echo '<tr><td class="label">' . htmlentities($key) . '</td><td class="break-code">' . $parser->text($value) . '</td></tr>';
	}
	echo '</table>';
}

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

function PrepareLootDropTable(LootDrop $lootDrop, array &$properties) {
	$properties['Multipliers'] = sprintf('%F - %F', $lootDrop->MultiplierMin(), $lootDrop->MultiplierMax());
	$properties['Spawn Code'] = '`' . $lootDrop->SpawnCode() . '`';
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
	return '[' . $obj->Label() . '](/Games/Ark/Mods/' . urlencode($obj->ContentPackMarketplaceId()) . '/' . urlencode($obj->ClassString()) . ')';
}

?>