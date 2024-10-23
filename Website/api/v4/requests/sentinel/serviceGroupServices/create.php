<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupService};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupCache = [];

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service group member objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$serviceGroupServiceRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceGroupServiceRequests = $obj;
		$multiResponse = true;
	}

	$newMembers = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupServiceRequests as $serviceGroupServiceRequest) {
		if (isset($serviceGroupServiceRequest['serviceGroupId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Must specify a service group id.', $serviceGroupServiceRequest, 400);
		}

		$serviceGroupId = $serviceGroupServiceRequest['serviceGroupId'];
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
				return Response::NewJsonError('Service group not found', $serviceGroupId, 400);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}

		try {
			$newMembers[] = ServiceGroupService::Create($serviceGroupServiceRequest);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create service group member: ' . $err->getMessage(), $serviceGroupServiceRequest, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($newMembers, 201);
	} else {
		return Response::NewJson($newMembers[0], 201);
	}
}

?>
