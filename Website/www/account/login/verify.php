<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Verify Your E-Mail Address');

if (isset($_POST['code'])) {
	$code = $_POST['code'];
	
	BeaconCommon::StartSession();
	if ($code === $_SESSION['login_verify_code']) {
		unset($_SESSION['login_verify_code']);
		$_SESSION['login_email_verified'] = true;
		header('Location: /account/login/password.php');
		http_response_code(302);
		exit;
	}
	
	$error = true;
} else {
	$error = false;
}

?><h1>Verify Your E-Mail Address</h1>
<form action="" method="post">
	<p><input type="text" maxlength="6" minlength="6" name="code" placeholder="Verification Code" pattern="^[0-9]{6}$" title="Enter the 6 digit verification code."></p>
	<?php if ($error) { ?><p>Sorry, that's not the correct verification code.</p><?php } ?>
	<p><input type="submit" value="Verify"></p>
</form>