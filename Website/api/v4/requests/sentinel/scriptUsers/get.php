<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ScriptUser};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$scriptUser = ScriptUser::Fetch($context['pathParameters']['scriptUserId']);
	if (is_null($scriptUser) || ($scriptUser->UserHasPermission($userId, PermissionBits::ScriptSharing) === false && $scriptUser->UserId() !== $userId)) {
		return Response::NewJsonError('Script user not found', null, 404);
	}
	return Response::NewJson($scriptUser, 200);
}

?>
