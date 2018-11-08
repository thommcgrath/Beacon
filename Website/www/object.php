<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

if (!isset($_SERVER['PATH_INFO'])) {
	http_response_code(404);
	echo 'This doesn\'t lead anywhere.';
	exit;
}

$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
if ((is_array($request) === false) || (count($request) == 0)) {
	http_response_code(404);
	echo 'This doesn\'t lead anywhere.';
	exit;
}

$object_id = $request[0];
if (!BeaconCommon::IsUUID($object_id)) {
	http_response_code(400);
	echo 'Malformed object id';
	exit;
}

$obj = BeaconObject::GetByObjectID($object_id);
if (is_null($obj)) {
	http_response_code(404);
	echo 'Object not found';
	exit;
}
$group = $obj->ObjectGroup();
$properties = array(
	'Mod' => '[' . $obj->ModName() . '](/mods/info.php?mod_id=' . urlencode($obj->ModID()) . ')'
);

BeaconTemplate::SetTitle($obj->Label());

switch ($group) {
case 'creatures':
	$type = 'Creature';
	PrepareCreatureTable(BeaconCreature::GetByObjectID($object_id), $properties);
	break;
case 'diets':
	$type = 'Diet';
	PrepareDietTable(BeaconDiet::GetByObjectID($object_id), $properties);
	break;
case 'engrams':
	$type = 'Engram';
	PrepareEngramTable(BeaconEngram::GetByObjectID($object_id), $properties);
	break;
case 'loot_sources':
	$type = 'Loot Source';
	PrepareLootSourceTable(BeaconLootSource::GetByObjectID($object_id), $properties);
	break;
case 'presets':
	$type = 'Preset';
	PreparePresetTable(BeaconPreset::GetByObjectID($object_id), $properties);
	break;
default:
	$type = $group;
	break;
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
		$obj = BeaconObject::GetByObjectID($id);
		if (is_null($obj)) {
			continue;
		}
		
		$related_items[] = '[' . $obj->Label() . '](/object.php/' . urlencode($obj->ObjectID()) . ')';
	}
	if (count($related_items) > 0) {
		$properties['Related Objects'] = implode(', ', $related_items);
	}
}

function PrepareCreatureTable(BeaconCreature $creature, array &$properties) {
	if ($creature instanceof BeaconBlueprint) {
		PrepareBlueprintTable($creature, $properties);
	}
	
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
	if ($engram instanceof BeaconBlueprint) {
		PrepareBlueprintTable($engram, $properties);
	}
}

function PrepareLootSourceTable(BeaconLootSource $loot_source, array &$properties) {
	if ($loot_source instanceof BeaconBlueprint) {
		PrepareBlueprintTable($loot_source, $properties);
	}
	
	$properties['Multipliers'] = sprintf('%F - %F', $loot_source->MultiplierMin(), $loot_source->MultiplierMax());
}

function PrepareDietTable(BeaconDiet $diet, array &$properties) {
	if ($diet instanceof BeaconBlueprint) {
		PrepareBlueprintTable($engram, $diet);
	}
	
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
	if ($preset instanceof BeaconBlueprint) {
		PrepareBlueprintTable($preset, $properties);
	}
}

?>