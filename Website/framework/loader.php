<?php

if (ob_get_level()) {
	ob_end_clean();
}

mb_http_output('UTF-8');
mb_http_input('UTF-8');
mb_internal_encoding('UTF-8');

spl_autoload_register(function($class_name) {
	$filename = str_replace('\\', '/', $class_name) . '.php';
	
	// check the global classes
	$file = dirname(__FILE__) . '/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
	
	// check the most recent api too
	$file = dirname(__FILE__, 2) . '/api/v1/classes/' . $filename;
	if (file_exists($file)) {
		include($file);
	}
});

(function() {
	$_SERVER['CSP_NONCE'] = base64_encode(random_bytes(12));
	$policy = 'default-src \'self\' https://*.beaconapp.cc https://*.stripe.com \'nonce-' . $_SERVER['CSP_NONCE'] . '\'; child-src \'self\' https://www.youtube-nocookie.com https://*.stripe.com;';
	if (isset($_SERVER['HTTP_USER_AGENT']) && (preg_match('/Edge\/\d+/', $_SERVER['HTTP_USER_AGENT']) === 1)) {
		// Edge treats SVG style info in the page context incorrect, so we need unsafe-inline
		$policy .= ' style-src \'self\' \'unsafe-inline\';';
	}
	$policy .= ' upgrade-insecure-requests; block-all-mixed-content; sandbox allow-forms allow-same-origin allow-scripts;';
	header('X-Frame-Options: SAMEORIGIN');
	header('X-Content-Type-Options: nosniff');
	header('X-XSS-Protection: 1; mode=block');
	header('Strict-Transport-Security: max-age=15638400; includeSubDomains; preload');
	header('Public-Key-Pins: pin-sha256=\"9U4eJjHBF6yuWAG5YdOrAhnaCQ4e/3LzOgwQkXIa2vo=\"; pin-sha256=\"86h29611cpitP0ZXL3WgeNhgTPDPgiS97NsbmPSg1BY=\"; pin-sha256=\"wPCukSJxPVVV60AInhJHvGt/sWYOa5rvk7oGiFK1pd4=\"; max-age=15638400; includeSubDomains;');
	header('Content-Security-Policy: ' . $policy);
	header('X-Content-Security-Policy: ' . $policy);
	header('X-WebKit-CSP: ' . $policy);
	header('Cache-Control: no-cache');
})();

require(dirname(__FILE__) . '/config.php');

BeaconTemplate::Start();

?>