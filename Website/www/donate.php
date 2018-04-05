<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
require($_SERVER['FRAMEWORK_DIR'] . '/stripe/init.php');
BeaconTemplate::AddStylesheet('/assets/css/donate.css');

if (isset($_POST['token']) && isset($_POST['amount']) && isset($_POST['email'])) {
	$token = $_POST['token'];
	$amount = $_POST['amount'];
	$email = $_POST['email'];
	
	\Stripe\Stripe::setApiKey(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	try {
		$customer = \Stripe\Customer::create(array(
		  'email' => $email,
		  'source'  => $token
		));
	
		$charge = \Stripe\Charge::create(array(
		  'customer' => $customer->id,
		  'amount'   => $amount,
		  'currency' => 'usd'
		));
	} catch (Exception $e) {
		trigger_error('Unable to charge card', E_USER_ERROR);
	}
	
	BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/donate.php?donated=true'));
	
	exit;
} elseif (isset($_GET['donated'])) {
	BeaconTemplate::SetTitle('Thanks for your contribution!');
	echo '<h1>Thanks for your contribution!</h1>';
	echo '<p class="text-center">Seriously, Beacon is a hobby project. It costs money to develop and run this server, so any contribution helps to keep the lights on.</p>';
	exit;
}

BeaconTemplate::AddHeaderLine('<script src="/assets/scripts/donate.js"></script>');
BeaconTemplate::AddHeaderLine('<script src="https://checkout.stripe.com/checkout.js"></script>');
BeaconTemplate::SetTitle('Make a Donation');

?><h1>Make a Donation</h1>
<p>Three options for supporting the project:</p>
<div class="triple_column">
	<div class="column text-center">
		<p><a href="https://www.patreon.com/thommcgrath"><img src="/assets/images/patreon-color.svg" height="50"></a></p>
		<p>Make a monthly donation of any amount with rewards in coming in the future.</p>
		<p><a href="https://www.patreon.com/thommcgrath" class="button">Become a Patron</a></p>
	</div>
	<div class="column text-center">
		<p><img src="/assets/images/stripe-color.svg" height="50"></p><p>Make a fast and easy one-time donation of any amount using a credit card.</p>
		<p><input id="stripe_amount_field" type="text" placeholder="Amount" name="amount"><br><button id="stripe_donate_button">Make a Donation</button></p>
		<form id="stripe_checkout_form" action="" method="POST">
			<input type="hidden" name="stripe_key" id="stripe_public_key" value="<?php echo BeaconCommon::GetGlobal('Stripe_Public_Key'); ?>">
			<input type="hidden" name="token" id="stripe_token_field" value="">
			<input type="hidden" name="email" id="stripe_email_field" value="">
			<input type="hidden" name="amount" id="stripe_confirmed_amount_field" value="">
		</form>
	</div>
	<div class="column text-center">
		<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZX4EE4YTSP9LS"><img src="/assets/images/paypal-color.svg" height="50"></a></p>
		<p>Make a one-time or monthly donation of any amount using a PayPal account or credit card.</p>
		<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZX4EE4YTSP9LS" class="button">Make a Donation</a></p>
	</div>
</div>