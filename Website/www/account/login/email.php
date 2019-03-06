<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_POST['email']) || BeaconUser::ValidateEmail($_POST['email']) == false) {
	http_response_code(400);
	echo json_encode(array(), JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
if (BeaconLogin::SendVerification($email)) {
	http_response_code(200);
	echo json_encode($response = array(
		'email' => $email,
		'verified' => false
	), JSON_PRETTY_PRINT);
} else {
	echo json_encode(array(), JSON_PRETTY_PRINT);
}

?>