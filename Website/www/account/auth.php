<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Cache-Control: no-cache');

use BeaconAPI\v4\Session;

$return_uri = isset($_GET['return']) ? $_GET['return'] : '/';
if (stripos($return_uri, '://') === false) {
	$return_uri = BeaconCommon::AbsoluteUrl($return_uri);
}

$temporary = filter_var($_GET['temporary'] ?? false, FILTER_VALIDATE_BOOL);

if (isset($_GET['session_id'])) {
	$session_id = $_GET['session_id'];
	$session = Session::Fetch($session_id);
	if (is_null($session) === false) {
		$session->SendCookie($temporary);
	}
} else {
	$session = Session::GetFromCookie();
	if (is_null($session) === false) {
		$session->Delete();
	}
	Session::RemoveCookie();
}

BeaconCommon::Redirect($return_uri);

?>