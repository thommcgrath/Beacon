<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconTemplate::SetTitle('Thanks for purchasing!');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('checkout-welcome.js'));

?><h1 class="text-center">Thanks for purchasing Beacon Omni!</h1>
<div id="checking_container" class="welcome_content">
	<p><img src="<?php echo BeaconCommon::AssetURI('spinner.svg'); ?>" width="64" height="64" id="checking_spinner"></p>
	<p><span id="checking_text">Checking purchase status&hellip;</span><span id="checking_subtext"></span></p>
</div>
<div id="purchase_confirmed" class="welcome_content">
	<p id="confirmed_text"></p>
	<p class="text-center"><a href="" id="activate_button" class="button blue">Activate Omni</a>
	<p class="text-lighter smaller text-center">If there is a mistake with your purchase, please do not purchase again. <a href="/help/contact">Open a support ticket</a> so the mistake can be corrected.</p>
</div>
<div id="purchase_unknown" class="welcome_content">
	<p>Your purchase status cannot be retrieved. Maybe your browser is blocking cookies. Maybe you're visiting this page from a different browser than the one you purchased with. Or maybe something has simply gone wrong.</p>
	<p>Don't worry though, your purchase will still be completed normally. After you receive your receipt via email, sign into Beacon using the same email address that was used for the purchase, and Beacon Omni should be activated. If not, it means Stripe hasn't yet sent over purchase details, so wait a few minutes then relaunch Beacon.</p>
</div>
<div id="purchase_delayed" class="welcome_content">
	<p>This is unusual, but Stripe has not sent over purchase details yet. Unfortunately, the only option is to wait.</p>
	<p>In the meantime, follow the instructions below to sign into Beacon. Once Omni has been activated for your account, you'll only need to restart Beacon to use it.</p>
	<p>You can safely leave this page at any time, your purchase will still be completed.</p>
</div>
<div id="signin_instructions" class="welcome_content">
	<h3>How to sign into Beacon</h3>
	<?php include('instructions.php'); ?>
</div>