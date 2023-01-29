<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Session, User};

header('Cache-Control: no-cache');
BeaconCommon::StartSession();
BeaconTemplate::SetTitle('Beacon Login');
BeaconTemplate::SetBodyClass('purple');

$cleanup_url = false;
	
if ((empty($_GET['user_id']) || empty($_GET['private_key']) || empty($_GET['private_key_secret'])) === false) {
	SetupPrivateKeyImport($_GET['user_id'], $_GET['private_key'], $_GET['private_key_secret']);
	$cleanup_url = true;
}
if (empty($_GET['return']) === false) {
	$_SESSION['login_return_url'] = $_GET['return'];
	$cleanup_url = true;
}
if (empty($_GET['email']) === false) {
	$_SESSION['login_explicit_email'] = $_GET['email'];
	$cleanup_url = true;
}
if (empty($_GET['code']) === false) {
	$_SESSION['login_explicit_code'] = $_GET['code'];
	$cleanup_url = true;
}
if (empty($_GET['key']) === false) {
	$_SESSION['login_explicit_key'] = $_GET['key'];
	$cleanup_url = true;
}
if (empty($_GET['password']) === false) {
	$_SESSION['login_explicit_password'] = $_GET['password'];
	$cleanup_url = true;
}

/*if ($cleanup_url) {
	header('Location: /account/login/');
	http_response_code(302);
	exit;
}*/

if (isset($_SESSION['login_return_url'])) {
	$return_url = $_SESSION['login_return_url'];
} else {
	$return_url = BeaconCommon::AbsoluteURL('/account/');
}

if (isset($_SESSION['login_explicit_email'])) {
	$explicit_email = $_SESSION['login_explicit_email'];
} else {
	$explicit_email = null;
}
if (isset($_SESSION['login_explicit_code'])) {
	$explicit_code = $_SESSION['login_explicit_code'];
} else {
	$explicit_code = null;
}
if (isset($_SESSION['login_explicit_key'])) {
	$explicit_key = $_SESSION['login_explicit_key'];
} else {
	$explicit_key = null;
}
if (isset($_SESSION['login_explicit_password'])) {
	$explicit_password = $_SESSION['login_explicit_password'];
} else {
	$explicit_password = null;
}

if (is_null($explicit_email) === false && is_null($explicit_code) === false) {
	// confirm
	unset($_SESSION['login_explicit_email'], $_SESSION['login_explicit_code']);
	
	if (is_null($explicit_key) === false) {
		unset($_SESSION['login_explicit_key']);
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT email_id, code FROM email_verification WHERE email_id = uuid_for_email($1);', $explicit_email);
		if ($results->RecordCount() == 1) {
			$encrypted_code = $results->Field('code');
			try {
				$decrypted_code = BeaconEncryption::SymmetricDecrypt($explicit_key, hex2bin($encrypted_code));
				
				if ($decrypted_code === $explicit_code) {
					$database->BeginTransaction();
					$database->Query('UPDATE email_verification SET verified = TRUE WHERE email_id = $1;', $results->Field('email_id'));
					$database->Commit();
					
					echo '<div id="login_container"><h1>Address Confirmed</h1><p>You can now close this window and continue following the instructions inside Beacon.</p></div>';
					
					exit;
				}
			} catch (Exception $err) {
			}
		}
		$explicit_key = null;
		unset($explicit_key);
	} else {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT email_id FROM email_verification WHERE email_id = uuid_for_email($1) AND code = encode(digest($2, \'sha512\'), \'hex\');', $explicit_email, $explicit_code);
		if ($results->RecordCount() == 0) {
			$explicit_code = null;
		}
	}
}

if (is_null($explicit_email) === false && is_null($explicit_key) === false) {
	unset($_SESSION['login_explicit_email'], $_SESSION['login_explicit_key']);
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT email_id, code FROM email_verification WHERE email_id = uuid_for_email($1);', $explicit_email);
	if ($results->RecordCount() == 1) {
		$encrypted_code = $results->Field('code');
		try {
			$code = BeaconEncryption::SymmetricDecrypt($explicit_key, hex2bin($encrypted_code));
			$database->BeginTransaction();
			$database->Query('UPDATE email_verification SET verified = TRUE WHERE email_id = $1;', $results->Field('email_id'));
			$database->Commit();
			
			echo '<div id="login_container"><h1>Address Confirmed</h1><p>You can now close this window and continue following the instructions inside Beacon.</p></div>';
			
			exit;
		} catch (Exception $err) {
			$explicit_key = null;
		}
	} else {
		$explicit_key = null;
	}
}

$session = Session::GetFromCookie();
if (is_null($session) === false) {
	$user = $session->User();
	if (is_null($user) === false && is_null($explicit_email) === false) {
		$desired_user = User::Fetch($explicit_email);
		if (is_null($desired_user) === true || $desired_user->UserId() !== $user->UserId()) {
			$user = null;
			$session = null;
			Session::RemoveCookie();
		}
	}
	if (is_null($user) == false) {
		BeaconCommon::Redirect($return_url);
	}
}

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

?>
<div id="login_container">
	<h1>Beacon Login<input type="hidden" id="login_return_field" value="<?php echo htmlentities($return_url); ?>">
	<?php if (is_null($explicit_email) === false) { ?><input type="hidden" id="login_explicit_email" value="<?php echo htmlentities($explicit_email); ?>"><?php } ?>
	<?php if (is_null($explicit_code) === false) { ?><input type="hidden" id="login_explicit_code" value="<?php echo htmlentities($explicit_code); ?>"><?php } ?>
	<?php if (is_null($explicit_email) === false && is_null($explicit_code) === false && is_null($explicit_password) === false) { ?><input type="hidden" id="login_explicit_password" value="<?php echo htmlentities($explicit_password); ?>"><?php } ?></h1>
	<?php
		$login = new BeaconLogin();
		$login->with_remember_me = true;
		$login->with_login_cancel = false;
		$login->session_consumer_uri = '/account/auth?session_id={{session_id}}&return={{return_uri}}&temporary={{temporary}}';
		$login->Show();
	?>
</div><?php

function SetupPrivateKeyImport(string $user_id, string $encrypted_private_key, string $secret) {
	if (!BeaconCommon::IsUUID($user_id)) {
		return false;
	}
	
	// First, verify that the user exists and the private key matches their public key
	$user = User::Fetch($user_id);
	if (is_null($user)) {
		return false;
	}
	
	try {
		$key = BeaconEncryption::RSADecrypt(Beacon::GetConfig('Beacon_Private_Key'), $secret);
		$decrypted_private_key = BeaconEncryption::SymmetricDecrypt($key, $encrypted_private_key);
		$test_value = BeaconCommon::GenerateUUID();
		$encrypted_test_value = BeaconEncryption::RSAEncrypt($user->PublicKey(), $test_value);
		$decrypted_test_value = BeaconEncryption::RSADecrypt($decrypted_private_key, $encrypted_test_value);
	} catch (Exception $e) {
		return false;
	}
	
	// Store these values in the session and redirect to clean the url.
	BeaconCommon::StartSession();
	$_SESSION['login_user_id'] = $user_id;
	$_SESSION['login_private_key'] = $encrypted_private_key; // keep it encrypted
	$_SESSION['login_private_key_secret'] = $secret;
	
	return true;
}

?>