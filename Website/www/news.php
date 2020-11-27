<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$stage = 3;
if (isset($_GET['stage'])) {
	$stage = intval($_GET['stage']);
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT * FROM news WHERE stage >= $1 ORDER BY moment DESC LIMIT 20;', $stage);
$news = [];
while (!$results->EOF()) {
	$url = $results->Field('url');
	if (is_string($url) && substr($url, 0, 1) === '/') {
		$url = BeaconCommon::AbsoluteURL($url);
	}
	
	$news[] = [
		'uuid' => $results->Field('uuid'),
		'title' => $results->Field('title'),
		'detail' => $results->Field('detail'),
		'url' => $url,
		'min_version' => $results->Field('min_version'),
		'max_version' => $results->Field('max_version'),
		'timestamp' => $results->Field('moment'),
		'mac_min_os' => $results->Field('mac_os_version'),
		'win_min_os' => $results->Field('win_os_version')
	];
	$results->MoveNext();
}

header('Content-Type: application/json');
echo json_encode($news, JSON_PRETTY_PRINT);

?>