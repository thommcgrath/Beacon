<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();

$database = BeaconCommon::Database();

$stableVersion = BeaconCommon::NewestVersionForStage(3);
$currency = BeaconShop::GetCurrency();
$supportedCurrencies = BeaconShop::GetCurrencyOptions();
BeaconTemplate::SetTitle('Buy Beacon Omni');
BeaconTemplate::SetCanonicalPath('/omni', str_starts_with($_SERVER['REQUEST_URI'], '/omni/license/') === false);

$gameRows = $database->Query('SELECT game_id, game_name, early_access, beacon_major_version, beacon_minor_version FROM public.games WHERE public = TRUE ORDER BY game_name;');
$gamesList = [];
$gameInfo = [];
while (!$gameRows->EOF()) {
	$game = [
		'gameId' => $gameRows->Field('game_id'),
		'name' => $gameRows->Field('game_name'),
		'earlyAccess' => $gameRows->Field('early_access'),
		'majorVersion' => $gameRows->Field('beacon_major_version'),
		'minorVersion' => $gameRows->Field('beacon_minor_version')
	];
	$gamesList[] = $game;
	$gameInfo[$game['gameId']] = $game;
	$gameRows->MoveNext();
}

$results = $database->Query('SELECT products.game_id, products.tag, products.product_id, products.product_name, product_prices.price, EXTRACT(epoch FROM products.updates_length) AS plan_length_seconds, products.updates_length::TEXT AS plan_length FROM public.products INNER JOIN public.product_prices ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1 AND products.active = TRUE AND products.hidden = FALSE;', $currency);
$productDetails = [];
$productIds = [];
while (!$results->EOF()) {
	$productId = $results->Field('product_id');
	$productName = $results->Field('product_name');
	$productPrice = $results->Field('price');
	$gameId = $results->Field('game_id');
	$tag = $results->Field('tag');
	$planLengthSeconds = $results->Field('plan_length_seconds');
	$planLength = $results->Field('plan_length');

	$product = [
		'ProductId' => $productId,
		'Name' => $productName,
		'Price' => floatval($productPrice),
		'GameId' => $gameId,
		'Tag' => $tag,
		'PlanLengthSeconds' => $planLengthSeconds,
		'PlanLength' => $planLength,
	];

	$productDetails[$gameId][$tag] = $product;
	$productIds[$productId] = $product;

	$results->MoveNext();
}

$ark2Enabled = isset($productDetails['Ark2']);
$arkSAEnabled = isset($productDetails['ArkSA']);
$palworldEnabled = isset($productDetails['Palworld']);

$paymentMethods = [
	'Universal' => ['apple', 'google', 'mastercard', 'visa', 'amex', 'discover', 'dinersclub', 'jcb'],
	'EUR' => ['bancontact', 'eps', 'ideal', 'p24'],
	'PLN' => ['p24'],
];
$paymentLabels = [
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
	'ideal' => 'iDEAL',
	'p24' => 'Przelewy24',
];

$supportedPaymentMethods = $paymentMethods['Universal'];
if (array_key_exists($currency, $paymentMethods)) {
	$supportedPaymentMethods = array_merge($supportedPaymentMethods, $paymentMethods[$currency]);
}
$paymentMethodInfo = [];
foreach ($supportedPaymentMethods as $payment_method) {
	$paymentMethodInfo[] = [
		'key' => $payment_method,
		'label' => $paymentLabels[$payment_method],
		'iconUrl' => BeaconCommon::AssetURI('paymethod_' . $payment_method . '.svg')
	];
}

$forceEmail = null;
if (isset($_GET['licenseId'])) {
	$licenseId = $_GET['licenseId'];
	if (BeaconUUID::Validate($licenseId)) {
		$license = BeaconAPI\v4\License::Fetch($licenseId);
		if (is_null($license) === false) {
			$emailId = $license->EmailId();
			$results = $database->Query('SELECT merchant_reference FROM public.purchases WHERE purchaser_email = $1 AND refunded = FALSE;', $emailId);
			$stripeApi = null;
			while (!$results->EOF()) {
				$merchantReference = $results->Field('merchant_reference');
				if (str_starts_with($merchantReference, 'pi_')) {
					if (is_null($stripeApi)) {
						$stripeApi = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'), '2022-08-01');
					}
					$email = $stripeApi->EmailForPaymentIntent($merchantReference);
					if (is_null($email) === false) {
						$forceEmail = $email;
						break;
					}
				}
				$results->MoveNext();
			}
		}
	}
}

