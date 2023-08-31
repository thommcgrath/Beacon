<?php

function handle_request(array $context): void {
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
	
	BeaconAPI::ReplySuccess($body = [
		'readConnected' => $readConnected,
		'writeConnected' => $writeConnected,
	], ($readConnected && $writeConnected) ? 200 : 500);
}


?>
