<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Content-Type: text/plain');

if (isset($_GET['destination']) === false) {
	BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/'));
}

$destination = $_GET['destination'];
switch ($destination) {
case 'gsatoken':
	BeaconCommon::Redirect('https://dash.gameserverapp.com/configure/api');
	break;
case 'nitradodash':
	if (isset($_GET['serviceid']) === false || is_numeric($_GET['serviceid']) === false) {
		BeaconCommon::Redirect('https://server.nitrado.net/usa/services/index');
	} else {
		$service_id = intval($_GET['serviceid']);
		BeaconCommon::Redirect('https://server.nitrado.net/usa/services/weblogin/' . $service_id);
	}
	break;
case 'discord':
	BeaconCommon::Redirect('https://discord.gg/NmMVv4b');
	break;
case 'newhelpticket':
case 'refreshuser':
case 'refreshengrams':
case 'checkforupdate':
	BeaconCommon::Redirect("beacon://action/{$destination}");
	break;
}

?>
