<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Account Login</title>
		<link href="/assets/css/main.css" rel="stylesheet" media="all" type="text/css">
		<link href="/assets/css/login.css" rel="stylesheet" media="all" type="text/css">
		<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicon/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon/favicon-16x16.png">
		<link rel="manifest" href="/assets/favicon/manifest.json">
		<link rel="mask-icon" href="/assets/favicon/safari-pinned-tab.svg" color="#713a9a">
		<link rel="shortcut icon" href="/assets/favicon/favicon.ico">
		<link rel="alternate" type="application/json" title="Beacon Developer Blog" href="/blog/json.php">
		<link rel="alternate" type="application/rss+xml" title="Beacon Developer Blog" href="/blog/rss.php">
		<link rel="search" type="application/opensearchdescription+xml" href="/search/opensearch.php" title="Beacon Search">
		<meta name="apple-mobile-web-app-title" content="Beacon">
		<meta name="application-name" content="Beacon">
		<meta name="msapplication-config" content="/assets/favicon/browserconfig.xml">
		<meta name="theme-color" content="#713a9a">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script src="/assets/scripts/main.js"></script>
		<script src="/assets/scripts/login.js"></script>
	</head>
	<body>
		<div id="site_wrapper">
			<div id="main">
				<div id="login_header"><img src="/assets/images/beacon-white.svg" width="100" id="login_logo"></div>
				<div id="login_container">
					<div id="login_page_intro">
						<form action="" method="post" id="login_form_intro">
							<p><input type="email" id="login_email_field" placeholder="Email" required></p>
							<p><input type="password" id="login_password_field" placeholder="Password" minlength="8" title="Enter a password with at least 8 characters" required></p>
							<p><input type="submit" id="login_action_button" value="Log In"><input type="hidden" name="return" value="<?php echo htmlentities($_SERVER['REQUEST_URI']); ?>" id="login_return_field"></p>
						</form>
						<p class="smaller"><a href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>" id="login_recover_button">Create or recover account</a></p>
					</div>
					<div id="login_page_loading">
						<p><img id="loading_spinner" src="/assets/images/spinner-white.svg" width="64"></p>
					</div>
					<div id="login_page_recover">
						<p class="explanation">To create a new Beacon Account or recover an existing Beacon Account, enter your email address.</p>
						<form id="login_recover_form">
							<p><input type="email" id="recover_email_field" placeholder="Email" required></p>
							<p><a id="recover_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a><input type="submit" id="recover_action_button" value="Continue"></p>
						</form>
					</div>
					<div id="login_page_verify">
						<p class="explanation">Check your email. Enter the code you were sent to continue.</p>
						<form id="login_verify_form">
							<p><input type="hidden" id="verify_email_field" value=""><input type="text" id="verify_code_field" placeholder="Code" required></p>
							<p><a id="verify_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a><input type="submit" id="verify_action_button" value="Continue"></p>
						</form>
					</div>
					<div id="login_page_password">
						<p class="explanation">Time to choose a password. Your password must be at least 8 characters long, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better.</p>
						<form id="login_password_form">
							<p><input type="hidden" id="password_email_field" value=""><input type="hidden" id="password_code_field" value=""><input type="password" id="password_initial_field" placeholder="Password" minlength="8"></p>
							<p><input type="password" id="password_confirm_field" placeholder="Password Again" minlength="8"></p>
							<p><a id="password_cancel_button" class="button" href="#<?php echo BeaconCommon::GenerateRandomKey(6); ?>">Cancel</a><input type="submit" id="password_action_button" value="Finish"></p>
						</form>
					</div>
				</div>
				<footer class="inner">
					<p><a id="footer_github_logo" href="https://github.com/thommcgrath/Beacon" title="GitHub"><img height="24" src="/assets/images/github-white.svg"></a><a id="footer_patreon_logo" href="https://www.patreon.com/thommcgrath" title="Patreon"><img height="24" src="/assets/images/patreon-white.svg"></a><a id="footer_discord_logo" href="/discord.php" title="Discord"><img height="24" src="/assets/images/discord-white.svg"></a></p>
					<p>Beacon is an open source project by Thom McGrath. Copyright 2016-<?php echo date('Y'); ?>.</p>
					<p>Get in touch using <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
				</footer>
				<div id="overlay"></div>
				<div id="dialog">
					<p id="dialog_message">Message</p>
					<p id="dialog_explanation">Explanation</p>
					<p id="dialog_buttons"><button id="dialog_action_button">Ok</button></p>
				</div>
			</div>
		</div>
	</body>
</html>