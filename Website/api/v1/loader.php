<?php
	
header('Content-Type: application/json');
header('Cache-Control: no-cache');

// classes local to this API will get loaded first
spl_autoload_register(function($class_name) {
	$parts = explode('\\', $class_name, 2);
	if (count($parts) === 1) {
		$file = dirname(__FILE__) . '/classes/' . $class_name . '.php';
	} elseif (count($parts) === 2) {
		if ($parts[0] === 'BeaconAPI') {
			$file = dirname(__FILE__, 2) . '/common/' . str_replace('\\', '/', $parts[1]) . '.php';
		} else {
			$file = dirname(__FILE__) . '/classes/' . $parts[0] . '/' . str_replace('\\', '/', $parts[1]) . '.php';
		}
	} else {
		return;
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

BeaconAPI::HandleRateLimiting();

?>