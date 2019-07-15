<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_POST['email']) || BeaconUser::ValidateEmail($_POST['email']) == false || (empty($_POST['code'])) && empty($_POST['key'])) {
	http_response_code(400);
	echo json_encode(array(), JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
$code = null;
$verified = false;

$database = BeaconCommon::Database();
if (isset($_POST['code'])) {
	$code = $_POST['code'];
	$results = $database->Query('SELECT email_id FROM email_verification WHERE email_id = uuid_for_email($1) AND code = encode(digest($2, \'sha512\'), \'hex\');', $email, $code);
	$verified = $results->RecordCount() == 1;
} else {
	$key = $_POST['key'];
	$results = $database->Query('SELECT email_id, code, verified FROM email_verification WHERE email_id = uuid_for_email($1);', $email);
	if ($results->RecordCount() == 1) {
		$encrypted_code = $results->Field('code');
		try {
			$code = BeaconEncryption::SymmetricDecrypt($key, hex2bin($encrypted_code));
			$verified = $results->Field('verified');
		} catch (Exception $err) {
		}
	}
}

$response = array(
	'email' => $email,
	'verified' => $verified,
	'code' => $code,
	'username' => null
);

if ($verified) {
	$results = $database->Query('SELECT username FROM users WHERE email_id = $1;', $results->Field('email_id'));
	if ($results->RecordCount() == 1) {
		$response['username'] = $results->Field('username');
	}
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>