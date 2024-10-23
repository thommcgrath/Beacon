<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$group = ServiceGroup::Fetch($context['pathParameters']['serviceGroupId']);
	if (is_null($group) || $group->HasPermission($userId, PermissionBits::ServiceGroupRead) === false) {
		return Response::NewJsonError('Service group not found', null, 404);
	}
	return Response::NewJson($group, 200);
}

?>
