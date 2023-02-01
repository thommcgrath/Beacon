<?php

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_internal_encoding('UTF-8');
ini_set('serialize_precision', -1);

// Keep version set to v3, v4 is accessed explicitly
global $api_version;
if (isset($_SERVER['API_VERSION'])) {
	$api_version = $_SERVER['API_VERSION'];
}
if (is_int($api_version) === false || isset($api_version) === false || empty($api_version)) {
	$api_version = 3;
}
$_SERVER['API_VERSION'] = $api_version;

spl_autoload_register(function($class_name) {
	$original_class_name = $class_name;
	
	$apiVersion = $_SERVER['API_VERSION'];
	$apiRoot = dirname(__FILE__, 2) . '/api';
	$paths = [
		dirname(__FILE__) . '/classes'
	];
	
	/*
	Modern:
		BeaconAPI\v4\Project = v4/classes/Project.php
		BeaconAPI\v4\Ark\Project = v4/classes/Ark/Project.php
		BeaconAPI\v4\User = v4/classes/User.php
		
	Legacy:
		BeaconAPI\Project = common/classes/Project.php
		BeaconAPI\Ark\Project = common/Ark/classes/Project.php
		Ark\Project = v3/ark/classes/Project.php
		BeaconUser = v3/classes/BeaconUser.php
	*/
	
	if (str_starts_with($class_name, 'BeaconAPI\\')) {
		$class_name = substr($class_name, 10);
		if (preg_match('/^(v\d+)\\\/', $class_name, $matches) === 1) {
			// Explicit version
			$version = $matches[1];
			$class_name = substr($class_name, strlen($version) + 1);
			$paths[] = "{$apiRoot}/{$version}/classes";
		} else {
			// Old messy style
			if (str_starts_with($class_name, 'Ark\\')) {
				$class_name = substr($class_name, 4);
				$paths[] = "{$apiRoot}/common/Ark";
			} else {
				$paths[] = "{$apiRoot}/common";
			}
		}
	} else if (str_starts_with($class_name, 'Ark\\')) {
		$apiRoot = dirname(__FILE__, 2) . '/api';
		$class_name = substr($class_name, 4);
		$paths[] = "{$apiRoot}/v{$apiVersion}/ark/classes";
	}
	
	// Search the v3 classes last
	$paths[] = "{$apiRoot}/v{$apiVersion}/classes";
	
	$filename = str_replace('\\', '/', $class_name) . '.php';
	foreach ($paths as $path) {
		if (file_exists("{$path}/{$filename}")) {
			include("{$path}/{$filename}");
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
	
	//header('Content-Security-Policy: ' . $policy);
	//header('Cache-Control: public, max-age=3600, must-revalidate');
	//header('X-Endpoint-Server: ' . gethostname());
})();

BeaconTemplate::Start();

?>
