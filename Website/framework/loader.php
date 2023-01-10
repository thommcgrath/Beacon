<?php

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_internal_encoding('UTF-8');
ini_set('serialize_precision', -1);

global $api_version;
if (isset($_SERVER['API_VERSION'])) {
	$api_version = $_SERVER['API_VERSION'];
}
if (is_int($api_version) === false || isset($api_version) === false || empty($api_version)) {
	$api_version = 3;
}
$_SERVER['API_VERSION'] = $api_version;

spl_autoload_register(function($class_name) {
	$filename = str_replace('\\', '/', $class_name) . '.php';
	$paths = [dirname(__FILE__) . '/classes/' . $filename];
	$path_parts = explode('\\', $class_name, 2);
	
	if (count($path_parts) === 2 && $path_parts[0] === 'BeaconAPI') {
		$paths[] = dirname(__FILE__, 2) . '/api/common/' . str_replace('\\', '/', $path_parts[1]) . '.php';
	} elseif (count($path_parts) === 2) {
		$paths[] = dirname(__FILE__, 2) . '/api/v' . $_SERVER['API_VERSION'] . '/' . strtolower($path_parts[0]) . '/classes/' . str_replace('\\', '/', $path_parts[1]) . '.php';
	}
	$paths[] = dirname(__FILE__, 2) . '/api/v' . $_SERVER['API_VERSION'] . '/classes/' . $filename;
	
	foreach ($paths as $path) {
		if (file_exists($path)) {
			include($path);
			return;
		}
	}
});

require(dirname(__FILE__) . '/config.php');

$maintenance_mode = BeaconCommon::GetGlobal('Maintenance Mode');
if ($maintenance_mode !== true) {
	try {
		BeaconCommon::Database()->Connect();
	} catch (Exception $err) {
		$maintenance_mode = true;
	}
}
if ($maintenance_mode === true) {
	$should_exit = true;
	if (php_sapi_name() == "cli") {
		if (getenv('BEACON_RUN_IN_MAINTENANCE_MODE') === 'yes') {
			$should_exit = false;
		} else {
			echo "Maintenance mode is active.\n";
		}
	} else {
		http_response_code(503);
		$message = "Beacon services are offline for just a moment, but we'll be back as soon as possible!";
		if (isset($_SERVER['HTTP_HOST']) && stristr($_SERVER['HTTP_HOST'], 'api')) {
			header('Content-Type: application/json');
			echo json_encode(array('message' => $message, 'details' => null), JSON_PRETTY_PRINT);
		} else {
			BeaconTemplate::SetTemplate('maintenance');
			BeaconTemplate::Start();
			echo $message;
		}
	}
	if ($should_exit) {
		exit;
	}
}

BeaconErrors::SetSecureMode(BeaconCommon::InProduction());
BeaconErrors::StartWatching();

(function() {
	$_SERVER['CSP_NONCE'] = base64_encode(random_bytes(12));
	
	$policies = [
		'default-src' => [
			"'self'",
			"'nonce-" . $_SERVER['CSP_NONCE'] . "'",
			"https://*.usebeacon.app"
		],
		'frame-src' => [
			"'self'",
			"https://player.vimeo.com"
		],
		'style-src' => [
			"'self'",
			"'nonce-" . $_SERVER['CSP_NONCE'] . "'"
		],
		'script-src' => [
			"'self'",
			"'nonce-" . $_SERVER['CSP_NONCE'] . "'"
		],
		'font-src' => [
			"'self'"
		],
		'object-src' => [
			"'none'"
		],
		'base-uri' => [
			"'self'"
		],
		'sandbox' => [
			'allow-forms',
			'allow-same-origin',
			'allow-scripts',
			'allow-downloads'
		],
		'upgrade-insecure-requests' => []
	];
	
	$groups = array();
	foreach ($policies as $group => $attributes) {
		if (count($attributes) > 0) {
			$groups[] = $group . ' ' . implode(' ', $attributes) . ';';
		} else {
			$groups[] = $group . ';';
		}
	}
	$policy = implode(' ', $groups);
	
	header('Content-Security-Policy: ' . $policy);
	header('Cache-Control: public, max-age=3600, must-revalidate');
	header('X-Endpoint-Server: ' . gethostname());
})();

BeaconTemplate::Start();

?>
