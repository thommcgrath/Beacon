<?php
	
define('KEY_ARK', 'ark');
define('KEY_ARK_GIFT', 'ark_gift');
define('KEY_ARK2', 'ark2');
define('KEY_ARK2_GIFT', 'ark2_gift');
define('KEY_STW', 'stw');

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();

$database = BeaconCommon::Database();
$stable_version = BeaconCommon::NewestVersionForStage(3);
$currency = 'USD';
$decimal_character = '.';
$thousands_character = ',';
$currency_symbol = '$';

$results = $database->Query('SELECT products.product_id, product_prices.currency, product_prices.price FROM products INNER JOIN product_prices ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1;', $currency);
$product_details = [];
while (!$results->EOF()) {
	$key = '';
	switch ($results->Field('product_id')) {
	case BeaconShop::ARK_PRODUCT_ID:
		$key = KEY_ARK;
		break;
	case BeaconShop::ARK_GIFT_ID:
		$key = KEY_ARK_GIFT;
		break;
	case BeaconShop::ARK2_PRODUCT_ID:
		$key = KEY_ARK2;
		break;
	case BeaconShop::ARK2_GIFT_ID:
		$key = KEY_ARK2_GIFT;
		break;
	case BeaconShop::STW_ID:
		$key = KEY_STW;
		break;
	}
	if (empty($key)) {
		$results->MoveNext();
		continue;
	}
	
	$product_details[$key] = [
		'price' => floatval($results->Field('price')),
		'price_formatted' => $currency_symbol . number_format($results->Field('price'), 2, $decimal_character, $thousands_character) . ' ' . $currency,
	];
	
	$results->MoveNext();
}

if (isset($product_details[KEY_ARK]) === false) {
	throw new Exception('Unable to find Omni product');
	exit;
}

$ark2_enabled = isset($product_details[KEY_ARK2]);

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));

BeaconTemplate::StartScript();
?>
<script>
"use strict";

