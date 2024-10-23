<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ServiceGroup, ServiceGroupUser};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupUserIds = [];
	if (isset($context['pathParameters']['serviceGroupUserId'])) {
		$serviceGroupUserIds = explode(',', $context['pathParameters']['serviceGroupUserId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$serviceGroupUserIds[] = $body['serviceGroupUserId'];
		} else {
			foreach ($body as $userObj) {
				$serviceGroupUserIds[] = $userObj['serviceGroupUserId'];
			}
		}
	}

	if (count($serviceGroupUserIds) <= 0) {
		return Response::NewJsonError('No service group users were specified to be deleted.', $serviceGroupUserIds, 400);
	}
	foreach ($serviceGroupUserIds as $serviceGroupUserId) {
		if (BeaconCommon::IsUUID($serviceGroupUserId) === false) {
			return Response::NewJsonError('Service group user ids should be UUIDs', $serviceGroupUserIds, 400);
		}
	}

	$serviceGroupCache = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupUserIds as $serviceGroupUserId) {
		$serviceGroupUser = ServiceGroupUser::Fetch($serviceGroupUserId);
		if (is_null($serviceGroupUser)) {
			$database->Rollback();
			return Response::NewJsonError('Service group user not found.', $serviceGroupUserId, 404);
		}

		$serviceGroupId = $serviceGroupUser->ServiceGroupId();
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, PermissionBits::ServiceGroupUpdateUsers) === false) {
				$database->Rollback();
				return Response::NewJsonError('Service group user not found.', $serviceGroupUserId, 404);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}

		try {
			$serviceGroupUser->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting service group user.", ['error' => $err, 'serviceGroupUserId' => $serviceGroupUserId], 500);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested service group users.', ['error' => $err, 'serviceGroupUserIds' => $serviceGroupUserIds], 500);
	}
}

?>
