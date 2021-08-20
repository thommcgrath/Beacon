<?php

class BeaconLogin {
	public $with_login_cancel = false;
	public $with_remember_me = true;
	public $session_consumer_uri = '';
	
	public function Show() {
		BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('login.scss'));
		BeaconTemplate::AddScript(BeaconCommon::AssetURI('login.js'));
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT generate_username() AS username;');
		$default_username = $results->Field('username');
		
		?>
<div id="page_loading">
	<p class="text-center"><img id="loading_spinner" src="/assets/images/spinner.svg" class="white-on-dark" width="64"></p>
</div>
<div id="page_login">
	<form id="login_form_intro" action="check" method="post">
		<p><input type="email" name="email" placeholder="E-Mail Address" id="login_email_field" required></p>
		<p><input type="password" name="password" placeholder="Password" id="login_password_field" minlength="8" title="Enter a password with at least 8 characters" required></p>
		<?php if ($this->with_remember_me) { ?><p><label class="checkbox"><input type="checkbox" id="login_remember_check"><span></span>Remember me on this computer</label></p><?php } ?>
		<ul class="buttons"><li><input type="submit" value="Login"></li><li><button id="login_recover_button">Create or Recover Account</button></li><?php if ($this->with_login_cancel) { ?><li><button id="login_cancel_button">Cancel</button></li><?php } ?></ul>
	</form>
</div>
<div id="page_recover">
	<p class="explanation">To create a new Beacon Account or recover an existing Beacon Account, enter your email address.</p>
	<form id="login_recover_form">
		<p><input type="email" id="recover_email_field" placeholder="Email" required></p>
		<ul class="buttons"><li><input type="submit" id="recover_action_button" value="Continue"></li><li><a id="recover_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
<div id="page_verify">
	<p class="explanation">Check your email. Enter the code you were sent to continue.</p>
	<p class="explanation smaller">Be sure to check junk folders. Despite our best efforts, one of the major email providers likes to tag Beacon emails as spam.</p>
	<form id="login_verify_form">
		<p><input type="hidden" id="verify_email_field" value=""><input type="text" id="verify_code_field" placeholder="Code" required></p>
		<ul class="buttons"><li><input type="submit" id="verify_action_button" value="Continue"></li><li><a id="verify_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
<div id="page_password" class="as-new-user" beacon-consumer-uri="<?php echo htmlentities($this->session_consumer_uri); ?>">
	<p class="explanation"><span class="new-user-part">Time to choose a username and password. Your username can be anything you wish.</span><span class="recover-user-part">Time to choose a new password.</span> Your password must be at least 8 characters long, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
	<form id="login_password_form">
		<p class="new-user-part"><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""><input type="text" id="username_field" placeholder="Username" minlength="1"><br><span class="smaller">Perhaps <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($default_username); ?>"><?php echo htmlentities($default_username); ?></a> has a nice ring to it? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
		<p><input type="password" id="password_initial_field" placeholder="Password" minlength="8"></p>
		<p><input type="password" id="password_confirm_field" placeholder="Password Again" minlength="8"></p>
		<ul class="buttons"><li><input type="submit" id="password_action_button" value="Finish"></li><li><a id="password_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
		<?php
	}
	
	public static function GenerateUsername() {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT generate_username() AS username;');
		return $results->Field('username');
	}
	
	public static function GenerateVerificationCode(string $email, $key = null) {
		if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
			return null;
		}
		
		$database = BeaconCommon::Database();
		$code = BeaconCommon::GenerateRandomKey(6, '0123456789');
		$database->BeginTransaction();
		$database->Query('DELETE FROM email_verification WHERE email_id = uuid_for_email($1);', $email);
		if (is_null($key)) {
			$database->Query('INSERT INTO email_verification (email_id, code) VALUES (uuid_for_email($1, TRUE), encode(digest($2, \'sha512\'), \'hex\'));', $email, $code);
		} else {
			$encrypted_code = bin2hex(BeaconEncryption::SymmetricEncrypt($key, $code, false));
			$database->Query('INSERT INTO email_verification (email_id, code) VALUES (uuid_for_email($1, TRUE), $2);', $email, $encrypted_code);
		}
		$database->Commit();
		
		return $code;
	}
	
	public static function GenerateVerificationLink(string $email, $password = null) {
		$code = static::GenerateVerificationCode($email);
		if (is_null($code)) {
			return null;
		}
		
		$path = '/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code);
		
		if (is_null($password) === false) {
			if (is_string($password) === false) {
				return null;
			}
			$path .= '&password=' . urlencode($password);
		}
		
		return BeaconCommon::AbsoluteURL($path);
	}
	
	public static function SendVerification(string $email, $key = null, string $subject = 'Please Verify Your E-Mail Address') {
		$code = static::GenerateVerificationCode($email, $key);
		if (is_null($code)) {
			return false;
		}
		
		$code_spaced = implode(' ', str_split($code));
		$url = BeaconCommon::AbsoluteURL('/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code) . (is_null($key) ? '' : '&key=' . urlencode($key)));
		$plain = "You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.\n\n$code\n\nAlternatively, you may use the following link to continue the process automatically:\n\n$url\n\nIf you need help, simply reply to this email." . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device at the following ip address: ' . BeaconCommon::RemoteAddr() : '');
		$html = '<center>You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.<br /><br /><span style="font-weight:bold;font-size: x-large">' . $code_spaced . '</span><br /><br />Alternatively, you may use the following link to continue the process automatically:<br /><br /><a href="' . $url . '">' . $url . '</a><br /><br />If you need help, simply reply to this email.' . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device at the following ip address: <span style="font-weight:bold">' . htmlentities(BeaconCommon::RemoteAddr()) . '</span>' : '') . '</center>';
		
		return BeaconEmail::SendMail($email, $subject, $plain, $html);
	}
	
	public static function SendTeamWelcome(string $email, string $password, string $parent, string $subject = 'Welcome to your Beacon Team') {
		$link = static::GenerateVerificationLink($email, $password);
		if (is_null($link)) {
			return false;
		}
		
		$plain = "A Beacon account has been created for you by $parent to share access to their Beacon documents. Please follow the link below to verify your email address and create a password for your account.\n\n$link";
		$html = '<center>A Beacon account has been created for you by ' . htmlentities($parent) . ' to share access to their Beacon documents. Please follow the link below to verify your email address and create a password for your account.<br /><br /><a href="' . htmlentities($link) . '">' . htmlentities($link) . '</a></center>';
		
		return BeaconEmail::SendMail($email, $subject, $plain, $html);
	}
	
	public static function SendForcedPasswordChangeEmail(string $email, string $password, string $subject = 'Please change your Beacon account password') {
		$link = static::GenerateVerificationLink($email, $password);
		if (is_null($link)) {
			return false;
		}
		
		$plain = "A mandatory password change has been initiated for your Beacon account. Please follow the link below to verify your email address and create a new password for your account.\n\n$link";
		$html = '<center>A mandatory password change has been initiated for your Beacon account. Please follow the link below to verify your email address and create a new password for your account.<br /><br /><a href="' . htmlentities($link) . '">' . htmlentities($link) . '</a></center>';
		
		return BeaconEmail::SendMail($email, $subject, $plain, $html);
	}
}

?>