<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PlayerNote};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelPlayersUpdate;
}

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$playerNoteId = $context['pathParameters']['playerNoteId'];
	$playerNote = PlayerNote::Fetch($playerNoteId);
	if (is_null($playerNote)) {
		return Response::NewJsonError('Player note not found', null, 404);
	}
	if ($playerNote->UserId() !== $userId) {
		return Response::NewJsonError('Player notes can only be edited by their author', null, 400);
	}

	$properties = Core::BodyAsJson();
	try {
		$playerNote->Edit($properties);
		return Response::NewJson($playerNote, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit player note: ' . $err->getMessage(), $properties, 400);
	}
}

?>
