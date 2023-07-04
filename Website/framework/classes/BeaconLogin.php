<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Session};

class BeaconLogin {
	public static function Show(array $params): void {
		BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('login.css'));
		BeaconTemplate::AddScript(BeaconCommon::AssetURI('login.js'));
		
		$deviceId = BeaconCommon::DeviceId();
		$params['apiDomain'] = BeaconCommon::APIDomain();
		$params['deviceId'] = $deviceId;
		$params['flowRequiresPassword'] = false;
		
		$session = BeaconCommon::GetSession();
		$flowId = $params['flowId'] ?? null;
		$params['challengeExpiration'] = time() + 300;
		$params['useAppCancelBehavior'] = false;
		
		$flow = null;
		$app = null;
		if (is_null($flowId) === false) {
			$flow = ApplicationAuthFlow::Fetch($flowId);
			if (is_null($flow) || $flow->IsCompleted()) {
				// Show an error
				echo '<h1>Expired Login Request</h1>';
				echo '<p>This login request has expired or has already been completed. Please request a new login from your app.</p>';
				echo '<p class="text-center"><a class="button" href="/account/">Account Home</a></p>';
				return;
			}
			$app = $flow->Application();
			
			if (($app->Experience() & Application::kExperienceAppWebView) === Application::kExperienceAppWebView) {
				BeaconTemplate::SetVar('No Navigation', true);
				$params['useAppCancelBehavior'] = true;
				$params['withCancel'] = true;
			}
		}
		
