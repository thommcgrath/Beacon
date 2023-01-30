<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\EmailVerificationCode;

if (empty($_POST['email']) || BeaconEmail::IsEmailValid($_POST['email']) == false) {
	http_response_code(400);
	echo json_encode([], JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
$params = [];
if (isset($_POST['key'])) {
	$params['key'] = $_POST['key'];
}
if (isset($_POST['flowId'])) {
	$params['flowId'] = $_POST['flowId'];
}
$verification = EmailVerificationCode::Create($email, $params); // Email sent here
	
if (is_null($verification)) {
	echo json_encode(['message' => 'Unable to deliver to ' . $email . '. The mail server may be rejecting messages. Contact support at help@usebeacon.app once the mailbox is working again.'], JSON_PRETTY_PRINT);
	return;
}

http_response_code(200);
echo json_encode(['email' => $email, 'verified' => false], JSON_PRETTY_PRINT);

?>
