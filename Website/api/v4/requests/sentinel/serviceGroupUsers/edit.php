<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupUser};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupUser = ServiceGroupUser::Fetch($context['pathParameters']['serviceGroupUserId']);
	if (is_null($serviceGroupUser)) {
		return Response::NewJsonError('Group user not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupUser->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
		return Response::NewJsonError('Group user not found', null, 404);
	}
	$properties = Core::BodyAsJson();
	try {
		$serviceGroupUser->Edit($properties);
		return Response::NewJson($serviceGroupUser, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit service group user: ' . $err->getMessage(), $properties, 400);
	}
}

?>
