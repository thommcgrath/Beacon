<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupMember};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupMemberIds = [];
	if (isset($context['pathParameters']['serviceGroupMemberId'])) {
		$serviceGroupMemberIds = explode(',', $context['pathParameters']['serviceGroupMemberId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$serviceGroupMemberIds[] = $body['serviceGroupMemberId'];
		} else {
			foreach ($body as $memberObj) {
				$serviceGroupMemberIds[] = $memberObj['serviceGroupMemberId'];
			}
		}
	}

	if (count($serviceGroupMemberIds) <= 0) {
		return Response::NewJsonError('No service group members were specified to be deleted.', $serviceGroupMemberIds, 400);
	}
	foreach ($serviceGroupMemberIds as $serviceGroupMemberId) {
		if (BeaconCommon::IsUUID($serviceGroupMemberId) === false) {
			return Response::NewJsonError('Service group member ids should be UUIDs', $serviceGroupMemberIds, 400);
		}
	}

	$serviceGroupCache = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupMemberIds as $serviceGroupMemberId) {
		$serviceGroupMember = ServiceGroupMember::Fetch($serviceGroupMemberId);
		if (is_null($serviceGroupMember)) {
			$database->Rollback();
			return Response::NewJsonError('Service group member not found.', $serviceGroupMemberId, 404);
		}

		$serviceGroupId = $serviceGroupMember->ServiceGroupId();
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
				$database->Rollback();
				return Response::NewJsonError('Service group member not found.', $serviceGroupMemberId, 404);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}

		try {
			$serviceGroupMember->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting service group member.", ['error' => $err, 'serviceGroupMemberId' => $serviceGroupMemberId], 500);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested service group members..', ['error' => $err, 'serviceGroupMemberIds' => $serviceGroupMemberIds], 500);
	}
}

?>
