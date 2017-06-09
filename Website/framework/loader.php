<?php

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

?>