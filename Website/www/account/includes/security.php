<?php

use BeaconAPI\v4\{Authenticator, User, UserCredential};

$two_factor_enabled = BeaconCommon::GetGlobal('2FA Enabled');
$authenticators = Authenticator::Search(['userId' => $user->UserId()], true);
$has_authenticators = count($authenticators) > 0;
$credentials = UserCredential::Search(['userId' => $user->UserId()], true);
$securityModel = $user->SecurityModel();
$securityModelsEnabled = BeaconCommon::GetGlobal('Enable Security Models') ?? false;

?><div class="visual-group">
	<h3>Change Password</h3>
	<p class="notice-block notice-warning"><strong>Important</strong>: Never give any user access to your Beacon account, under any circumstances. The only way for someone to be forcefully removed from your account is for your private key to be replaced. See below for reasons why you should avoid doing this. To safely share access to one or more of your Beacon documents, follow <a href="/help/sharing_beacon_documents">these instructions</a>.</p>
	<form id="change_password_form" action="" method="post">
		<div class="floating-label">
			<input type="password" class="text-field" id="password_current_field" placeholder="Current Password">
			<label for="password_current_field">Current Password</label>
		</div>
		<div class="floating-label">
			<input type="password" class="text-field" id="password_initial_field" placeholder="New Password" minlength="8">
			<label for="password_initial_field">New Password</label>
		</div>
		<div class="floating-label">
			<input type="password" class="text-field" id="password_confirm_field" placeholder="Confirm New Password" minlength="8">
			<label for="password_confirm_field">Confirm New Password</label>
		</div>
		<?php if ($user->Is2FAProtected()) { ?>
		<div class="floating-label">
			<input type="text" class="text-field" id="password_auth_field" placeholder="Two Step Code">
			<label for="password_auth_field">Two Step Code</label>
		</div>
		<?php } ?>
		<div class="subsection">
			<p><label class="checkbox"><input type="checkbox" id="password_regenerate_check" value="true"><span></span>Replace private key</label></p>
			<p class="text-red bold uppercase text-center">Read this carefully!</p>
			<p class="smaller">If you need to force someone with access to your account out, you will need a new private key. When this option is turned on, the following will happen:</p>
			<ol class="smaller">
				<li class="text-red bold">Any encrypted data in your projects, including everything in the <em>Servers</em> section, will be lost.</li>
				<li>Any shared cloud projects will need to be shared again.</li>
				<li>All other devices will be signed out.</li>
				<?php if ($user->Is2FAProtected()) { ?><li>Two-step verification will be required for all devices on the next login.</li><?php } ?>
			</ol>
		</div>
		<p class="text-right"><input type="submit" id="password_action_button" value="Save Password" disabled></p>
	</form>
