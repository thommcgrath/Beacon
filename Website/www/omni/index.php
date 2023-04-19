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
$product_ids = [];
while (!$results->EOF()) {
	$product_id = $results->Field('product_id');
	$product_name = $results->Field('product_name');
	$product_price = $results->Field('price');
	$game_id = $results->Field('game_id');
	$tag = $results->Field('tag');
	
	$product = [
		'ProductId' => $product_id,
		'Name' => $product_name,
		'Price' => floatval($product_price),
		'GameId' => $game_id,
		'Tag' => $tag
	];
	
	$product_details[$game_id][$tag] = $product;
	$product_ids[$product_id] = $product;
	
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
const ProductIds = <?php echo json_encode($product_ids); ?>;

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

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('checkout.js'));

?>
<div id="storefront">
	<div id="page-landing">
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
	<div id="page-cart" class="hidden invisible">
		<div id="storefront-cart-header">
			<div><button id="cart-back-button">&laquo; Back</button></div>
			<div id="storefront-cart-header-email-field">&nbsp;</div>
			<div><button id="storefront-cart-header-email-button" class="hidden">Change Email</button></div>
		</div>
		<div id="storefront-cart"></div>
	</div>
</div>
<?php BeaconTemplate::StartModal('checkout-wizard'); ?>
	<div class="modal-content">
		<div class="title-bar">Select Your Games</div>
		<div class="content">
			<p>For which games would you like to purchase Beacon Omni?</p>
			<div id="checkout-wizard-list">
				<div id="checkout-wizard-list-arksa">
					<div class="checkout-wizard-checkbox-cell">
						<label class="checkbox"><input type="checkbox" value="arksa" id="checkout-wizard-arksa-check"><span></span></label>
					</div>
					<div class="checkout-wizard-description-cell">
						<div><label for="checkout-wizard-arksa-check">Ark: Survival Ascended</label></div>
						<div class="checkout-wizard-promo" id="checkout-wizard-promo-arksa">50% off when bundled with Ark: Survival Evolved</div>
						<div class="checkout-wizard-status">
							<span id="checkout-wizard-status-arksa">Includes one year of app updates. Additional years cost <span class="formatted-price" beacon-price="10">10</span> each.</span>
						</div>
						<div id="checkout-wizard-arksa-duration-group" class="input-group input-group-sm">
							<span class="input-group-text">Update Years</span>
							<input class="text-field" type="number" value="1" id="checkout-wizard-arksa-duration-field" min="1" max="10">
							<button id="checkout-wizard-arksa-yeardown-button">-</button>
							<button id="checkout-wizard-arksa-yearup-button">+</button>
						</div>
					</div>
					<div class="checkout-wizard-price-cell">
						<span id="checkout-wizard-arksa-full-price" class="formatted-price" beacon-price="20">20</span><br>
						<span id="checkout-wizard-arksa-discount-price" class="hidden formatted-price checkout-wizard-discount" beacon-price="10">10</span>
					</div>
				</div>
				<div id="checkout-wizard-list-ark">
					<div class="checkout-wizard-checkbox-cell">
						<label class="checkbox"><input type="checkbox" value="ark" id="checkout-wizard-ark-check"><span></span></label>
					</div>
					<div class="checkout-wizard-description-cell">
						<div><label for="checkout-wizard-ark-check">Ark: Survival Evolved</label></div>
						<div class="checkout-wizard-status">
							<span id="checkout-wizard-status-ark">Includes lifetime updates.</span>
						</div>
					</div>
					<div class="checkout-wizard-price-cell">
						<span id="checkout-wizard-ark-price" class="formatted-price" beacon-price="15">15</span>
					</div>
				</div>
			</div>
			<p class="smaller text-lighter">These are one time payments. Beacon Omni is not subscription software. <a href="/omni/updates" target="_blank">Learn More</a></p>
		</div>
		<div class="button-bar">
			<div class="left"><label class="checkbox"><input type="checkbox" value="true" id="checkout-wizard-gift-check"><span></span>This purchase is a gift.</label></div>
			<div class="middle">&nbsp;</div>
			<div class="right">
				<div class="button-group">
					<button id="checkout-wizard-cancel">Cancel</button>
					<button id="checkout-wizard-action" class="default" disabled>Add to Cart</button>
				</div>
			</div>
		</div>
	</div>
<?php
BeaconTemplate::FinishModal();
BeaconTemplate::StartModal('checkout-email');
?>
	<div class="modal-content">
		<div class="title-bar">Your E-Mail Address</div>
		<div class="content">
			<p>We need your e-mail address to show you the most accurate pricing and options. This will not be stored until your purchase is complete and will not be used for marketing messages. Feel free to read more about our <a href="/help/about_user_privacy" target="_blank">privacy policy</a> in a new tab.</p>
			<div class="floating-label">
				<input class="text-field" type="email" id="checkout-email-field" placeholder="E-Mail Address">
				<label for="checkout-email-field">E-Mail Address</label>
			</div>
			<p class="hidden text-red" id="checkout-email-error">There was an error with your email address</p>
		</div>
		<div class="button-bar">
			<div class="left">&nbsp;</div>
			<div class="middle">&nbsp;</div>
			<div class="right">
				<div class="button-group">
					<button id="checkout-email-cancel">Cancel</button>
					<button id="checkout-email-action" class="default">Ok</button>
				</div>
			</div>
		</div>
	</div>
<?php BeaconTemplate::FinishModal(); ?>
