<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\EmailVerificationCode;

if (empty($_POST['email']) || BeaconEmail::IsEmailValid($_POST['email']) == false || (empty($_POST['code'])) && empty($_POST['key'])) {
	http_response_code(400);
	echo json_encode([], JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
$key = isset($_POST['key']) ? $_POST['key'] : null;
$code = isset($_POST['code']) ? $_POST['code'] : null;
$verification = null;
if (is_null($code) === false) {
	$verification = EmailVerificationCode::Fetch($email, $code);
	if (is_null($verification) === false) {
		$verification->Verify();
	}
} elseif (is_null($key) === false) {
	$potentialCodes = EmailVerificationCode::Search($email);
	foreach ($potentialCodes as $potentialCode) {
		if ($potentialCode->DecryptCode($key)) {
			$verification = $potentialCode;
			break;
		}
	}
}
	
if (is_null($verification)) {
	http_response_code(400);
	echo json_encode([], JSON_PRETTY_PRINT);
	exit;
}

$response = [
	'email' => $email,
	'verified' => $verification->IsVerified(),
	'code' => $verification->IsVerified() ? $verification->Code() : null,
	'username' => null
];

if ($verification->IsVerified()) {
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT username FROM users WHERE email_id = $1;', $verification->EmailId());
	if ($results->RecordCount() === 1) {
		$response['username'] = $results->Field('username');
	}
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>