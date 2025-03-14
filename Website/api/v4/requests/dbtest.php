<?php

use BeaconAPI\v4\{Core, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$readConnected = false;
	$writeConnected = false;

	try {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT CURRENT_TIMESTAMP AS now;');
		$readConnected = $rows->RecordCount() === 1;
	} catch (Exception $err) {
	}

	try {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('SELECT CURRENT_TIMESTAMP AS now;');
		$writeConnected = $rows->RecordCount() === 1;
		$database->Rollback();
	} catch (Exception $err) {
	}

	return Response::NewJson([
		'readConnected' => $readConnected,
		'writeConnected' => $writeConnected,
	], ($readConnected && $writeConnected) ? 200 : 500);
}


?>