		if (is_null($session) === false) {
			if (is_null($flow)) {
				// We're not authorizing an app, so there's nothing to do here.
				BeaconCommon::Redirect($params['return']);
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
		
		$flowRequiresPassword = false;
		if (is_null($flow) === false) {
			$flowRequiresPassword = $flow->HasScope(Application::kScopeUsersPrivateKeyRead);
			$params['flowRequiresPassword'] = $flowRequiresPassword;
		}
		
		BeaconTemplate::StartScript();
		echo "<script>\n";
		echo "const loginParams = " . json_encode($params, JSON_PRETTY_PRINT) . ";\n";
		echo "</script>";
		BeaconTemplate::FinishScript();
			
		if (is_null($session) === false && is_null($flow) === false) {
			$user = $session->User();
			?><div id="page_authorize">
				<h3>Allow <?php echo htmlentities($app->Name()); ?> to use Beacon services as <?php echo htmlentities($user->Username()); ?><span class="user-suffix">#<?php echo htmlentities($user->Suffix()); ?></span>?</h3>
				<div class="app_id">
					<div class="app_id_avatar"><?php echo $app->IconHtml(64); ?></div>
					<div class="api_id_namecard"><span class="bold larger"><?php echo htmlentities($app->Name()); ?></span><br>Website: <a href="<?php echo htmlentities($app->Website()); ?>" target="_blank"><?php echo htmlentities($app->Website()); ?></a></div>
				</div>
				<?php if ($app->IsOfficial() === false) { ?><p class="explanation smaller italic">This is a unofficial application and not affiliated with Beacon / The ZAZ Studios. Only allow access to applications you trust. This permission can be revoked in your account control panel.</p><?php } ?>
				<p class="explanation"><?php echo htmlentities($app->Name()); ?> will be able to:</p>
				<ul>
					<?php
					
					if ($flowRequiresPassword) {
						echo '<li>Decrypt user files and project data.</li>';
					}
					
					define('kBitCreate', 1);
					define('kBitRead', 2);
					define('kBitUpdate', 4);
					define('kBitDelete', 8);
					
					$scopes = $flow->Scopes();
					$features = [];
					foreach ($scopes as $scope) {
						$feature = strtok($scope, ':');
						$permissions = strtok(':');
						if ($permissions === false) {
							$features[$feature] = (kBitCreate | kBitRead | kBitUpdate | kBitDelete);
						} else {
							$bits = 0;
							switch ($permissions) {
							case 'create':
								$bits = kBitCreate;
								break;
							case 'read':
								$bits = kBitRead;
								break;
							case 'update':
								$bits = kBitUpdate;
								break;
							case 'delete':
								$bits = kBitDelete;
								break;
							}
							$features[$feature] = ($features[$feature] ?? 0) | $bits;
						}
					}
					
					foreach ($features as $feature => $permissions) {
						$permissionWords = [];
						if (($permissions & kBitRead) === kBitRead) {
							$permissionWords[] = 'view';
						}
						if (($permissions & kBitCreate) === kBitCreate) {
							$permissionWords[] = 'create';
						}
						if (($permissions & kBitUpdate) === kBitUpdate) {
							$permissionWords[] = 'edit';
						}
						if (($permissions & kBitDelete) === kBitDelete) {
							$permissionWords[] = 'delete';
						}
						$permissionPhrase = ucfirst(BeaconCommon::ArrayToEnglish($permissionWords));
							
						if (count($permissionWords) === 0) {
							continue;
						}
						
						$message = '';
						switch ($feature) {
						case 'common':
							$message = "{$permissionPhrase} basic objects such as Ark blueprints.";
							break;
						case 'apps':
							$message = "{$permissionPhrase} your apps and their credentials.";
							break;
						case 'sentinel_logs':
							$message = "{$permissionPhrase} your Sentinel logs.";
							break;
						case 'sentinel_players':
							$message = "{$permissionPhrase} your Sentinel player notes.";
							break;
						case 'sentinel_services':
							$message = "{$permissionPhrase} your Sentinel servers and groups.";
							break;
						case 'user':
							$message = "{$permissionPhrase} your user information.";
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
					<?php if ($flowRequiresPassword === false) { ?><li>Decrypt user files and project data.</li><?php } ?>
					<li>Know your account email or password.</li>
					<li><?php
					
					$jokePermissions = [
						'Summon a typhoon of staplers.',
						'Make breakfast.',
						'Play a fiddle on a roof.',
						'Influence the passage of time.',
						'Simply walk into Mordor.',
						'Juggle buffalo.',
						'Reach singularity.'
					];
					$index = array_rand($jokePermissions, 1);
					echo htmlentities($jokePermissions[$index]);
						
					?></li>
				</ul>
				<ul class="buttons"><li><button class="default" id="authorize_action_button">Allow</button></li><li><button id="authorize_cancel_button" class="red">Cancel</button></li><li><button id="authorize_switch_button">Switch User</button></li></ul>
			</div><?php
			
			BeaconTemplate::StartModal('authorizePasswordDialog');
			?>
			<div class="modal-content">
				<div class="title-bar">Confirm Password</div>
				<div class="content">
					<p>To authorize this app, please confirm your password.</p>
					<p><div class="floating-label" id="authorizePasswordFieldGroup"><input type="password" id="authorizePasswordField" placeholder="Confirm Password" class="text-field" autocomplete="current-password"><label for="authorizePasswordField">Confirm Password</label></div></p>
				</div>
				<div class="button-bar">
					<div class="left"&nbsp;</div>
					<div class="middle">&nbsp;</div>
					<div class="right">
						<div class="button-group">
							<button id="authorizePasswordCancelButton">Cancel</button>
							<button id="authorizePasswordActionButton" class="default">Continue</button>
						</div>
					</div>
				</div>
			</div>
			<?php
			BeaconTemplate::FinishModal();
			return;
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT generate_username() AS username;');
		$default_username = $results->Field('username');
		
		$withRememberMe = $params['withRemember'] ?? true;
		$withCancel = $params['withCancel'] ?? false;
		
		?>
<div id="page_loading">
	<p class="text-center"><img id="loading_spinner" src="<?php echo BeaconCommon::AssetURI('spinner.svg'); ?>" class="white-on-dark" width="64"></p>
</div>
<div id="page_login">
	<form id="login_form_intro" action="check" method="post">
		<p class="floating-label"><input class="text-field" type="email" name="email" placeholder="E-Mail Address" id="login_email_field" autocomplete="email" required><label for="login_email_field">E-Mail Address</label></p>
		<p class="floating-label"><input class="text-field" type="password" name="password" placeholder="Password" id="login_password_field" autocomplete="current-password" minlength="8" title="Enter a password with at least 8 characters" required><label for="login_password_field">Password</label></p>
		<?php if ($withRememberMe) { ?><p><label class="checkbox"><input type="checkbox" id="login_remember_check"><span></span>Remember me on this computer</label></p><?php } ?>
		<ul class="buttons"><li><input type="submit" value="Login"></li><li><button id="login_recover_button">Create or Recover Account</button></li><?php if ($withCancel) { ?><li><button id="login_cancel_button" class="red">Cancel</button></li><?php } ?></ul>
	</form>
</div>
<div id="page_totp">
	<form id="login_form_totp" method="post">
		<p>Your account is protected by two step authentication. Please enter the code generated by your authenticator app.</p>
		<p class="floating-label"><input class="text-field" type="text" name="totp_code" placeholder="Two Step Verification Code" id="totp_code_field" autocomplete="one-time-code" required minlength="6" maxlength="6" title="Enter the six character code created by your authenticator app."><label for="totp_code_field">Two Step Verification Code</label></p>
		<p><label class="checkbox"><input type="checkbox" id="totp_remember_check"><span></span>Don't ask for codes on this device</label></p>
		<ul class="buttons"><li><input id="totp_action_button" type="submit" value="Verify"></li><li><button id="totp_cancel_button">Cancel</button></li></ul>
	</form>
</div>
<div id="page_recover">
	<p class="explanation">To create a new Beacon Account or recover an existing Beacon Account, enter your email address.</p>
	<form id="login_recover_form">
		<p class="floating-label"><input class="text-field" type="email" id="recover_email_field" placeholder="E-Mail Address" autocomplete="email" required><label for="recover_email_field">E-Mail Address</label></p>
		<ul class="buttons"><li><input type="submit" id="recover_action_button" value="Continue"></li><li><a id="recover_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
<div id="page_verify">
	<p class="explanation">Check your email. Enter the code you were sent to continue.</p>
	<p class="explanation smaller">Be sure to check junk folders. Despite our best efforts, one of the major email providers likes to tag Beacon emails as spam.</p>
	<form id="login_verify_form">
		<div class="hidden"><input type="hidden" id="verify_email_field" value=""></div>
		<p class="floating-label"><input class="text-field" type="text" id="verify_code_field" placeholder="Verification Code" required><label for="verify_code_field">Verification Code</label></p>
		<ul class="buttons"><li><input type="submit" id="verify_action_button" value="Continue"></li><li><a id="verify_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a></li></ul>
	</form>
</div>
<div id="page_password" class="as-new-user">
	<p class="explanation"><span class="new-user-part">Time to choose a username and password. Your username can be anything you wish.</span><span class="recover-user-part">Time to choose a new password.</span> Your password must be at least 8 characters long, and must not contain too many repeating characters, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
	<form id="login_password_form">
		<div class="hidden"><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""></div>
		<div class="new-user-part">
			<p class="floating-label mb-1"><input class="text-field" type="text" id="username_field" placeholder="Username" autocomplete="username" minlength="1"><label for="username_field">Username</label></p>
			<p class="smaller mt-1">Perhaps <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($default_username); ?>"><?php echo htmlentities($default_username); ?></a> has a nice ring to it? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</p>
		</div>
		<p class="floating-label"><input class="text-field" type="password" id="password_initial_field" placeholder="Password" autocomplete="new-password" minlength="8"><label for="password_initial_field">Password</label></p>
		<p class="floating-label"><input class="text-field" type="password" id="password_confirm_field" placeholder="Confirm Password" autocomplete="new-password" minlength="8"><label for="password_confirm_field">Confirm Password</label></p>
		<p id="password_totp_paragraph" class="hidden floating-label"><input class="text-field" type="text" id="password_totp_field" placeholder="Two Step Verification Code"><label id="password_totp_label" for="password_totp_field">Two Step Verification Code</label></p>
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