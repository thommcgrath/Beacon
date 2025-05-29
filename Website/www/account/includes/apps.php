<?php

use BeaconAPI\v4\{Application, Core};

if ($user->Is2FAProtected() === false) {
	echo '<p>Your account must be protected by two step authentication to register for an API key. See the Authenticators section of the <a href="#security">Security</a> tab to set up two step authentication.</p>';
	exit;
}

?><div class="visual-group">
	<h3>Beacon Applications</h3>
	<p>Developers, register for Beacon API access here.</p>
	<?php

	$apps = Application::Search(['userId' => $user->UserId()], true);
	if (count($apps) > 0) {
		echo '<table class="generic">';
		echo '<thead>';
		echo '<tr><th class="w-0">&nbsp;</th><th class="w-50">App Name</th><th class="w-50">Client Id</th><th class="w-0">&nbsp;</th></tr>';
		echo '</thead>';
		echo '<tbody>';

		foreach ($apps as $app) {
			echo '<tr><td>' . $app->IconHtml(32) . '</td><td>' . htmlentities($app->Name()) . '</td><td>' . htmlentities($app->ApplicationId()) . '</td><td class="nowrap"><button class="apps-edit-button" beacon-app-id="' . htmlentities($app->ApplicationId()) . '">Edit</button><button class="apps-delete-button red" beacon-app-id="' . htmlentities($app->ApplicationId()) . '">Delete</button></td></tr>';
		}

		echo '</tbody>';
		echo '</table>';

		echo '<p class="text-right"><button class="blue" id="apps-create-button">Add Application</button></p>';
	} else {
		echo '<p class="text-center"><button class="blue" id="apps-create-button">Add Application</button></p>';
	}

	?>
</div>
<?php BeaconTemplate::StartModal('app-editor-modal'); ?>
<div class="modal-content">
	<div class="title-bar">Application Details</div>
	<div id="app-editor-content" class="content">
		<div class="visual-group">
			<h3>Identity</h3>
			<p>These values are displayed to users before they approve your login request.</p>
			<div class="floating-label">
				<input type="text" class="text-field" id="app-editor-name-field" placeholder="Application Name">
				<label for="app-editor-name-field">Application Name</label>
			</div>
			<div class="floating-label">
				<input type="text" class="text-field" id="app-editor-website-field" placeholder="Website">
				<label for="app-editor-website-field">Website</label>
			</div>
			<div class="app-avatar-picker">
				<div><img class="avatar" src="https://assets.usebeacon.app/images/avatars/default/64px.png" srcset="https://assets.usebeacon.app/images/avatars/default/64px.png, https://assets.usebeacon.app/images/avatars/default/128px.png 2x, https://assets.usebeacon.app/images/avatars/default/256px.png 3x" width="64" height="64" alt="" id="app-editor-icon-cell" /></div>
				<div><button id="app-editor-icon-choose-button">Choose Icon</button><input type="file" id="app-editor-icon-chooser" class="hidden" accept=".png,.jpg,.jpeg,.gif,.psd,.tiff,.tif,.webp" /></div>
				<div id="app-editor-icon-disclaimer" class="hidden">This is just a preview. The final image will receive additional processing once saved.</div>
			</div>
		</div>
		<div class="visual-group" id="app-editor-security-group">
			<h3>Security Level</h3>
			<p>To increase security, you can require your application to use a secret. This is known as an <a href="https://oauth.net/2/client-types/" target="_blank">OAuth confidential client</a>. Examples of confidential clients include closed-source server-generated websites and Discord bots. However, mobile apps, desktop apps, open source projects, and client-side or single-page websites are not confidential clients because the secret would need to be included in the code that is shipped to end users. The Beacon app and the Beacon Sentinel website, for example, are not confidential clients.</p>
			<p><label class="checkbox"><input type="checkbox" name="confidential" value="true" id="app-editor-confidential-check"><span></span>This application is a confidential client</label></p>
			<p id="app-editor-secret-hint" class="italic hidden">Once this application is registered, your secret will be generated and provided. This secret cannot be retrieved in the future, so be prepared to store it securely, such as in a password manager.</p>
		</div>
		<div class="visual-group">
			<h3>Features</h3>
			<p>These switches determine which Beacon API features your application will have access to. Respect the principle of least privilege; an application should only request access to the features it needs. These features are displayed to users when they approve a login request. You can modify these features after registering your application. However, adding new features requires users to log in again before the new features become active for them.</p>
			<p>Global data, such as game and project data, is always available.</p>
			<ul class="app-editor-scopes-picker">
				<li><label class="checkbox"><input type="checkbox" value="<?php echo htmlentities(Application::kScopeUsersRead); ?>" id="app-editor-scope-users-read" class="app-scope-checkbox"><span></span>Read User Identity</label><br /><span class="app-editor-feature-description">Allows your application to read user identity data. Most applications need this scope.</span></li>
				<li><label class="checkbox"><input type="checkbox" value="<?php echo htmlentities(Application::kScopeSentinelRead); ?>" id="app-editor-scope-sentinel-read" class="app-scope-checkbox"><span></span>Read Sentinel Data</label><br /><span class="app-editor-feature-description">Allows your application to read data from Beacon Sentinel.</span></li>
				<li><label class="checkbox"><input type="checkbox" value="<?php echo htmlentities(Application::kScopeSentinelWrite); ?>" id="app-editor-scope-sentinel-write" class="app-scope-checkbox"><span></span>Change Sentinel Data</label><br /><span class="app-editor-feature-description">Allows your application to change Beacon Sentinel data, such as adding servers, groups, and scripts.</span></li>
				<li><label class="checkbox"><input type="checkbox" value="<?php echo htmlentities(Application::kScopeUsersUpdate); ?>" id="app-editor-scope-users-write" class="app-scope-checkbox"><span></span>Change User Identity</label><span class="tag yellow">Restricted</span><br /><span class="app-editor-feature-description">Allows your application to change user identity data, such as username.</span></li>
				<li><label class="checkbox"><input type="checkbox" value="<?php echo htmlentities(Application::kScopeUsersPrivateKeyRead); ?>" id="app-editor-scope-users-private-key" class="app-scope-checkbox"><span></span>Retrieve User Private Key</label><span class="tag yellow">Restricted</span><br /><span class="app-editor-feature-description">Allows your application to receive the user&apos;s private key, which is needed for accessing protected project parts and cloud files.</span></li>
			</ul>
			<p><span class="tag yellow mr-1">Restricted</span>features require approval. If you need these features, save your application without them, then contact customer service.</p>
		</div>
		<div class="visual-group">
			<h3>Callback URLs</h3>
			<p>The user will be directed to a URL under your control to deliver authentication information. List one or more URLs here, separated by newlines or returns. When initiating a login request, your code will specify one of these URLs. All URLs must start with &apos;https://&apos;.</p>
			<div class="floating-label"><textarea id="app-editor-callbacks-field" class="text-field" placeholder="Callback URLs" rows="4"></textarea><label for="app-editor-callbacks-field">Callback URLs</label></div>
		</div>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="app-editor-cancel-button">Cancel</button>
				<button id="app-editor-action-button" class="default">Add</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
