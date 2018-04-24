<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTemplate('dashboard');

$session = null;
if (isset($_SERVER['PATH_INFO'])) {
	$components = explode('/', $_SERVER['PATH_INFO']);
	$session = BeaconSession::GetBySessionID($components[1]);
}

var_dump($session);

?>