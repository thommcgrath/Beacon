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
if (isset($_SESSION['store_currency_options']) === false) {
	$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	$spec = $api->GetCountrySpec(BeaconCommon::RemoteCountry());
	$currency_options = [];
	$method_options = [];
	if (is_null($spec)) {
		$currency_options = ['USD'];
		$method_options = ['card'];
		$default_currency = 'USD';
	} else {
		foreach ($spec['supported_payment_currencies'] as $currency_code) {
			$currency_code = strtoupper($currency_code);
			switch ($currency_code) {
			case 'USD':
			case 'EUR':
				$currency_options[] = $currency_code;
				break;
			}
		}
		foreach ($spec['supported_payment_methods'] as $method_code) {
			$method_code = strtolower($method_code);
			switch ($method_code) {
			case 'card':
				$method_options[] = $method_code;
				break;
			}
		}
		$default_currency = strtoupper($spec['default_currency']);
		if (in_array($default_currency, $currency_options) === false) {
			$default_currency = 'USD';
		}
	}
	$_SESSION['store_currency_options'] = $currency_options;
	$_SESSION['store_currency'] = $default_currency;
	$_SESSION['store_default_currency'] = $default_currency;
	$_SESSION['store_allowed_methods'] = $method_options;
	unset($currency_options, $default_currency, $api, $method_options);
}
if (isset($_SESSION['store_currency'])) {
	$currency = $_SESSION['store_currency'];
} else {
	$currency = 'USD';
}

switch ($currency) {
case 'USD':
	$decimal_character = '.';
	$thousands_character = ',';
	$currency_symbol = '$';
	break;
case 'EUR':
	$decimal_character = ',';
	$thousands_character = '.';
	$currency_symbol = '€';
	break;
case 'GBP':
	$decimal_character = '.';
	$thousands_character = ',';
	$currency_symbol = '£';
}

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

var checking_email = false;
var owns_ark = false;

var ark_checkbox = null;
var stw_quantity_field = null;
var ark_gift_quantity_field = null;

<?php if ($ark2_enabled) { ?>var ark2_checkbox = null;
var owns_ark2 = false;
var ark2_gift_quantity_field = null;<?php } ?>

let update_total = function() {
	let include_ark = owns_ark === false && ark_checkbox && ark_checkbox.checked;
	let stw_quantity = 0;
	if (stw_quantity_field) {
		stw_quantity = Math.min(stw_quantity_field.value, 10);
	}
	let ark_gift_quantity = 0;
	if (ark_gift_quantity_field) {
		ark_gift_quantity = Math.min(ark_gift_quantity_field.value, 10);
	}
	
	if (stw_quantity_field && stw_quantity_field.value != stw_quantity) {
		stw_quantity_field.value = stw_quantity;
	}
	if (ark_gift_quantity_field && ark_gift_quantity_field.value != ark_gift_quantity) {
		ark_gift_quantity_field.value = ark_gift_quantity;
	}
	
	let ark_price = <?php echo json_encode($product_details[KEY_ARK]['price']); ?>;
	let ark_gift_price = <?php echo json_encode($product_details[KEY_ARK_GIFT]['price']); ?>;
	let stw_price = <?php echo json_encode($product_details[KEY_STW]['price']); ?>;
	let total = (stw_price * stw_quantity) + (ark_gift_price * ark_gift_quantity);
	if (include_ark) {
		total += ark_price;
	}
	
	<?php if ($ark2_enabled) { ?>let ark2_gift_quantity = 0;
	let include_ark2 = ark2_checkbox && ark2_checkbox.checked;
	if (ark2_gift_quantity_field) {
		ark2_gift_quantity = Math.min(ark2_gift_quantity_field.value, 10);
	}
	if (ark2_gift_quantity_field && ark2_gift_quantity_field.value != ark2_gift_quantity) {
		ark2_gift_quantity_field.value = ark2_gift_quantity;
	}
	let ark2_price = <?php echo json_encode($product_details[KEY_ARK2]['price']); ?>;
	let ark2_gift_price = <?php echo json_encode($product_details[KEY_ARK2_GIFT]['price']); ?>;
	total += (ark2_gift_price * ark2_gift_quantity);
	if (include_ark2) {
		total += ark2_price;
	}<?php } ?>
	
	document.getElementById('total_field').innerHTML = <?php echo json_encode($currency_symbol); ?> + format_currency(total, <?php echo json_encode($decimal_character); ?>, <?php echo json_encode($thousands_character); ?>) + <?php echo json_encode(' ' . $currency); ?>;
	document.getElementById('stripe_checkout_button').disabled = (total == 0) || validate_email(document.getElementById('checkout_email_field').value) == false;
};

