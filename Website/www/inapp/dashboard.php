<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTemplate('dashboard');

$session = null;
if (isset($_SERVER['PATH_INFO'])) {
	$components = explode('/', $_SERVER['PATH_INFO']);
	$session = BeaconSession::GetBySessionID($components[1]);
}

var_dump($session);

?>