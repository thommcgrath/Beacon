<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$return_uri = isset($_GET['return']) ? $_GET['return'] : '/';
if (stripos($return_uri, '://') === false) {
	$return_uri = BeaconCommon::AbsoluteURL($return_uri);
}

if (isset($_GET['session_id'])) {
	$session_id = $_GET['session_id'];
	$session = BeaconSession::GetBySessionID($session_id);
	if ($session !== null) {
		$session->SendCookie();
	}
} else {
	BeaconSession::RemoveCookie();
}

BeaconCommon::Redirect($return_uri);

?>