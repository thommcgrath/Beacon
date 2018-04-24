<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_GET['email']) || BeaconUser::ValidateLoginKey($_GET['email']) == false || empty($_GET['password']) || empty($_GET['code'])) {
	http_response_code(400);
	echo json_encode(array('message' => 'Missing parameters.'), JSON_PRETTY_PRINT);
	exit;
}

$email = $_GET['email'];
$password = $_GET['password'];
$code = $_GET['code'];

$database = BeaconCommon::Database();
$results = $database->Query('SELECT * FROM email_verification WHERE email = $1 AND code = encode(digest($2, \'sha512\'), \'hex\');', $email, $code);
if ($results->RecordCount() == 0) {
	http_response_code(400);
	echo json_encode(array('message' => 'Email not verified.'), JSON_PRETTY_PRINT);
	exit;
}

if (!BeaconUser::ValidatePassword($password)) {
	http_response_code(400);
	echo json_encode(array('message' => 'Password must be at least 8 characters and you should avoid repeating characters.'), JSON_PRETTY_PRINT);
	exit;
}

$user = BeaconUser::GetByEmail($email);
if (is_null($user)) {
	$user_id = BeaconCommon::GenerateUUID();
} else {
	$user_id = $user->UserID();
}
$handle_private_key = openssl_pkey_new(array(
	'digest_alg' => 'sha512',
	'private_key_bits' => 2048,
	'private_key_type' => OPENSSL_KEYTYPE_RSA
));
openssl_pkey_export($handle_private_key, $private_key);
$public_key = openssl_pkey_get_details($handle_private_key);
$public_key = $public_key['key'];
openssl_pkey_free($handle_private_key);

$private_key_salt = BeaconEncryption::GenerateSalt();
$private_key_iterations = 12000;
$hash = BeaconEncryption::HashFromPassword($password, $private_key_salt, $private_key_iterations);

$encrypted_private_key = BeaconEncryption::BlowfishEncrypt($hash, $private_key);

$private_key_salt = bin2hex($private_key_salt);
$encrypted_private_key = bin2hex($encrypted_private_key);

$database->BeginTransaction();
if (is_null($user)) {
	$database->Query('INSERT INTO users (user_id, login_key, public_key, private_key, private_key_salt, private_key_iterations) VALUES ($1, $2, $3, $4, $5, $6);', $user_id, $email, $public_key, $encrypted_private_key, $private_key_salt, $private_key_iterations);
} else {
	$database->Query('UPDATE users SET public_key = $2, private_key = $3, private_key_salt = $4, private_key_iterations = $5 WHERE user_id = $1;', $user_id, $public_key, $encrypted_private_key, $private_key_salt, $private_key_iterations);
}
$database->Query('DELETE FROM email_verification WHERE email = $1;', $email);
$database->Query('DELETE FROM sessions WHERE user_id = $1;', $user_id);
$database->Commit();

$session = BeaconSession::Create($user_id);
$token = $session->SessionID();

$response = array(
	'session_id' => $token
);

if (is_null($user)) {
	$headers = 'From: "Beacon Support" <forgotmyparachute@beaconapp.cc>';
	$subject = 'Welcome to Beacon';
	$body = "You just created a Beacon Account, which means you can easily share your documents with multiple devices. You can also link accounts like Discord, Nitrado, and Patreon to your Beacon Account. You can manage your account at <https://beaconapp.cc/account/> to change your password, link accounts, manage documents, and delete your account. Though let's hope you don't want to do that last one.\n\nFor reference, you can view Beacon's privacy policy at <https://beaconapp.cc/privacy.php>. The TL;DR of it is simple: your data is yours and won't be sold or monetized in anyway.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
	mail($email, $subject, $body, $headers);
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>