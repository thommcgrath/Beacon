<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupUser};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$filters = $_GET;
	if (isset($filters['serviceGroupId'])) {
		$serviceGroupId = $filters['serviceGroupId'];
		$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
		if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionView) === false) {
			return Response::NewJsonError('Service group not found', null, 404);
		}
	} else {
		$filters['userId'] = $userId;
		$filters['permissions'] = ServiceGroup::PermissionView;
	}
	return Response::NewJson(ServiceGroupUser::Search($filters), 200);
}

?>
