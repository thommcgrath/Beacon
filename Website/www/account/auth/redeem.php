<?php

// This file signs a user out and provides "manage account" functionality to Beacon 1.6 and earlier

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');

use BeaconAPI\v4\Session;

$returnUri = isset($_GET['return']) ? $_GET['return'] : '/';
if (stripos($returnUri, '://') === false) {
	$returnUri = BeaconCommon::AbsoluteUrl($returnUri);
}

$temporary = filter_var($_GET['temporary'] ?? false, FILTER_VALIDATE_BOOL);

if (isset($_GET['session_id'])) {
	$sessionId = $_GET['session_id'];
	$session = Session::Fetch($sessionId);
	if (is_null($session) === false) {
		$activeSession = BeaconCommon::GetSession();
		if (is_null($activeSession) === false) {
			if ($activeSession->UserId() === $session->UserId()) {
				BeaconCommon::Redirect($returnUri);
			} else {
				$activeSession->Delete();
			}
		}
		
		if ($session->ApplicationId() === '12877547-7ad0-466f-a001-77815043c96b') {
			BeaconCommon::SetSession($session, !$temporary);
		} else {
			$websiteSession = Session::Create($session->User(), '12877547-7ad0-466f-a001-77815043c96b', ['common']);
			if (is_null($websiteSession) === false) {
				BeaconCommon::SetSession($websiteSession, !$temporary);
			}
		}
	}
} else {
	$session = BeaconCommon::GetSession();
	if (is_null($session) === false) {
		BeaconCommon::SetSession(null, false);
		$session->Delete();
	}
}

BeaconCommon::Redirect($returnUri);

?>