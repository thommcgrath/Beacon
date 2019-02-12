<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
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

if ($cleanup_url) {
	header('Location: /account/login/');
	http_response_code(302);
	exit;
}

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

$session = BeaconSession::GetFromCookie();
if (is_null($session) == false) {
	$user = BeaconUser::GetByUserID($session->UserID());
	if (is_null($user) == false && is_null($explicit_email) == false) {
		$desired_user = BeaconUser::GetByEmail($explicit_email);
		if (is_null($desired_user) == true || $desired_user->UserID() !== $user->UserID()) {
			$user = null;
			$session = null;
			BeaconSession::RemoveCookie();
		}
	}
	if (is_null($user) == false) {
		BeaconCommon::Redirect($return_url);
	}
}

BeaconTemplate::StartStyles();
?><style>

#login_container {
	margin-left: auto;
	margin-right: auto;
	max-width: 600px;
}

</style><?php
BeaconTemplate::FinishStyles();

?>
<div id="login_container">
	<h1>Beacon Login<input type="hidden" id="login_return_field" value="<?php echo htmlentities($return_url); ?>"><?php if (!is_null($explicit_email)) { ?><input type="hidden" id="login_explicit_email" value="<?php echo htmlentities($explicit_email); ?>"><?php } ?></h1>
	<?php
		$login = new BeaconLogin();
		$login->with_remember_me = true;
		$login->with_login_cancel = false;
		$login->session_consumer_uri = '/account/auth.php?session_id={{session_id}}&return={{return_uri}}&temporary={{temporary}}';
		$login->Show();
	?>
</div><?php

function SetupPrivateKeyImport(string $user_id, string $encrypted_private_key, string $secret) {
	if (!BeaconCommon::IsUUID($user_id)) {
		return false;
	}
	
	// First, verify that the user exists and the private key matches their public key
	$user = BeaconUser::GetByUserID($user_id);
	if (is_null($user)) {
		return false;
	}
	
	try {
		$key = BeaconEncryption::RSADecrypt(Beacon::GetConfig('Beacon_Private_Key'), $secret);
		$decrypted_private_key = BeaconEncryption::BlowfishDecrypt($key, $encrypted_private_key);
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