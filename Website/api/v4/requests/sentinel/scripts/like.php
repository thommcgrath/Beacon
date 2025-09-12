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

	$body = Core::BodyAsJson();
	if (is_array($body) === false) {
		$body = [];
	}

	$liked = $body['liked'] ?? null;
	$userId = Core::UserId();
	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.scripts WHERE script_id = $1 AND community_status = $2) AS exists;', $scriptId, 'Approved');
	if ($rows->Field('exists') === false) {
		return Response::NewJsonError(code: 'scriptNotFound', httpStatus: 404, message: 'Could not find the script.');
	}

	$result = ['liked' => $liked];
	$rows = $database->Query('SELECT * FROM sentinel.script_likes WHERE script_id = $1 AND user_id = $2;', $scriptId, $userId);
	if ($rows->RecordCount() > 0) {
		if (is_null($liked)) {
			$database->BeginTransaction();
			$database->Query('DELETE FROM sentinel.script_likes WHERE script_id = $1 AND user_id = $2;', $scriptId, $userId);
			$database->Commit();
		} elseif ($liked !== $rows->Field('liked')) {
			$database->BeginTransaction();
			$database->Query('UPDATE sentinel.script_likes SET liked = $3 WHERE script_id = $1 AND user_id = $2;', $scriptId, $userId, $liked);
			$database->Commit();
		}
	} else {
		if (is_null($liked) === false) {
			$database->BeginTransaction();
			$database->Query('INSERT INTO sentinel.script_likes (script_id, user_id, liked) VALUES ($1, $2, $3);', $scriptId, $userId, $liked);
			$database->Commit();
		}
	}

	return Response::NewJson($result, 200);
}

?>
