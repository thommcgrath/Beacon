<?php

use BeaconAPI\v4\{Authenticator, User, UserCredential};

include('securityClasses.php');

$authenticators = Authenticator::FetchForUser($user);
$hasAuthenticators = count($authenticators) > 0;
$credentials = UserCredential::Search(['userId' => $user->UserId()], true);
$securityModel = $user->SecurityModel();
$securityModelsEnabled = BeaconCommon::GetGlobal('Enable Security Models') ?? false;
$passwordlessAvailable = $securityModel === User::SecurityModelStandard || $securityModel === User::SecurityModelEnhanced;

$signInOptions = [];
$passkeys = [];
$withRemoveButtons = false;
$hasPassword = false;
if ($securityModel === User::SecurityModelLegacy) {
	$hasPassword = true;
} else {
	$withRemoveButtons = count($credentials) > 1;
	foreach ($credentials as $credential) {
		switch ($credential->Type()) {
		case UserCredential::TypePassword:
			$hasPassword = true;
			break;
		case UserCredential::TypePasskey:
			$passkeys[] = $credential;
		}
	}
}

$passwordSignIn = new SignInOption(title: 'Password', optionId: 'password',  svg: '<path d="M0,44.159581v-24.378256c0-2.777363.743585-4.885008,2.230754-6.322933s3.619436-2.156888,6.396799-2.156888h46.715346c2.797061,0,4.939176.718963,6.426346,2.156888s2.230754,3.54557,2.230754,6.322933v24.378256c0,2.797061-.743585,4.919478-2.230754,6.367253s-3.629285,2.171662-6.426346,2.171662H8.627554c-2.777363,0-4.90963-.723887-6.396799-2.171662s-2.230754-3.570192-2.230754-6.367253ZM4.756973,44.395953c0,1.221252.334859,2.166737,1.004578,2.836456s1.615204,1.004578,2.836456,1.004578h46.803986c1.221252,0,2.166737-.334859,2.836456-1.004578s1.004578-1.615204,1.004578-2.836456v-24.850998c0-2.560689-1.280345-3.841034-3.841034-3.841034H8.598007c-2.560689,0-3.841034,1.280345-3.841034,3.841034v24.850998ZM18.259685,36.23868c-1.181857,0-2.191359-.418574-3.028508-1.255723s-1.255723-1.846651-1.255723-3.028508.418574-2.191359,1.255723-3.028508,1.846651-1.255723,3.028508-1.255723c1.162159,0,2.166737.418574,3.013734,1.255723s1.270496,1.846651,1.270496,3.028508-.418574,2.191359-1.255723,3.028508-1.846651,1.255723-3.028508,1.255723ZM32.030778,36.23868c-1.162159,0-2.161813-.418574-2.998961-1.255723s-1.255723-1.846651-1.255723-3.028508.418574-2.191359,1.255723-3.028508,1.836802-1.255723,2.998961-1.255723c1.181857,0,2.191359.418574,3.028508,1.255723s1.255723,1.846651,1.255723,3.028508-.418574,2.191359-1.255723,3.028508-1.846651,1.255723-3.028508,1.255723ZM45.828954,36.23868c-1.181857,0-2.191359-.418574-3.028508-1.255723s-1.255723-1.846651-1.255723-3.028508.418574-2.191359,1.255723-3.028508,1.846651-1.255723,3.028508-1.255723,2.191359.418574,3.028508,1.255723,1.255723,1.846651,1.255723,3.028508-.418574,2.191359-1.255723,3.028508-1.846651,1.255723-3.028508,1.255723Z"/>');
if ($hasPassword) {
	$addButton = new SignInOptionButton('add-authenticator', 'Add Authenticator', 'green');
	$addButton->SetAttribute('beacon-authenticator-count', count($authenticators));
	$passwordSignIn->AddButton($addButton);

	if ($hasAuthenticators) {
		$passwordSignIn->AddButton(new SignInOptionButton('view-backup-codes', 'View Backup Codes'));

		foreach ($authenticators as $authenticator) {
			$authenticatorRow = new SignInOptionRow('Authenticator: ' . $authenticator->Nickname());
			$authenticatorRemoveButton = new SignInOptionButton('remove-authenticator-' . $authenticator->AuthenticatorId(), 'Remove Authenticator', 'red authenticator-remove-button');
			$authenticatorRemoveButton->SetAttribute('beacon-authenticator-id', $authenticator->AuthenticatorId());
			$authenticatorRemoveButton->SetAttribute('beacon-authenticator-name', $authenticator->Nickname());
			$authenticatorRow->AddButton($authenticatorRemoveButton);
			$passwordSignIn->AddRow($authenticatorRow);
		}
	} else {
		$passwordSignIn->AddTag('Two Step Authentication Available');
	}
	$passwordSignIn->AddButton(new SignInOptionButton('change-password', 'Change Password'));
	if ($withRemoveButtons) {
		$passwordSignIn->AddButton(new SignInOptionButton('remove-password', 'Remove Password', 'red'));
	}
} else {
	$passwordSignIn->AddButton(new SignInOptionButton('change-password', 'Set Up'));
}
$signInOptions[] = $passwordSignIn;

