<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Beacon Login');

$cleanup_url = false;
	
if ((empty($_GET['user_id']) || empty($_GET['private_key']) || empty($_GET['private_key_secret'])) === false) {
	SetupPrivateKeyImport($_GET['user_id'], $_GET['private_key'], $_GET['private_key_secret']);
	$cleanup_url = true;
}
if (empty($_GET['return']) === false) {
	BeaconCommon::StartSession();
	$_SESSION['login_return_url'] = $_GET['return'];
	$cleanup_url = true;
}

if ($cleanup_url) {
	header('Location: /account/login/');
	http_response_code(302);
	exit;
}

?><h1>Beacon Login</h1>
<?php if (BeaconCommon::InDevelopment() && isset($_SESSION)) { echo '<pre>' . var_export($_SESSION, true) . '</pre>'; } ?>
<form action="check.php" method="post">
	<p><input type="email" name="email" placeholder="E-Mail Address" required></p>
	<p><input type="password" name="password" placeholder="Password" minlength="8" title="Enter a password with at least 8 characters" required></p>
	<p><input type="submit" value="Login"></p>
	<p>Don't have an account? Enter the email and password you'd like to use and press &quot;Login.&quot;</p>
</form><?php

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