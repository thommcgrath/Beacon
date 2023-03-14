<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
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
		BeaconCommon::SetSession($session, !$temporary);
	}
} else {
	$session = BeaconCommon::GetSession();
	if (is_null($session) === false) {
		BeaconCommon::SetSession(null, false);
		$session->Delete();
	}
}

BeaconCommon::Redirect($return_uri);

?>