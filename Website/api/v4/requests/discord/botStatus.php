<?php

use BeaconAPI\v4\{Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$botId = $context['pathParameters']['botId'];
	$response = [
		'botId' => '',
		'shards' => 1,
		'connected' => 0,
		'status' => 'disconnected',
	];
	if (BeaconUUID::Validate($botId) === false) {
		return Response::NewJson($response, 200);
	}
	$response['botId'] = $botId;

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT shards, shards_connected FROM public.discord_bots WHERE bot_id = $1;', $botId);
	if ($rows->RecordCount() !== 1) {
		return Response::NewJson($response, 200);
	}

	$shards = $rows->Field('shards');
	$shardsConnected = $rows->Field('shards_connected');
	$response['shards'] = intval($shards);
	$response['connected'] = intval($shardsConnected);
	if ($shardsConnected === $shards) {
		$response['status'] = 'connected';
	} elseif ($shardsConnected > 0) {
		$response['status'] = 'degraded';
	} else {
		$response['status'] = 'disconnected';
	}

	return Response::NewJson($response, 200);
}

?>
