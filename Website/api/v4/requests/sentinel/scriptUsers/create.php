<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script, ScriptUser};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No script user objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$requests = [$obj];
		$multiResponse = false;
	} else {
		$requests = $obj;
		$multiResponse = true;
	}

	$scriptCache = [];
	$permissionsCache = [];
	$scriptUsers = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($requests as $request) {
		if (isset($request['scriptId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Script user object must include a script id.', $request, 400);
		}
		if (isset($request['userId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Script user object must include a user id.', $request, 400);
		}
		if (isset($request['permissions']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Script user object must include a permissions value.', $request, 400);
		}
		$scriptId = $request['scriptId'];
		if (isset($scriptCache[$scriptId]) === false) {
			$scriptCache[$scriptId] = Script::Fetch($scriptId);
			if (is_null($scriptCache[$scriptId]) || $scriptCache[$scriptId]->UserHasPermission($userId, PermissionBits::ScriptSharing) === false) {
				$database->Rollback();
				return Response::NewJsonError('You are not authorized to add users to this script.', $request, 403);
			}
		}
		if (strtolower($request['userId']) === strtolower($scriptCache[$scriptId]->UserId())) {
			$database->Rollback();
			return Response::NewJsonError('The script owner should not be added as a user.', $request, 400);
		}
		$desiredPermissions = intval($request['permissions']);
		if (isset($permissionsCache[$scriptId]) === false) {
			$permissionscache[$scriptId] = $scriptCache[$scriptId]->GetUserPermissions($userId);
		}
		$allowedPermissions = $permissionscache[$scriptId];
		if (($desiredPermissions & $allowedPermissions) !== $desiredPermissions) {
			$database->Rollback();
			return Response::NewJsonError('You cannot add a user to a script with more permissions than you have.', $request, 403);
		}

		try {
			$scriptUsers[] = ScriptUser::Create($request);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create script user: ' . $err->getMessage(), $request, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($scriptUsers, 201);
	} else {
		return Response::NewJson($scriptUsers[0], 201);
	}
}

?>