let format_currency = function(amount, decimal_character, thousands_character) {
	let adjusted_amount = Math.round(amount * 100).toString();
	if (adjusted_amount.length < 3) {
		adjusted_amount = '000'.substr(adjusted_amount.length) + adjusted_amount;
	}
	let decimals = adjusted_amount.substr(adjusted_amount.length - 2, 2);
	let whole = adjusted_amount.substr(0, adjusted_amount.length - 2);
	return whole + decimal_character + decimals;
};

let set_view_mode = function() {
	window.scrollTo(window.scrollX, 0);
	if (window.location.hash === '#checkout') {
		document.getElementById('page_landing').className = 'hidden';
		document.getElementById('page_cart').className = '';
	} else {
		document.getElementById('page_landing').className = '';
		document.getElementById('page_cart').className = 'hidden';
	}
};

let update_checkout_components = function() {
	if (owns_ark) {
		document.getElementById('ark_checkbox_frame').className = 'hidden';
		document.getElementById('ark_owned_caption').className = 'text-lighter';
	} else {
		document.getElementById('ark_checkbox_frame').className = '';
		document.getElementById('ark_owned_caption').className = 'hidden';
	}<?php if ($ark2_enabled) { ?>
	if (owns_ark2) {
		document.getElementById('ark2-activelicense').className = '';
	} else {
		document.getElementById('ark2-activelicense').className = 'hidden';
	}<?php } ?>
	update_total();
};

let validate_email = function(email) {
	let re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(String(email).trim().toLowerCase());
};

let lookup_email = function(email) {
	let process_purchases = function(purchases) {
		owns_ark = false;
		<?php if ($ark2_enabled) { ?>owns_ark2 = false;<?php } ?>
		for (let idx = 0; idx < purchases.length; idx++) {
			switch (purchases[idx].product_id) {
			case <?php echo json_encode(BeaconShop::ARK_PRODUCT_ID); ?>:
				owns_ark = true;
				break;
			<?php if ($ark2_enabled) { ?>case <?php echo json_encode(BeaconShop::ARK2_PRODUCT_ID); ?>:
				owns_ark2 = true;
				break;<?php } ?>
			}
		}
		update_checkout_components();
	};
	
	checking_email = true;
	update_checkout_components();
	if (validate_email(email)) {
		request.get('/omni/lookup', {'email': email}, function(obj) {
			checking_email = false;
			process_purchases(obj.purchases);
		}, function(status, body) {
			checking_email = false;
			process_purchases([]);
		});
	} else {
		checking_email = false;
		process_purchases([]);
	}
};

