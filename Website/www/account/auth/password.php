<?php

// This file is for a "hard" password reset, for when the user forgets their password

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\{EmailVerificationCode, Session, User};

define('ERR_EMAIL_NOT_VERIFIED', 436);
define('ERR_PASSWORD_VIOLATES_RULES', 437);
define('ERR_PASSWORD_COMPROMISED', 438);
define('ERR_CONFIRM_CHILD_RESET', 439);

if (empty($_POST['email']) || BeaconEmail::IsEmailValid($_POST['email']) == false || empty($_POST['password']) || empty($_POST['code']) || empty($_POST['username'])) {
	http_response_code(400);
	echo json_encode(['message' => 'Missing parameters.'], JSON_PRETTY_PRINT);
	exit;
}

$user_id = null;
$email = $_POST['email'];
$password = $_POST['password'];
$code = $_POST['code'];
$username = trim($_POST['username']); // only used for new accounts
$allow_vulnerable = isset($_POST['allow_vulnerable']) ? filter_var($_POST['allow_vulnerable'], FILTER_VALIDATE_BOOLEAN) : false;
	
$verification = EmailVerificationCode::Fetch($email);
if (is_null($verification) || $verification->CheckCode($code) === false) {
	http_response_code(ERR_EMAIL_NOT_VERIFIED);
	echo json_encode(['message' => 'Email not verified.'], JSON_PRETTY_PRINT);
	exit;
}

// make sure the password is a good password
if (User::ValidatePassword($password) === false) {
	http_response_code(ERR_PASSWORD_VIOLATES_RULES);
	echo json_encode(['message' => 'Password must be at least 8 characters and you should avoid repeating characters.'], JSON_PRETTY_PRINT);
	exit;
}

// check the password against haveibeenpwned, only if not already checked
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
			http_response_code(ERR_PASSWORD_COMPROMISED);
			echo json_encode(['message' => 'Password is listed as vulnerable according to haveibeenpwned.com'], JSON_PRETTY_PRINT);
			exit;
		}
	}
}

// get the user id if this user already has an account
$new_user = false;
$user = User::Fetch($email);
if (is_null($user)) {
	$new_user = true;
	$user = new User;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();

$verification_code = $_POST['verification_code'] ?? '';
if ($user->Is2FAProtected() && $user->Verify2FACode($verification_code) === false) {
	$database->Rollback();
	http_response_code(403);
	echo json_encode(['message' => 'Verification code required.', 'details' => [ 'code' => '2FA_ENABLED' ]], JSON_PRETTY_PRINT);
	exit;
}

$public_key = null;
$private_key = null;
BeaconEncryption::GenerateKeyPair($public_key, $private_key);

if ($user->AddAuthentication($username, $email, $password, $private_key) === false && $user->ReplacePassword($password, $private_key, User::GenerateUsercloudKey()) === false) {
	$database->Rollback();
	http_response_code(500);
	echo json_encode(['message' => 'There was an error updating authentication parameters.'], JSON_PRETTY_PRINT);
	exit;
}
if ($user->Commit() === false) {
	$database->Rollback();
	http_response_code(500);
	echo json_encode(['message' => 'There was an error saving the user.'], JSON_PRETTY_PRINT);
	exit;
}

// delete all sessions
$sessions = Session::Search(['userId' => $user->UserId()], true);
foreach ($sessions as $session) {
	$session->Delete();
}

$no_session = filter_var($_POST['no_session'], FILTER_VALIDATE_INT);
$response = [
	'user_id' => $user->UserId()
];

if ($no_session === false) {
	// get a new session
	$session = Session::Create($user, BeaconCommon::BeaconAppId);
	$response['session_id'] = $session->SessionId();
}

$verification->Delete();
$database->Commit();

if ($new_user) {
	$subject = 'Welcome to Beacon';
	$body = "You just created a Beacon Account, which means you can easily share your documents with multiple devices. You can manage your account at <" . BeaconCommon::AbsoluteURL("/account/") . "> to change your password, manage documents, and see your Beacon Omni purchase status.\n\nFor reference, you can view Beacon's privacy policy at <" . BeaconCommon::AbsoluteURL("/privacy") . ">. The summary of it is simple: your data is yours and won't be sold or monetized in any way.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
	BeaconEmail::SendMail($email, $subject, $body);
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>