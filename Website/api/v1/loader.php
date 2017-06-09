<?php
	
header('Content-Type: application/json');

// classes local to this API will get loaded first
spl_autoload_register(function($class_name) {
	$file = dirname(__FILE__) . '/classes/' . str_replace('\\', '/', $class_name) . '.php';
	if (file_exists($file)) {
		include($file);
	}
});

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

?>