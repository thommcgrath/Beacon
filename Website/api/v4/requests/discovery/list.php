<?php

use BeaconAPI\v4\{Core, ContentPackDiscoveryResult, Response};

function handleRequest(array $context): Response {
	$filters = $_GET;
	$filters['deleted'] = false;
	$results = ContentPackDiscoveryResult::Search($filters);
	return Response::NewJson($results, 200);
}

?>