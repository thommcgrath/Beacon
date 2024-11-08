<?php

use BeaconAPI\v4\{Application, Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeAppsCreate;
}

function handleRequest(array $context): Response {
	if (Core::IsJsonContentType() === false) {
		return Response::NewJsonError('Send a JSON body', null, 400);
	}

	$obj = Core::BodyAsJson();
	$obj['userId'] = Core::UserId();
	try {
		$app = Application::Create($obj);
		return Response::NewJson($app, 201);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
