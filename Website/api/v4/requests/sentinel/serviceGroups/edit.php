<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$group = ServiceGroup::Fetch($context['pathParameters']['serviceGroupId']);
	if (is_null($group) || $group->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
		return Response::NewJsonError('Service group not found', null, 404);
	}
	$groupProperties = Core::BodyAsJson();
	try {
		$group->Edit($groupProperties);
		return Response::NewJson($group, 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not edit service group: ' . $err->getMessage(), $groupProperties, 400);
	}
}

?>
