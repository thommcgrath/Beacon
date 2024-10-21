<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupUser};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupCache = [];

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service group user objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$serviceGroupUserRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceGroupUserRequests = $obj;
		$multiResponse = true;
	}

	$newUsers = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupUserRequests as $serviceGroupUserRequest) {
		if (isset($serviceGroupUserRequest['serviceGroupId']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Must specify a service group id.', $serviceGroupUserRequest, 400);
		}

		$serviceGroupId = $serviceGroupUserRequest['serviceGroupId'];
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
				return Response::NewJsonError('Service group not found', $serviceGroupId, 400);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}
		$serviceGroup = $serviceGroupCache[$serviceGroupId];

		if (isset($serviceGroupUserRequest['userId']) && strtolower($serviceGroupUserRequest['userId']) === strtolower($serviceGroup->UserId())) {
			$database->Rollback();
			return Response::NewJsonError('A service group cannot have the group owner as a member.', $serviceGroupUserRequest, 400);
		}

		try {
			$newUsers[] = ServiceGroupUser::Create($serviceGroupUserRequest);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create service group user: ' . $err->getMessage(), $serviceGroupUserRequest, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($newUsers, 201);
	} else {
		return Response::NewJson($newUsers[0], 201);
	}
}

?>
