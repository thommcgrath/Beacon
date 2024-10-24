<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$script = Script::Fetch($context['pathParameters']['scriptId']);
	if (is_null($script) || $script->UserHasPermission($userId, PermissionBits::ScriptUpdate) === false) {
		return Response::NewJsonError('Script not found', null, 404);
	}
	$properties = Core::BodyAsJson();
	try {
		$script->Edit($properties);
		return Response::NewJson($script, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit script: ' . $err->getMessage(), $properties, 400);
	}
}

?>
