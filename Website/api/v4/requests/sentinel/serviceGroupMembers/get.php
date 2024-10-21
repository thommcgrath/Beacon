<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupMember};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupMember = ServiceGroupMember::Fetch($context['pathParameters']['serviceGroupMemberId']);
	if (is_null($serviceGroupMember)) {
		return Response::NewJsonError('Group member not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupMember->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionView) === false) {
		return Response::NewJsonError('Group member not found', null, 404);
	}
	return Response::NewJson($serviceGroupMember, 200);
}

?>
