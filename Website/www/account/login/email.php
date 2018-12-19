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
$database = BeaconCommon::Database();
$code = BeaconCommon::GenerateRandomKey(8);
$database->BeginTransaction();
$database->Query('DELETE FROM email_verification WHERE email_id = uuid_for_email($1);', $email);
$database->Query('INSERT INTO email_verification (email_id, code) VALUES (uuid_for_email($1, TRUE), encode(digest($2, \'sha512\'), \'hex\'));', $email, $code);
$database->Commit();

$response = array(
	'email' => $email,
	'verified' => false
);

$headers = 'From: "Beacon Support" <forgotmyparachute@beaconapp.cc>';
$subject = 'Your Beacon Account Verification Code';
$body = "To continue setting up your Beacon Account, enter the following code where prompted.\n\n$code\n\nIf you need help, simply reply to this email.";

if (!mail($email, $subject, $body, $headers)) {
	echo json_encode(array(), JSON_PRETTY_PRINT);
	exit;
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>