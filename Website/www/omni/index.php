<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();
	
$database = BeaconCommon::Database();
	
if (isset($_SESSION['store_currency_options']) === false) {
	$stripe_api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'), '2022-08-01');
	$country = BeaconCommon::RemoteCountry();
	if ($country === 'XX') {
		$country = 'US';
	}
	$countries = [$country];
	if ($country !== 'US') {
		$countries[] = 'US';
	}
	
	foreach ($countries as $country) {
		$cache_key = 'country:' . $country;
		$spec = BeaconCache::Get($cache_key);
		if (is_null($spec)) {
			$spec = $stripe_api->GetCountrySpec($country);
			if (is_null($spec) === false) {
				BeaconCache::Set($cache_key, $spec);
				break;
			}
		}
	}
	
	$results = $database->Query('SELECT code, name FROM public.currencies WHERE code = ANY($1) ORDER BY name;', '{' . implode(',', $spec['supported_payment_currencies']) . '}');
	$supported_currencies = [];
	while (!$results->EOF()) {
		$supported_currencies[$results->Field('code')] = $results->Field('name');
		$results->MoveNext();
	}
	$_SESSION['store_currency_options'] = $supported_currencies;
	$_SESSION['store_default_currency'] = strtoupper($spec['default_currency']);
	$_SESSION['store_currency'] = $_SESSION['store_default_currency'];
}

$stable_version = BeaconCommon::NewestVersionForStage(3);
$currency = $_SESSION['store_currency'];
$supported_currencies = $_SESSION['store_currency_options'];

$results = $database->Query('SELECT products.game_id, products.tag, products.product_id, products.product_name, product_prices.price FROM products INNER JOIN product_prices ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1;', $currency);
$product_details = [];
while (!$results->EOF()) {
	$product_id = $results->Field('product_id');
	$product_name = $results->Field('product_name');
	$product_price = $results->Field('price');
	$game_id = $results->Field('game_id');
	$tag = $results->Field('tag');
	
	$product_details[$game_id][$tag] = [
		'ProductId' => $product_id,
		'Name' => $product_name,
		'Price' => floatval($product_price)
	];
	
	$results->MoveNext();
}

$ark2_enabled = isset($product_details['Ark2']);
$arksa_enabled = isset($product_details['ArkSA']);

BeaconTemplate::LoadGlobalize();

BeaconTemplate::StartScript();
?>
<script>
BeaconCurrency.currencyCode = <?php echo json_encode($currency); ?>;
const Products = <?php echo json_encode($product_details); ?>;

// Deprecated
const currencyCode = <?php echo json_encode($currency); ?>;
const arkPrice = Products.Ark?.Base?.Price ?? 0;
const arkGiftPrice = Products.Ark?.Gift?.Price ?? 0;
const stwPrice = Products.STW?.Base?.Price ?? 0;
const ark2Price = Products.Ark2?.Base?.Price ?? 0;
const ark2GiftPrice = Products.Ark2?.Gift?.Price ?? 0;
const arkSAPrice = Products.ArkSA?.Base?.Price ?? 0;
const arkSAGiftPrice = Products.ArkSA?.Gift?.Price ?? 0;
const arkSAUpgradePrice = Products.ArkSA?.Upgrade?.Price ?? 0;
const arkSARenewPrice = Products.ArkSA?.Renewal?.Price ?? 0;

const arkProductId = Products.Ark?.Base?.ProductId ?? '';
const ark2ProductId = Products.Ark2?.Base?.ProductId ?? '';
const arkSAProductId = Products.ArkSA?.Base?.ProductId ?? '';
</script>
<?php
BeaconTemplate::FinishScript();

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('build/omni.css'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('checkout.js'));

