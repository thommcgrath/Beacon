<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
	$since = $since->format('Y-m-d H:i:sO');
}

$min_version = array_key_exists('version', $_GET) ? intval($_GET['version']) : null;

$database = ConnectionManager::BeaconDatabase();
$values = array();

# Loot Soruces

if ($since === null) {
	if ($min_version === null) {
		$results = $database->Query("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort, min_version FROM loot_sources WHERE min_version IS NULL;");
	} else {
		$results = $database->Query("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort, min_version FROM loot_sources WHERE min_version IS NULL OR min_version <= $1;", array($min_version));
	}
	$delete_results = null;
} else {
	if ($min_version === null) {
		$results = $database->Query("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort, min_version FROM loot_sources WHERE last_update > $1 AND min_version IS NULL;", array($since));
	} else {
		$results = $database->Query("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort, min_version FROM loot_sources WHERE last_update > $1 AND (min_version IS NULL OR min_version <= $2);", array($since, $min_version));
	}
	$delete_results = $database->Query("SELECT classstring FROM deletions WHERE \"table\" = 'loot_sources' AND time > $1;", array($since));
}
$sources = array();
while (!$results->EOF()) {
	$sources[] = array(
		'class' => $results->Field('classstring'),
		'label' => $results->Field('label'),
		'kind' => $results->Field('kind'),
		'mask' => intval($results->Field('engram_mask')),
		'mult_min' => floatval($results->Field('multiplier_min')),
		'mult_max' => floatval($results->Field('multiplier_max')),
		'uicolor' => $results->Field('uicolor'),
		'sort' => intval($results->Field('sort')),
		'version' => intval($results->Field('min_version'))
	);
	$results->MoveNext();
}
$sources_deleted = array();
if ($delete_results !== null) {
	while (!$delete_results->EOF()) {
		$sources_deleted[] = $delete_results->Field('classstring');
		$delete_results->MoveNext();
	}
} 
$values['loot_sources'] = array(
	'additions' => $sources,
	'removals' => $sources_deleted
);

# Engrams

if ($since === null) {
	if ($min_version === null) {
		$results = $database->Query("SELECT classstring, label, availability, can_blueprint, min_version FROM engrams WHERE min_version IS NULL;");
	} else {
		$results = $database->Query("SELECT classstring, label, availability, can_blueprint, min_version FROM engrams WHERE min_version IS NULL OR min_version <= $1;", array($min_version));
	}
	$delete_results = null;
} else {
	if ($min_version === null) {
		$results = $database->Query("SELECT classstring, label, availability, can_blueprint, min_version FROM engrams WHERE last_update > $1 AND min_version IS NULL;", array($since));
	} else {
		$results = $database->Query("SELECT classstring, label, availability, can_blueprint, min_version FROM engrams WHERE last_update > $1 AND (min_version IS NULL OR min_version <= $2);", array($since, $min_version));
	}
	$delete_results = $database->Query("SELECT classstring FROM deletions WHERE \"table\" = 'engrams' AND time > $1;", array($since));
}
$engrams = array();
while (!$results->EOF()) {
	$engrams[] = array(
		'class' => $results->Field('classstring'),
		'label' => $results->Field('label'),
		'availability' => intval($results->Field('availability')),
		'blueprint' => ($results->Field('can_blueprint') == 't') ? 1 : 0,
		'version' => intval($results->Field('min_version'))
	);
	$results->MoveNext();
}
$engrams_deleted = array();
if ($delete_results !== null) {
	while (!$delete_results->EOF()) {
		$engrams_deleted[] = $delete_results->Field('classstring');
		$delete_results->MoveNext();
	}
} 
$values['engrams'] = array(
	'additions' => $engrams,
	'removals' => $engrams_deleted
);

# Presets

if ($since === null) {
	$results = $database->Query("SELECT classstring, label, contents FROM presets;");
	$delete_results = null;
} else {
	$results = $database->Query("SELECT classstring, label, contents FROM presets WHERE last_update > $1;", array($since));
	$delete_results = $database->Query("SELECT classstring FROM deletions WHERE \"table\" = 'presets' AND time > $1;", array($since));
}
$presets = array();
while (!$results->EOF()) {
	$presets[] = array(
		'id' => $results->Field('classstring'),
		'label' => $results->Field('label'),
		'contents' => $results->Field('contents')
	);
	$results->MoveNext();
}
$presets_deleted = array();
if ($delete_results !== null) {
	while (!$delete_results->EOF()) {
		$presets_deleted[] = $delete_results->Field('classstring');
		$delete_results->MoveNext();
	}
} 
$values['presets'] = array(
	'additions' => $presets,
	'removals' => $presets_deleted
);

if ($min_version === null) {
	$results = $database->Query("SELECT MAX(last_update) FROM updatable_objects WHERE min_version IS NULL");
} else {
	$results = $database->Query("SELECT MAX(last_update) FROM updatable_objects WHERE min_version IS NULL OR min_version <= $1", array($min_version));
}
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));

$values['timestamp'] = $last_database_update->format('Y-m-d H:i:s');
$values['beacon_version'] = 1;
$values['is_full'] = ($since === null) ? 1 : 0;
if ($min_version === null) {
	$values['min_version'] = 0;
} else {
	$values['min_version'] = $min_version;
}

$body = json_encode($values);
$hash = md5($body);

header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="BeaconData' . $last_database_update->format('YmdHis') . '.json"');
header('Content-MD5: ' . $hash);
echo $body;

?>