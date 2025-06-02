<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');
header('Content-Type: application/json');

use BeaconAPI\v4\{DeviceAuthFlow, Response};

$deviceCode = $_GET['code'] ?? '';
$flow = DeviceAuthFlow::Fetch($deviceCode);
if ($flow) {
	Response::NewJson([
		'flowId' => $flow->FlowId(),
		'deviceCode' => $deviceCode,
	], 200)->Flush();
	return;
}

Response::NewJsonError(message: 'Incorrect device code', code: 'invalidDeviceCode', httpStatus: 404)->Flush();
return;

?>
