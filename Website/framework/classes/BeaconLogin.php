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
	<form id="login_form_intro" action="check.php" method="post">
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
		$code = BeaconCommon::GenerateRandomKey(8);
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
	
	public static function GenerateVerificationLink(string $email) {
		$code = static::GenerateVerificationCode($email);
		if (is_null($code)) {
			return null;
		}
		
		return BeaconCommon::AbsoluteURL('/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code));
	}
	
	public static function SendVerification(string $email, $key = null) {
		$code = static::GenerateVerificationCode($email, $key);
		if (is_null($code)) {
			return false;
		}
		
		$plain = "To continue setting up your Beacon Account, enter the following code where prompted.\n\n$code\n\nNote: The code is case-sensitive.\nIf you need help, simply reply to this email.\n\nRecent Beacon News";
		$html = '<center><a href="' . BeaconCommon::AbsoluteURL('/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code) . (is_null($key) ? '' : '&key=' . urlencode($key))) . '">Click Here to Confirm Your E-Mail</a></center><br /><br \>If you need to enter the code manually, your code is ' . htmlentities($code) . '. The code is case-sensitive, so using copy and paste is recommended.<br /><br />If you need help, simply reply to this email.<br /><br /><strong style="font-size: larger;">Recent Beacon News</strong>';
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT MAX(build_number) AS latest_public_build FROM updates WHERE stage = 3;');
		$public_build = $results->Field('latest_public_build');
		$results = $database->Query('(SELECT message, secondary_message, action_url, last_update FROM client_notices WHERE (min_version IS NULL OR min_version <= $1) AND (max_version IS NULL OR max_version >= $1)) UNION (SELECT subject AS message, preview AS secondary_message, \'/blog/\' || article_slug AS action_url, last_updated AS last_update FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP) ORDER BY last_update DESC LIMIT 3;', $public_build);
		while (!$results->EOF()) {
			$plain .= "\n\n" . $results->Field('message');
			if ($results->Field('action_url') != '') {
				$url = BeaconCommon::AbsoluteURL($results->Field('action_url'));
				$plain .= "\n" . $url;
				$html .= '<br /><br /><strong><a href="' . htmlentities($url) . '">' . htmlentities($results->Field('message')) . '</a></strong>';
			} else {
				$html .= '<br /><br /><strong>' . htmlentities($results->Field('message')) . '</strong>';
			}
			if ($results->Field('secondary_message') != '') {
				$plain .= "\n" . $results->Field('secondary_message');
				$html .= '<br />' . nl2br(htmlentities($results->Field('secondary_message')), true);
			}
			$results->MoveNext();
		}
		
		return BeaconEmail::SendMail($email, 'Please Verify Your E-Mail Address', $plain, $html);
	}
}

?>