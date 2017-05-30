<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$since = null;
if (array_key_exists('changes_since', $_GET)) {
	$since = New DateTime($_GET['changes_since']);
	$since = $since->format('Y-m-d H:i:sO');
}

$database = ConnectionManager::BeaconDatabase();
$results = $database->Query("SELECT * FROM updates ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() == 0) {
	echo '{}';
	exit;
}

$values = array(
	'build' => intval($results->Field('build_number')),
	'version' => $results->Field('build_display'),
	'notes' => $results->Field('notes'),
	'mac' => array(
		'url' => $results->Field('mac_url'),
		'signature' => $results->Field('mac_signature')
	),
	'win' => array(
		'url' => $results->Field('win_url'),
		'signature' => $results->Field('win_signature')
	)
);

header('Content-Type: text/plain');
echo json_encode($values);

?>