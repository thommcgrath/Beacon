<?php

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_http_input('UTF-8');
mb_internal_encoding('UTF-8');

spl_autoload_register(function($class_name) {
	global $api_version;
	if (is_int($api_version) == false || isset($api_version) == false || empty($api_version)) {
		$api_version = 2;
	}
	
	$filename = str_replace('\\', '/', $class_name) . '.php';
	
	// check the global classes
	$file = dirname(__FILE__) . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
	
	// check the most recent api too
	$file = dirname(__FILE__, 2) . '/api/v' . $api_version . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
});

BeaconErrors::SetSecureMode(BeaconCommon::InProduction());
BeaconErrors::StartWatching();

(function() {
	$_SERVER['CSP_NONCE'] = base64_encode(random_bytes(12));
	
	$policies = array(
		'default-src' => array(
			"'self'",
			"https://*.usebeacon.app",
			"https://*.stripe.com"
		),
		'frame-src' => array(
			"'self'",
			"https://www.youtube-nocookie.com",
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

require(dirname(__FILE__) . '/config.php');

BeaconTemplate::Start();

?>
