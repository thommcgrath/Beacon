<?php

// API v3, Beacon 1.6 and lower
// This file is for a "hard" password reset, for when the user forgets their password.
// Must use BeaconAPI\Session and not BeaconAPI\v4\Session

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\{EmailVerificationCode, User, UserGenerator};
use BeaconAPI\Session;

define('ERR_EMAIL_NOT_VERIFIED', 436);
define('ERR_PASSWORD_VIOLATES_RULES', 437);
define('ERR_PASSWORD_COMPROMISED', 438);
define('ERR_CONFIRM_CHILD_RESET', 439);

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$code = $_POST['code'] ?? '';

if (empty($email) || empty($password) || empty($code)) {
	http_response_code(400);
	echo json_encode(['message' => 'Missing parameters.'], JSON_PRETTY_PRINT);
	exit;
}

$username = trim($_POST['username'] ?? ''); // only used for new accounts
$allowVulnerable = filter_var($_POST['allow_vulnerable'] ?? false, FILTER_VALIDATE_BOOLEAN);
$secondFactorCode = trim($_POST['verification_code'] ?? '');

$verification = EmailVerificationCode::Fetch($email, $code);
if (is_null($verification) || $verification->IsVerified() === false) {
	http_response_code(ERR_EMAIL_NOT_VERIFIED);
	echo json_encode(['message' => 'Email not verified.'], JSON_PRETTY_PRINT);
	exit;
}

// make sure the password is a good password
if (User::ValidatePassword($password) === false) {
	http_response_code(ERR_PASSWORD_VIOLATES_RULES);
	echo json_encode(['message' => 'Password must be at least 8 characters.'], JSON_PRETTY_PRINT);
	exit;
}

// check the password against haveibeenpwned, only if not already checked
if ($allowVulnerable == false) {
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

$publicKeyPem = null;
$privateKeyPem = null;
BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);

$privateKeySalt = BeaconEncryption::GenerateSalt();
$privateKeyIterations = 100000;
$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
$privateKey = bin2hex(BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false));
$privateKeySalt = bin2hex($privateKeySalt);
$cloudKey = bin2hex(BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey()));

$userProperties = [
	'publicKey' => $publicKeyPem,
	'privateKey' => $privateKey,
	'privateKeySalt' => $privateKeySalt,
	'privateKeyIterations' => $privateKeyIterations,
	'cloudKey' => $cloudKey
];

$database = BeaconCommon::Database();
$database->BeginTransaction();

try {
	$sendWelcomeEmail = false;
	$user = User::Fetch($email);
	if (is_null($user)) {
		$userProperties['email'] = $email;
		$userProperties['username'] = $username;

		$user = UserGenerator::CreateNamed($email, $username, $password);
		$sendWelcomeEmail = true;
	} else {
		if ($user->Is2FAProtected() && $user->Verify2FACode($secondFactorCode) === false) {
			$database->Rollback();
			http_response_code(403);
			echo json_encode(['message' => 'Verification code required.', 'details' => [ 'code' => '2FA_ENABLED' ]], JSON_PRETTY_PRINT);
			exit;
		}

		UserGenerator::ReplacePassword($user, $password);
	}

	// Remove the verification codes for this user
	EmailVerificationCode::Clear($email);

	// Make sure to use the v3 user class here
	$session = Session::Create(\BeaconAPI\User::GetByUserID($user->UserId()), $secondFactorCode);
	if (is_null($session)) {
		$database->Rollback();
		http_response_code(403);
		echo json_encode(['message' => 'Verification code required.', 'details' => [ 'code' => '2FA_ENABLED' ]], JSON_PRETTY_PRINT);
		exit;
	}

	$database->Commit();

	if ($sendWelcomeEmail) {
		$subject = 'Welcome to Beacon';
		$body = "You just created a Beacon Account, which means you can easily share your projects with multiple devices. You can manage your account at <" . BeaconCommon::AbsoluteURL("/account/") . "> to change your password, manage projects, and see your Beacon Omni purchase status.\n\nFor reference, you can view Beacon's privacy policy at <" . BeaconCommon::AbsoluteURL("/privacy") . ">. The summary of it is simple: your data is yours and won't be sold or monetized in any way.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
		BeaconEmail::SendMail($email, $subject, $body);
	}

	http_response_code(200);
	echo json_encode([
		'session_id' => $session->SessionID()
	], JSON_PRETTY_PRINT);
	exit;
} catch (Exception $err) {
	$database->Rollback();
	http_response_code(403);
	echo json_encode(['message' => 'Verification code required.', 'details' => [ 'code' => '2FA_ENABLED' ]], JSON_PRETTY_PRINT);
	exit;
}

?>
