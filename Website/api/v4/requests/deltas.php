<?php

use BeaconAPI\v4\{APIResponse, Core};

Core::Authorize('common');

function handleRequest(array $context): APIResponse {
	$version = false;
	if (isset($context['pathParameters']['version'])) {
		$version = filter_var($context['pathParameters']['version'], FILTER_VALIDATE_INT);
	} else if (isset($_GET['version'])) {
		$version = filter_var($_GET['version'], FILTER_VALIDATE_INT);
	}
	if ($version === false) {
		return APIResponse::NewJsonError('Missing version parameter', null, 400);
	} else if ($version < 7) {
		return APIResponse::NewJsonError('Use the v3 API for deltas below version 7', null, 400);
	}
	
	$database = BeaconCommon::Database();
	$paths = [];
	$total = 0;
	$since = new DateTime('2000-01-01 00:00:00');
	if (isset($_GET['since'])) {
		try {
			if (is_numeric($_GET['since'])) {
				$since = new DateTime();
				$since->setTimestamp($_GET['since']);
			} else {
				$since = new DateTime($_GET['since']);
			}
		} catch (Exception $err) {
			return APIResponse::NewJsonError('Unable to parse timestamp', $err->getMessage(), 400);
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
	
	return APIResponse::NewJson(['since' => $since->format('Y-m-d H:i:sO'), 'files' => $paths, 'total_size' => $total], 200);
}

?>