document.addEventListener('DOMContentLoaded', () => {
	const pageLanding = document.getElementById('page_landing');
	const pageCart = document.getElementById('page_cart');
	const stwQuantityField = document.getElementById('stw_quantity_field');
	const arkGiftQuantityField = document.getElementById('ark_gift_quantity_field');
	const arkCheckbox = document.getElementById('ark_checkbox');
	const arkCheckboxFrame = document.getElementById('ark_checkbox_frame');
	const arkOwnedCaption = document.getElementById('ark_owned_caption');
	const ark2GiftQuantityField = document.getElementById('ark2_gift_quantity_field');
	const ark2Checkbox = document.getElementById('ark2_checkbox');
	const ark2ActiveLicenseCaption = document.getElementById('ark2-activelicense');
	const buyButton = document.getElementById('buy-button');
	const cartBackButton = document.getElementById('cart_back_button');
	const stripeCheckoutButton = document.getElementById('stripe_checkout_button');
	const emailField = document.getElementById('checkout_email_field');
	const totalField = document.getElementById('total_field');
	const requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, buyButton, cartBackButton, stripeCheckoutButton, emailField, totalField];
	if (requiredPageElements.includes(null)) {
		console.log('Missing page elements');
		return false;
	}
	
	const status = {
		checkingEmail: false,
		ownsArk: false,
		ownsArk2: false
	}
	
	const currencyCode = <?php echo json_encode($currency); ?>;
	const currencySymbol = <?php echo json_encode($currency_symbol); ?>;
	const decimalCharacter = <?php echo json_encode($decimal_character); ?>;
	const thousandsCharacter = <?php echo json_encode($thousands_character); ?>;
	
	const updateTotal = () => {
		const includeArk = status.ownsArk === false && arkCheckbox.checked;
		const stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
		const arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
		
		if (stwQuantityField.value != stwQuantity) {
			stwQuantityField.value = stwQuantity;
		}
		if (arkGiftQuantityField.value != arkGiftQuantity) {
			arkGiftQuantityField.value = arkGiftQuantity;
		}
		
		const arkPrice = <?php echo json_encode($product_details[KEY_ARK]['price']); ?>;
		const arkGiftPrice = <?php echo json_encode($product_details[KEY_ARK_GIFT]['price']); ?>;
		const stwPrice = <?php echo json_encode($product_details[KEY_STW]['price']); ?>;
		let total = (stwPrice * stwQuantity) + (arkGiftPrice * arkGiftQuantity);
		if (includeArk) {
			total += arkPrice;
		}
		
		if (ark2GiftQuantityField && ark2Checkbox && ark2ActiveLicenseCaption) {
			const includeArk2 = ark2Checkbox.checked;
			const ark2GiftQuantity = Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
			
			if (ark2GiftQuantityField.value != ark2GiftQuantity) {
				ark2GiftQuantityField.value = ark2GiftQuantity;
			}
			
			const ark2Price = <?php echo json_encode($product_details[KEY_ARK2]['price'] ?? 0); ?>;
			const ark2GiftPrice = <?php echo json_encode($product_details[KEY_ARK2_GIFT]['price'] ?? 0); ?>;
			total += (ark2GiftPrice * ark2GiftQuantity);
			if (includeArk2) {
				total += ark2Price;
			}
		}
		
		const formattedTotal = formatCurrency(total);
		totalField.innerHTML = `${currencySymbol}${formattedTotal} ${currencyCode}`;
		stripeCheckoutButton.disabled = (total == 0) || status.checkingEmail || validateEmail(emailField.value) == false;
	};
	
	const formatCurrency = (amount) => {
		let adjustedAmount = Math.round(amount * 100).toString();
		if (adjustedAmount.length < 3) {
			adjustedAmount = '000'.substr(adjustedAmount.length) + adjustedAmount;
		}
		const decimals = adjustedAmount.substr(adjustedAmount.length - 2, 2);
		const whole = adjustedAmount.substr(0, adjustedAmount.length - 2);
		return whole + decimalCharacter + decimals;
	};
	
	const setViewMode = () => {
		window.scrollTo(window.scrollX, 0);
		if (window.location.hash === '#checkout') {
			pageLanding.classList.add('hidden');
			pageCart.classList.remove('hidden');
		} else {
			pageLanding.classList.remove('hidden');
			pageCart.classList.add('hidden');
		}
	};
	
	const updateCheckoutComponents = () => {
		if (status.ownsArk) {
			arkCheckboxFrame.classList.add('hidden');
			arkOwnedCaption.classList.remove('hidden');
		} else {
			arkCheckboxFrame.classList.remove('hidden');
			arkOwnedCaption.classList.add('hidden');
		}
		if (ark2ActiveLicenseCaption) {
			if (status.ownsArk2) {
				ark2ActiveLicenseCaption.classList.remove('hidden');
			} else {
				ark2ActiveLicenseCaption.classList.add('hidden');
			}
		}
		updateTotal();
	};
	
	const validateEmail = (email) => {
		const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(String(email).trim().toLowerCase());
	};
	
	const lookupEmail = (email) => {
		const processPurchases = (purchases) => {
			status.ownsArk = false;
			status.ownsArk2 = false;
			
			for (const purchase of purchases) {
				switch (purchase.product_id) {
				case <?php echo json_encode(BeaconShop::ARK_PRODUCT_ID); ?>:
					status.ownsArk = true;
					break;
				case <?php echo json_encode(BeaconShop::ARK2_PRODUCT_ID); ?>:
					status.ownsArk2 = true;
					break;
				}
			}
			updateCheckoutComponents();
		};
		
		status.checkingEmail = true;
		updateCheckoutComponents();
		if (validateEmail(email)) {
			const params = new URLSearchParams();
			params.append('email', email);
			
			BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then((response) => {
				status.checkingEmail = false;
				try {
					const obj = JSON.parse(response.body);
					processPurchases(obj.purchases);
				} catch (e) {
					console.log(e);
					processPurchases([]);
				}
			}).catch((error) => {
				status.checkingEmail = false;
				processPurchases([]);
			}); 
		} else {
			status.checkingEmail = false;
			processPurchases([]);
		}
	};
	
	updateCheckoutComponents();
	setViewMode();
	
	buyButton.addEventListener('click', (ev) => {
		history.pushState({}, '', '/omni/#checkout');
		dispatchEvent(new PopStateEvent('popstate', {}));
		ev.preventDefault();
	});
	
	cartBackButton.addEventListener('click', (ev) => {
		history.pushState({}, '', '/omni/');
		dispatchEvent(new PopStateEvent('popstate', {}));
		ev.preventDefault();
	});
	
	stwQuantityField.addEventListener('input', (ev) => {
		updateTotal();
	});
	
	arkGiftQuantityField.addEventListener('input', (ev) => {
		updateTotal();
	});
	
	arkCheckbox.addEventListener('change', (ev) => {
		updateTotal();
	});
	
	if (ark2GiftQuantityField) {
		ark2GiftQuantityField.addEventListener('input', (ev) => {
			updateTotal();
		});
	}
	
	if (ark2Checkbox) {
		ark2Checkbox.addEventListener('change', (ev) => {
			updateTotal();
		});
	}
	
	stripeCheckoutButton.addEventListener('click', (ev) => {
		ev.target.disabled = true;
		
		const includeArk = status.ownsArk === false && arkCheckbox.checked;
		const stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
		const arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
		const includeArk2 = ark2Checkbox && ark2Checkbox.checked;
		const ark2GiftQuantity = ark2GiftQuantityField && Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
		
		const params = new URLSearchParams();
		params.append('email', emailField.value);
		params.append('ark', includeArk);
		params.append('ark2', includeArk2);
		params.append('ark_gift', arkGiftQuantity);
		params.append('ark2_gift', ark2GiftQuantity);
		params.append('stw', stwQuantity);
		
		BeaconWebRequest.post('/omni/begin', params).then((response) => {
			try {
				const obj = JSON.parse(response.body);
				if (sessionStorage) {
					sessionStorage.setItem('client_reference_id', obj.client_reference_id);
				}
				
				window.location.href = obj.url;
			} catch (e) {
				console.log(e);
				BeaconDialog.Show('There was an error starting the checkout process.', e.message);
			}
		}).catch((error) => {
			let message = error.body;
			try {
				const obj = JSON.parse(message);
				if (obj.message) {
					message = obj.message;
				}
			} catch (e) {
				console.log(e);
			}
			BeaconDialog.show('There was an error starting the checkout process.', message);
			ev.target.disabled = false;
		});
	});
	
	emailField.addEventListener('input', (ev) => {
		if (emailField.timer) {
			clearTimeout(emailField.timer);
		}
		
		emailField.timer = setTimeout(() => {
			lookupEmail(emailField.value);
			updateTotal();
		}, 250);
	});
	
	const email = sessionStorage?.getItem('email') ?? localStorage?.getItem('email') ?? null;
	if (email) {
		emailField.value = email;
		lookupEmail(email);
	}
	
	const currencyLinks = document.querySelectorAll('.currency-button');
	for (const link of currencyLinks) {
		link.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			const linkCurrency = ev.target.getAttribute('currency');
			const params = new URLSearchParams();
			params.append('currency', linkCurrency);
			BeaconWebRequest.get(`/omni/currency?${params.toString()}`).then((response) => {
				location.reload();
			}).catch((error) => {
				BeaconDialog.show('Sorry, there was a problem setting the currency.', error.body);
			});
			
			return false;
		});
	}
	
	window.addEventListener('popstate', (ev) => {
		setViewMode();
	});
});
</script>
<?php
BeaconTemplate::FinishScript();

