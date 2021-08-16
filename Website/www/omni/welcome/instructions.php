<?php

$stable_version = BeaconCommon::MinVersion();
$suffix = $stable_version >= 10500300 ? '_15' : '';
BeaconTemplate::StartStyles(); ?>
<style>

.signin_step+.signin_step {
	margin-top: 20px;
	border-top-width: 1px;
	border-top-style: solid;
	padding-top: 20px;
}

.signin_text {
	padding-left: 170px;
}

.img_signin {
	border-width: 1px;
	border-style: solid;
	background-size: 100%;
	float: left;
	background-color: rgba(255, 255, 255, 0.05);
}

#img_signin_menu {
	background-image: url(/omni/welcome/menu<?php echo $suffix; ?>.png);
	width: 150px;
	height: 118px;
}

#img_signin_link {
	background-image: url(/omni/welcome/signin<?php echo $suffix; ?>.png);
	width: 150px;
	height: 59px;
}

#img_signin_enable {
	background-image: url(/omni/welcome/enable_cloud<?php echo $suffix; ?>.png);
	width: 150px;
	height: 59px;
	clear: left;
	margin-top: 6px;
}

#img_signin_options {
	background-image: url(/omni/welcome/options<?php echo $suffix; ?>.png);
	width: 150px;
	height: 59px;
}

#img_signin_fields {
	background-image: url(/omni/welcome/fields<?php echo $suffix; ?>.png);
	width: 150px;
	height: 59px;
	clear: left;
	margin-top: 6px;
}

@media (-webkit-min-device-pixel-ratio: 1.5), (min-resolution: 144dpi) {
	#img_signin_menu {
		background-image: url(/omni/welcome/menu<?php echo $suffix; ?>@2x.png);
	}
	
	#img_signin_options {
		background-image: url(/omni/welcome/options<?php echo $suffix; ?>@2x.png);
	}
	
	#img_signin_fields {
		background-image: url(/omni/welcome/fields<?php echo $suffix; ?>@2x.png);
	}
}

</style><?php
BeaconTemplate::FinishStyles();

?><div class="signin_step separator-color">
	<div id="img_signin_menu" class="img_signin separator-color">&nbsp;</div>
	<div class="signin_text">
		<h4>Open the menu</h4>
		<p>Click the user icon in the top right corner of Beacon, as shown here.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
<div class="signin_step separator-color">
	<div id="img_signin_link" class="img_signin separator-color">&nbsp;</div>
	<div id="img_signin_enable" class="img_signin separator-color">&nbsp;</div>
	<div class="signin_text">
		<h4>Click the &quot;Sign In&quot; link</h4>
		<p>If you see &quot;Enable Cloud &amp; Community&quot; instead, click that one.</p>
		<p>If you see your username, you're already signed in! Relaunch Beacon to activate Omni. Or you can click &quot;Sign Out&quot; if you see a different email address.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
<div class="signin_step separator-color">
	<div id="img_signin_options" class="img_signin separator-color">&nbsp;</div>
	<div id="img_signin_fields" class="img_signin separator-color">&nbsp;</div>
	<div class="signin_text">
		<h4>Login or create your account</h4>
		<p>Click &quot;Login with Email&quot; if given the option, which will display the login form. Otherwise Beacon will bring you directly to the form.</p>
		<p>Enter your email address and password, or click &quot;Create or Recover Account&quot; to setup a password. Follow the steps in Beacon.</p>
	</div>
	<div class="push">&nbsp;</div>
</div>
