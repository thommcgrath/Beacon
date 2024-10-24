<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, ScriptUser};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$scriptUserIds = [];
	if (isset($context['pathParameters']['scriptUserId'])) {
		$scriptUserIds = explode(',', $context['pathParameters']['scriptUserId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			$scriptUserIds[] = $body['scriptUserId'];
		} else {
			foreach ($body as $obj) {
				$scriptUserIds[] = $obj['scriptUserId'];
			}
		}
	}

	if (count($scriptUserIds) <= 0) {
		return Response::NewJsonError('No script users were specified to be deleted.', $scriptUserIds, 400);
	}
	foreach ($scriptUserIds as $scriptUserId) {
		if (BeaconCommon::IsUUID($scriptUserId) === false) {
			return Response::NewJsonError('Script user ids should be UUIDs', $scriptUserIds, 400);
		}
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($scriptUserIds as $scriptUserId) {
		$scriptUser = ScriptUser::Fetch($scriptUserId);
		if (is_null($scriptUser)) {
			$database->Rollback();
			return Response::NewJsonError("Script user {$scriptUserId} not found.", ['scriptUserId' => $scriptUserId], 404);
		} elseif ($scriptUser->UserHasPermission($userId, PermissionBits::ScriptSharing) === false && $scriptUser->UserId() !== $userId) {
			$database->Rollback();
			return Response::NewJsonError('You do not have permission to remove users from this script.', ['scriptUserId' => $scriptUserId], 404);
		}

		try {
			$scriptUser->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError("There was an error deleting script user {$scriptUserId}", ['error' => $err, 'scriptUserId' => $scriptUserId], 400);
		}
	}
	try {
		$database->Commit();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError('There was an internal error while trying to delete the requested script users.', ['error' => $err, 'scriptUserIds' => $scriptUserIds], 500);
	}
}

?>
