<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconTemplate::SetTitle('Thanks for purchasing!');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));

$sessionId = $_GET['session'] ?? '';
$session = null;
if (empty($sessionId) === false) {
	$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	$session = $api->GetCheckoutSession($sessionId);
}
if (is_null($session)) {
	?><div id="purchase_unknown" class="welcome_content">
		<p>Your purchase status cannot be retrieved. Maybe your browser is blocking cookies. Maybe you're visiting this page from a different browser than the one you purchased with. Or maybe something has simply gone wrong.</p>
		<p>Don't worry though, your purchase will still be completed normally. After you receive your receipt via email, sign into Beacon using the same email address that was used for the purchase, and Beacon Omni should be activated. If not, it means Stripe hasn't yet sent over purchase details, so wait a few minutes then relaunch Beacon.</p>
	</div><?php
	exit;
}

$metadata = $session['metadata'];
$hasProductMetadata = BeaconCommon::HasAnyKeys($metadata, 'beacon-has-sentinel', 'beacon-has-omni');
if ($hasProductMetadata) {
	$hasOmni = filter_var($metadata['beacon-has-omni'] ?? '', FILTER_VALIDATE_BOOLEAN);
	$hasSentinel = filter_var($metadata['beacon-has-sentinel'] ?? '', FILTER_VALIDATE_BOOLEAN);
} else {
	$hasOmni = true;
	$hasSentinel = false;
}

$email = $session['customer_details']['email'];
$user = BeaconAPI\v4\User::Fetch($email);
if (is_null($user)) {
	$userMessage = "You will need to create an account with {$email} to use your purchase. A setup link was emailed to you already.";
} else {
	$userMessage = "Your purchase is ready on your {$user->Username(true)} ({$email}) account.";
}

$buttons = [];
if ($hasOmni) {
	$buttons['Launch Beacon'] = 'beacon://action/refreshuser?silent=false';
}
if ($hasSentinel) {
	$sentinelUrl = '/welcome?email=' . urlencode($email);
	if (is_null($user) === false) {
		$sentinelUrl .= '&user_id=' . urlencode($user->UserId()) . '&username=' . urlencode($user->Username(true));
	}
	$sentinelUrl = BeaconCommon::SentinelUrl($sentinelUrl);
	if ($hasOmni === false) {
		// No good reason to show the buttons
		BeaconCommon::Redirect($sentinelUrl);
	}
	$buttons['Go To Sentinel'] = $sentinelUrl;
}

?><div id="purchase_confirmed" class="welcome_content">
	<p class="confirmed_text"><?php echo htmlentities($userMessage); ?></p>
	<p>You will need to sign into your account using the instructions below if you are not already signed in. If you made a mistake with your purchase, please do not purchase again. <a href="/help/contact">Open a support ticket</a> so the mistake can be corrected.</p>
</div>
<?php
if (count($buttons) > 0) {
	echo '<p class="text-center">';
	foreach ($buttons as $caption => $url) {
		echo '<a href="' . htmlentities($url) . '" class="button default">' . htmlentities($caption) . '</a>';
	}
	echo '</p>';
}
if ($hasOmni) { ?>
<div id="signin_instructions" class="welcome_content">
	<h3>How to sign into Beacon</h3>
	<?php include('instructions.php'); ?>
</div>
<?php } ?>

