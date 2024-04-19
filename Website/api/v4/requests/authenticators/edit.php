<?php

use BeaconAPI\v4\{Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$authenticatorId = $context['pathParameters']['authenticatorId'];
	$authenticator = Authenticator::Fetch($authenticatorId);
	if (is_null($authenticator) || $authenticator->UserId() !== $userId) {
		return Response::NewJsonError('Application not found', null, 404);
	}

	$obj = Core::BodyAsJson();
	try {
		$authenticator->Edit($obj);
		return Response::NewJson($authenticator, 200);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
