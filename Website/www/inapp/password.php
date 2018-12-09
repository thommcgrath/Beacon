<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_GET['email']) || BeaconUser::ValidateEmail($_GET['email']) == false || empty($_GET['password']) || empty($_GET['code'])) {
	http_response_code(400);
	echo json_encode(array('message' => 'Missing parameters.'), JSON_PRETTY_PRINT);
	exit;
}

$email = $_GET['email'];
$password = $_GET['password'];
$code = $_GET['code'];
$allow_vulnerable = isset($_GET['allow_vulnerable']) ? boolval($_GET['allow_vulnerable']) : false;

$database = BeaconCommon::Database();
$results = $database->Query('SELECT * FROM email_verification WHERE email_id = uuid_for_email($1) AND code = encode(digest($2, \'sha512\'), \'hex\');', $email, $code);
if ($results->RecordCount() == 0) {
	http_response_code(436);
	echo json_encode(array('message' => 'Email not verified.'), JSON_PRETTY_PRINT);
	exit;
}

if (!BeaconUser::ValidatePassword($password)) {
	http_response_code(437);
	echo json_encode(array('message' => 'Password must be at least 8 characters and you should avoid repeating characters.'), JSON_PRETTY_PRINT);
	exit;
}

if ($allow_vulnerable == false) {
	$hash = strtolower(sha1($password));
	$prefix = substr($hash, 0, 5);
	$suffix = substr($hash, 5);
	$url = 'https://api.pwnedpasswords.com/range/' . $prefix;
	$hashes = explode("\n", file_get_contents($url));
	foreach ($hashes as $hash) {
		$count = intval(substr($hash, 36));
		$hash = strtolower(substr($hash, 0, 35));
		if ($hash == $suffix && $count > 0) {
			// vulnerable
			http_response_code(438);
			echo json_encode(array('message' => 'Password is listed as vulnerable according to haveibeenpwned.com'), JSON_PRETTY_PRINT);
			exit;
		}
	}
}

$new_user = false;
$user = BeaconUser::GetByEmail($email);
if (is_null($user)) {
	$new_user = true;
	$user = new BeaconUser();
}

$public_key = null;
$private_key = null;
BeaconEncryption::GenerateKeyPair($public_key, $private_key);

$user->SetPublicKey($public_key);
if ($user->AddAuthentication('', $email, $password, $private_key) == false && $user->ReplacePassword($password, $private_key) == false) {
	http_response_code(500);
	echo json_encode(array('message' => 'There was an error updating authentication parameters.'), JSON_PRETTY_PRINT);
	exit;
}
if ($user->Commit() == false) {
	http_response_code(500);
	echo json_encode(array('message' => 'There was an error saving the user.'), JSON_PRETTY_PRINT);
	exit;
}
$session = BeaconSession::Create($user->UserID());
$token = $session->SessionID();

$response = array(
	'session_id' => $token
);

if ($new_user) {
	$headers = 'From: "Beacon Support" <forgotmyparachute@beaconapp.cc>';
	$subject = 'Welcome to Beacon';
	$body = "You just created a Beacon Account, which means you can easily share your documents with multiple devices. You can also link accounts like Discord, Nitrado, and Patreon to your Beacon Account. You can manage your account at <https://beaconapp.cc/account/> to change your password, link accounts, manage documents, and delete your account. Though let's hope you don't want to do that last one.\n\nFor reference, you can view Beacon's privacy policy at <https://beaconapp.cc/privacy.php>. The TL;DR of it is simple: your data is yours and won't be sold or monetized in anyway.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
	mail($email, $subject, $body, $headers);
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>