<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$groupId = $context['pathParameters']['serviceGroupId'];
	$group = ServiceGroup::Fetch($groupId);
	if (is_null($group) || $group->HasPermission($userId, ServiceGroup::PermissionView) === false) {
		return Response::NewJsonError('Service group not found', null, 404);
	}

	$detailedResults = isset($_GET['detailedResults']) && filter_var($_GET['detailedResults'], FILTER_VALIDATE_BOOL);
	$services = $group->LoadServices($detailedResults);
	return Response::NewJson($services, 200);
}

?>
