<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupService};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupService = ServiceGroupService::Fetch($context['pathParameters']['serviceGroupServiceId']);
	if (is_null($serviceGroupService)) {
		return Response::NewJsonError('Group member not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupService->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionView) === false) {
		return Response::NewJsonError('Group member not found', null, 404);
	}
	return Response::NewJson($serviceGroupService, 200);
}

?>
