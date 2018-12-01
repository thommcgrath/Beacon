<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_GET['email']) || BeaconUser::ValidateLoginKey($_GET['email']) == false || empty($_GET['code'])) {
	http_response_code(400);
	echo json_encode(array(), JSON_PRETTY_PRINT);
	exit;
}

$email = $_GET['email'];
$code = $_GET['code'];

$database = BeaconCommon::Database();
$results = $database->Query('SELECT * FROM email_verification WHERE email = $1 AND code = encode(digest($2, \'sha512\'), \'hex\');', $email, $code);
$verified = $results->RecordCount() == 1;

$response = array(
	'email' => $email,
	'verified' => $verified
);

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>