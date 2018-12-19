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

BeaconTemplate::AddScript(BeaconCommon::AssetURI('login.js'));

BeaconTemplate::StartStyles();
?><style>

#login_container {
	margin-left: auto;
	margin-right: auto;
	max-width: 600px;
}

#login_page_loading,
#login_page_recover,
#login_page_verify,
#login_page_password {
	display: none;
}

ul.buttons {
	margin: 0px;
	padding: 0px;
	list-style: none;
	
	li {
		text-align: center;
		width: auto;
		margin-top: 12px;
		margin-bottom: 12px;
	}

	@media (min-width: 500px) {
		display: -webkit-box;
		display: -ms-flexbox;
		display: flex;
		-ms-flex-wrap: nowrap;
		flex-wrap: nowrap;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		-ms-flex-direction: row;
		flex-direction: row;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		justify-content: center;
		
		li {
			margin-left: 6px;
			margin-right: 6px;
			margin-top: 0px;
			margin-bottom: 0px;
		}
	}
}

a.username-suggestion {
	font-style: italic;
}

.as-new-user {
	.new-user-part {
		display: initial;
	}
	
	.recover-user-part {
		display: none;
	}
}

.as-recover-user {
	.new-user-part {
		display: none;
	}
	
	.recover-user-part {
		display: initial;
	}
}

</style><?php
BeaconTemplate::FinishStyles();

$database = BeaconCommon::Database();
$results = $database->Query('SELECT generate_username() AS username;');
$default_username = $results->Field('username');

?>
<div id="login_container">
	<h1>Beacon Login<input type="hidden" id="login_return_field" value="<?php echo htmlentities($return_url); ?>"></h1>
	<div id="login_page_intro">
		<form id="login_form_intro" action="check.php" method="post">
			<p><input type="email" name="email" placeholder="E-Mail Address" id="login_email_field" required></p>
			<p><input type="password" name="password" placeholder="Password" id="login_password_field" minlength="8" title="Enter a password with at least 8 characters" required></p>
			<ul class="buttons"><li><input type="submit" value="Login"></li><li><button id="login_recover_button">Create or Recover Account</button></li></ul>
		</form>
	</div>
	<div id="login_page_loading">
		<p class="text-center"><img id="loading_spinner" src="/assets/images/spinner.svg" class="white-on-dark" width="64"></p>
	</div>
	<div id="login_page_recover">
		<p class="explanation">To create a new Beacon Account or recover an existing Beacon Account, enter your email address.</p>
		<form id="login_recover_form">
			<p><input type="email" id="recover_email_field" placeholder="Email" required></p>
			<ul class="buttons"><li><input type="submit" id="recover_action_button" value="Continue"></li><li><a id="recover_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
		</form>
	</div>
	<div id="login_page_verify">
		<p class="explanation">Check your email. Enter the code you were sent to continue.</p>
		<form id="login_verify_form">
			<p><input type="hidden" id="verify_email_field" value=""><input type="text" id="verify_code_field" placeholder="Code" required></p>
			<ul class="buttons"><li><input type="submit" id="verify_action_button" value="Continue"></li><li><a id="verify_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
		</form>
	</div>
	<div id="login_page_password" class="as-new-user">
		<p class="explanation"><span class="new-user-part">Time to choose a username and password. Your username can be anything you wish.</span><span class="recover-user-part">Time to choose a new password.</span> Your password must be at least 8 characters long, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
		<form id="login_password_form">
			<p class="new-user-part"><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""><input type="text" id="username_field" placeholder="Username" minlength="1"><br><span class="smaller">Perhaps <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($default_username); ?>"><?php echo htmlentities($default_username); ?></a> has a nice ring to it? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
			<p><input type="password" id="password_initial_field" placeholder="Password" minlength="8"></p>
			<p><input type="password" id="password_confirm_field" placeholder="Password Again" minlength="8"></p>
			<ul class="buttons"><li><input type="submit" id="password_action_button" value="Finish"></li><li><a id="password_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
		</form>
	</div>
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