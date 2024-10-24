<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script, ServiceGroup, ServiceGroupScript};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupScript = ServiceGroupScript::Fetch($context['pathParameters']['serviceGroupScriptId']);
	if (is_null($serviceGroupScript)) {
		return Response::NewJsonError('Service group script not found', null, 404);
	}

	$serviceGroup = ServiceGroup::Fetch($serviceGroupScript->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->UserHasPermission($userId, PermissionBits::ServiceGroupUpdateContents) === false) {
		return Response::NewJsonError('You do not have permission to change this script in the group.', null, 403);
	}

	$properties = Core::BodyAsJson();
	if (isset($properties['permissions'])) {
		$desiredPermissions = intval($properties['permissions']);
		$script = Script::Fetch($serviceGroupScript->ScriptId());
		$allowedPermissions = $script->GetUserPermissions($userId) & ~PermissionBits::ScriptSharing;
		if (($desiredPermissions & $allowedPermissions) !== $desiredPermissions) {
			return Response::NewJsonError('You cannot give the group more permissions than you have.', $properties, 403);
		}
	}

	try {
		$serviceGroupScript->Edit($properties);
		return Response::NewJson($serviceGroupScript, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit script user: ' . $err->getMessage(), $properties, 400);
	}
}

?>
