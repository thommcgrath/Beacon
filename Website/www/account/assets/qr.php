<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

header('Content-Type: image/svg+xml');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	return;
}
	
$message = base64_decode($_GET['content']);
echo QRCode::svg($message);
	
?>