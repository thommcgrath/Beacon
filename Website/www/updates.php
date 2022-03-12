<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Cache-Control: no-cache');

$stage = 3;
if (isset($_GET['stage'])) {
	$stage = intval($_GET['stage']);
}

$current_build = 0;
if (isset($_GET['build'])) {
	$current_build = intval($_GET['build']);
}

$html_mode = false;
if (isset($_GET['html'])) {
	$html_mode = true;
	header('Content-Type: text/html');
} else {
	header('Content-Type: application/json');
}

// Beacon 1.2.0 and its betas did not report architecture correctly
$device_mask = BeaconUpdates::ARCH_INTEL32;
if ($current_build >= 10201300 && isset($_GET['arch'])) {
	switch ($_GET['arch']) {
	case 'x86':
		$device_mask = BeaconUpdates::ARCH_INTEL32;
		break;
	case 'x86_64':
	case 'x64':
		$device_mask = BeaconUpdates::ARCH_INTEL64;
		break;
	case 'arm':
		$device_mask = BeaconUpdates::ARCH_ARM32;
		break;
	case 'arm64':
	case 'arm_64':
		$device_mask = BeaconUpdates::ARCH_ARM64;
		break;
	}
}

$updates = BeaconUpdates::FindUpdates($current_build, $device_mask, $stage);
	
$include_notices = $current_build > 33;
$database = BeaconCommon::Database();
if ($include_notices) {
	$database = BeaconCommon::Database();
	$notices = [];
	if ($html_mode === false) {
		$results = $database->Query('SELECT message, secondary_message, action_url FROM client_notices WHERE (min_version IS NULL OR min_version <= $1) AND (max_version IS NULL OR max_version >= $1) AND last_update > CURRENT_TIMESTAMP - \'3 weeks\'::INTERVAL ORDER BY last_update DESC LIMIT 5;', $current_build);
		while (!$results->EOF()) {
			$notices[] = [
				'message' => $results->Field('message'),
				'secondary_message' => $results->Field('secondary_message'),
				'action_url' => $results->Field('action_url')
			];
			$results->MoveNext();
		}
	}
}

if (count($updates) === 0) {
	if ($html_mode) {
		echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Beacon Update</title></head><body><h1>No update</h1></body></html>';
	} elseif ($include_notices) {
		$values = [
			'notices' => $notices
		];
		echo json_encode($values, JSON_PRETTY_PRINT);
	} else {
		echo '{}';
	}
	exit;
}

$update = $updates[0];
$values = [
	'build' => $update['build_number'],
	'version' => $update['build_display'],
	'preview' => ($current_build < 10500000) ? 'Beacon\'s biggest update ever is here!' : $update['preview'],
	'required' => (is_null($update['required_if_below']) === false && $current_build <= $update['required_if_below'] ? true : false),
	'build_date' => date('Y-m-d H:i:sO', $update['publish_time']),
];

if ($include_notices) {
	$values['notices'] = $notices;
}

foreach ($update['files'] as $platform => $files) {
	$key = '';
	switch ($platform) {
	case BeaconUpdates::PLATFORM_MACOS:
		$key = 'mac';
		break;
	case BeaconUpdates::PLATFORM_WINDOWS:
		$key = 'win';
		break;
	default:
		continue;
	}
	
	foreach ($files as $url => $signatures) {
		if (array_key_exists(BeaconUpdates::SIGNATURE_RSA, $signatures) === false) {
			continue;
		}
		
		$values[$key] = [
			'url' => BeaconCommon::SignDownloadURL($url),
			'signature' => $signatures[BeaconUpdates::SIGNATURE_RSA]
		];
		break;
	}
}

$markdown = '';
foreach ($updates as $update) {
	if ($markdown === '') {
		$markdown = "# Beacon " . $update['build_display'] . " is now available\n\n" . $update['notes'];
	} else {
		$markdown .= "\n\n## Changes in " . $update['build_display'] . "\n\n" . $update['notes'];
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
	$notes_path = '/history';
	if ($updates[0]['stage'] < 3) {
		// It may seem odd, but preview releases should show notes for both alphas and betas.
		$notes_path .= '?stage=1';
	}
	$notes_path .= '#build' . $updates[0]['build_number'];
	$values['notes'] = $html;
	$values['notes_url'] = BeaconCommon::AbsoluteURL($notes_path);
	echo json_encode($values, JSON_PRETTY_PRINT);
}

?>
