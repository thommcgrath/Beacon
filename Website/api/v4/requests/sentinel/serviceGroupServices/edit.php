<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ServiceGroup, ServiceGroupService};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupService = ServiceGroupService::Fetch($context['pathParameters']['serviceGroupServiceId']);
	if (is_null($serviceGroupService)) {
		return Response::NewJsonError('Group service not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupService->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, PermissionBits::ServiceGroupUpdateContents) === false) {
		return Response::NewJsonError('Group service not found', null, 404);
	}
	$properties = Core::BodyAsJSON();
	try {
		$serviceGroupService->Edit($properties);
		return Response::NewJson($serviceGroupService, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit service group service: ' . $err->getMessage(), $properties, 400);
	}
}

?>
