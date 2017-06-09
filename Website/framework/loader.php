<?php
	
header('X-Frame-Options: SAMEORIGIN');
header('X-Content-Type-Options: nosniff');
header('X-XSS-Protection: 1; mode=block');
header('Strict-Transport-Security: max-age=15638400; includeSubDomains; preload');
header('Public-Key-Pins: pin-sha256=\"9U4eJjHBF6yuWAG5YdOrAhnaCQ4e/3LzOgwQkXIa2vo=\"; pin-sha256=\"86h29611cpitP0ZXL3WgeNhgTPDPgiS97NsbmPSg1BY=\"; pin-sha256=\"wPCukSJxPVVV60AInhJHvGt/sWYOa5rvk7oGiFK1pd4=\"; max-age=15638400; includeSubDomains;');
header('Content-Security-Policy: default-src \'self\'; upgrade-insecure-requests; block-all-mixed-content; sandbox allow-forms allow-same-origin allow-scripts; referrer no-referrer-when-downgrade;');
header('X-Content-Security-Policy: default-src \'self\'; upgrade-insecure-requests; block-all-mixed-content; sandbox allow-forms allow-same-origin allow-scripts; referrer no-referrer-when-downgrade;');
header('X-WebKit-CSP: default-src \'self\'; upgrade-insecure-requests; block-all-mixed-content; sandbox allow-forms allow-same-origin allow-scripts; referrer no-referrer-when-downgrade;');

$_SERVER['FRAMEWORK_DIR'] = dirname(__FILE__);
if (!isset($_SERVER['SITE_ROOT'])) {
	$_SERVER['SITE_ROOT'] = dirname(__FILE__, 2);
}

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_http_input('UTF-8');
mb_internal_encoding('UTF-8');

spl_autoload_register(function($class_name) {
	$filename = str_replace('\\', '/', $class_name) . '.php';
	
	// check the global classes
	$file = $_SERVER['FRAMEWORK_DIR'] . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
	
	// check the most recent api too
	$file = $_SERVER['SITE_ROOT'] . '/api/v1/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
});

require($_SERVER['FRAMEWORK_DIR'] . '/config.php');

BeaconTemplate::Start();

?>