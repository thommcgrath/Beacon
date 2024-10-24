<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$script = Script::Fetch($context['pathParameters']['scriptId']);
	if (is_null($script) || $script->UserHasPermission($userId, PermissionBits::ScriptRead) === false) {
		return Response::NewJsonError('Script not found', null, 404);
	}
	return Response::NewJson($script, 200);
}

?>
