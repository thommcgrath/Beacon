<?php

require(dirname(__FILE__, 5) . '/framework/loader.php');
header('Cache-Control: no-cache');

use BeaconAPI\v4\OAuth;

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo '<h1>Error</h1>';
	echo '<p>Method not allowed. Make only GET requests.</p>';
	exit;
}

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/?return=' . urlencode($_SERVER['REQUEST_URI']));
}

$tokenId = OAuth::CleanupProvider($_GET['token']);
$token = OAuth::Fetch($tokenId);
if (is_null($token) === false && $token->UserId() === $session->UserId()) {
	$token->Delete();
}
BeaconCommon::Redirect('/account/#oauth');

?>
