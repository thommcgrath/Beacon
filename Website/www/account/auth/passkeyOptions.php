<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Content-Type: application/json');

$obj = [
	'challenge' => BeaconCommon::Base64UrlEncode(random_bytes(128)),
	'allowCredentials' => [],
	'userVerification' => 'preferred',
	'rpId' => 'usebeacon.app',
];

http_response_code(200);
echo json_encode($obj, JSON_PRETTY_PRINT);

?>
