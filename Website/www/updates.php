<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Cache-Control: no-cache');

$stage = 3;
$current_build = 0;
$arch_priority = array('combo', '64', '32');
if (isset($_GET['build'])) {
	$current_build = intval($_GET['build']);
}
if (isset($_GET['stage'])) {
	$stage = intval($_GET['stage']);
}
if (isset($_GET['html'])) {
	$html_mode = true;
	header('Content-Type: text/html');
} else {
	$html_mode = false;
	header('Content-Type: application/json');
}
if (isset($_GET['arch'])) {
	switch ($_GET['arch']) {
	case 'x86_64':
		$arch_priority = array('64', 'combo');
		break;
	case 'x86':
		$arch_priority = array('32', 'combo');
		break;
	}
}
if (isset($_GET['platform']) && isset($_GET['osversion']) && preg_match('/^\d{1,3}\.\d{1,3}\.\d{1,6}$/', $_GET['osversion']) === 1) {
	switch ($_GET['platform']) {
	case 'mac':
		$version_column = 'min_mac_version';
		$os_version = $_GET['osversion'];
		break;
	case 'win':
		$version_column = 'min_win_version';
		$os_version = $_GET['osversion'];
		break;
	}
}

$include_notices = $current_build > 33;

$database = BeaconCommon::Database();
if ($include_notices) {
	$notices = array();
	if ($html_mode === false) {
		$results = $database->Query('SELECT message, secondary_message, action_url FROM client_notices WHERE (min_version IS NULL OR min_version <= $1) AND (max_version IS NULL OR max_version >= $1) AND last_update > CURRENT_TIMESTAMP - \'3 weeks\'::INTERVAL ORDER BY last_update DESC LIMIT 5;', $current_build);
		while (!$results->EOF()) {
			$notices[] = array(
				'message' => $results->Field('message'),
				'secondary_message' => $results->Field('secondary_message'),
				'action_url' => $results->Field('action_url')
			);
			$results->MoveNext();
		}
	}
}

if (isset($version_column) && isset($os_version)) {
	$results = $database->Query('SELECT * FROM updates WHERE build_number > $1 AND stage >= $2 AND os_version_as_integer(' . $version_column . ') <= os_version_as_integer($3) ORDER BY build_number DESC;', $current_build, $stage, $os_version);
} else {
	$results = $database->Query('SELECT * FROM updates WHERE build_number > $1 AND stage >= $2 ORDER BY build_number DESC;', $current_build, $stage);
}
if ($results->RecordCount() == 0) {
	if ($html_mode) {
		echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Beacon Update</title></head><body><h1>No update</h1></body></html>';
	} elseif ($include_notices) {
		$values = array(
			'notices' => $notices
		);
		echo json_encode($values, JSON_PRETTY_PRINT);
	} else {
		echo '{}';
	}
	exit;
}

$values = array(
	'build' => intval($results->Field('build_number')),
	'version' => $results->Field('build_display'),
	'preview' => $results->Field('preview'),
	'mac' => array(
		'url' => $results->Field('mac_url'),
		'signature' => $results->Field('mac_signature')
	)
);

foreach ($arch_priority as $part) {
	if (is_null($results->Field('win_' . $part . '_url')) === false) {
		$values['win'] = array(
			'url' => $results->Field('win_' . $part . '_url'),
			'signature' => $results->Field('win_' . $part . '_signature')
		);
		break;
	}
}

if ($include_notices) {
	$values['notices'] = $notices;
}

$markdown = '';
while (!$results->EOF()) {
	if ($markdown === '') {
		$markdown = "# Beacon " . $results->Field('build_display') . " is now available\n\n" . $results->Field('notes');
	} else {
		$markdown .= "\n\n## Changes in " . $results->Field('build_display') . "\n\n" . $results->Field('notes');
	}
	$results->MoveNext();
}

$parser = new Parsedown();
$body = $parser->text($markdown);

$css_url = BeaconCommon::AbsoluteURL(BeaconCommon::AssetURI('default.scss'));
$html = <<<HTML
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Beacon Update</title>
		<link href="$css_url" rel="stylesheet" type="text/css">
		<style type="text/css">
		body {margin: 20px;}
		</style>
	</head>
	<body>
$body
	</body>
</html>
HTML;

if ($html_mode) {
	echo $html;
} else {
	$values['notes'] = $html;
	echo json_encode($values, JSON_PRETTY_PRINT);
}

?>
