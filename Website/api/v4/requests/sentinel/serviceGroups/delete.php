<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupIds = [];
	if (isset($context['pathParameters']['serviceGroupId'])) {
		$serviceGroupIds = explode(',', $context['pathParameters']['serviceGroupId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$serviceGroupIds[] = $body['serviceGroupId'];
		} else {
			foreach ($body as $groupObj) {
				$serviceGroupIds[] = $groupObj['serviceGroupId'];
			}
		}
	}

	if (count($serviceGroupIds) <= 0) {
		return Response::NewJsonError('No service groups were specified to be deleted.', $serviceGroupIds, 400);
	}
	foreach ($serviceGroupIds as $serviceGroupId) {
		if (BeaconCommon::IsUUID($serviceGroupId) === false) {
			return Response::NewJsonError('Service group ids should be UUIDs', $serviceGroupIds, 400);
		}
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupIds as $serviceGroupId) {
		$group = ServiceGroup::Fetch($serviceGroupId);
		if ($group && $group->HasPermission($userId, ServiceGroup::PermissionDelete)) {
			try {
				$group->Delete();
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError("There was an error deleting service group {$serviceGroupId}", ['error' => $err, 'serviceGroupId' => $serviceGroupId], 500);
			}
		} else {
			$database->Rollback();
			return Response::NewJsonError("Service group {$serviceGroupId} not found.", ['serviceGroupId' => $serviceGroupId], 404);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested service groups.', ['error' => $err, 'serviceGroupIds' => $serviceGroupIds], 500);
	}
}

?>