BeaconTemplate::AddScript(BeaconCommon::AssetURI('checkout.js'));
BeaconTemplate::StartScript();
?>
<script>

document.addEventListener('DOMContentLoaded', () => {
	const event = new Event('beaconRunCheckout');
	event.checkoutProperties = <?php echo json_encode([
		'currencyCode' => $currency,
		'currencies' => $_SESSION['store_currency_options'],
		'paymentMethods' => $paymentMethodInfo,
		'products' => $productDetails,
		'productIds' => $productIds,
		'forceEmail' => $forceEmail,
		'games' => $gamesList,
	]); ?>;
	document.dispatchEvent(event);
});
</script>
<?php
BeaconTemplate::FinishScript();

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));

?>
<div id="storefront">
	<div id="page-landing">
		<div class="omni-hero">
			<div class="light-only"><img src="<?php echo BeaconCommon::AssetURI('beacon-omni-logotype.svg'); ?>"></div>
			<div class="dark-only"><img src="<?php echo BeaconCommon::AssetURI('beacon-omni-logotype-dark.svg'); ?>"></div>
		</div>
		<div class="text-center"><button id="buy-button" class="default">Buy Omni</button><br><span class="smaller">Already purchased? See <a href="/account/#omni">your account control panel</a> for more details.</span></div>
		<div id="panel-games" class="page-panel">
			<div class="page-panel-nav">
				<ul>
					<?php
					$firstGame = true;
					foreach ($gamesList as $game) {
						$gameId = $game['gameId'];
						$gameName = $game['name'];
						if ($game['earlyAccess']) {
							$gameName .= ' (Early Access)';
						}
						echo '<li' . ($firstGame ? ' class="page-panel-active"' : '') . '><a href="#' . htmlentities(urlencode($gameId)) . '" page="' . htmlentities($gameId) . '">' . htmlentities($gameName) . '</a></li>';
						$firstGame = false;
					}
					?>
				</ul>
			</div>
			<div class="page-panel-pages">
				<?php
				$firstGame = true;
				foreach ($gamesList as $game) {
					$gameId = $game['gameId'];
					echo '<div class="page-panel-page' . ($firstGame ? ' page-panel-visible' : '') . '" page="' . htmlentities($gameId) . '">';
					include('modules/' . strtolower($gameId) . '.php');
					echo '</div>';
					$firstGame = false;
				}
				?>
			</div>
		</div>
	</div>
	<div id="page-cart" class="hidden invisible">
		<div id="storefront-cart-header" class="storefront-cart-section">
			<div><button id="cart-back-button">&laquo; Back</button></div>
			<div id="storefront-cart-header-email-field">&nbsp;</div>
			<div><button id="storefront-cart-header-email-button" class="hidden">Change Email</button></div>
		</div>
		<div id="storefront-cart" class="storefront-cart-section"></div>
		<div id="storefront-cart-footer" class="storefront-cart-section">
			<div class="storefront-cart-totals">
				<div class="storefront-cart-total-row">
					<div class="bold">Total</div><div id="storefront-cart-total" class="formatted-price"></div>
				</div>
			</div>
			<div class="storefront-refund-notice">
				<label class="checkbox"><input type="checkbox" id="storefront-refund-checkbox"><span></span>By checking this box, you agree to Beacon's <a href="/policies/refund">refund policy</a>. Refunds are offered if requested within 14 days of purchase, or until personalized content has been generated with the export and/or deploy features, whichever comes first.</label>
			</div>
			<div class="storefront-button-row double-group">
				<div>
					<div class="select"><span></span>
						<select id="storefront-cart-currency-menu">
							<?php

							foreach ($_SESSION['store_currency_options'] as $currencyCode => $currencyLabel) {
								echo '<option value="' . htmlentities($currencyCode) . '"';
								if ($currencyCode === $currency) {
									echo ' selected="selected"';
								}
								echo '>' . htmlentities($currencyLabel) . '</option>';
							}

							?>
						</select>
					</div>
				</div>
				<div>
					<div class="button-group">
						<button id="storefront-cart-more-button">Add More</button>
						<button id="storefront-cart-checkout-button" class="default">Checkout</button>
					</div>
				</div>
			</div>
			<div class="storefront-cart-paymethods">
				<?php

				foreach ($paymentMethodInfo as $payMethod) {
					echo '<div><img src="' . $payMethod['iconUrl'] . '" title="' . $payMethod['label'] . '" alt="' . $payMethod['label'] . '"></div>';
				}

				?>
			</div>
			<div class="storefront-cart-notice">
				<a href="/policies/refund">Beacon Refund Policy</a>
			</div>
			<div class="comment-block">
				<div class="icon"><img src="<?php echo BeaconCommon::AssetURI('stripe-climate-badge.svg'); ?>" width="32" alt=""></div>
				<div class="comment">2% of your purchase will be contributed to the removal of carbon dioxide from the atmosphere.</div>
			</div>
		</div>
	</div>
