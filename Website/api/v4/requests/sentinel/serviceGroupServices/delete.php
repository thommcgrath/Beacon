<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup, ServiceGroupService};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupServiceIds = [];
	if (isset($context['pathParameters']['serviceGroupServiceId'])) {
		$serviceGroupServiceIds = explode(',', $context['pathParameters']['serviceGroupServiceId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$serviceGroupServiceIds[] = $body['serviceGroupServiceId'];
		} else {
			foreach ($body as $memberObj) {
				$serviceGroupServiceIds[] = $memberObj['serviceGroupServiceId'];
			}
		}
	}

	if (count($serviceGroupServiceIds) <= 0) {
		return Response::NewJsonError('No service group members were specified to be deleted.', $serviceGroupServiceIds, 400);
	}
	foreach ($serviceGroupServiceIds as $serviceGroupServiceId) {
		if (BeaconCommon::IsUUID($serviceGroupServiceId) === false) {
			return Response::NewJsonError('Service group member ids should be UUIDs', $serviceGroupServiceIds, 400);
		}
	}

	$serviceGroupCache = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupServiceIds as $serviceGroupServiceId) {
		$serviceGroupService = ServiceGroupService::Fetch($serviceGroupServiceId);
		if (is_null($serviceGroupService)) {
			$database->Rollback();
			return Response::NewJsonError('Service group member not found.', $serviceGroupServiceId, 404);
		}

		$serviceGroupId = $serviceGroupService->ServiceGroupId();
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
				$database->Rollback();
				return Response::NewJsonError('Service group member not found.', $serviceGroupServiceId, 404);
			}
			$serviceGroupCache[$serviceGroupId] = $serviceGroup;
		}

		try {
			$serviceGroupService->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting service group member.", ['error' => $err, 'serviceGroupServiceId' => $serviceGroupServiceId], 500);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested service group members..', ['error' => $err, 'serviceGroupServiceIds' => $serviceGroupServiceIds], 500);
	}
}

?>
