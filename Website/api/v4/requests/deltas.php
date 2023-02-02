<?php

function handleRequest(array $context): APIResponse {
	if (isset($context['pathParameters']['version'])) {
		$version = intval($context['pathParameters']['version']);
	} else if (isset($_GET['version'])) {
		$version = intval($_GET['version']);
	} else {
		BeaconAPI::ReplyError('Missing version parameter', null, 400);
	}
	
	$database = BeaconCommon::Database();
	$paths = [];
	$total = 0;
	if (isset($_GET['since'])) {
		try {
			if (is_numeric($_GET['since'])) {
				$since = new DateTime();
				$since->setTimestamp($_GET['since']);
			} else {
				$since = new DateTime($_GET['since']);
			}
		} catch (Exception $err) {
			BeaconAPI::ReplyError('Unable to parse timestamp', $err->getMessage(), 400);
		}
		$results = $database->Query('SELECT path, size FROM update_files WHERE type = \'Delta\' AND version = $1 AND created > $2 ORDER BY created ASC;', $version, $since->format('Y-m-d H:i:sO'));
		while (!$results->EOF()) {
			$paths[] = [
				'url' => 'https://updates.usebeacon.app' . $results->Field('path'),
				'size' => $results->Field('size')
			];
			$total += $results->Field('size');
			$results->MoveNext();
		}
	} else {
		$results = $database->Query('SELECT path, size FROM update_files WHERE version = $1 AND type = \'Complete\';', $version);
		if ($results->RecordCount() > 0) {
			$size = $results->Field('size');
			$paths = [['url' => 'https://updates.usebeacon.app' . $results->Field('path'), 'size' => $size]];
			$total = $size;
		}
	}
	
	BeaconAPI::ReplySuccess(['files' => $paths, 'total_size' => $total]);
}

?>