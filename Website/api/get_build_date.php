<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

http_response_code(200);
header('Content-Type: text/plain');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

if (isset($_GET['version']) === false) {
	echo BeaconCommon::BuildDateForVersion(99999999);
} else {
	echo BeaconCommon::BuildDateForVersion($_GET['version']);
}

?>