document.addEventListener('DOMContentLoaded', function() {
	stw_quantity_field = document.getElementById('stw_quantity_field');
	ark_gift_quantity_field = document.getElementById('ark_gift_quantity_field');
	ark_checkbox = document.getElementById('ark_checkbox');
	<?php if ($ark2_enabled) { ?>ark2_checkbox = document.getElementById('ark2_checkbox');
	ark2_gift_quantity_field = document.getElementById('ark2_gift_quantity_field');<?php } ?>
	
	update_checkout_components();
	set_view_mode();
	
	document.getElementById('buy-button').addEventListener('click', function(ev) {
		history.pushState({}, '', '/omni/#checkout');
		let popStateEvent = new PopStateEvent('popstate', {});
		dispatchEvent(popStateEvent);
		ev.preventDefault();
	});
	
	document.getElementById('cart_back_button').addEventListener('click', function(ev) {
		history.pushState({}, '', '/omni/');
		let popStateEvent = new PopStateEvent('popstate', {});
		dispatchEvent(popStateEvent);
		ev.preventDefault();
	});
	
	if (stw_quantity_field) {
		stw_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	
	if (ark_gift_quantity_field) {
		ark_gift_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	
	if (ark_checkbox) {
		ark_checkbox.addEventListener('change', function(ev) {
			update_total();
		});
	}
	
	<?php if ($ark2_enabled) { ?>if (ark2_gift_quantity_field) {
		ark2_gift_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	if (ark2_checkbox) {
		ark2_checkbox.addEventListener('change', function(ev) {
			update_total();
		});
	}<?php } ?>
	
	document.getElementById('stripe_checkout_button').addEventListener('click', function(ev) {
		this.disabled = true;
		
		let include_ark = owns_ark === false && ark_checkbox && ark_checkbox.checked;
		let stw_quantity = 0;
		if (stw_quantity_field) {
			stw_quantity = Math.min(stw_quantity_field.value, 10);
		}
		let ark_gift_quantity = 0;
		if (ark_gift_quantity_field) {
			ark_gift_quantity = Math.min(ark_gift_quantity_field.value, 10);
		}
		<?php if ($ark2_enabled) { ?>let include_ark2 = ark2_checkbox && ark2_checkbox.checked;
		let ark2_gift_quantity = 0;
		if (ark2_gift_quantity_field) {
			ark2_gift_quantity = Math.min(ark2_gift_quantity_field.value, 10);
		}<?php } ?>
 		
 		let checkout_final = function() {
			let url = '/omni/begin';
			let formdata = {
				'email': document.getElementById('checkout_email_field').value,
			};
			if (include_ark) {
				formdata.ark = true;
			}
			if (ark_gift_quantity > 0) {
				formdata.ark_gift = ark_gift_quantity;
			}
			<?php if ($ark2_enabled) { ?>if (include_ark2) {
				formdata.ark2 = true;
			}
			if (ark2_gift_quantity > 0) {
				formdata.ark2_gift = ark2_gift_quantity;
			}<?php } ?>
			if (stw_quantity > 0) {
				formdata.stw = stw_quantity;
			}
			
			request.post(url, formdata, function(obj) {
				if (sessionStorage) {
					sessionStorage.setItem('client_reference_id', obj.client_reference_id);
				}
				
				window.location.href = obj.url;
			}, function(status, body) {
				let error = JSON.parse(body);
				let message = body;
				if (error.message) {
					message = error.message;
				}
				dialog.show('There was an issue starting the checkout process.', message);
				document.getElementById('stripe_checkout_button').disabled = false;
			});
		};
		
		checkout_final();
	});
	
	document.getElementById('checkout_email_field').addEventListener('input', function() {
		let callback = function () {
			lookup_email(this.value);
			update_total();
		};
		callback = callback.bind(this);
		
		if (this.timer) {
			clearTimeout(this.timer);
		}
		this.timer = setTimeout(callback, 250);
	});
	
	let email = null;
	if (sessionStorage) {
		email = sessionStorage.getItem('email');
	}
	if (!email && localStorage) {
		email = localStorage.getItem('email');
	}
	if (email) {
		document.getElementById('checkout_email_field').value = email;
		lookup_email(email);
	}
	
	let currency_links = document.getElementsByClassName('currency-button');
	for (let i = 0; i < currency_links.length; i++) {
		let currency_link = currency_links.item(i);
		currency_link.addEventListener('click', function(ev) {
			let currency_code = this.getAttribute('currency');
			ev.preventDefault();
			
			request.get('/omni/currency', {'currency': currency_code}, function(obj)  {
				location.reload();
			}, function(status, body) {
				dialog.show('Sorry, there was a problem setting the currency.', body);
			});
			
			return false;
		});
	}
});
	
window.addEventListener('popstate', function(ev) {
	set_view_mode();
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
				
				$payment_methods = [
					'universal' => ['mastercard', 'visa', 'amex', 'discover', 'dinersclub', 'jcb'],
					'usd' => [],
					'eur' => ['bancontact', 'eps', 'giropay', 'ideal', 'p24'],
					'gbp' => []
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
						echo '<img src="' . BeaconCommon::AssetURI('paymethod_' . $method_code . '.svg') . '" class="' . $class . '" title="' . htmlentities($payment_labels[$method_code]) . '" alt="' . htmlentities($payment_labels[$method_code]) . '">';
					}
				}
				
				?></div>
				<?php
					if (count($_SESSION['store_currency_options']) > 1) {
						echo '<div id="checkout_currency_cell">';
						echo 'Currency: ';
						foreach ($_SESSION['store_currency_options'] as $currency_code) {
							echo '<a href="/omni/#' . urlencode($currency_code) . '" class="currency-button' . ($currency_code === $currency ? ' chosen' : '') . '" rel="nofollow" currency="' . htmlentities($currency_code) . '">' . htmlentities($currency_code) . '</a>';
						}
						echo '</div>';
					}
				?>
			</td>
		</tr>
	</table>
</div>