</div>
<?php BeaconTemplate::StartModal('checkout-wizard'); ?>
	<div class="modal-content">
		<div class="title-bar">Select Your Games</div>
		<div class="content">
			<p>For which games would you like to purchase Beacon Omni?</p>
			<div id="checkout-wizard-list">
				<?php if ($arkSAEnabled) { ?><div id="checkout-wizard-list-arksa" class="checkout-wizard-list-game" beacon-game-id="ArkSA">
					<div class="checkout-wizard-checkbox-cell">
						<label class="checkbox"><input type="checkbox" value="arksa" id="checkout-wizard-arksa-check"><span></span></label>
					</div>
					<div class="checkout-wizard-description-cell">
						<div><label for="checkout-wizard-arksa-check">Ark: Survival Ascended</label></div>
						<div class="checkout-wizard-promo" id="checkout-wizard-promo-arksa">50% off when bundled with Ark: Survival Evolved</div>
						<div class="checkout-wizard-status">
							<span id="checkout-wizard-status-arksa">Includes 1 year of app updates. Additional years cost <span class="formatted-price" beacon-price="<?php echo $productDetails['ArkSA']['Renewal']['Price']; ?>"></span> each.</span>
						</div>
						<div id="checkout-wizard-arksa-duration-group" class="input-group input-group-sm">
							<span class="input-group-text">Update Years</span>
							<input class="text-field no-stepper" type="number" value="1" id="checkout-wizard-arksa-duration-field" min="1" max="10">
							<button id="checkout-wizard-arksa-yeardown-button">-</button>
							<button id="checkout-wizard-arksa-yearup-button">+</button>
						</div>
					</div>
					<div class="checkout-wizard-price-cell">
						<span id="checkout-wizard-arksa-full-price" class="formatted-price" beacon-price="<?php echo $productDetails['ArkSA']['Base']['Price']; ?>"></span><br>
						<span id="checkout-wizard-arksa-discount-price" class="hidden formatted-price checkout-wizard-discount" beacon-price="<?php echo $productDetails['ArkSA']['Upgrade']['Price']; ?>"></span>
					</div>
				</div><?php } ?>
				<div id="checkout-wizard-list-ark" class="checkout-wizard-list-game separated" beacon-game-id="Ark">
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
						<span id="checkout-wizard-ark-price" class="formatted-price" beacon-price="<?php echo $productDetails['Ark']['Base']['Price']; ?>"></span>
					</div>
				</div>
