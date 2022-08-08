<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Content-Type: text/plain');

if (isset($_GET['destination']) === false) {
	BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/'), true);
}

$destination = $_GET['destination'];
switch ($destination) {
case 'gsatoken':
	BeaconCommon::Redirect('https://dash.gameserverapp.com/configure/api', true);
	break;
case 'nitradodash':
	if (isset($_GET['serviceid']) === false || is_numeric($_GET['serviceid']) === false) {
		BeaconCommon::Redirect('https://server.nitrado.net/usa/services/index', true);
	} else {
		$service_id = intval($_GET['serviceid']);
		BeaconCommon::Redirect('https://server.nitrado.net/usa/services/weblogin/' . $service_id, true);
	}
	break;
case 'discord':
	BeaconCommon::Redirect('https://discord.gg/NmMVv4b', true);
	break;
}

?>
