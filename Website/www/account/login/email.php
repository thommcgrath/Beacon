<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\{EmailVerificationCode, User};

if (empty($_POST['email']) || BeaconUser::ValidateEmail($_POST['email']) == false) {
	http_response_code(400);
	echo json_encode(array(), JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
$key = isset($_POST['key']) ? $_POST['key'] : null;

$user = User::Fetch($email);
if (is_null($user) === false) {
	if ($user->IsChildAccount()) {
		http_response_code(400);
		echo json_encode([
			'error' => true,
			'message' => 'Child accounts cannot reset their own passwords. Contact the parent account owner to begin the password reset.'
		], JSON_PRETTY_PRINT);
		return;
	} elseif ($user->IsEnabled() === false) {
		http_response_code(400);
		echo json_encode([
			'error' => true,
			'message' => 'Account is disabled.'
		], JSON_PRETTY_PRINT);
		return;
	}
}

$code = EmailVerificationCode::Create($email, ['key' => $key]);
if (is_null($code) === false) {
	http_response_code(200);
	echo json_encode($response = array(
		'email' => $email,
		'verified' => false
	), JSON_PRETTY_PRINT);
} else {
	echo json_encode(array('message' => 'Unable to deliver to ' . $email . '. The mail server may be rejecting messages. Contact support at help@usebeacon.app once the mailbox is working again.'), JSON_PRETTY_PRINT);
}

?>