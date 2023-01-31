<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Session};

class BeaconLogin {
	public static function Show(array $params): void {
		BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('login.scss'));
		BeaconTemplate::AddScript(BeaconCommon::AssetURI('login.js'));
		
		$deviceId = BeaconCommon::DeviceId();
		$params['apiDomain'] = BeaconCommon::APIDomain();
		$params['deviceId'] = $deviceId;
		
		$session = Session::GetFromCookie();
		$flowId = $params['flowId'] ?? null;
		$flow = null;
		$params['challengeExpiration'] = time() + 300;
		if (is_null($session) === false) {
			if (is_null($flowId)) {
				// We're not authorizing an app, so there's nothing to do here.
				BeaconCommon::Redirect($params['return']);
				return;
			}
			
			$flow = ApplicationAuthFlow::Fetch($flowId);
			if (is_null($flow) || $flow->IsCompleted()) {
				// Show an error
				echo '<h1>Expired Login Request</h1>';
				echo '<p>This login request has expired or has already been completed. Please request a new login from your app.</p>';
				echo '<p class="text-center"><a class="button" href="/account/">Account Home</a></p>';
				return;
			}
			
			$params['challenge'] = $flow->NewChallenge($deviceId, $session->User(), $params['challengeExpiration']);
		} else {
			$challengeSecret = Application::Fetch(BeaconCommon::BeaconWebsiteAppId)->Secret();
			$challengeRaw = $deviceId . $params['challengeExpiration'] . $challengeSecret;
			if (is_null($flow) === false) {
				$challengeRaw .= $flow->FlowId();
			}
			$params['challenge'] = base64_encode(hash('sha3-512', $challengeRaw, true));
		}
		
		BeaconTemplate::StartScript();
		echo "<script>\n";
		echo "const loginParams = " . json_encode($params, JSON_PRETTY_PRINT) . ";\n";
		echo "</script>";
		BeaconTemplate::FinishScript();
			
