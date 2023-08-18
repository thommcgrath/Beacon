<?php

use BeaconAPI\v4\{Core, Response};

function handleRequest(array $context): Response {
	return Response::NewJson([
		'cluster' => BeaconCommon::GetGlobal('Pusher Cluster'),
		'key' => BeaconCommon::GetGlobal('Pusher Key'),
	], 200);
}

?>
