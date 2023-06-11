<?php

use BeaconAPI\v4\Authenticator;

$two_factor_enabled = BeaconCommon::GetGlobal('2FA Enabled');
$authenticators = Authenticator::Search(['userId' => $user->UserId()], true);
$has_authenticators = count($authenticators) > 0;

BeaconTemplate::AddScript(BeaconCommon::AssetURI('jsOTP-es5-min.js'));

?><div class="visual-group">
	<h3>Change Password</h3>
	<p class="notice-block notice-warning"><strong>Important</strong>: Do not give any user access to your Beacon account for any reason. The only way to forcefully remove somebody from your account is to replace your private key. See below for why you don't want to do this. To safely share access to one or more of your Beacon documents, please follow <a href="/help/sharing_beacon_documents">these instructions</a>.</p>
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
		<div class="subsection">
			<p><label class="checkbox"><input type="checkbox" id="password_regenerate_check" value="true"><span></span>Replace private key</label></p>
			<p class="text-red bold uppercase text-center">Read this carefully!</p>
			<p class="smaller">If there is somebody with access to your account that you need to force out, you will need a new private key. With this option turned on, the following will happen:</p>
			<ol class="smaller">
				<li><strong class="text-red">Any encrypted data inside your projects will be lost</strong>, which includes everything inside the <em>Servers</em> section.</li>
				<li>Shared cloud projects will need to be re-shared</li>
				<li>All other devices will be signed out.</li>
				<?php if ($user->Is2FAProtected()) { ?><li>All devices will require two step verification on next log in.</li><?php } ?>
			</ol>
		</div>
		<p class="text-right"><input type="submit" id="password_action_button" value="Save Password" disabled></p>
	</form>
</div>
<?php if ($has_authenticators || $two_factor_enabled) { ?>
<div class="visual-group">
	<h3>Authenticators</h3>
	<?php
	
	if ($has_authenticators) {
		echo '<p>Two step authentication is <strong>enabled</strong> for your account. An authenticator code is required to sign in on an untrusted device, and to change or reset your password.</p>';
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
	<p class="text-right"><button id="replace-backup-codes-button" class="yellow">Replace Backup Codes</button></p>
</div>
<?php } ?>
<?php BeaconTemplate::StartModal('add-authenticator-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Add Authenticator</div>
	<div id="add-authenticator-content" class="content">
		<div id="add-authenticator-content-left"><img id="add-authenticator-qrcode" src=""></img></div>
		<div id="add-authenticator-content-right">
			<p>Scan this code with your authenticator app, then enter the code it generates.</p>
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