</div>
<?php if ($has_authenticators || $two_factor_enabled) { ?>
<div class="visual-group">
	<h3>Two Step Authentication</h3>
	<?php

	if ($has_authenticators) {
		echo '<p>Two step authentication is <strong>enabled</strong> for your account. You will need an authenticator code to sign in on an untrusted device or to change or reset your password.</p>';
		echo '<table class="generic" id="authenticators-table"><thead><tr><th>Nickname</th><th class="low-priority">Date Added (<span id="authenticators_time_zone_name">UTC</span>)</th><th class="min-width">Actions</th></tr></thead><tbody>';
		foreach ($authenticators as $authenticator) {
			echo '<tr id="authenticator-' . htmlentities($authenticator->AuthenticatorId()) . '"><td>' . htmlentities($authenticator->Nickname()) . '<div class="row-details">Date Added: <time datetime="' . date('c', $authenticator->DateAdded()) . '">' . date('M jS, Y \a\t g:i A e', $authenticator->DateAdded()) . '</time></div></td><td class="low-priority"><time datetime="' . date('c', $authenticator->DateAdded()) . '">' . date('M jS, Y \a\t g:i A e', $authenticator->DateAdded()) . '</time></td><td class="min-width"><button beacon-authenticator-id="' . htmlentities($authenticator->AuthenticatorId()) . '" beacon-authenticator-name="' . html_entity_decode($authenticator->Nickname()) . '" class="delete_authenticator_button destructive red">Delete</a></td></tr>';
		}
		echo '</table></table>';
	} else {
		echo '<p>Two step authentication is <strong>disabled</strong> for your account. Add an authenticator to get started.</p>';
	}

	?>
	<p class="text-right"><button id="add-authenticator-button">Add Authenticator</button></p>
</div>
<?php if ($has_authenticators) { ?>
<div class="visual-group">
	<h3>Backup Codes</h3>
	<p>Here are your backup codes. Keep them in a safe place. If there is a problem with your authenticator, you can use a backup code instead. Once used, a backup code is invalidated and replaced with a new code.</p>
	<?php
		$codes = $user->Get2FABackupCodes();
		echo '<div id="backup-codes" class="flex-grid">';
		foreach ($codes as $code) {
			echo '<div class="flex-grid-item">' . htmlentities($code) . '</div>';
		}
		echo '</div>';
	?>
	<p>Backup codes cannot be used to add or remove authenticators, or to change the account password.</p>
	<p class="text-right"><button id="replace-backup-codes-button" class="yellow">Replace Backup Codes</button></p>
</div>
<?php } ?>
<?php if ($securityModelsEnabled && $securityModel !== User::SecurityModelAnonymous) { ?><div class="visual-group">
	<h3>Security Model</h3>
	<p>Your choice of security model affects how Beacon stores private data and features available to your account.</p>
	<form id="security_model_form" action="" method="post">
		<ul class="security_model_group">
			<?php if ($securityModel === User::SecurityModelLegacy) { ?><li>
				<div class="security_model_row">
					<div class="security_model_radio"><div class="input-radio"><input type="radio" name="security_model" value="<?php echo htmlentities(User::SecurityModelLegacy); ?>" id="security_model_legacy" checked></div></div>
					<div class="security_model_explain">
						<p><label for="security_model_legacy">Legacy</label><span class="tag green">High Security</span></p>
						<p>In Beacon's original security model, your account's private data is encrypted using your account password and other information, so that only you can access it. Nobody, not even the creator of Beacon, can access your private data. However, since your account password is required for decryption, features such as passkeys are unavailable for your account. If you lose or reset your password, all your encrypted data will be lost too. This includes passwords and server entries inside projects, as well as cloud data. <strong>Once you have switched off this model, it is gone for good. You will not be able to switch back to the legacy model</strong>.</p>
						<p><span class="text-green bold">Pros</span>: Most familiar. Nobody can access your private data without your account password.<br>
						<span class="text-red bold">Cons</span>: There are no passwordless logins, such as passkeys and 'sign in with' options. Forgetting your password means losing some data.</p>
					</div>
				</div>
			</li><?php } ?>
			<li>
				<div class="security_model_row">
					<div class="security_model_radio"><div class="input-radio"><input type="radio" name="security_model" value="<?php echo htmlentities(User::SecurityModelStandard); ?>" id="security_model_standard"<?php echo $securityModel === User::SecurityModelStandard ? ' checked' : '' ?>></div></div>
					<div class="security_model_explain">
						<p><label for="security_model_standard">Standard</label><span class="tag yellow">Reasonable Security</span></p>
						<p>This model is the default for new Beacon accounts and encrypts private data using a key controlled by Beacon. This is formally known as 'encryption at rest' and is considered to provide a reasonable level of security. It allows you to use passwordless logins, such as passkeys and 'sign in with' options. A password reset will not result in any data loss.</p>
						<p><span class="text-green bold">Pros</span>: Most convenient. Log in with a passkey or external account.<br>
						<span class="text-red bold">Cons</span>: If Beacon were ever breached, your projects and cloud files could be decrypted, revealing sensitive information such as server admin passwords.</p>
					</div>
				</div>
			</li>
			<li>
				<div class="security_model_row">
					<div class="security_model_radio"><div class="input-radio"><input type="radio" name="security_model" value="<?php echo htmlentities(User::SecurityModelEnhanced); ?>" id="security_model_enhanced"<?php echo $securityModel === User::SecurityModelEnhanced ? ' checked' : '' ?>></div></div>
					<div class="security_model_explain">
						<p><label for="security_model_enhanced">Enhanced</label><span class="tag green">Highest Security</span></p>
						<p>This model encrypts your private data using a secret key provided by Beacon when you enable the model. <strong>You must keep this secret safe</strong>. You will need this secret when signing into the Beacon app. If it is lost, it will need to be replaced and all your private data will be lost.</p>
						<p><span class="text-green bold">Pros</span>: Highly flexible. You can log in with a passkey or an external account, but you will need a password-like secret during the login process. Nobody can access your private data without your account secret.<br>
						<span class="text-red bold">Cons</span>: Secrets are almost impossible to remember. Losing your secret means losing some data.</p>
					</div>
				</div>
			</li>
		</ul>
		<ul class="security_model_group">
			<li>
				<p><span class="bold">What is considered private data?</span><br>Beacon encrypts the following data:</p>
				<ul>
					<li>Cloud files, excluding projects. These include both custom and discovered mod data, as well as templates.</li>
					<li>The &quot;Servers&quot; section of all projects.</li>
					<li>Any text in &quot;Custom Config&quot; that is surrounded in <code>$$BeaconEncrypted$$</code> tags in all projects.</li>
				</ul>
				<p>A lost password (in legacy mode) or secret (in enhanced mode) would require discarding all private data.</p>
			</li>
		</ul>
	</form>
</div><?php } ?>
<?php BeaconTemplate::StartModal('add-authenticator-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Add Authenticator</div>
	<div id="add-authenticator-content" class="content">
		<div id="add-authenticator-content-left"><img id="add-authenticator-qrcode" src=""></img></div>
		<div id="add-authenticator-content-right">
			<p>Scan this code with your authenticator app, then enter the code it generates.</p>
			<p class="notice-block notice-warning hidden" id="add-authenticator-error-message"></p>
			<?php if ($user->Is2FAProtected()) { ?>
			<div class="floating-label">
				<input type="text" class="text-field" id="add-authenticator-password-field" placeholder="Other Authenticator Code" value="">
				<label for="add-authenticator-password-field">Other Authenticator Code</label>
			</div>
			<?php } else { ?>
			<div class="floating-label">
				<input type="password" class="text-field" id="add-authenticator-password-field" placeholder="Account Password" value="">
				<label for="add-authenticator-password-field">Account Password</label>
			</div>
			<?php } ?>
			<div class="floating-label">
				<input type="text" class="text-field" id="add-authenticator-code-field" placeholder="Verification Code">
				<label for="add-authenticator-code-field">Verification Code</label>
			</div>
			<div class="floating-label">
				<input type="text" class="text-field" id="add-authenticator-nickname-field" placeholder="Nickname" value="Google Authenticator">
				<label for="add-authenticator-nickname-field">Nickname</label>
			</div>
		</div>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="add-authenticator-cancel-button">Cancel</button>
				<button id="add-authenticator-action-button" class="default" disabled>Verify</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
<?php } ?>
