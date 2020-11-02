<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTemplate('welcome');

$login_only = isset($_GET['login_only']) ? (strtolower($_GET['login_only']) == 'true') : false;

?>
<div id="branding_section">
	<img id="branding_logo" src="/assets/images/beacon-color.svg" width="128">
	<h1 id="branding_title">Welcome to Beacon</h1>
</div>
<?php if (!$login_only) { ?>
<div id="page_intro">
	<p class="explanation">Beacon stores fully anonymous user data to provide community document sharing and cloud storage features.<br><a href="/privacy">See how Beacon manages your data&hellip;</a></p>
	<div id="welcome_choices">
		<p><button id="intro_continue_button" class="default">Continue</button></p>
		<p><button id="intro_login_button">Log In With Email</button></p>
		<p><button id="intro_decline_button">Disable Cloud &amp; Community Features</button></p>
	</div>
</div>
<?php } ?>
<?php
	$login = new BeaconLogin();
	$login->with_remember_me = false;
	$login->with_login_cancel = true;
	$login->session_consumer_uri = 'beacon://set_user_token?token={{session_id}}&password={{user_password}}';
	$login->Show();
?>