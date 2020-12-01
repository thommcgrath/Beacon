<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$return_uri = isset($_GET['return']) ? $_GET['return'] : '/';
if (stripos($return_uri, '://') === false) {
	$return_uri = BeaconCommon::AbsoluteURL($return_uri);
}

$temporary = isset($_GET['temporary']) ? strtolower($_GET['temporary']) == 'true' : false;

if (isset($_GET['session_id'])) {
	$session_id = $_GET['session_id'];
	$session = BeaconSession::GetBySessionID($session_id);
	if ($session !== null) {
		$session->SendCookie($temporary);
	}
} else {
	$session = BeaconSession::GetFromCookie();
	if (is_null($session) === false) {
		$session->Delete();
	}
	BeaconSession::RemoveCookie();
}

BeaconCommon::Redirect($return_uri);

?>