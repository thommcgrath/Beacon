<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PlayerNote};

$requiredScopes[] = Application::kScopeSentinelPlayersRead;

function handleRequest(array $context): Response {
	$playerNoteId = $context['pathParameters']['playerNoteId'];
	$playerNote = PlayerNote::Fetch($playerNoteId);
	if (is_null($playerNote)) {
		return Response::NewJsonError('Player note not found', null, 404);
	}
	return Response::NewJson($playerNote, 200);
}

?>
