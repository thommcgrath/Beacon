<?php

require(dirname(__FILE__, 2) . '/loader.php');

if (!isset($_GET['provider'])) {
	\BeaconAPI::ReplyError('Must include the `provider` parameter.', null, 400);
}

\BeaconAPI::Authorize(false);
$user_id = \BeaconAPI::UserID();
$provider = $_GET['provider'];
	
$oauth = Sentinel\OAuth::Lookup($user_id, $provider);
if ($oauth && $oauth->Test(true)) {
	\BeaconAPI::ReplySuccess($oauth);
} else {
	\BeaconAPI::ReplyError('Token not found.', null, 404);
}

?>
