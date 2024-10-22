<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PlayerNote};

$requiredScopes[] = Application::kScopeSentinelPlayersUpdate;

function handleRequest(array $context): Response {
	$noteProperties = Core::BodyAsJson();
	$noteProperties['userId'] = Core::UserId();
	try {
		$note = PlayerNote::Create($noteProperties);
		return Response::NewJson($note, 201);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not create player note: ' . $err->getMessage(), $noteProperties, 400);
	}
}

?>
