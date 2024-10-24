<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$scriptIds = [];
	if (isset($context['pathParameters']['scriptId'])) {
		$scriptIds = explode(',', $context['pathParameters']['scriptId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$scriptIds[] = $body['scriptId'];
		} else {
			foreach ($body as $obj) {
				$scriptIds[] = $obj['scriptId'];
			}
		}
	}

	if (count($scriptIds) <= 0) {
		return Response::NewJsonError('No scripts were specified to be deleted.', $scriptIds, 400);
	}
	foreach ($scriptIds as $scriptId) {
		if (BeaconCommon::IsUUID($scriptId) === false) {
			return Response::NewJsonError('Script ids should be UUIDs', $scriptIds, 400);
		}
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($scriptIds as $scriptId) {
		$script = Script::Fetch($scriptId);
		if (is_null($script) || $script->UserHasPermission($userId, PermissionBits::ScriptDelete) === false) {
			$database->Rollback();
			return Response::NewJsonError("Script {$scriptId} not found.", ['scriptId' => $scriptId], 404);
		}

		try {
			$script->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting script {$scriptId}", ['error' => $err, 'scriptId' => $scriptId], 400);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested scripts.', ['error' => $err, 'scriptIds' => $scriptIds], 500);
	}
}

?>
