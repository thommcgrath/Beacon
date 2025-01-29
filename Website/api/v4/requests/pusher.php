<?php

use BeaconAPI\v4\{Core, Response};

function handleRequest(array $context): Response {
	$user = Core::User();
	$enabled = $user->IsAnonymous() === false;
	if ($enabled) {
		if (BeaconCommon::IsBeacon()) {
			$beaconVersion = BeaconCommon::BeaconVersion();
			if ($beaconVersion < 20301306) {
				$enabled = false;
			}
		} else {
			$enabled = false;
		}
	}
	$response = [
		'enabled' => $enabled,
	];
	if ($enabled) {
		$response['cluster'] = BeaconCommon::GetGlobal('Pusher Cluster');
		$response['key'] = BeaconCommon::GetGlobal('Pusher Key');
		$response['restartWaitPeriod'] = 60000;
	}

	return Response::NewJson($response, 200);
}

?>
