<?php

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::RequireParams('version');

if (BeaconAPI::Method() !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$database = BeaconCommon::Database();
$version = intval($_GET['version']);
if (isset($_GET['since'])) {
	try {
		$since = new DateTime($_GET['since']);
	} catch (Exception $err) {
		BeaconAPI::ReplyError('Unable to parse timestamp', $err->getMessage(), 400);
	}
	$results = $database->Query('SELECT path, size FROM update_deltas WHERE version = $1 AND created > $2 ORDER BY created ASC;', $version, $since->format('Y-m-d H:i:sO'));
	$paths = [];
	$total = 0;
	while (!$results->EOF()) {
		$paths[] = [
			'url' => 'https://updates.beaconapp.cc' . $results->Field('path'),
			'size' => $results->Field('size')
		];
		$total += $results->Field('size');
		$results->MoveNext();
	}
} else {
	$results = $database->Query('SELECT EXTRACT(epoch FROM MAX(created)) AS newest FROM update_deltas WHERE version = $1;', $version);
	$query = '';
	$prefix = '';
	if (BeaconCommon::InProduction() == false) {
		$prefix = '/' . BeaconCommon::EnvironmentName();
	}
	if (is_null($results->Field('newest')) == false) {
		$query = '?t=' . $results->Field('newest');
	}
	$paths = [['url' => 'https://updates.beaconapp.cc/v' . $version . $prefix . '/Complete.beacondata' . $query, 'size' => -1]];
	$total = -1;
}

BeaconAPI::ReplySuccess(['files' => $paths, 'total_size' => $total]);

?>