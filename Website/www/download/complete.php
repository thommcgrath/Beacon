<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$database = BeaconCommon::Database();

if (isset($_GET['version'])) {
	$version = intval($_GET['version']);
} else {
	$results = $database->Query('SELECT delta_version, build_number FROM updates WHERE stage >= 3 ORDER BY stage DESC LIMIT 1;');
	$version = $results->Field('delta_version');
	$build_number = $results->Field('build_number');
}

if ($version >= 5) {
	$results = $database->Query('SELECT path FROM update_files WHERE version = $1 AND type = \'Complete\';', $version);
	if ($results->RecordCount() == 0) {
		http_response_code(404);
		header('Content-Type: text/plain');
		echo 'Unknown delta version';
		exit;
	}
	
	$destination = 'https://updates.beaconapp.cc' . $results->Field('path');
} else {
	if (isset($build_number) == false) {
		$results = $database->Query('SELECT build_number FROM updates WHERE delta_version = $1 ORDER BY build_number DESC LIMIT 1;', $version);
		if ($results->RecordCount() == 0) {
			http_response_code(404);
			header('Content-Type: text/plain');
			echo 'Unknown delta version';
			exit;
		}
		$build_number = $results->Field('build_number');
	}
	
	$destination = BeaconCommon::AbsoluteURL('/download/classes.php?version=' . $build_number);
}

http_response_code(302);
header('Location: ' . $destination);
exit;

?>