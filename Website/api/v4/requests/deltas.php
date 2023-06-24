<?php

use BeaconAPI\v4\{Response, Core};

function handleRequest(array $context): Response {
	$version = false;
	if (isset($context['pathParameters']['version'])) {
		$version = filter_var($context['pathParameters']['version'], FILTER_VALIDATE_INT);
	} else if (isset($_GET['version'])) {
		$version = filter_var($_GET['version'], FILTER_VALIDATE_INT);
	}
	if ($version === false) {
		return Response::NewJsonError('Missing version parameter', null, 400);
	} else if ($version < 7) {
		return Response::NewJsonError('Use the v3 API for deltas below version 7', null, 400);
	}
	
	$database = BeaconCommon::Database();
	$paths = [];
	$total = 0;
	$since = new DateTime('2000-01-01 00:00:00');
	
	// Get the complete first so we can compare sizes later
	$rows = $database->Query("SELECT path, size FROM update_files WHERE version = $1 AND type = 'Complete';", $version);
	if ($rows->RecordCount() > 0) {
		$size = filter_var($rows->Field('size'), FILTER_VALIDATE_INT);
		$paths = [['url' => 'https://updates.usebeacon.app' . $rows->Field('path'), 'size' => $size]];
		$total = $size;
	}
	
	if (isset($_GET['since'])) {
		try {
			if (is_numeric($_GET['since'])) {
				$since = new DateTime();
				$since->setTimestamp($_GET['since']);
			} else {
				$since = new DateTime($_GET['since']);
			}
		} catch (Exception $err) {
			return Response::NewJsonError('Unable to parse timestamp', $err->getMessage(), 400);
		}
		
		// Get the total size of updates
		$rows = $database->Query("SELECT SUM(size) AS total_size FROM public.update_files WHERE type = 'Delta' AND version = $1 AND created > $2;", $version, $since->format('Y-m-d H:i:sO'));
		$combinedSize = filter_var($rows->Field('total_size'), FILTER_VALIDATE_INT);
		
		// Use deltas only if the combined size of delta downloads is less than the complete download
		if ($combinedSize < $total) {
			$total = 0;
			$paths = [];
			
			$rows = $database->Query("SELECT path, size FROM update_files WHERE type = 'Delta' AND version = $1 AND created > $2 ORDER BY created ASC;", $version, $since->format('Y-m-d H:i:sO'));
			while (!$rows->EOF()) {
				$size = filter_var($rows->Field('size'), FILTER_VALIDATE_INT);
				$paths[] = [
					'url' => 'https://updates.usebeacon.app' . $rows->Field('path'),
					'size' => $size
				];
				$total += $size;
				$rows->MoveNext();
			}
		}
	}
	
	return Response::NewJson(['since' => $since->format('Y-m-d H:i:sO'), 'files' => $paths, 'totalSize' => $total], 200);
}

?>