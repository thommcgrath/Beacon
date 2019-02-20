<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

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
}

$parser = new Parsedown();

echo '<h1><span class="object_type">' . htmlentities($type) . '</span> ' . htmlentities($obj->Label()) . '</h1>';
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
			$related_items[] = '[' . $obj->Label() . '](/object/' . urlencode($obj->ObjectID()) . ')';
		} else {
			$related_items[] = '[' . $blueprint->Label() . '](/object/' . urlencode($blueprint->ClassString()) . ')';
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
}

function PrepareEngramTable(BeaconEngram $engram, array &$properties) {
}

function PrepareLootSourceTable(BeaconLootSource $loot_source, array &$properties) {
	$properties['Multipliers'] = sprintf('%F - %F', $loot_source->MultiplierMin(), $loot_source->MultiplierMax());
}

function PrepareDietTable(BeaconDiet $diet, array &$properties) {
	$engram_ids = $diet->EngramIDs();
	$engrams = array();
	foreach ($engram_ids as $id) {
		$engram = BeaconEngram::GetByObjectID($id);
		$engrams[] = '[' . $engram->Label() . '](/object.php/' . $engram->ObjectID() . ')';
	}
	$properties['Preferred Foods'] = implode(', ', $engrams);
	
	$creature_ids = $diet->CreatureIDs();
	$creatures = array();
	foreach ($creature_ids as $id) {
		$creature = BeaconCreature::GetByObjectID($id);
		$creatures[] = '[' . $creature->Label() . '](/object.php/' . $creature->ObjectID() . ')';
	}
	$properties['Eaten By'] = implode(', ', $creatures);
}

function PreparePresetTable(BeaconPreset $preset, array &$properties) {
}

?>