<?php
				foreach ($gamesList as $game) {
					$gameId = $game['gameId'];
					$gameName = $game['name'];
					if ($gameId === 'Ark' || $gameId === 'ArkSA') {
						continue;
					}

					$gameIdLower = strtolower($gameId);
					$gameIdLowerHtml = htmlentities($gameIdLower);
					$baseProduct = $productDetails[$gameId]['Base'];
					$isLifetime = is_null($baseProduct['PlanLength']);

					echo "\t\t\t\t"  . '<div id="checkout-wizard-list-' . $gameIdLowerHtml . '" class="checkout-wizard-list-game separated" beacon-game-id="' . htmlentities($gameId) . '">' . "\n";
					echo "\t\t\t\t\t" . '<div class="checkout-wizard-checkbox-cell"><label class="checkbox"><input type="checkbox" value="' . $gameIdLowerHtml . '" id="checkout-wizard-' . $gameIdLowerHtml . '-check"><span></span></label></div>' . "\n";
					echo "\t\t\t\t\t" . '<div class="checkout-wizard-description-cell">' . "\n";
					echo "\t\t\t\t\t\t" . '<div><label for="checkout-wizard-' . $gameIdLowerHtml . '-check">' . htmlentities($gameName) . '</label></div>' . "\n";
					echo "\t\t\t\t\t\t" . '<div class="checkout-wizard-status">' . "\n";
					echo "\t\t\t\t\t\t\t" . '<span id="checkout-wizard-status-' . $gameIdLowerHtml . '">';
					if ($isLifetime) {
						echo 'Includes lifetime updates.';
					} else {
						echo 'Includes ' . htmlentities($baseProduct['PlanLength']) . ' of app updates. Additional years cost <span class="formatted-price" beacon-price="' . htmlentities($productDetails[$gameId]['Renewal']['Price']) . '"></span> each.';
					}
					echo '</span>' . "\n";
					echo "\t\t\t\t\t\t" . '</div>' . "\n"; // checkout-wizard-status
					if ($isLifetime === false) {
						echo "\t\t\t\t\t\t" . '<div id="checkout-wizard-' . $gameIdLowerHtml . '-duration-group" class="input-group input-group-sm">' . "\n";
						echo "\t\t\t\t\t\t\t" . '<span class="input-group-text">Update Years</span>' . "\n";
						echo "\t\t\t\t\t\t\t" . '<input class="text-field no-stepper" type="number" value="1" id="checkout-wizard-' . $gameIdLowerHtml . '-duration-field" min="1" max="10">' . "\n";
						echo "\t\t\t\t\t\t\t" . '<button id="checkout-wizard-' . $gameIdLowerHtml . '-yeardown-button">-</button>' . "\n";
						echo "\t\t\t\t\t\t\t" . '<button id="checkout-wizard-' . $gameIdLowerHtml . '-yearup-button">+</button>' . "\n";
						echo "\t\t\t\t\t\t" . '</div>' . "\n";
					}
					echo "\t\t\t\t\t" . '</div>' . "\n"; // checkout-wizard-description-cell
					echo "\t\t\t\t\t" . '<div class="checkout-wizard-price-cell">' . "\n";
					echo "\t\t\t\t\t\t" . '<span id="checkout-wizard-' . $gameIdLowerHtml . '-price" class="formatted-price" beacon-price="' . htmlentities($baseProduct['Price']) . '"></span><br>' . "\n";
					echo "\t\t\t\t\t" . '</div>' . "\n"; // checkout-wizard-price-cell
					echo "\t\t\t\t" . '</div>' . "\n"; // checkout-wizard-list-game
				}
				?>
			</div>
			<p class="smaller text-lighter">These are one time payments. Beacon Omni is not subscription software. <a href="/omni/updates" target="beacon" rel="noopener noreferrer">Learn More</a></p>
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
		<div class="title-bar">Beacon Account E-Mail Address</div>
		<div class="content">
			<p>We need the e-mail address of your Beacon account to show you the most accurate pricing and options. If you do not have a Beacon account yet, enter the e-mail address you want to use to create one. You will create your Beacon account after purchase.</p>
			<div class="floating-label">
				<input class="text-field" type="email" id="checkout-email-field" placeholder="Beacon Account E-Mail Address">
				<label for="checkout-email-field">Beacon Account E-Mail Address</label>
			</div>
			<p class="hidden text-red" id="checkout-email-error">There was an error with your email address</p>
			<p> This will not be stored until your purchase is complete and will not be used for marketing messages. Feel free to read more about our <a href="/help/about_user_privacy" target="beacon" rel="noopener noreferrer">privacy policy</a> in a new tab.</p>
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
<?php BeaconTemplate::FinishModal();

function OutputGameHeader(string $titleHtml, string $gameId): void {
	echo '<div class="omni-game-header"><div class="omni-game-header-title">' . $titleHtml . '</div><div class="omni-game-header-button"><button id="checkout-buy-' . strtolower($gameId) . '-button" class="blue">Buy Now</button></div></div>' . "\n";
}

?>
