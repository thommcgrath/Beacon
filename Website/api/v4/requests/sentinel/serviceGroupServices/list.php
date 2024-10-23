<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ServiceGroup, ServiceGroupService};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$filters = $_GET;
	if (isset($filters['serviceGroupId'])) {
		$serviceGroupId = $filters['serviceGroupId'];
		$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
		if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, PermissionBits::ServiceGroupRead) === false) {
			return Response::NewJsonError('Service group not found', null, 404);
		}
	}
	return Response::NewJson(ServiceGroupService::Search($filters), 200);
}

?>
