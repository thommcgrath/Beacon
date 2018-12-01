<?php
	
header('Content-Type: application/json');
header('Cache-Control: no-cache');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE, PUT');
header('Access-Control-Allow-Headers: X-Requested-With, Content-Type, Authorization, Origin, Accept');

// classes local to this API will get loaded first
spl_autoload_register(function($class_name) {
	$file = dirname(__FILE__) . '/classes/' . str_replace('\\', '/', $class_name) . '.php';
	if (file_exists($file)) {
		include($file);
	}
});

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (BeaconAPI::Method() == 'OPTIONS') {
	http_response_code(200);
	exit;
}

?>