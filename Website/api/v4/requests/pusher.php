<?php

use BeaconAPI\v4\{Core, Response};

function handleRequest(array $context): Response {
	$user = Core::User();
	$enabled = $user->IsAnonymous() === false;
	$response = [
		'enabled' => $enabled,
	];
	if ($enabled) {
		$response['cluster'] = BeaconCommon::GetGlobal('Pusher Cluster');
		$response['key'] = BeaconCommon::GetGlobal('Pusher Key');
	}
	
	return Response::NewJson($response, 200);
}

?>