?>
<div id="page_landing">
	<h1>Do more with Beacon Omni</h1>
	<p>Beacon does a lot for free. Loot drops, server control, file sharing, and more. But when it's time to get into more advanced configuration like crafting costs and player experience, then it's time to upgrade to Beacon Omni.</p>
	<p>All users of Beacon can use all features, however Omni-only config types will not be included in generated Game.ini and GameUserSettings.ini files.</p>
	<div class="text-center"><button id="buy-button" class="default">Buy Omni</button><br><span class="smaller">Already purchased? See <a href="/account/#omni">your account control panel</a> for more details.</span></div>
	<div class="comment-block">
		<div class="icon"><img src="<?php echo BeaconCommon::AssetURI('stripe-climate-badge.svg'); ?>" width="32" alt=""></div>
		<div class="comment">2% of your purchase will be contributed to the removal of carbon dioxide from the atmosphere.</div>
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
				<td>Nitrado Server Control<br><span class="smaller text-lighter">Nitrado server owners can allow Beacon to directly control their server, including proper restart timing, config editing, and server settings changes.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>GameServerApp.com Support<br><span class="smaller text-lighter">Import and update GameServerApp.com config templates with only a few clicks.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>FTP Upload and Download<br><span class="smaller text-lighter">Beacon can use FTP edit your Game.ini and GameUserSettings.ini files right on the server.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Download Community Beacon Files<br><span class="smaller text-lighter">Download Beacon files created by other users to make getting started with custom loot easier.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Create Community Beacon Files<br><span class="smaller text-lighter">Share your creation with the world to serve as a starting point for others.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Breeding Multipliers<br><span class="smaller text-lighter">Adjust any of the breeding-related multipliers with realtime display of their effects on Ark's creatures and their imprint times.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Day and Night Cycle<br><span class="smaller text-lighter">Change the length of Ark's days and nights using minutes instead of multipliers.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Decay and Spoil<br><span class="smaller text-lighter">Change and preview item decay, decomposition, and spoil times.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<?php if ($stable_version >= 10502300) { ?>
			<tr>
				<td>General Settings<?php if ($stable_version < 10503300) { ?><span class="tag blue mini left-space">New in Beacon 1.5.2</span><?php } ?><br><span class="smaller text-lighter">Beacon has support for nearly every setting available to Ark servers.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<?php } ?>
			<tr>
				<td>Item Stat Limits<br><span class="smaller text-lighter">Globally limit item stats to precise admin-defined amounts, just like official servers.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Loot Drops<br><span class="smaller text-lighter">Beacon's original purpose, editing loot drops, is what it does best.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Stat Multipliers<br><span class="smaller text-lighter">Change the stats of players, wild creatures, and tamed creatures.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Crafting Costs<br><span class="smaller text-lighter">Change the cost of any craftable item in Ark.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Creature Adjustments<br><span class="smaller text-lighter">Adjust creature-specific damage and vulnerability multipliers, replace creatures with others, or disable specific creatures entirely.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Creature Spawns<br><span class="smaller text-lighter">Add, remove, or change the creatures available on any map. Want to add lots of Featherlights to The Island, or put one really high level Pteranodon on Aberration? It's possible.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Engram Control<br><span class="smaller text-lighter">Change when engrams are unlockable, if they auto-unlock, and the number of engram points awarded each level. Beacon's powerful wizard allows users to instantly build full engram designs, such as auto-unlocking everything except tek items at spawn.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Harvest Rates<br><span class="smaller text-lighter">Change the harvest multiplier for any harvestable item in the game. Tip: this is a great way to improve server performance.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Levels and XP<br><span class="smaller text-lighter">Control max level and the experience curve for both players and tamed dinos.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Stack Sizes<br><span class="smaller text-lighter">Ark finally allows admins to customize stack sizes, so Beacon Omni has an editor ready to go.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>More config types on the way<br><span class="smaller text-lighter">With each major release, Beacon adds new editor types to both the free edition and Beacon Omni.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
		</tbody>
	</table>
