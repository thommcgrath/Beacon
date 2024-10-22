<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PlayerNote};

$requiredScopes[] = Application::kScopeSentinelPlayersRead;

function handleRequest(array $context): Response {
	$filters = $_GET;
	$playerNotes = PlayerNote::Search($filters);
	return Response::NewJson($playerNotes, 200);
}

?>
