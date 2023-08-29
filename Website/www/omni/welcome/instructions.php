<?php

$newInstructions = false;
$newestVersion = \BeaconCommon::NewestVersionForStage(3);
if ($newestVersion > 20000000) {
	$newInstructions = true;
} elseif (isset($user)) {
	$sessions = BeaconAPI\v4\Session::Search(['userId' => $user->UserId(), 'applicationId' => '9f823fcf-eb7a-41c0-9e4b-db8ed4396f80'], true);
	$newInstructions = count($sessions) > 0;
}
	
if ($newInstructions) {
	?><div class="signin_step separator-color">
		<div class="signin_flex">
			<div class="signin_flex-images">
				<img class="separator-color" src="/omni/welcome/menu_20.png" srcset="/omni/welcome/menu_20.png, /omni/welcome/menu_20@2x.png 2x" width="225" height="100" alt="">
			</div>
			<div class="signin_flex-text">
				<h4>Open the menu</h4>
				<p>Click the user icon in the top right corner of Beacon, as shown here.</p>
			</div>
		</div>
	</div>
	<div class="signin_step separator-color">
		<div class="signin_flex">
			<div class="signin_flex-images">
				<img class="separator-color" src="/omni/welcome/signin_20.png" srcset="/omni/welcome/signin_20.png, /omni/welcome/signin_20@2x.png 2x" width="225" height="186" alt="">
			</div>
			<div class="signin_flex-text">
				<h4>If you see your username at the top of the menu:</h4>
				<p>You're already signed in! Choose &quot;Refresh Purchases&quot; to load the latest information.</p>
				<h4>If you see an Anonymous username at the top of the menu:</h4>
				<p>Choose the &quot;Change Account&quot; option to sign in.</p>
				<p>Also use this option if you see the wrong username at the top of the menu.</p>
			</div>
		</div>
		<div class="signin_flex">
			<div class="signin_flex-images">
				<img class="separator-color" src="/omni/welcome/enable_cloud_20.png" srcset="/omni/welcome/enable_cloud_20.png, /omni/welcome/enable_cloud_20@2x.png 2x" width="225" height="76" alt="">
			</div>
			<div class="signin_flex-text">
				<h4>If you see &quot;Enable Cloud &amp; Community&quot; instead:</h4>
				<p>Your cloud features are turned off. Choose &quot;Enable Cloud &amp; Community&quot; to turn them on and sign in.</p>
			</div>
		</div>
	</div>
	<div class="signin_step separator-color">
		<div class="signin_flex">
			<div class="signin_flex-images">
				<img class="separator-color" src="/omni/welcome/options_20.png" srcset="/omni/welcome/options_20.png, /omni/welcome/options_20@2x.png 2x" width="225" height="100" alt="">
			</div>
			<div class="signin_flex-text">
				<h4>Login or create your account</h4>
				<p>Click &quot;Use a Beacon Account&quot; which will display the login form the login form does not show on its own.</p>
				<p>Enter your email address and password, or click &quot;Create or Recover Account&quot; to setup a password. Follow the steps in Beacon.</p>
			</div>
		</div>
	</div><?php
	return;
}

?><div class="signin_step separator-color">
	<div id="img_signin_menu" class="img_signin separator-color"><img src="/omni/welcome/menu_15.png" srcset="/omni/welcome/menu_15.png, /omni/welcome/menu_15@2x.png 2x" width="150" height="118" alt=""></div>
	<div class="signin_text">
		<h4>Open the menu</h4>
		<p>Click the user icon in the top right corner of Beacon, as shown here.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
<div class="signin_step separator-color">
	<div id="img_signin_link" class="img_signin separator-color"><img src="/omni/welcome/signin_15.png" width="150" height="59" alt=""></div>
	<div id="img_signin_enable" class="img_signin separator-color"><img src="/omni/welcome/enable_cloud_15.png" width="150" height="59" alt=""></div>
	<div class="signin_text">
		<h4>Click the &quot;Sign In&quot; link</h4>
		<p>If you see &quot;Enable Cloud &amp; Community&quot; instead, click that one.</p>
		<p>If you see your username, you're already signed in! Relaunch Beacon to activate Omni. Or you can click &quot;Sign Out&quot; if you see a different email address.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
<div class="signin_step separator-color">
	<div id="img_signin_options" class="img_signin separator-color"><img src="/omni/welcome/options_15.png" srcset="/omni/welcome/options_15.png, /omni/welcome/options_15@2x.png 2x" width="150" height="59" alt=""></div>
	<div id="img_signin_fields" class="img_signin separator-color"><img src="/omni/welcome/fields_15.png" srcset="/omni/welcome/fields_15.png, /omni/welcome/fields_15@2x.png 2x" width="150" height="59" alt=""></div>
	<div class="signin_text">
		<h4>Login or create your account</h4>
		<p>Click &quot;Login with Email&quot; if given the option, which will display the login form. Otherwise Beacon will bring you directly to the form.</p>
		<p>Enter your email address and password, or click &quot;Create or Recover Account&quot; to setup a password. Follow the steps in Beacon.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
