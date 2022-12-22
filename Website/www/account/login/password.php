<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

define('ERR_EMAIL_NOT_VERIFIED', 436);
define('ERR_PASSWORD_VIOLATES_RULES', 437);
define('ERR_PASSWORD_COMPROMISED', 438);
define('ERR_CONFIRM_CHILD_RESET', 439);

if (empty($_POST['email']) || BeaconUser::ValidateEmail($_POST['email']) == false || empty($_POST['password']) || empty($_POST['code']) || empty($_POST['username'])) {
	http_response_code(400);
	echo json_encode(array('message' => 'Missing parameters.'), JSON_PRETTY_PRINT);
	exit;
}

$user_id = null;
$email = $_POST['email'];
$password = $_POST['password'];
$code = $_POST['code'];
$key = isset($_POST['key']) ? $_POST['key'] : null;
$username = trim($_POST['username']); // only used for new accounts
$allow_vulnerable = isset($_POST['allow_vulnerable']) ? filter_var($_POST['allow_vulnerable'], FILTER_VALIDATE_BOOLEAN) : false;
$confirm_reset_children = isset($_POST['confirm_reset_children']) ? filter_var($_POST['confirm_reset_children'], FILTER_VALIDATE_BOOLEAN) : false;
$current_password = (isset($_POST['previous_password']) && empty($_POST['previous_password']) === false) ? $_POST['previous_password'] : null;
$database = BeaconCommon::Database();

// get the email uuid
$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
$email_id = $results->Field('email_id');

// validate the code, and if provided, the key
if (ValidateCode($email_id, $code, $key) == false) {
	http_response_code(ERR_EMAIL_NOT_VERIFIED);
	echo json_encode(array('message' => 'Email not verified.'), JSON_PRETTY_PRINT);
	exit;
}

// get the user id if this user already has an account
$results = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $email_id);
if ($results->RecordCount() == 1) {
	$user_id = $results->Field('user_id');
}

// make sure the password is a good password
if (!BeaconUser::ValidatePassword($password)) {
	http_response_code(ERR_PASSWORD_VIOLATES_RULES);
	echo json_encode(array('message' => 'Password must be at least 8 characters and you should avoid repeating characters.'), JSON_PRETTY_PRINT);
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
			echo json_encode(array('message' => 'Password is listed as vulnerable according to haveibeenpwned.com'), JSON_PRETTY_PRINT);
			exit;
		}
	}
}

$new_user = false;
if (is_null($user_id)) {
	$new_user = true;
	$user = new BeaconUser();
} else {
	$user = BeaconUser::GetByUserID($user_id);
}

if (is_null($current_password)) {
	if ($user->IsChildAccount()) {
		http_response_code(500);
		echo json_encode(array('message' => 'Cannot force change a child account password.'), JSON_PRETTY_PRINT);
		exit;
	}
	if ($user->HasChildAccounts() === true && $confirm_reset_children === false) {
		http_response_code(ERR_CONFIRM_CHILD_RESET);
		echo json_encode(array('message' => 'All team passwords will also be reset. Include `confirm_reset_children` to confirm.'), JSON_PRETTY_PRINT);
		exit;
	}
	
	$public_key = null;
	$private_key = null;
	BeaconEncryption::GenerateKeyPair($public_key, $private_key);
	
	if ($user->AddAuthentication($username, $email, $password, $private_key) === false && $user->ReplacePassword($password, $private_key, BeaconUser::GenerateUsercloudKey()) === false) {
		http_response_code(500);
		echo json_encode(array('message' => 'There was an error updating authentication parameters.'), JSON_PRETTY_PRINT);
		exit;
	}
} else {
	if ($user->ChangePassword($current_password, $password) === false) {
		http_response_code(500);
		echo json_encode(array('message' => 'Failed to gracefully change password'), JSON_PRETTY_PRINT);
		exit;
	}
}
if ($user->Commit() == false) {
	http_response_code(500);
	echo json_encode(array('message' => 'There was an error saving the user.'), JSON_PRETTY_PRINT);
	exit;
}
$session = BeaconSession::Create($user);
$token = $session->SessionID();

$database->BeginTransaction();
$database->Query('DELETE FROM email_verification WHERE email_id = $1;', $email_id);
$database->Commit();

$response = array(
	'session_id' => $token
);

if ($new_user) {
	$subject = 'Welcome to Beacon';
	$body = "You just created a Beacon Account, which means you can easily share your documents with multiple devices. You can manage your account at <" . BeaconCommon::AbsoluteURL("/account/") . "> to change your password, manage documents, and see your Beacon Omni purchase status.\n\nFor reference, you can view Beacon's privacy policy at <" . BeaconCommon::AbsoluteURL("/privacy") . ">. The summary of it is simple: your data is yours and won't be sold or monetized in any way.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
	BeaconEmail::SendMail($email, $subject, $body);
}

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

function ValidateCode(string $email_id, string $code, $key) {
	$database = BeaconCommon::Database();
	
	if (is_null($key) == false) {
		$results = $database->Query('SELECT verified, code FROM email_verification WHERE email_id = $1;', $email_id);
		if ($results->RecordCount() == 0) {
			return false;
		}
		
		$encrypted_code = $results->Field('code');
		$verified = $results->Field('verified');
		if ($verified == false) {
			return false;
		}
		try {
			$decrypted_code = BeaconEncryption::SymmetricDecrypt($key, hex2bin($encrypted_code));
			return $decrypted_code === $code;
		} catch (Exception $err) {
			return false;
		}
	} else {
		$results = $database->Query('SELECT * FROM email_verification WHERE email_id = $1 AND code = encode(digest($2, \'sha512\'), \'hex\');', $email_id, $code);	
		if ($results->RecordCount() == 0) {
			return false;
		}
		return true;
	}
}

?>