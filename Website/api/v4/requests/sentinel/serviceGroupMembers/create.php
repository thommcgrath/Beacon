<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupMember};

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
		$serviceGroupMemberRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceGroupMemberRequests = $obj;
		$multiResponse = true;
	}

	$newMembers = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupMemberRequests as $serviceGroupMemberRequest) {
		if (isset($serviceGroupMemberRequest['serviceGroupId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Must specify a service group id.', $serviceGroupMemberRequest, 400);
		}

		$serviceGroupId = $serviceGroupMemberRequest['serviceGroupId'];
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
				return Response::NewJsonError('Service group not found', $serviceGroupId, 400);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}

		try {
			$newMembers[] = ServiceGroupMember::Create($serviceGroupMemberRequest);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create service group member: ' . $err->getMessage(), $serviceGroupMemberRequest, 400);
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
