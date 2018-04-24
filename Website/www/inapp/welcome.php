<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Welcome to Beacon</title>
		<meta name="viewport" content="width=400">
		<link href="/assets/css/main.css" rel="stylesheet" media="all" type="text/css">
		<link href="/inapp/welcome.css" rel="stylesheet" media="all" type="text/css">
		<script src="/inapp/welcome.js"></script>
	</head>
	<body>
		<div id="branding_section">
			<img id="branding_logo" src="/assets/images/beacon-color.svg" width="128">
			<h1 id="branding_title">Welcome to Beacon</h1>
		</div>
		<div id="page_intro">
			<p class="explanation">Beacon stores fully anonymous user data to provide community document sharing and cloud storage features.<br><a href="/privacy.php">See how Beacon manages your data&hellip;</a></p>
			<div id="welcome_choices">
				<p><button id="welcome_continue_button" class="primary_button">Continue</button></p>
				<p><button id="welcome_login_button">Log In With Email</button></p>
				<p><button id="welcome_decline_button">Disable Cloud &amp; Community Features</button></p>
			</div>
		</div>
		<div id="page_login">
			<p class="explanation">Use a Beacon account to access your Beacon Cloud data on multiple devices.</p>
			<form id="login_form">
				<p><input type="email" id="login_email_field" placeholder="Email" required></p>
				<p><input type="password" id="login_password_field" placeholder="Password" minlength="8" title="Enter a password with at least 8 characters" required></p>
				<p><input type="submit" id="login_action_button" value="Log In"></p>
			</form>
			<p><button id="login_recover_button">Create or Recover Beacon Account</button></p>
			<p><button id="login_cancel_button">Cancel</button></p>
		</div>
		<div id="page_recover">
			<p class="explanation">To create a new Beacon Account or recover an existing Beacon Account, enter your email address.</p>
			<form id="recover_form">
				<p><input type="email" id="recover_email_field" placeholder="Email" required></p>
				<p><input type="submit" id="recover_action_button" value="Continue"></p>
			</form>
			<p><button id="recover_cancel_button">Cancel</button></p>
		</div>
		<div id="page_verify">
			<p class="explanation">Check your email. Enter the code you were sent to continue.</p>
			<form id="verify_form">
				<p><input type="hidden" id="verify_email_field" value=""><input type="text" id="verify_code_field" placeholder="Code" required></p>
				<p><input type="submit" id="verify_action_button" value="Continue"></p>
			</form>
			<p><button id="verify_cancel_button">Cancel</button></p>
		</div>
		<div id="page_password">
			<p class="explanation">Time to choose a password. Your password must be at least 8 characters long, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
			<form id="password_form">
				<p><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""><input type="password" id="password_initial_field" placeholder="Password" minlength="8"></p>
				<p><input type="password" id="password_confirm_field" placeholder="Password Again" minlength="8"></p>
				<p><input type="submit" id="password_action_button" value="Finish"></p>
			</form>
			<p><button id="password_cancel_button">Cancel</button></p>
		</div>
		<div id="page_loading">
			<p><img id="loading_spinner" src="/assets/images/spinner.svg" width="64"></p>
		</div>
		<div id="overlay"></div>
		<div id="dialog">
			<p id="dialog_message">Message</p>
			<p id="dialog_explanation">Explanation</p>
			<p id="dialog_buttons"><button id="dialog_action_button">Ok</button></p>
		</div>
	</body>
</html>