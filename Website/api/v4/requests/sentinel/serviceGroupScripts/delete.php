<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ServiceGroup, ServiceGroupScript};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupScriptIds = [];
	if (isset($context['pathParameters']['serviceGroupScriptId'])) {
		$serviceGroupScriptIds = explode(',', $context['pathParameters']['serviceGroupScriptId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$serviceGroupScriptIds[] = $body['serviceGroupScriptId'];
		} else {
			foreach ($body as $obj) {
				$serviceGroupScriptIds[] = $obj['serviceGroupScriptId'];
			}
		}
	}

	if (count($serviceGroupScriptIds) <= 0) {
		return Response::NewJsonError('No service group scripts were specified to be deleted.', $serviceGroupScriptIds, 400);
	}
	foreach ($serviceGroupScriptIds as $serviceGroupScriptId) {
		if (BeaconCommon::IsUUID($serviceGroupScriptId) === false) {
			return Response::NewJsonError('Service group script ids should be UUIDs', $serviceGroupScriptIds, 400);
		}
	}

	$serviceGroupCache = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupScriptIds as $serviceGroupScriptId) {
		$serviceGroupScript = ServiceGroupScript::Fetch($serviceGroupScriptId);
		if (is_null($serviceGroupScript)) {
			$database->Rollback();
			return Response::NewJsonError("Service group script not found.", ['serviceGroupScriptId' => $serviceGroupScriptId], 404);
		}
		$serviceGroupId = $serviceGroupScript->ServiceGroupId();
		if (isset($serviceGroupCache[$serviceGroupId]) === false) {
			$serviceGroup = ServiceGroup::Fetch($serviceGroupId);
			if (is_null($serviceGroup) || $serviceGroup->UserHasPermission($userId, PermissionBits::ServiceGroupUpdateContents) === false) {
				$database->Rollback();
				return Response::NewJsonError('You do not have permission to remove scripts from this service group.', ['serviceGroupScriptId' => $serviceGroupScriptId], 403);
			}
		}

		try {
			$serviceGroupScript->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting service group script", ['error' => $err, 'serviceGroupScriptId' => $serviceGroupScriptId], 400);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested service group scripts.', ['error' => $err, 'serviceGroupScriptIds' => $serviceGroupScriptIds], 500);
	}
}

?>
