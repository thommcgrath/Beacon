<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

if (empty($_POST['email']) || empty($_POST['password'])) {
	header('Location: ./');
	exit;
}

$email = $_POST['email'];
$password = $_POST['password'];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
	echo '<p>' . htmlentities($email) . ' is not a valid email address.</p>';
	exit;
}

$user = BeaconUser::GetByEmail($email);
if (is_null($user)) {
	// user does not exist
	BeaconCommon::StartSession();
	if (isset($_SESSION['login_email']) && isset($_SESSION['login_email_verified']) && strtolower($_SESSION['login_email']) === strtolower($email) && $_SESSION['login_email_verified'] === true) {
		// skip this step, verification is already done, just update the password
		$_SESSION['login_desired_password'] = $password;
		header('Location: /account/login/password');
		exit;
	}
	
	if (isset($_SESSION['login_verify_code'])) {
		$verify_code = $_SESSION['login_verify_code'];
	} else {
		$verify_code = BeaconCommon::GenerateRandomKey(6, '0123456789');
	}
	
	$headers = "From: Beacon Support <help@' . BeaconCommon::Domain() . '>";
	$subject = "Email Verification Code";
	$body = "Your email verification is $verify_code";
	if (!mail($email, $subject, $body, $headers)) {
		echo 'email did not send';
		exit;
	}
	
	$_SESSION['login_desired_password'] = $password;
	$_SESSION['login_verify_code'] = $verify_code;
	$_SESSION['login_email'] = $email;
	header('Location: /account/login/verify');
	exit;
} else {
	// check password
	if ($user->TestPassword($password)) {
		BeaconCommon::StartSession();
		if (isset($_SESSION['login_user_id']) && strtolower($_SESSION['login_user_id']) !== strtolower($user->UserID())) {
			// need to merge login_user_id into user_id
			if (!BeaconUser::MergeUsers($user, $_SESSION['login_user_id'])) {
				// uh oh
				echo 'Unable to merge users';
				exit;
			}
		}
		
		unset($_SESSION['login_user_id'], $_SESSION['login_private_key'], $_SESSION['login_private_key_secret']);
		
		if (isset($_SESSION['login_return_url'])) {
			header('Location: ' . $_SESSION['login_return_url']);
			unset($_SESSION['login_return_url']);
		} else {
			header('Location: /account/');
		}
		http_response_code(302);
		exit;
	} else {
		echo 'bad password';
	}
}

?>
