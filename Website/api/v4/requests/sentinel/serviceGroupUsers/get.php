<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupUser};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupUser = ServiceGroupUser::Fetch($context['pathParameters']['serviceGroupUserId']);
	if (is_null($serviceGroupUser)) {
		return Response::NewJsonError('Group user not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupUser->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionView) === false) {
		return Response::NewJsonError('Group user not found', null, 404);
	}
	return Response::NewJson($serviceGroupUser, 200);
}

?>
