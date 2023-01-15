<?php
	
header('Content-Type: application/json');
header('Cache-Control: no-cache');

$api_version = 4;
require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconAPI\v4\Core::HandleCORS();

?>