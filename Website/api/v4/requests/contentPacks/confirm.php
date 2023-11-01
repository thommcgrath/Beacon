<?php

use BeaconAPI\v4\{Core, ContentPack, Response};

function handleRequest(array $context): Response {
	$contentPackId = $context['pathParameters']['contentPackId'];
	if (BeaconCommon::IsUUID($contentPackId) === false) {
		return Response::NewJsonError('The contentPackId parameter should be a UUID.', null, 400);
	}

	$pack = ContentPack::Fetch($contentPackId);
	if (is_null($pack)) {
		return Response::NewJsonError('Content pack not found.', null, 404);
	}

	$confirmed = $pack->AttemptConfirmation();
	if ($confirmed) {
		return Response::NewJson($pack, 200);
	} else {
		return Response::NewJson($pack, 400);
	}
}

?>
