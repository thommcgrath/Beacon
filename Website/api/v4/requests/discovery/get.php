<?php

use BeaconAPI\v4\{Core, ModDiscoveryResult, Response};

function handleRequest(array $context): ?Response {
	$contentPackId = $context['pathParameters']['contentPackId'];
	
	$result = ModDiscoveryResult::Fetch($contentPackId);
	if (is_null($result)) {
		return Response::NewJsonError('Result not found.', $contentPackId, 404);
	}
	
	if ($context['routeKey'] === 'HEAD /discovery/{contentPackId}') {
		return Response::NewJson('', 200);
	}
	
	$storagePath = $result->StoragePath();
	BeaconCloudStorage::StreamFile($storagePath);
	return null;
}

?>
