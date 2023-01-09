<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

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
	'Mod' => '[' . $obj->ModName() . '](/mods/' . urlencode($obj->ModID()) . ')'
];
$tags = $obj->Tags();
if (count($tags) > 0) {
	$links = [];
	foreach ($tags as $tag) {
		$links[] = '[' . ucwords(str_replace('_', ' ', $tag)) . '](/tags/' . urlencode($tag) . ')';
	}
	$properties['Tags'] = implode(', ', $links);
}

if ($obj instanceof \Ark\Blueprint) {
	PrepareBlueprintTable($obj, $properties);
}

if ($obj instanceof \Ark\Creature) {
	$type = 'Creature';
	PrepareCreatureTable($obj, $properties);
} elseif ($obj instanceof \Ark\Engram) {
	$type = 'Engram';
	PrepareEngramTable($obj, $properties);
} elseif ($obj instanceof \Ark\Diet) {
	$type = 'Diet';
	PrepareDietTable($obj, $properties);
} elseif ($obj instanceof \Ark\LootSource) {
	$type = 'Loot Source';
	PrepareLootSourceTable($obj, $properties);
} elseif ($obj instanceof \Ark\Preset) {
	$type = 'Preset';
	PreparePresetTable($obj, $properties);
} elseif ($obj instanceof \Ark\SpawnPoint) {
	$type = 'Spawn Point';
	PrepareSpawnPointTable($obj, $properties);
}

$parser = new Parsedown();

echo '<h1><span class="object_type">' . htmlentities($type) . '</span> ' . htmlentities($obj->Label()) . (is_null($obj->AlternateLabel()) ? '' : '<br><span class="subtitle">AKA ' . htmlentities($obj->AlternateLabel()) . '</span>') . '</h1>';
if ($obj instanceof \Ark\LootSource && $obj->Experimental()) {
	echo '<p class="notice-block notice-warning">This loot source is considered experimental. Some data on this page, such as the spawn code, may not be accurate.</p>';
}
echo '<table id="object_details" class="generic">';
foreach ($properties as $key => $value) {
	echo '<tr><td class="label">' . htmlentities($key) . '</td><td class="break-code">' . $parser->text($value) . '</td></tr>';
}
echo '</table>';

