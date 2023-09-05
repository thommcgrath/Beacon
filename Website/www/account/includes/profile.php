<?php

$database = BeaconCommon::Database();
$results = $database->Query('SELECT generate_username() AS username;');
$suggested_username = $results->Field('username');

?><div class="visual-group">
	<h3>Change Username</h3>
	<form id="change_username_form" action="" method="post">
		<div class="floating-label">
			<input type="text" class="text-field" id="username_field" placeholder="New Username">
			<label for="username_field">New Username</label>
		</div>
		<p><span class="smaller">How about <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($suggested_username); ?>"><?php echo htmlentities($suggested_username); ?></a>? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
		<p class="text-right"><input type="submit" id="username_action_button" value="Save Username" disabled></p>
	</form>
</div>
<div class="visual-group">
	<h3>Change Email Address</h3>
	<form id="change_email_form" action="" method="post">
		<input type="hidden" id="email_need_2fa" value="<?php echo ($user->Is2FAProtected() ? 'true' : 'false'); ?>">
		<div class="floating-label">
			<input type="text" class="text-field" id="email_field" placeholder="New Email">
			<label for="email_field">New Email</label>
		</div>
		<p class="text-right"><input type="submit" id="email_action_button" value="Save Email" disabled></p>
	</form>
</div>
<?php if ($user->Is2FAProtected()) { 
BeaconTemplate::StartModal('change_email_2fa_form'); ?>
<div class="modal-content">
	<div class="title-bar">Enter Authenticator Code</div>
	<div class="content">
		<p>Your account is protected by two step authentication. Please enter an authentication code from your app.</p>
		<div class="floating-label">
			<input type="text" class="text-field" id="email_2fa_code_field" placeholder="Verification Code">
			<label for="email_2fa_code_field">Verification Code</label>
		</div>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="email_2fa_cancel_button">Cancel</button>
				<button id="email_2fa_action_button" class="default" disabled>Verify</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal();
} ?>
