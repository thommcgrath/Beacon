<?php

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::RequireParams('version', 'since');

if (BeaconAPI::Method() !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$version = intval($_GET['version']);
try {
	$since = new DateTime($_GET['since']);
} catch (Exception $err) {
	BeaconAPI::ReplyError('Unable to parse timestamp', $err->getMessage(), 400);
}
$database = BeaconCommon::Database();
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

BeaconAPI::ReplySuccess(['files' => $paths, 'total_size' => $total]);

?>