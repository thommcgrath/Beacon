<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::AddHeaderLine('<script src="https://js.stripe.com/v3/"></script>');
BeaconTemplate::StartScript();

BeaconCommon::StartSession();
if (!isset($_SESSION['client_reference_id'])) {
	$client_reference_id = BeaconCommon::GenerateUUID();
	$_SESSION['client_reference_id'] = $client_reference_id;
} else {
	$client_reference_id = $_SESSION['client_reference_id'];
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT stripe_sku, retail_price FROM products WHERE product_id = $1', '972f9fc5-ad64-4f9c-940d-47062e705cc5');
if ($results->RecordCount() != 1) {
	throw new Exception('Unable to find product');
	exit;
}
$omni_sku = $results->Field('stripe_sku');
$purchase_price = '$' . number_format($results->Field('retail_price'), 2, '.', ',');
?>
<script>
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('buy-button').addEventListener('click', function() {
		this.disabled = true;
		
		var stripe = Stripe(<?php echo json_encode(BeaconCommon::GetGlobal('Stripe_Public_Key')); ?>, {
			betas: ['checkout_beta_4']
		});
		
		stripe.redirectToCheckout({
			items: [{sku: <?php echo json_encode($omni_sku); ?>, quantity: 1}],
			successUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/welcome/')); ?>,
			cancelUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/')); ?>,
			clientReferenceId: <?php echo json_encode($client_reference_id); ?>
		}).then(function (result) {
			if (result.error) {
				dialog.show('Unable to start Stripe checkout', result.error.message);
			}
		});
	});
});
</script>
<?php
BeaconTemplate::FinishScript();
BeaconTemplate::StartStyles(); ?>
<style type="text/css">

table.generic .bullet-column {
	width: 100px;
}

</style>
<?php
BeaconTemplate::FinishStyles();

$session = BeaconSession::GetFromCookie();
if (!is_null($session)) {
	$user = BeaconUser::GetByUserID($session->UserID());
} else {
	$user = null;
}

?>
<h1>Do more with Beacon Omni</h1>
<p>Beacon does a lot for free. Loot drops, server control, file sharing, and more. But when it's time to get into more advanced configuration like crafting costs and player experience, then it's time to upgrade to Beacon Omni.</p>
<p>All users of Beacon can use all features, however Omni-only config types will not be included in generated Game.ini and GameUserSettings.ini files.</p>
<?php if (BeaconUser::OmniFree) { ?>
<p class="text-center inset-note"><strong>Beacon Omni is currently in beta testing. While testing, Omni features are available to all users. Instructions for activating Omni are available in <a href="/account/#omni">your account control panel</a>. Free beta Omni licenses will expire in the future.</strong></p>
<?php } elseif (is_null($user) == false && $user->OmniVersion() >= 1) { ?>
<p class="text-center inset-note">You have already purchased Beacon Omni! See <a href="/account/#omni">your account control panel</a> for instructions on activating Beacon Omni on your computer.</p>
<?php } else { ?>
<p class="text-center"><button id="buy-button" class="default">Buy Omni: <?php echo htmlentities($purchase_price); ?></button><br><span class="smaller">Already purchased? See <a href="/account/#omni">your account control panel</a> for more details.</span></p>
<?php } ?>
<table class="generic">
	<thead>
		<tr>
			<th>Feature</th>
			<th class="text-center bullet-column">Beacon</th>
			<th class="text-center bullet-column">Omni</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Loot Drops<br><span class="smaller text-lighter">Beacon's original purpose, editing loot drops, it what it does best.</span></td>
			<td class="text-center">&#10687;</td>
			<td class="text-center">&#10687;</td>
		</tr>
		<tr>
			<td>Nitrado Server Control<br><span class="smaller text-lighter">Nitrado server owners can allow Beacon to directly control their server, including proper restart timing, config editing, and server settings changes.</span></td>
			<td class="text-center bullet-column">&#10687;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>FTP Upload and Download<br><span class="smaller text-lighter">Beacon can use FTP edit your Game.ini and GameUserSettings.ini files right on the server.</span></td>
			<td class="text-center bullet-column">&#10687;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>Download Community Beacon Files<br><span class="smaller text-lighter">Download Beacon files created by other users to make getting started with custom loot easier.</span></td>
			<td class="text-center bullet-column">&#10687;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>Create Community Beacon Files<br><span class="smaller text-lighter">Share your creation with the world to serve as a starting point for others.</span></td>
			<td class="text-center bullet-column">&#10687;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>Crafting Costs<br><span class="smaller text-lighter">Change the cost of any craftable item in Ark.</span></td>
			<td class="text-center bullet-column">&nbsp;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>Player &amp; Tame Experience<br><span class="smaller text-lighter">Control max level and the experience curve for both players and tamed dinos.</span></td>
			<td class="text-center bullet-column">&nbsp;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>Stack Sizes (Experimental)<br><span class="smaller text-lighter">Ark finally allows admins to customize stack sizes, so Beacon Omni has an editor ready to go.</span></td>
			<td class="text-center bullet-column">&nbsp;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
		<tr>
			<td>More config types on the way<br><span class="smaller text-lighter">Support for more config control such as spawn map, breeding timers, and detailed harvest rates are planned for Omni.</span></td>
			<td class="text-center bullet-column">&nbsp;</td>
			<td class="text-center bullet-column">&#10687;</td>
		</tr>
	</tbody>
</table>