</div>
<div id="page_cart" class="hidden">
	<p id="cart_back_paragraph"><button id="cart_back_button">&laquo; Back</button></p>
	<table class="generic no-row-colors">
		<tr>
			<td colspan="3">
				<p>Beacon Account E-Mail Address</p>
				<p><input type="email" name="email" id="checkout_email_field" placeholder="E-Mail Address"></p>
				<p class="text-lighter smaller">If you do not already have an account, you will be required to verify this email address before you can use your purchase.</p>
			</td>
		</tr>
		<?php if ($ark2_enabled) { ?><tr class="header">
			<td colspan="3">Beacon Omni for Ark 2</td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark 2 + 1 year of updates<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for Ark 2 for your account. This includes a year of software updates.<span id="ark2-activelicense" class="hidden"> Since your account already has an active update plan, your plan's expiration date will be extended for an additional year.</span></span></td>
			<td class="quantity_column"><div id="ark2_checkbox_frame"><label class="checkbox"><input type="checkbox" name="ark2" id="ark2_checkbox" checked><span></span></label></div></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['Ark2']['Base']['Price'] ?? 0); ?></td>
		</tr>
		<tr>
			<td>Beacon Omni For Ark 2 + 1 year of updates (Gift Code)<br><span class="smaller text-lighter">Same option as above, except you will be sent a gift code that can be given away however you'd like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="ark2_gift_quantity_field" min="0" max="10"></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['Ark2']['Gift']['Price'] ?? 0); ?></td>
		</tr><?php } ?>
		<?php if ($arksa_enabled) { ?><tr class="header">
			<td colspan="3">Beacon Omni for Ark: Survival Ascended</td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark: Survival Ascended + 1 year of updates<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for Ark: Survival Ascended for your account. This includes a year of software updates.<span id="arksa-activelicense" class="hidden"> Since your account already has an active update plan, your plan's expiration will be extended by an additional year.</span><span id="arksa-upgrade" class="hidden"> Because your account already owns Beacon Omni for Ark: Survival Evolved, your price is 50% off.</span></span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="arksa_quantity_field" min="0" max="10"></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['ArkSA']['Base']['Price'] ?? 0); ?></td>
		</tr>
		<tr>
			<td>Beacon Omni For Ark: Survival Ascended + 1 year of updates (Gift Code)<br><span class="smaller text-lighter">Same option as above, except you will be sent a gift code that can be given away however you'd like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="arksa_gift_quantity_field" min="0" max="10"></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['ArkSA']['Gift']['Price'] ?? 0); ?></td>
		</tr><?php } ?>
		<tr class="header">
			<td colspan="3">Beacon Omni for Ark: Survival Evolved</td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark: Survival Evolved<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for Ark: Survival Evolved for your account. All software updates are included for life.</span></td>
			<td class="quantity_column"><div id="ark_checkbox_frame"><label class="checkbox"><input type="checkbox" name="ark" id="ark_checkbox" <?php if ($ark2_enabled === false) { ?>checked<?php } ?>><span></span></label></div><span id="ark_owned_caption" class="hidden">Owned</span></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['Ark']['Base']['Price'] ?? 0); ?></td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark: Survival Evolved (Gift Code)<br><span class="smaller text-lighter">Same option as above, except you will be sent a gift code that can be given away however you'd like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="ark_gift_quantity_field" min="0" max="10"></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['Ark']['Gift']['Price'] ?? 0); ?></td>
		</tr>
		<tr class="header">
			<td colspan="3">Other Stuff</td>
		</tr>
		<tr>
			<td>Beacon Share The Wealth<br><span class="smaller text-lighter">Think of this like a tip jar. Beacon Share The Wealth is an optional purchase that allows you to show further financial support by gifting copies of Beacon Omni to <em>random</em> users at a reduced cost. <a href="stw">Learn More</a></span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="stw_quantity_field" min="0" max="10"></td>
			<td class="price_column formatted-price"><?php echo htmlentities($product_details['STW']['Base']['Price'] ?? 0); ?></td>
		</tr>
		<tr>
			<td colspan="2" class="text-right">Total</td>
			<td class="price_column" id="total_field">...</td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
				<div id="checkout_button_cell"><button class="default" id="stripe_checkout_button">Checkout</button></div>
				<div id="checkout_methods_cell" class="<?php echo strtolower($currency); ?>"><?php
				
				$payment_methods = [
					 'universal' => ['apple', 'google', 'mastercard', 'visa', 'amex', 'discover', 'dinersclub', 'jcb'],
					 'eur' => ['bancontact', 'eps', 'giropay', 'ideal', 'p24'],
				 ];
				$payment_labels = [
					'apple' => 'Apple Pay',
					'google' => 'Google Pay',
					'mastercard' => 'Mastercard',
					'visa' => 'Visa',
					'amex' => 'American Express',
					'discover' => 'Discover',
					'dinersclub' => 'Diner\'s Club',
					'jcb' => 'JCB',
					'bancontact' => 'Bancontact',
					'eps' => 'EPS',
					'giropay' => 'giropay',
					'ideal' => 'iDEAL',
					'p24' => 'Przelewy24'
				];
				
				foreach ($payment_methods as $class => $method_codes) {
					foreach ($method_codes as $method_code) {
						$label = $payment_labels[$method_code];
						echo '<img src="' . BeaconCommon::AssetURI('paymethod_' . $method_code . '.svg') . '" class="universal" title="' . htmlentities($label) . '" alt="' . htmlentities($label) . '">';
					}
				}
				
				?></div>
				<?php
					 if (count($_SESSION['store_currency_options']) > 1) {
						 echo '<div id="checkout_currency_cell">';
						 echo 'Currency: <div class="select"><span></span><select id="currency-menu">';
						 foreach ($_SESSION['store_currency_options'] as $currency_code => $currency_name) {
							 echo '<option value="' . htmlentities($currency_code) . '"' . ($currency_code === $currency ? ' selected' : '') . '>' . htmlentities($currency_name) . '</option>';
						 }
						 echo '</select></div></div>';
					 }
				 ?>
				<p class="smaller"><a href="/help/refund_policy">Beacon Refund Policy</a></p>
			</td>
		</tr>
	</table>