		if (is_null($flow) === false) {
			$app = $flow->Application();
			?><div id="page_authorize">
				<h3>Allow <?php echo htmlentities($app->Name()); ?> to use Beacon services?</h3>
				<div class="app_id">
					<div class="app_id_avatar"><?php echo $app->IconHtml(64); ?></div>
					<div class="api_id_namecard"><span class="bold larger"><?php echo htmlentities($app->Name()); ?></span><br>Website: <a href="<?php echo htmlentities($app->Website()); ?>" target="_top"><?php echo htmlentities($app->Website()); ?></a></div>
				</div>
				<p class="explanation smaller italic">This is a unofficial application and not affiliate with Beacon / The ZAZ Studios. Only allow access to applications you trust. This permission can be revoked in your account control panel.</p>
				<p class="explanation"><?php echo htmlentities($app->Name()); ?> will be able to:</p>
				<ul>
					<?php
					$scopes = $flow->Scopes();
					$features = [];
					foreach ($scopes as $scope) {
						$feature = strtok($scope, ':');
						$permissions = strtok(':');
						if ($permissions === false || $permissions === 'write') {
							$features[$feature] = 'readwrite';
						} else {
							$features[$feature] = $permissions;
						}
					}
					
					foreach ($features as $feature => $permissions) {
						$message = '';
						switch ($feature) {
						case 'common':
							$message = 'Edit basic objects such as Ark blueprints.';
							break;
						case 'apps':
							if ($permissions === 'readwrite') {
								$message = 'Edit your developer identity and credentials.';
							} else {
								$message = 'View your developer identity and credentials.';
							}
							break;
						case 'sentinel_logs':
							if ($permissions === 'readwrite') {
								$message = 'Edit your Sentinel logs.';
							} else {
								$message = 'Read your Sentinel logs.';
							}
							break;
						case 'sentinel_players':
							if ($permissions === 'readwrite') {
								$message = 'Edit your Sentinel players.';
							} else {
								$message = 'Read your Sentinel players.';
							}
							break;
						case 'sentinel_services':
							if ($permissions === 'readwrite') {
								$message = 'Edit your Sentinel servers and groups.';
							} else {
								$message = 'Read your Sentinel servers and groups.';
							}
							break;
						case 'user':
							if ($permissions === 'readwrite') {
								$message = 'Edit your user info.';
							} else {
								$message = 'Read your user info.';
							}
							break;
						}
						if (empty($message) === false) {
							echo '<li>' . htmlentities($message) . '</li>';
						}
					}
					?>
				</ul>
				<p class="explanation"><?php echo htmlentities($app->Name()); ?> will <strong>not</strong> be able to:</p>
				<ul>
					<li>Decrypt user files and project data.</li>
					<li>Know your account email or password.</li>
					<li><?php
					
					$jokePermissions = [
						'Summon a typhoon of staplers.',
						'Make breakfast.',
						'Play a fiddle on a roof.',
						'Take the red pill.',
						'Influence the passage of time.'
					];
					$index = array_rand($jokePermissions, 1);
					echo htmlentities($jokePermissions[$index]);
						
					?></li>
				</ul>
				<ul class="buttons"><li><button class="default" id="authorize_action_button">Allow</button></li><li><button id="authorize_cancel_button">Cancel</button></li></ul>
			</div><?php
			return;
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT generate_username() AS username;');
		$default_username = $results->Field('username');
		
		$withRememberMe = $params['withRemember'] ?? true;
		$withCancel = $params['withCancel'] ?? false;
		
		?>
<div id="page_loading">
	<p class="text-center"><img id="loading_spinner" src="/assets/images/spinner.svg" class="white-on-dark" width="64"></p>
</div>
<div id="page_login">
	<form id="login_form_intro" action="check" method="post">
		<p><input type="email" name="email" placeholder="E-Mail Address" id="login_email_field" required></p>
		<p><input type="password" name="password" placeholder="Password" id="login_password_field" minlength="8" title="Enter a password with at least 8 characters" required></p>
		<?php if ($withRememberMe) { ?><p><label class="checkbox"><input type="checkbox" id="login_remember_check"><span></span>Remember me on this computer</label></p><?php } ?>
		<ul class="buttons"><li><input type="submit" value="Login"></li><li><button id="login_recover_button">Create or Recover Account</button></li><?php if ($withCancel) { ?><li><button id="login_cancel_button">Cancel</button></li><?php } ?></ul>
	</form>
</div>
<div id="page_totp">
	<form id="login_form_totp" method="post">
		<p>Your account is protected by two step authentication. Please enter the code generated by your authenticator app.</p>
		<p><input type="text" name="totp_code" placeholder="Code" id="totp_code_field" required minlength="6" maxlength="6" title="Enter the six character code created by your authenticator app."></p>
		<p><label class="checkbox"><input type="checkbox" id="totp_remember_check"><span></span>Don't ask for codes on this device</label></p>
		<ul class="buttons"><li><input id="totp_action_button" type="submit" value="Verify"></li><li><button id="totp_cancel_button">Cancel</button></li></ul>
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
<div id="page_password" class="as-new-user">
	<p class="explanation"><span class="new-user-part">Time to choose a username and password. Your username can be anything you wish.</span><span class="recover-user-part">Time to choose a new password.</span> Your password must be at least 8 characters long, and must not contain too many repeating characters, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
	<form id="login_password_form">
		<p class="new-user-part"><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""><input type="text" id="username_field" placeholder="Username" minlength="1"><br><span class="smaller">Perhaps <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($default_username); ?>"><?php echo htmlentities($default_username); ?></a> has a nice ring to it? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
		<p><label for="password_initial_field">Password</label><br><input type="password" id="password_initial_field" placeholder="Password" minlength="8"></p>
		<p><label for="password_confirm_field">Confirm Password</label><br><input type="password" id="password_confirm_field" placeholder="Confirm Password" minlength="8"></p>
		<p id="password_totp_paragraph" class="hidden"><label id="password_totp_label" for="password_totp_field">Two Step Verification Code</label><br><input type="text" id="password_totp_field" placeholder="Two Step Verification Code"></p>
		<ul class="buttons"><li><input type="submit" id="password_action_button" value="Finish"></li><li><a id="password_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
<?php
	}
	
	public static function GenerateUsername(): string {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT generate_username() AS username;');
		return $results->Field('username');
	}
}

?>