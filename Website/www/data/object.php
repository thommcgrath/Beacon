<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (!isset($_GET['id'])) {
	http_response_code(400);
	echo 'Missing id parameter';
	exit;
}

$workshop_id = isset($_GET['mod']) ? intval($_GET['mod']) : 0;
$obj = BeaconCommon::ResolveObjectIdentifier($_GET['id'], $workshop_id);
if (is_null($obj)) {
	http_response_code(404);
	echo 'Object not found';
	exit;
}

if (is_array($obj)) {
	echo '<h1>' . htmlentities($_GET['id']) . ' Disambiguation</h1>';
	echo '<ul>';
	foreach ($obj as $o) {
		echo '<li><a href="/object/' . urlencode($o->ModWorkshopID()) . '/' . urlencode($o->ClassString()) . '">' . htmlentities($o->Label()) . '</a> <span class="text-lighter">(' . htmlentities($o->ModName()) . ')</span></li>';
	}
	echo '</ul>';
	exit;
}

if ($obj instanceof BeaconBlueprint && $_GET['id'] != $obj->ClassString()) {
	if ($obj->IsAmbiguous()) {
		header('Location: /object/' . urlencode($obj->ModWorkshopID()) . '/' . urlencode($obj->ClassString()));
	} else {
		header('Location: /object/' . urlencode($obj->ClassString()));
	}
	exit;
}

BeaconTemplate::SetTitle($obj->Label());

$properties = array(
	'Mod' => '[' . $obj->ModName() . '](/mods/' . urlencode($obj->ModID()) . ')'
);
$tags = $obj->Tags();
if (count($tags) > 0) {
	$links = array();
	foreach ($tags as $tag) {
		$links[] = '[' . ucwords($tag) . '](/tags/' . urlencode($tag) . ')';
	}
	$properties['Tags'] = implode(', ', $links);
}

if ($obj instanceof BeaconBlueprint) {
	PrepareBlueprintTable($obj, $properties);
}

if ($obj instanceof BeaconCreature) {
	$type = 'Creature';
	PrepareCreatureTable($obj, $properties);
} elseif ($obj instanceof BeaconEngram) {
	$type = 'Engram';
	PrepareEngramTable($obj, $properties);
} elseif ($obj instanceof BeaconDiet) {
	$type = 'Diet';
	PrepareDietTable($obj, $properties);
} elseif ($obj instanceof BeaconLootSource) {
	$type = 'Loot Source';
	PrepareLootSourceTable($obj, $properties);
} elseif ($obj instanceof BeaconPreset) {
	$type = 'Preset';
	PreparePresetTable($obj, $properties);
} elseif ($obj instanceof BeaconSpawnPoint) {
	$type = 'Spawn Point';
	PrepareSpawnPointTable($obj, $properties);
}

$parser = new Parsedown();

echo '<h1><span class="object_type">' . htmlentities($type) . '</span> ' . htmlentities($obj->Label()) . (is_null($obj->AlternateLabel()) ? '' : '<br><span class="subtitle">AKA ' . htmlentities($obj->AlternateLabel()) . '</span>') . '</h1>';
if ($obj instanceof BeaconLootSource && $obj->Experimental()) {
	echo '<p class="notice-block notice-warning">This loot source is considered experimental. Some data on this page, such as the spawn code, may not be accurate.</p>';
}
echo '<table id="object_details" class="generic">';
foreach ($properties as $key => $value) {
	echo '<tr><td class="label">' . htmlentities($key) . '</td><td class="break-code">' . $parser->text($value) . '</td></tr>';
}
echo '</table>';

function PrepareBlueprintTable(BeaconBlueprint $blueprint, array &$properties) {
	$properties['Class'] = $blueprint->ClassString();
	$properties['Spawn Code'] = '`' . $blueprint->SpawnCode() . '`';
	$properties['Map Availability'] = implode(', ', BeaconMaps::Names($blueprint->Availability()));
	
	$related_ids = $blueprint->RelatedObjectIDs();
	$related_items = array();
	foreach ($related_ids as $id) {
		$blueprint = BeaconBlueprint::GetByObjectID($id);
		if (is_null($blueprint)) {
			$obj = BeaconObject::GetByObjectID($id);
			if (is_null($obj)) {
				continue;
			}
			$related_items[] = MarkdownLinkToObject($obj);
		} else {
			$related_items[] = MarkdownLinkToObject($blueprint);
		}
	}
	if (count($related_items) > 0) {
		$properties['Related Objects'] = implode(', ', $related_items);
	}
}

function PrepareCreatureTable(BeaconCreature $creature, array &$properties) {
	/*if ($creature->Tamable()) {
		$taming_diet = $creature->TamingDiet();
		$tamed_diet = $creature->TamedDiet();
		$preferred_food = BeaconObject::GetByObjectID($taming_diet[0]);
		$properties['Tamable'] = 'Yes';
		$properties['Taming Method'] = $creature->TamingMethod();
		$properties['Preferred Food'] = '[' . $preferred_food->Label() . '](/object.php/' . urlencode($preferred_food->ObjectID()) . ')';
		$properties['Taming Diet'] = '[' . $taming_diet->Label() . '](/object.php/' . urlencode($taming_diet->ObjectID()) . ')';
		$properties['Tamed Diet'] = '[' . $tamed_diet->Label() . '](/object.php/' . urlencode($tamed_diet->ObjectID()) . ')';
	} else {
		$properties['Tamable'] = 'No';
	}
	
	$properties['Rideable'] = $creature->Rideable() ? 'Yes' : 'No';
	$properties['Carryable'] = $creature->Carryable() ? 'Yes' : 'No';
	$properties['Breedable'] = $creature->Breedable() ? 'Yes' : 'No';*/
	$incubation_time = $creature->IncubationTimeSeconds();
	if (!is_null($incubation_time)) {
		$properties['Incubation Time'] = BeaconCommon::SecondsToEnglish($incubation_time);
	}
	$mature_time = $creature->MatureTimeSeconds();
	if (!is_null($mature_time)) {
		$properties['Mature Time'] = BeaconCommon::SecondsToEnglish($mature_time);
	}
	$min_mating_interval = $creature->MinMatingIntervalSeconds();
	$max_mating_interval = $creature->MaxMatingIntervalSeconds();
	if (is_null($min_mating_interval) == false && is_null($max_mating_interval) == false) {
		$properties['Mating Cooldown'] = BeaconCommon::SecondsToEnglish($min_mating_interval, false, 3600) . ' to ' . BeaconCommon::SecondsToEnglish($max_mating_interval, false, 3600);
	}
}

