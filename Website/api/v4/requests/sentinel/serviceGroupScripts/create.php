<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script, ServiceGroup, ServiceGroupScript};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service group script objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$requests = [$obj];
		$multiResponse = false;
	} else {
		$requests = $obj;
		$multiResponse = true;
	}

	$scriptCache = [];
	$serviceGroupCache = [];
	$permissionsCache = [];
	$serviceGroupScripts = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($requests as $request) {
		if (isset($request['scriptId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Service group script object must include a script id.', $request, 400);
		}
		if (isset($request['serviceGroupId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Service group script object must include a service group id.', $request, 400);
		}
		if (isset($request['permissions']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Service group script object must include a permissions value.', $request, 400);
		}
		$serviceGroupId = $request['serviceGroupId'];
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroupCache[$serviceGroupId] = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroupCache[$serviceGroupId]) || $serviceGroupCache[$serviceGroupId]->UserHasPermission($userId, PermissionBits::ServiceGroupUpdateContents) === false) {
				$database->Rollback();
				return Response::NewJsonError('You are not authorized to scripts to this service group.', $request, 403);
			}
		}
		$scriptId = $request['scriptId'];
		if (isset($scriptCache[$scriptId]) === false) {
			$scriptCache[$scriptId] = Script::Fetch($scriptId);
			if (is_null($scriptCache[$scriptId]) || $scriptCache[$scriptId]->UserHasPermission($userId, PermissionBits::ScriptSharing) === false) {
				$database->Rollback();
				return Response::NewJsonError('You are not authorized to add this script to service groups.', $request, 403);
			}
		}
		$desiredPermissions = intval($request['permissions']);
		if (isset($permissionsCache[$scriptId]) === false) {
			$permissionscache[$scriptId] = $scriptCache[$scriptId]->GetUserPermissions($userId);
		}
		$allowedPermissions = $permissionscache[$scriptId] & ~PermissionBits::ScriptSharing;
		if (($desiredPermissions & $allowedPermissions) !== $desiredPermissions) {
			$database->Rollback();
			return Response::NewJsonError('You cannot add this script to the service group with more permissions than you have.', $request, 403);
		}

		try {
			$serviceGroupScripts[] = ServiceGroupScript::Create($request);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create service group script: ' . $err->getMessage(), $request, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($serviceGroupScripts, 201);
	} else {
		return Response::NewJson($serviceGroupScripts[0], 201);
	}
}

?>