?>
<div id="page_landing">
	<h1>Do more with Beacon Omni</h1>
	<p>Beacon does a lot for free. Loot drops, server control, file sharing, and more. But when it's time to get into more advanced configuration like crafting costs and player experience, then it's time to upgrade to Beacon Omni.</p>
	<p>All users of Beacon can use all features, however Omni-only config types will not be included in generated Game.ini and GameUserSettings.ini files.</p>
	<div class="double_column">
		<div class="column text-center"><button id="buy-button" class="default">Buy Omni</button><br><span class="smaller">Already purchased? See <a href="/account/#omni">your account control panel</a> for more details.</span></div>
		<div class="column text-center">Unable to purchase for some reason? Learn more about Beacon's <em><a href="stw">Share The Wealth</a></em> program.</div>
	</div>
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
			<td class="price_column"><?php echo htmlentities($product_details[KEY_ARK2]['price_formatted']); ?></td>
		</tr>
		<tr>
			<td>Beacon Omni For Ark 2 + 1 year of upates (Gift Code)<br><span class="smaller text-lighter">Same option as above, except you will be sent a gift code that can be given away however you'd like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="ark2_gift_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($product_details[KEY_ARK2_GIFT]['price_formatted']); ?>
		</tr><?php } ?>
		<tr class="header">
			<td colspan="3">Beacon Omni for Ark: Survival Evolved</td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark: Survival Evolved<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for Ark: Survival Evolved for your account. All software updates are included for life.</span></td>
			<td class="quantity_column"><div id="ark_checkbox_frame"><label class="checkbox"><input type="checkbox" name="ark" id="ark_checkbox" <?php if ($ark2_enabled === false) { ?>checked<?php } ?>><span></span></label></div><span id="ark_owned_caption" class="hidden">Owned</span></td>
			<td class="price_column"><?php echo htmlentities($product_details[KEY_ARK]['price_formatted']); ?></td>
		</tr>
		<tr>
			<td>Beacon Omni for Ark: Survival Evolved (Gift Code)<br><span class="smaller text-lighter">Same option as above, except you will be sent a gift code that can be given away however you'd like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="ark_gift_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($product_details[KEY_ARK_GIFT]['price_formatted']); ?>
		</tr>
		<tr class="header">
			<td colspan="3">Other Stuff</td>
		</tr>
		<tr>
			<td>Beacon Share The Wealth<br><span class="smaller text-lighter">Think of this like a tip jar. Beacon Share The Wealth is an optional purchase that allows you to show further financial support by gifting copies of Beacon Omni to <em>random</em> users at a reduced cost. <a href="stw">Learn More</a></span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="stw_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($product_details[KEY_STW]['price_formatted']); ?>
		</tr>
		<tr>
			<td colspan="2" class="text-right">Total</td>
			<td class="price_column" id="total_field"><?php echo htmlentities($product_details[KEY_ARK]['price_formatted']); ?></td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
				<div id="checkout_button_cell"><button class="default" id="stripe_checkout_button">Checkout</button></div>
				<div id="checkout_methods_cell" class="<?php echo strtolower($currency); ?>"><?php
				
				$payment_labels = [
					//'apple' => 'Apple Pay',
					//'google' => 'Google Pay',
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
				foreach ($payment_labels as $method_code => $label) {
					echo '<img src="' . BeaconCommon::AssetURI('paymethod_' . $method_code . '.svg') . '" class="universal" title="' . htmlentities($label) . '" alt="' . htmlentities($label) . '">';
				}
				
				?></div>
				<p class="smaller">If necessary the price will be converted into AUD, CAD, EUR, GBP, JPY, MXN, or SGD at checkout.</p>
				<p class="smaller"><a href="/help/refund_policy">Beacon Refund Policy</a></p>
			</td>
		</tr>
	</table>
</div>