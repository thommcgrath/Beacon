<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ScriptUser};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$scriptUser = ScriptUser::Fetch($context['pathParameters']['scriptUserId']);
	if (is_null($scriptUser)) {
		return Response::NewJsonError('Script user not found', $script, 404);
	} elseif ($scriptUser->UserHasPermission($userId, PermissionBits::ScriptSharing) === false) {
		return Response::NewJsonError('You do not have permission to edit the users of this script', $scriptUser, 403);
	} elseif ($scriptUser->UserId() === $userId) {
		return Response::NewJsonError('You cannot edit your own permissions', $scriptUser, 403);
	}

	$properties = Core::BodyAsJson();
	if (isset($properties['permissions'])) {
		$desiredPermissions = $properties['permissions'];
		$allowedPermissions = $scriptUser->GetUserPermissions($userId);
		if (($desiredPermissions & $allowedPermissions) !== $desiredPermissions) {
			return Response::NewJsonError('You cannot give a user more permissions than you have.', $properties, 403);
		}
	}

	try {
		$scriptUser->Edit($properties);
		return Response::NewJson($scriptUser, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit script user: ' . $err->getMessage(), $properties, 400);
	}
}

?>
