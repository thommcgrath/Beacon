<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Script};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$scriptId = $context['pathParameters']['scriptId'];
	$script = Script::Fetch($scriptId);
	if (is_null($script) || Script::TestSentinelPermissions($scriptId, Core::UserId()) === false) {
		return Response::NewJsonError(message: 'Script not found', httpStatus: 404, code: 'notFound');
	}

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT script_revision_id, EXTRACT(EPOCH FROM date_created) AS date_created, approval_status FROM sentinel.script_revisions WHERE script_id = $1 ORDER BY date_created DESC;', $scriptId);
	$results = [];
	while (!$rows->EOF()) {
		$results[] = [
			'revisionId' => $rows->Field('script_revision_id'),
			'dateCreated' => floatval($rows->Field('date_created')),
			'approvalStatus' => $rows->Field('approval_status'),
		];
		$rows->MoveNext();
	}

	return Response::NewJson([
		'revisions' => $results,
	], 200);
}

?>
