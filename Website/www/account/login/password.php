<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Confirm Your Password');

BeaconCommon::StartSession();
if (isset($_POST['password'])) {
	$password = $_POST['password'];
} else {
	$password = $_SESSION['login_desired_password'];
}
$confirm_password = '';

$email = $_SESSION['login_email'];
if (BeaconUser::ValidatePassword($password)) {
	if (isset($_POST['confirm_password'])) {
		$confirm_password = $_POST['confirm_password'];
		if ($password === $confirm_password) {
			// valid password, time to commit
			
			if (isset($_SESSION['login_private_key'])) {
				try {
					$key = BeaconEncryption::RSADecrypt(Beacon::GetConfig('Beacon_Private_Key'), $_SESSION['login_private_key_secret']);
					$decrypted_private_key = BeaconEncryption::BlowfishDecrypt($key, $_SESSION['login_private_key']);
				} catch (Exception $e) {
					echo 'Unable to decrypt uploaded private key.';
					exit;
				}
			} else {
				$config = array(
					'digest_alg' => 'sha512',
					'private_key_bits' => 2048,
					'private_key_type' => OPENSSL_KEYTYPE_RSA
				);
				
				$key = openssl_pkey_new($config);
				if (@openssl_pkey_export($key, $pem) === false) {
					echo 'Unable to create new private key.';
				}
				$decrypted_private_key = $pem;
			}
			
			if (isset($_SESSION['login_user_id'])) {
				$user = BeaconUser::GetUserByID($_SESSION['login_user_id']);
			} else {
				$user = BeaconUser::GetByEmail($email);
			}
			if (is_null($user)) {
				$user = new BeaconUser();
			}
			
			$user->SetupAuthentication($email, $password, $decrypted_private_key);
			if (isset($_SESSION['login_return_url'])) {
				$return = $_SESSION['login_return_url'];
			} else {
				$return = '/account/';
			}
			unset($_SESSION['login_user_id'], $_SESSION['login_email'], $_SESSION['login_email_verified'], $_SESSION['login_verify_code'], $_SESSION['login_desired_password'], $_SESSION['login_return_url']);
			
			header('Location: ' . $return);
			
			exit;
		} else {
			$password_error = 'Password does not match confirmation password.';
		}
	}
} else {
	$password_error = 'Password must be at least 8 characters and not a common password.';
	$password = '';
}

?><h1>Confirm Your Password</h1>
<p>Almost done. Please choose a password.</p>
<?php if (!empty($password_error)) { echo '<p>' . htmlentities($password_error) . '</p>'; } ?>
<form action="" method="post">
	<p><input type="password" name="password" placeholder="Password" minlength="8" title="Enter a password with at least 8 characters" value="<?php echo htmlentities($password); ?>" required></p>
	<p><input type="password" name="confirm_password" placeholder="Confirm Password" minlength="8" title="Type the same password again" value="<?php echo htmlentities($confirm_password); ?>" requried></p>
	<p><input type="submit" value="Finish"></p>
</form>