if (BeaconCommon::GetGlobal('Enable Passkeys') ?? false) {
	$passkeySignIn = new SignInOption(title: 'Passkeys', optionId: 'passkeys', enabled: $passwordlessAvailable, svg:'<path d="M8.971933,55.776556c-1.410871,0-2.517524-.313037-3.319957-.939111s-1.20365-1.485824-1.20365-2.579249c0-1.710682.51585-3.505134,1.54755-5.383356s2.513115-3.641812,4.444245-5.290768,4.267886-2.989284,7.010267-4.020983,5.833071-1.54755,9.27207-1.54755c2.398481,0,4.63824.268947,6.719275.806842s3.968076,1.256557,5.661121,2.155988c.123451,1.922312.656937,3.685902,1.600457,5.290768s2.19126,2.91874,3.743218,3.941622v7.565798H8.971933ZM26.722459,31.280302c-1.88704,0-3.632994-.51585-5.23786-1.54755s-2.896695-2.424935-3.875487-4.179707c-.978792-1.756976-1.468188-3.727787-1.468188-5.914637,0-2.151579.489396-4.091527,1.468188-5.819844s2.270621-3.095099,3.875487-4.100345,3.35082-1.507869,5.23786-1.507869,3.632994.493805,5.23786,1.481415,2.896695,2.341165,3.875487,4.060664,1.468188,3.663857,1.468188,5.833071c0,2.204487-.489396,4.188524-1.468188,5.954318-.978792,1.763589-2.270621,3.161234-3.875487,4.192933s-3.35082,1.54755-5.23786,1.54755ZM51.139352,29.719525c1.551959,0,2.967239.379172,4.245841,1.137515s2.292666,1.776816,3.042191,3.055418,1.124288,2.685065,1.124288,4.219387c0,1.834133-.551122,3.469862-1.653365,4.907187s-2.667429,2.570431-4.695556,3.399318l3.544814,3.518361c.158723.158723.238085.330673.238085.51585s-.061726.330673-.185177.436488l-3.624176,3.544814,2.61893,2.61893c.141087.141087.211631.295401.211631.462942s-.070544.321855-.211631.462942l-4.20616,4.179707c-.141087.141087-.29981.207222-.476169.198404s-.326264-.074953-.449715-.198404l-2.222122-2.222122c-.246902-.282174-.370354-.555531-.370354-.820069v-13.09465c-1.622502-.634892-2.923149-1.662183-3.901941-3.081872s-1.468188-3.028965-1.468188-4.827826c0-1.551959.374763-2.96283,1.124288-4.232614s1.763589-2.283848,3.042191-3.042191,2.702701-1.137515,4.272295-1.137515ZM51.112898,33.158524c-.723072,0-1.335919.251311-1.838542.753934s-.753934,1.106652-.753934,1.812088c0,.723072.25572,1.340328.767161,1.851769s1.119879.767161,1.825315.767161,1.309465-.25572,1.812088-.767161.753934-1.128697.753934-1.851769c0-.705436-.251311-1.309465-.753934-1.812088s-1.106652-.753934-1.812088-.753934Z"/>');
	if ($passwordlessAvailable) {
		$passkeySignIn->AddButton(new SignInOptionButton('add-passkey', 'Add Passkey'));
		foreach ($passkeys as $passkey) {
			$passkeyRow = new SignInOptionRow($passkey->Name());
			$passkeyRemoveButton = new SignInOptionButton('remove-passkey-' . $passkey->CredentialId(), 'Remove Passkey', 'red passkey-remove-button');
			$passkeyRemoveButton->SetAttribute('beacon-passkey-id', $passkey->CredentialId());
			$passkeyRow->AddButton($passkeyRemoveButton);
			$passkeySignIn->AddRow($passkeyRow);
		}
		$passkeySignIn->AddTag('Checking browser support…');
	} else {
		$passkeySignIn->AddTag('Switch to standard or enhanced security to use passkeys');
	}
	$signInOptions[] = $passkeySignIn;
}

?><div class="visual-group">
	<h3>Sign In Options</h3>
	<div class="notice-lighter m-4 p-3 accent">Instead of giving someone access to your account, see &quot;<a href="https://help.usebeacon.app/core/sharing/" target="_blank">Sharing Beacon Projects With Other Users</a>&quot; if you need to share projects with another user.</div>
	<?php foreach ($signInOptions as $option) { ?><div class="sign-in-option <?php if ($option->Enabled() === false) { echo 'sign-in-option-unavailable'; } ?>" id="sign-in-option-<?php echo htmlentities($option->OptionId()); ?>">
		<div class="sign-in-option-icon"><svg id="a" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><?php echo $option->SVG(); ?></svg></div>
		<div class="sign-in-option-rows">
			<div class="sign-in-option-row">
				<div class="sign-in-option-content">
					<div class="sign-in-option-title"><?php echo htmlentities($option->Title()); ?></div>
					<?php if ($option->HasTags()) { ?><div class="sign-in-option-tags"><?php foreach ($option->Tags() as $tag) { ?><span class="sign-in-option-tag"><?php echo htmlentities($tag); ?></span><?php } ?></div><?php } ?>
				</div>
				<?php if ($option->HasButtons()) { ?><div class="sign-in-option-buttons">
					<?php foreach ($option->Buttons() as $button) {
						echo $button->RenderHtml();
					} ?>
				</div><?php } ?>
			</div>
			<?php if ($option->HasRows()) { ?><?php foreach ($option->Rows() as $row) { ?><div class="sign-in-option-row">
				<div class="sign-in-option-content"><?php echo htmlentities($row->Text()); ?></div>
				<?php if ($row->HasButtons()) { ?><div class="sign-in-option-buttons">
					<?php foreach ($row->Buttons() as $button) {
						echo $button->RenderHtml();
					} ?>
				</div><?php } ?>
			</div>
			<?php } ?><?php } ?>
		</div>
	</div><?php } ?>
