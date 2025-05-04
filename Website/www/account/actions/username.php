<?php

define('ERR_USERNAME_TAKEN', 439);

require(dirname(__FILE__, 4) . '/framework/loader.php');

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	http_response_code(400);
	echo json_encode(array('message' => 'Unauthorized.'), JSON_PRETTY_PRINT);
	exit;
}

if (empty($_POST['username'])) {
	http_response_code(400);
	echo json_encode(array('message' => 'Missing parameters.'), JSON_PRETTY_PRINT);
	exit;
}

$user = $session->User();
$old_username = $user->Username();

try {
	$user->Edit(['username' => $_POST['username']]);

	http_response_code(200);
	echo json_encode(array('username' => $user->Username(), 'old_username' => $old_username, 'message' => ''), JSON_PRETTY_PRINT);

	BeaconPusher::SharedInstance()->SendEvents([
		new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($user->UserId()), eventName: 'user-updated', body: ''),
		new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($user->UserId()), eventName: 'userUpdated', body: ''),
	]);
} catch (Exception $err) {
	http_response_code(ERR_USERNAME_TAKEN);
	echo json_encode(array('username' => $user->Username(), 'old_username' => $old_username, 'message' => $err->getMessage()), JSON_PRETTY_PRINT);
}

?>
