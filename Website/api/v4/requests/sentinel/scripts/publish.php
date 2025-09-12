<?php

use BeaconAPI\v4\{Application, Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$scriptId = $context['pathParameters']['scriptId'];
	if (BeaconUUID::Validate($scriptId) === false) {
		return Response::NewJsonError(code: 'badScriptId', httpStatus: 400, message: 'scriptId must be a UUID.');
	}

	switch ($context['routeKey']) {
	case 'POST /sentinel/scripts/{scriptId}/publish':
		$desiredStatus = 'Approved';
		break;
	case 'DELETE /sentinel/scripts/{scriptId}/publish':
		$desiredStatus = 'Private';
		break;
	default:
		return Response::NewJsonError(code: 'unknownRoute', httpStatus: 400, message: 'Unknown route.');
	}

	$userId = Core::UserId();
	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT community_status FROM sentinel.scripts WHERE script_id = $1 AND user_id = $2;', $scriptId, $userId);
	if ($rows->RecordCount() === 0) {
		return Response::NewJsonError(code: 'scriptNotFound', httpStatus: 404, message: 'Could not find the script.');
	}

	$currentStatus = $rows->Field('community_status');
	$result = [
		'scriptId' => $scriptId,
		'communityStatus' => $currentStatus,
	];

	if ($currentStatus !== $desiredStatus) {
		if ($currentStatus === 'Rejected' && $desiredStatus === 'Approved') {
			return Response::NewJsonError(code: 'scriptRejected', httpStatus: 400, message: 'This script cannot be shared to the community.');
		}

		$database->BeginTransaction();
		$database->Query('UPDATE sentinel.scripts SET community_status = $2 WHERE script_id = $1;', $scriptId, $desiredStatus);
		$database->Commit();
		$result['communityStatus'] = $desiredStatus;
	}

	return Response::NewJson($result, 200);
}

?>
