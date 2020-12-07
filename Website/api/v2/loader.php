<?php
	
header('Content-Type: application/json');
header('Cache-Control: no-cache');

// classes local to this API will get loaded first
spl_autoload_register(function($class_name) {
	if (substr($class_name, 0, 10) === 'BeaconAPI\\') {
		$file = dirname(__FILE__, 2) . '/common/' . str_replace('\\', '/', substr($class_name, 10)) . '.php';
	} else {
		$file = dirname(__FILE__) . '/classes/' . str_replace('\\', '/', $class_name) . '.php';
	}
	
	if (file_exists($file)) {
		include($file);
	}
});

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE, PUT, OPTIONS');
header('Access-Control-Allow-Headers: DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,X-Beacon-Upgrade-Encryption,X-Beacon-Token,Authorization');
header('Access-Control-Expose-Headers: Content-Length,Content-Range');
header('Vary: Origin');

if (BeaconAPI::Method() == 'OPTIONS') {
	header('Access-Control-Max-Age: 1728000');
	http_response_code(204);
	exit;
}

?>