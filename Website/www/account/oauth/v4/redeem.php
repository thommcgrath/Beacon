<?php

require(dirname(__FILE__, 5) . '/framework/loader.php');
header('Cache-Control: no-cache');

use BeaconAPI\v4\ServiceToken;

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo '<h1>Error</h1>';
	echo '<p>Method not allowed. Make only GET requests.</p>';
	exit;
}

if (!BeaconCommon::HasAllKeys($_GET, 'code', 'state')) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>This method requires <code>code</code> and <code>state</code> keys.</p>';
	exit;
}

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/?return=' . urlencode($_SERVER['REQUEST_URI']));
}

$provider = ServiceToken::CleanupProvider($_GET['provider']);
$code = $_GET['code'];
$state = $_GET['state'];
$expectedState = $_COOKIE['beacon_oauth_state'] ?? '';
if ($state !== $expectedState) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Verification has failed. This can happen if cookies are turned off. The beacon_oauth_state cookie is required to verify the authorization process has not been tampered with.</p>';
	exit;
}

$token = ServiceToken::Complete($session->UserId(), $provider, $_GET['code']);
BeaconCommon::Redirect('/account/#services');

?>
