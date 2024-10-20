#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest};

$requests = ServiceRefreshRequest::Search(['isPending' => true], true);
if (count($requests) === 0) {
	exit;
}

$database = BeaconCommon::Database();
for ($request = end($requests); key($requests) !== null; $request = prev($requests)) {
	try {
		$service = Service::Fetch($request->ServiceId());
		$service->RefreshDetails(); // Do not put this inside the transaction, because it may refresh the access token
	} catch (Exception $err) {
	}
	$database->BeginTransaction();
	$database->Query('UPDATE sentinel.service_refresh_requests SET is_pending = FALSE WHERE request_id = $1;', $request->RequestId());
	$database->Commit();
}

?>