</div>
<?php BeaconTemplate::StartModal('checkout-wizard'); ?>
<div id="checkout-wizard" class="wizard">
	<div id="checkout-wizard-start">
		<div class="title-bar">Getting Started</div>
		<div>
			<p>Thanks for your interest in Beacon Omni. We'll ask you a couple simple questions to get your purchase right.</p>
		</div>
		<div class="button-bar">
			<div class="left">&nbsp;</div>
			<div class="middle">&nbsp;</div>
			<div class="right">
				<button id="checkout-wizard-start-cancel">Cancel</button>
				<button id="checkout-wizard-start-action" class="default">Next</button>
			</div>
		</div>
	</div>
	<div id="checkout-wizard-email" class="invisible hidden">
		<div class="title-bar">Your E-Mail Address</div>
		<div>
			<p>Let's start with your E-Mail address. We'll use this to check your purchases so you don't accidentally purchase twice. This will not be stored and will not be used for marketing messages.</p>
			<p><input type="email" id="checkout-wizard-email-field" placeholder="E-Mail Address"></p>
			<p class="hidden text-red" id="checkout-wizard-email-error">There was an error with your email address</p>
		</div>
		<div class="button-bar">
			<div class="left">&nbsp;</div>
			<div class="middle">&nbsp;</div>
			<div class="right">
				<button id="checkout-wizard-email-cancel">Back</button>
				<button id="checkout-wizard-email-action" class="default">Next</button>
			</div>
		</div>
	</div>
	<div id="checkout-wizard-game" class="invisible hidden">
		<div class="title-bar">Select Your Games</div>
		<div>
			<p>For which games would you like to purchase Beacon Omni?</p>
			<div id="checkout-wizard-game-list">
				<div id="checkout-wizard-game-list-arksa">
					<div class="checkout-wizard-checkbox-cell">
						<label class="checkbox"><input type="checkbox" value="arksa" id="checkout-wizard-game-arksa-check"><span></span></label>
					</div>
					<div class="checkout-wizard-description-cell">
						<label for="checkout-wizard-game-arksa-check">Ark: Survival Ascended</label><br>
						<span class="checkout-wizard-game-status">
							<span id="checkout-wizard-game-status-arksa">Includes one year of app updates. Additional years cost <span class="formatted-price">10</span> each.</span>
						</span><br>
						<div class="input-group input-group-sm">
							<span class="input-group-text">Update Plan Duration:</span>
							<input class="text-field" type="number" value="1" id="checkout-wizard-game-arksa-duration-field" min="1" max="10">
							<span class="input-group-text" id="checkout-wizard-game-arksa-duration-suffix-field">Years</span>
						</div>
					</div>
					<div class="checkout-wizard-price-cell">
						<span id="checkout-wizard-game-arksa-full-price" class="formatted-price">20</span><br>
						<span id="checkout-wizard-game-arksa-discount-price" class="hidden formatted-price checkout-wizard-discount">10</span>
					</div>
				</div>
				<div id="checkout-wizard-game-list-ark">
					<div class="checkout-wizard-checkbox-cell"><label class="checkbox"><input type="checkbox" value="ark" id="checkout-wizard-game-ark-check"><span></span></label></div>
					<div class="checkout-wizard-description-cell"><label for="checkout-wizard-game-ark-check">Ark: Survival Evolved</label><br><span id="checkout-wizard-game-status-ark" class="checkout-wizard-game-status">Includes lifetime updates.</span></div>
					<div class="checkout-wizard-price-cell"><span id="checkout-wizard-game-ark-price" class="formatted-price">15</span></div>
				</div>
			</div>
			<p class="smaller text-lighter">These are one time payments. Beacon Omni is not subscription software. <a href="/omni/updates" target="_blank">Learn More</a></p>
		</div>
		<div class="button-bar">
			<div class="left"><label class="checkbox"><input type="checkbox" value="true" id="checkout-wizard-game-gift-check"><span></span>This purchase is a gift.</label></div>
			<div class="middle">&nbsp;</div>
			<div class="right">
				<button id="checkout-wizard-game-cancel">Back</button>
				<button id="checkout-wizard-game-action" class="default" disabled>Add to Cart</button>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::FinishModal(); ?>