function PrepareEngramTable(BeaconEngram $engram, array &$properties) {
	if (is_null($engram->ItemID()) == false) {
		$properties['Item ID'] = $engram->ItemID();
		$properties['Short Spawn Code'] = '`cheat giveitemnum ' . $engram->ItemID() . ' 1 1 0`';
	}
	
	if (is_null($engram->StackSize()) == false) {
		$properties['Stack Size'] = $engram->StackSize();
	}
	
	$properties['Blueprintable'] = $engram->CanBlueprint() ? 'Yes' : 'No';
	$properties['Harvestable'] = $engram->Harvestable() ? 'Yes' : 'No';
	
	if (is_null($engram->EntryString()) == false) {
		$properties['Unlock Code'] = '`' . $engram->UnlockCode() . '`';
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

function PrepareLootSourceTable(BeaconLootSource $loot_source, array &$properties) {
	$properties['Multipliers'] = sprintf('%F - %F', $loot_source->MultiplierMin(), $loot_source->MultiplierMax());
}

function PrepareDietTable(BeaconDiet $diet, array &$properties) {
	$engram_ids = $diet->EngramIDs();
	$engrams = array();
	foreach ($engram_ids as $id) {
		$engram = BeaconEngram::GetByObjectID($id);
		$engrams[] = MarkdownLinkToObject($engram);
	}
	$properties['Preferred Foods'] = implode(', ', $engrams);
	
	$creature_ids = $diet->CreatureIDs();
	$creatures = array();
	foreach ($creature_ids as $id) {
		$creature = BeaconCreature::GetByObjectID($id);
		$creatures[] = MarkdownLinkToObject($creature);
	}
	$properties['Eaten By'] = implode(', ', $creatures);
}

function PreparePresetTable(BeaconPreset $preset, array &$properties) {
}

function PrepareSpawnPointTable(BeaconSpawnPoint $spawn_point, array &$properties) {
	$spawns = $spawn_point->Spawns();
	$limits = $spawn_point->Limits();
	if (is_null($limits)) {
		$limits = [];
	}
	
	if (is_null($spawns)) {
		return;
	}
	
	$unique_creatures = array();
	$creatures = array();
	foreach ($spawns as $group) {
		foreach ($group['creatures'] as $creature_path) {
			if (in_array($creature_path, $unique_creatures)) {
				continue;
			}
			
			$creature = BeaconCreature::GetByObjectPath($creature_path);
			if (is_null($creature)) {
				continue;
			}
			
			$label = MarkdownLinkToObject($creature);
			if (array_key_exists($creature_path, $limits)) {
				$label .= ' (Max ' . BeaconCommon::FormatFloat($limits[$creature_path] * 100, 0) . '%)';
			}
			$creatures[] = $label;
			$unique_creatures[] = $creature_path;
		}
	}
	
	foreach ($limits as $creature_path => $percentage) {
		if (in_array($creature_path, $unique_creatures)) {
			continue;
		}
		
		$creature = BeaconCreature::GetByObjectPath($creature_path);
		if (is_null($creature)) {
			continue;
		}
		
		$creatures[] = MarkdownLinkToObject($creature) . ' (Max ' . BeaconCommon::FormatFloat($percentage * 100, 0) . '%)';
	}
	
	sort($creatures);
	$properties['Spawns'] = implode(', ', $creatures);
	
	unset($properties['Spawn Code']);
}

function ExpandRecipe($parent, bool $as_array = false, int $level = 1, int $multiplier = 1) {
	$recipe = $parent->Recipe();
	if (is_null($recipe) || is_array($recipe) == false || $level > 6) {
		return null;
	}
	
	$lines = [];
	foreach ($recipe as $ingredient) {
		$object_id = $ingredient['object_id'];
		$quantity = $ingredient['quantity'] * $multiplier;
		$exact = $ingredient['exact'];
		
		$object = BeaconEngram::GetByObjectID($object_id);
		$lines[] = '- ' . number_format($quantity) . 'x ' . MarkdownLinkToObject($object);
		
		/*if ($object->IsTagged('harvestable') === false) {
			$subcosts = ExpandRecipe($object, true, $level + 1, $quantity);
			if (is_null($subcosts) === false) {
				foreach ($subcosts as $subline) {
					$lines[] = '  ' . $subline;
				}
			}
		}*/
	}
	
	if ($as_array) {
		return $lines;
	}
	return implode("\n", $lines);
}

function MarkdownLinkToObject(BeaconBlueprint $obj) {
	$path = $obj->ClassString();
	
	if ($obj->IsAmbiguous()) {
		$path = $obj->ModWorkshopID() . '/' . $path;
	}
	
	return '[' . $obj->Label() . '](/object/' . $path . ')';
}

?>