function PrepareBlueprintTable(\Ark\Blueprint $blueprint, array &$properties) {
	$properties['Class'] = $blueprint->ClassString();
	if ($blueprint instanceof \Ark\Engram) {
		$spawn_codes = $blueprint->GenerateSpawnCodes(1, false);
		if (isset($spawn_codes['gfi'])) {
			$properties['GFI Spawn Code'] = '`' . $spawn_codes['gfi'] . '`';
		}
		if (isset($spawn_codes['index'])) {
			$properties['Numeric Spawn Code'] = '`' . $spawn_codes['index'] . '`';
		}
		$properties['Spawn Code'] = '`' . $spawn_codes['full'] . '`';
	} else {
		$properties['Spawn Code'] = '`' . $blueprint->SpawnCode() . '`';
	}
	$properties['Map Availability'] = implode(', ', \Ark\Maps::Names($blueprint->Availability()));
	
	$related_ids = $blueprint->RelatedObjectIDs();
	$related_items = [];
	foreach ($related_ids as $id) {
		$blueprint = \Ark\Blueprint::GetByObjectID($id);
		if (is_null($blueprint)) {
			$obj = \Ark\GenericObject::GetByObjectID($id);
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

function PrepareCreatureTable(\Ark\Creature $creature, array &$properties) {
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

function PrepareEngramTable(\Ark\Engram $engram, array &$properties) {
	if (is_null($engram->ItemID()) == false) {
		$properties['Item ID'] = $engram->ItemID();
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

function PrepareLootSourceTable(\Ark\LootSource $loot_source, array &$properties) {
	$properties['Multipliers'] = sprintf('%F - %F', $loot_source->MultiplierMin(), $loot_source->MultiplierMax());
}

function PrepareDietTable(\Ark\Diet $diet, array &$properties) {
	$engram_ids = $diet->EngramIDs();
	$engrams = [];
	foreach ($engram_ids as $id) {
		$engram = \Ark\Engram::GetByObjectID($id);
		$engrams[] = MarkdownLinkToObject($engram);
	}
	$properties['Preferred Foods'] = implode(', ', $engrams);
	
	$creature_ids = $diet->CreatureIDs();
	$creatures = [];
	foreach ($creature_ids as $id) {
		$creature = \Ark\Creature::GetByObjectID($id);
		$creatures[] = MarkdownLinkToObject($creature);
	}
	$properties['Eaten By'] = implode(', ', $creatures);
}

function PreparePresetTable(\Ark\Preset $preset, array &$properties) {
}

function PrepareSpawnPointTable(\Ark\SpawnPoint $spawn_point, array &$properties) {
	$spawns = $spawn_point->Spawns();
	$limits = $spawn_point->Limits();
	if (is_null($limits)) {
		$limits = [];
	} else {
		$temp = [];
		foreach ($limits as $limit) {
			$temp[$limit['creature']['UUID']] = $limit['max_percent'];
		}
		$limits = $temp;
		unset($temp);
	}
	
	if (is_null($spawns)) {
		return;
	}
	
	$unique_creatures = [];
	foreach ($spawns as $set) {
		$entries = $set['entries'];
		foreach ($entries as $entry) {
			$creature_id = $entry['creature']['UUID'];
			if (in_array($creature_id, $unique_creatures)) {
				continue;
			}
			$unique_creatures[] = $creature_id;
		}
	}
	
	$creatures = [];
	foreach ($unique_creatures as $creature_id) {
		$creature = \Ark\Creature::GetByObjectID($creature_id);
		$label = MarkdownLinkToObject($creature);
		if (array_key_exists($creature_id, $limits)) {
			$label .= ' (Max ' . BeaconCommon::FormatFloat($limits[$creature_id] * 100, 0) . '%)';
		}
		$creatures[] = $label;
	}
	
	sort($creatures);
	$properties['Spawns'] = implode(', ', $creatures);
	
	$populations = ['<table class="generic auto-width"><thead class="smaller"><tr><th class="min-width">Map</th><th class="text-right min-width low-priority">Num Nodes</th><th class="text-right min-width low-priority">Pop Per Node</th><th class="text-right min-width low-priority">Target Pop</th></thead>', '<tbody>'];
	$population_data = $spawn_point->Populations();
	foreach ($population_data as $map_id => $pop) {
		$map = \Ark\Map::GetNamed($map_id)[0];
		$node_count = $pop['instances'];
		$target_pop = $pop['target_population'];
		$avg_per_node = round($target_pop / $node_count);
		$node_count = number_format($node_count);
		$target_pop = number_format($target_pop);
		$avg_per_node = number_format($avg_per_node);
		$populations[] = "<tr><td><span class=\"nowrap\">{$map->Label()}</span><div class=\"row-details\">Nodes: {$node_count}, Pop Per Node {$avg_per_node}, Target Pop: {$target_pop}</div></td><td class=\"text-right low-priority\">{$node_count}</td><td class=\"text-right low-priority\">{$avg_per_node}</td><td class=\"text-right low-priority\">{$target_pop}</td></tr>";
	}
	$populations[] = '</tbody>';
	$populations[] = '</table>';
	$properties['Populations'] = implode("\n", $populations);
	
	unset($properties['Spawn Code']);
}

function ExpandRecipe($parent, bool $as_array = false, int $level = 1, int $multiplier = 1) {
	$recipe = $parent->Recipe();
	if (is_null($recipe) || is_array($recipe) == false || $level > 6) {
		return null;
	}
	
	$lines = [];
	foreach ($recipe as $ingredient) {
		$object_id = $ingredient['engram']['UUID'];
		$quantity = $ingredient['quantity'] * $multiplier;
		$exact = $ingredient['exact'];
		
		$object = \Ark\Engram::GetByObjectID($object_id);
		$lines[] = '- <span class="crafting_quantity">' . number_format($quantity) . 'x</span> ' . MarkdownLinkToObject($object);
		
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

function MarkdownLinkToObject(\Ark\Blueprint $obj) {
	$path = $obj->ObjectID();
	
	return '[' . $obj->Label() . '](/object/' . $path . ')';
}

?>