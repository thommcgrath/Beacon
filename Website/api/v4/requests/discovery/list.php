<?php

use BeaconAPI\v4\{Core, ModDiscoveryResult, Response};

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['deleted'] = false;
	$results = ModDiscoveryResult::Search($filters);
	return Response::NewJson($results, 200);
}

?>