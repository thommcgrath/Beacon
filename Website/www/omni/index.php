<?php
	
define('OMNI_UUID', '972f9fc5-ad64-4f9c-940d-47062e705cc5');
define('STW_UUID', 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015');

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::AddHeaderLine('<script src="https://js.stripe.com/v3/"></script>');

BeaconCommon::StartSession();
if (!isset($_SESSION['client_reference_id'])) {
	$client_reference_id = BeaconCommon::GenerateUUID();
	$_SESSION['client_reference_id'] = $client_reference_id;
} else {
	$client_reference_id = $_SESSION['client_reference_id'];
}

$database = BeaconCommon::Database();

$results = $database->Query('SELECT stripe_sku, retail_price FROM products WHERE product_id = $1;', OMNI_UUID);
if ($results->RecordCount() != 1) {
	throw new Exception('Unable to find Omni product');
	exit;
}
$omni_sku = $results->Field('stripe_sku');
$omni_price = $results->Field('retail_price');
$omni_price_formatted = '$' . number_format($omni_price, 2, '.', ',');

$results = $database->Query('SELECT stripe_sku, retail_price FROM products WHERE product_id = $1;', STW_UUID);
$stw_sku = $results->Field('stripe_sku');
$stw_price = $results->Field('retail_price');
$stw_price_formatted = '$' . number_format($stw_price, 2, '.', ',');

BeaconTemplate::StartStyles(); ?>
<style type="text/css">

table.generic .bullet-column {
	width: 100px;
}

#cart_back_paragraph {
	float: left;
}

.price_column {
	width: 75px;
	text-align: right;
}

.quantity_column {
	width: 75px;
	text-align: center;
}

</style>
<?php
BeaconTemplate::FinishStyles();

$session = BeaconSession::GetFromCookie();
if (!is_null($session)) {
	$user = BeaconUser::GetByUserID($session->UserID());
	$results = $database->Query('SELECT purchases.merchant_reference FROM purchased_products INNER JOIN purchases ON (purchased_products.purchase_id = purchases.purchase_id) INNER JOIN users ON (purchased_products.purchaser_email = users.email_id) WHERE purchased_products.product_id = $1 AND users.user_id = $2 LIMIT 1;', OMNI_UUID, $user->UserID());
} else {
	$user = null;
	$results = $database->Query('SELECT purchases.merchant_reference FROM purchased_products INNER JOIN purchases ON (purchased_products.purchase_id = purchases.purchase_id) WHERE purchased_products.product_id = $1 AND purchased_products.client_reference_id = $2 LIMIT 1;', OMNI_UUID, $client_reference_id);
}

$purchased = false;
$subtext = 'Already purchased?';
$buy_button_caption = 'Buy Omni';
$purchase_email = null;
if ($results->RecordCount() == 1) {
	$purchased = true;
	$subtext = 'You have already purchased Beacon Omni.';
	$buy_button_caption = 'Buy Share The Wealth Licenses';
	
	$merchant_reference = $results->Field('merchant_reference');
	if (substr($merchant_reference, 0, 3) == 'pi_') {
		// Stripe PaymentIntent
		$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
		$purchase_email = $api->EmailForPaymentIntent($merchant_reference);
		if (!empty($purchase_email)) {
			$subtext = 'Your Beacon Omni purchase is tied to ' . $purchase_email . '.';
			$user = BeaconUser::GetByEmail($purchase_email);
		}
	}
}

BeaconTemplate::StartScript();
?>
<script>
var update_total = function() {
	var include_omni = document.getElementById('omni_checkbox').checked;
	var stw_quantity = Math.min(document.getElementById('stw_quantity_field').value, 10);
	if (document.getElementById('stw_quantity_field').value != stw_quantity) {
		document.getElementById('stw_quantity_field').value = stw_quantity;
	}
	
	var omni_price = <?php echo json_encode($omni_price * 100); ?>;
	var stw_price = <?php echo json_encode($stw_price * 100); ?>;
	var total = stw_price * stw_quantity;
	if (include_omni) {
		total += omni_price;
	}
	
	document.getElementById('total_field').innerHTML = '$' + (total / 100).toFixed(2);
	document.getElementById('stripe_checkout_button').disabled = (total == 0);
};

