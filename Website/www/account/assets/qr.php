<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\Session;

header('Content-Type: image/svg+xml');

$session = Session::GetFromCookie();
if (is_null($session)) {
	return;
}
	
$message = base64_decode($_GET['content']);
echo QRCode::svg($message);
	
?>