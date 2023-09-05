<?php

// This allows Beacon 1.6 and lower to check on the status of a verification code.

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\EmailVerificationCode;

$email = $_REQUEST['email'] ?? '';
$code = $_REQUEST['code'] ?? null;
$key = $_REQUEST['key'] ?? null;

if (empty($email) || BeaconEmail::IsEmailValid($email) == false || (empty($code)) && empty($key)) {
	http_response_code(400);
	echo json_encode([], JSON_PRETTY_PRINT);
	exit;
}

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
$verified = is_null($verification) === false ? $verification->IsVerified() : false;

$response = [
	'email' => $email,
	'verified' => $verified,
	'code' => $code,
	'username' => null
];

if ($verified) {
	$response['code'] = $verification->Code();
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT username FROM users WHERE email_id = $1;', $verification->EmailId());
	if ($results->RecordCount() === 1) {
		$response['username'] = $results->Field('username');
	}
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>