document.addEventListener('DOMContentLoaded', function() {
	update_total();
	
	document.getElementById('buy-button').addEventListener('click', function() {
		document.getElementById('page_landing').className = 'hidden';
		document.getElementById('page_cart').className = '';
	});
	
	document.getElementById('cart_back_button').addEventListener('click', function(ev) {
		document.getElementById('page_landing').className = '';
		document.getElementById('page_cart').className = 'hidden';
		ev.preventDefault();
	});
	
	document.getElementById('stw_quantity_field').addEventListener('input', function(ev) {
		update_total();
	});
	
	document.getElementById('omni_checkbox').addEventListener('change', function(ev) {
		update_total();
	});
	
	document.getElementById('stripe_checkout_button').addEventListener('click', function(ev) {
		this.disabled = true;
		
		var include_omni = document.getElementById('omni_checkbox').checked;
		var stw_quantity = Math.min(document.getElementById('stw_quantity_field').value, 10);
		
		var items = [];
		if (include_omni) {
			items.push({sku: <?php echo json_encode($omni_sku); ?>, quantity: 1});
		}
		if (stw_quantity > 0) {
			items.push({sku: <?php echo json_encode($stw_sku); ?>, quantity: stw_quantity});
		}
		
		var stripe = Stripe(<?php echo json_encode(BeaconCommon::GetGlobal('Stripe_Public_Key')); ?>, {});
		
		var checkout = {
			items: items,
			successUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/welcome/')); ?>,
			cancelUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/')); ?>,
			clientReferenceId: <?php echo json_encode($client_reference_id); ?>,
			billingAddressCollection: 'required'
		};
		<?php
		if (!is_null($purchase_email)) {
			echo 'checkout.customerEmail = ' . json_encode($purchase_email) . ';';
		}
		?>
		
		stripe.redirectToCheckout(checkout).then(function (result) {
			if (result.error) {
				dialog.show('Unable to start Stripe checkout', result.error.message);
			}
		});
	});
});
</script>
<?php
BeaconTemplate::FinishScript();

$account_link = '/account/#omni';
if (is_null($session)) {
	$account_link = '/account/login/?return=' . urlencode($account_link);
	if (!is_null($purchase_email)) {
		$account_link .= '&email=' . urlencode($purchase_email);
		if (is_null($user)) {
			$account_link .= '#create';
		}
	}
}

?>
<div id="page_landing">
	<h1>Do more with Beacon Omni</h1>
	<p>Beacon does a lot for free. Loot drops, server control, file sharing, and more. But when it's time to get into more advanced configuration like crafting costs and player experience, then it's time to upgrade to Beacon Omni.</p>
	<p>All users of Beacon can use all features, however Omni-only config types will not be included in generated Game.ini and GameUserSettings.ini files.</p>
	<div class="double_column">
		<div class="column text-center"><button id="buy-button" class="default"><?php echo htmlentities($buy_button_caption); ?></button><br><span class="smaller"><?php echo htmlentities($subtext); ?> See <a href="<?php echo $account_link; ?>">your account control panel</a> for more details.</span></div>
		<div class="column text-center">Unable to purchase for some reason? Learn more about Beacon's <em><a href="stw">Share The Wealth</a></em> program.</div>
	</div>
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
				<td>Breeding Multipliers<br><span class="smaller text-lighter">Adjust any of the 8 breeding-related multipliers with realtime display of their effects on Ark's creatures and their imprint times.</span></td>
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
				<td>Stack Sizes<br><span class="smaller text-lighter">Ark finally allows admins to customize stack sizes, so Beacon Omni has an editor ready to go.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>Harvest Rates<br><span class="smaller text-lighter">Change the harvest multiplier for any harvestable item in the game. Tip: this is a great way to improve server performance.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>Creature Adjustments<br><span class="smaller text-lighter">Adjust creature-specific damage and vulnerability multipliers, replace creatures with others, or disable specific creatures entirely.</span></td>
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
</div>
<div id="page_cart" class="hidden">
	<p id="cart_back_paragraph"><button id="cart_back_button">&laquo; Back</button></p>
	<table class="generic">
		<tr<?php if ($purchased) { echo ' class="hidden"'; } ?>>
			<td>Beacon Omni<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for yourself.</span></td>
			<td class="quantity_column"><div><label class="checkbox"><input type="checkbox" name="omni" id="omni_checkbox" <?php echo ($purchased ? 'disabled' : 'checked'); ?>><span></span></label></div></td>
			<td class="price_column"><?php echo htmlentities($omni_price_formatted); ?></td>
		</tr>
		<tr>
			<td>Beacon Share The Wealth<br><span class="smaller text-lighter">Beacon Share The Wealth is an optional purchase that allows you to show further financial support by gifting copies of Beacon Omni to random users at a reduced cost. <a href="stw">Learn More</a></span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="<?php echo ($purchased ? 1 : 0); ?>" id="stw_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($stw_price_formatted); ?>
		</tr>
		<tr>
			<td colspan="2" class="text-right">Total</td>
			<td class="price_column" id="total_field"><?php echo htmlentities($omni_price_formatted); ?></td>
		</tr>
		<tr>
			<td colspan="3" class="text-center"><button class="default" id="stripe_checkout_button">Purchase via Stripe</button></td>
		</tr>
	</table>
</div>