</div>
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
						<p><label for="security_model_enhanced">Enhanced</label><span class="tag green">High Security</span></p>
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
		<p class="text-right"><input type="submit" id="security_model_save_button" value="Save Security Model" disabled></p>
	</form>
</div><?php } ?>
<?php BeaconTemplate::StartModal('password-change-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Set Account Password</div>
	<div class="content">
		<form id="change_password_form" action="" method="post">
			<?php if ($hasPassword) { ?><div class="floating-label">
				<input type="password" class="text-field" id="password_current_field" placeholder="Current Password" autocomplete="current-password">
				<label for="password_current_field">Current Password</label>
			</div><?php } ?>
			<div class="floating-label">
				<input type="password" class="text-field" id="password_initial_field" placeholder="New Password" minlength="8" autocomplete="new-password">
				<label for="password_initial_field">New Password</label>
			</div>
			<div class="floating-label">
				<input type="password" class="text-field" id="password_confirm_field" placeholder="Confirm New Password" minlength="8" autocomplete="new-password">
				<label for="password_confirm_field">Confirm New Password</label>
			</div>
			<?php if ($hasAuthenticators) { ?>
			<div class="floating-label">
				<input type="text" class="text-field" id="password_auth_field" placeholder="Two Step Code">
				<label for="password_auth_field">Two Step Code</label>
			</div>
			<?php } ?>
		</form>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="password-change-cancel-button">Cancel</button>
				<button id="password-change-action-button" class="default" disabled>Change Password</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
<?php if ($hasAuthenticators) { ?>
<?php BeaconTemplate::StartModal('manage-backup-codes-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Backup Codes</div>
	<div class="content">
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
	</div>
	<div class="button-bar">
		<div class="left">
			<div class="button-group">
				<button id="replace-backup-codes-button" class="yellow">Replace Backup Codes</button>
			</div>
		</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="backup-codes-action-button" class="default">Done</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
<?php } ?>
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
				<input type="text" class="text-field" id="add-authenticator-password-field" placeholder="Other Authenticator Code" autocomplete="one-time-code" value="">
				<label for="add-authenticator-password-field">Other Authenticator Code</label>
			</div>
			<?php } else { ?>
			<div class="floating-label">
				<input type="password" class="text-field" id="add-authenticator-password-field" placeholder="Account Password" autocomplete="current-password" value="">
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
<?php if ($securityModelsEnabled) { ?>
<?php BeaconTemplate::StartModal('security-model-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Change Security Model</div>
	<div id="security-model-content" class="content">
		<p class="notice-block notice-warning hidden" id="security-model-error-message"></p>
		<?php if ($hasPassword) { ?>
		<div class="floating-label">
			<input type="password" class="text-field" id="security-model-password-field" placeholder="Account Password" value="" autocomplete="current-password">
			<label for="security-model-password-field">Account Password</label>
		</div>
		<?php } ?>
		<?php if ($securityModel === User::SecurityModelEnhanced) { ?>
		<div class="floating-label">
			<input type="password" class="text-field" id="security-model-secret-field" placeholder="Account Secret" value="" autocomplete="off">
			<label for="security-model-secret-field">Account Secret</label>
		</div>
		<?php } ?>
		<?php if ($hasAuthenticators) { ?>
		<div class="floating-label">
			<input type="text" class="text-field" id="security-model-totp-field" placeholder="Authenticator Code" value="" autocomplete="one-time-code">
			<label for="security-model-totp-field">Authenticator Code</label>
		</div>
		<?php } ?>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="security-model-cancel-button">Cancel</button>
				<button id="security-model-action-button" class="default" disabled>Continue</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
<?php BeaconTemplate::StartModal('account-secret-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Your Account Secret</div>
	<div id="account-secret-content" class="content">
		<p>Here is your new account secret. <span class="bold text-red">You must save this secret. If it is lost, your account's private data is lost with it.</span> You will also need this secret to change security models.</p>
		<p class="text-red bold">This secret cannot be shown again.</p>
		<div class="floating-label">
			<input type="text" class="text-field" id="account-secret-field" value="" readonly>
			<label for="account-secret-field">Account Secret</label>
			<button class="blue" id="account-secret-copy-button">Copy</button>
		</div>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="account-secret-action-button" class="default" disabled>I Have Copied My Secret</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
<?php } ?>
