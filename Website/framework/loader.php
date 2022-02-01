<?php

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_internal_encoding('UTF-8');

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
	
	/*
	// check the global classes
	$file = dirname(__FILE__) . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
		return;
	}
	
	// check the common API
	if (substr($class_name, 0, 10) === 'BeaconAPI\\') {
		$file = dirname(__FILE__, 2) . '/api/common/' . str_replace('\\', '/', substr($class_name, 10)) . '.php';
		if (file_exists($file)) {
			include($file);
			return;
		}
	}
	
	// check the versioned api too
	$file = dirname(__FILE__, 2) . '/api/v' . $_SERVER['API_VERSION'] . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
		return;
	}*/
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
	exit;
}

BeaconErrors::SetSecureMode(BeaconCommon::InProduction());
BeaconErrors::StartWatching();

(function() {
	$_SERVER['CSP_NONCE'] = base64_encode(random_bytes(12));
	
	$policies = array(
		'default-src' => array(
			"'self'",
			"https://*.beaconapp.cc",
			"https://*.usebeacon.app",
			"https://*.stripe.com"
		),
		'frame-src' => array(
			"'self'",
			"https://www.youtube-nocookie.com",
			"https://player.vimeo.com",
			"https://*.stripe.com"
		),
		'style-src' => array(
			"'self'",
			"https://*.typekit.net/"
		),
		'script-src' => array(
			"'self'",
			"https://*.stripe.com"
		),
		'font-src' => array(
			"'self'",
			"https://use.typekit.net"
		),
		'object-src' => array(
			"'none'"
		),
		'base-uri' => array(
			"'self'"
		),
		'sandbox' => array(
			'allow-forms',
			'allow-same-origin',
			'allow-scripts',
			'allow-downloads'
		),
		'upgrade-insecure-requests' => array(
		)
	);
	
	$browser = isset($_SERVER['HTTP_USER_AGENT']) ? get_browser($_SERVER['HTTP_USER_AGENT'], true) : null;
	$use_nonces = !(is_array($browser) && $browser['browser'] == 'Edge');
	if ($use_nonces) {
		$policies['default-src'][] = "'nonce-" . $_SERVER['CSP_NONCE'] . "'";
		$policies['style-src'][] = "'nonce-" . $_SERVER['CSP_NONCE'] . "'";
		$policies['script-src'][] = "'nonce-" . $_SERVER['CSP_NONCE'] . "'";
	} else {
		$policies['default-src'][] = "'unsafe-inline'";
		$policies['style-src'][] = "'unsafe-inline'";
		$policies['script-src'][] = "'unsafe-inline'";
	}
	if (is_array($browser) && $browser['browser'] == 'Safari' && intval($browser['majorver']) <= 8 && in_array('unsafe-inline', $policies['default-src']) == false) {
		$policies['default-src'][] = "'unsafe-inline'";
	}
	
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
	header('Cache-Control: no-cache');
})();

BeaconTemplate::Start();

?>
