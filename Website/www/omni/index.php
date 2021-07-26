<?php
	
define('OMNI_UUID', '972f9fc5-ad64-4f9c-940d-47062e705cc5');
define('STW_UUID', 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015');
define('GIFT_UUID', '2207d5c1-4411-4854-b26f-bc4b48aa33bf');
define('SLOT_UUID', '10b653d8-1e17-4b5c-bb01-bca9e86149f9');

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
}

$results = $database->Query('SELECT products.product_id, product_prices.currency, product_prices.price FROM products INNER JOIN product_prices ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1;', $currency);
$product_details = [];
while (!$results->EOF()) {
	$key = '';
	switch ($results->Field('product_id')) {
	case OMNI_UUID:
		$key = 'omni';
		break;
	case STW_UUID:
		$key = 'stw';
		break;
	case GIFT_UUID:
		$key = 'gift';
		break;
	case SLOT_UUID:
 		$key = 'slot';
 		break;
	}
	if (empty($key)) {
		$results->MoveNext();
		continue;
	}
	
	$product_details[$key] = [
		'price' => $results->Field('price'),
		'price_formatted' => $currency_symbol . number_format($results->Field('price'), 2, $decimal_character, $thousands_character) . ' ' . $currency,
	];
	
	$results->MoveNext();
}

if (isset($product_details['omni']) === false) {
	throw new Exception('Unable to find Omni product');
	exit;
}

$teams_enabled = BeaconCommon::TeamsEnabled();

BeaconTemplate::StartStyles(); ?>
<style type="text/css">

table.generic .bullet-column {
	width: 100px;
}

td.bullet-column {
	color: #008000;
}

#cart_back_paragraph {
	float: left;
}

.price_column {
	width: 115px;
	text-align: right;
}

.quantity_column {
	width: 75px;
	text-align: center;
}

#email_section {
	border-width: 1px;
	border-style: solid;
	clear: both;
	padding: 20px;
	margin: 20px auto;
	border-radius: 6px;
	max-width: 400px;
}

#checkout_methods_cell {
	display: flex;
	flex-wrap: wrap;
	margin-top: 15px;
	margin-bottom: 5px;
	justify-content: center;
	
	img {
		margin: 5px;
		float: left;
		display: block;
		height: 22px;
	}
	
	&.usd {
		.usd {
			display: block;
		}
		
		.eur {
			display: none;
		}
	}
	
	&.eur {
		.usd {
			display: none;
		}
		
		.eur {
			display: block;
		}
	}
}

#checkout_button_cell {
	text-align: center;
}

#checkout_currency_cell {
	text-align: center;
	font-size: small;
	
	a {
		display: inline-block;
		padding: 2px 6px;
		border-radius: 4px;
		text-decoration: none;
		margin-left: 0.2em;
		margin-right: 0.2em;
		color: #084FD1;
		
		&.chosen {
			background-color: #084FD1;
			color: white;
		}
	}
}

@media (prefers-color-scheme: dark) {
	#checkout_currency_cell a {
		color: #3486FE;
		
		&.chosen {
			background-color: #3486FE;
		}
	}
}

</style>
<?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript();
?>
<script>
var owns_omni = false;
var is_child = false;

var stw_quantity_field = null;
var gift_quantity_field = null;
var slot_quantity_field = null;

var update_total = function() {
	var include_omni = owns_omni === false && is_child === false && document.getElementById('omni_checkbox').checked;
	var stw_quantity = 0;
	if (stw_quantity_field) {
		stw_quantity = Math.min(stw_quantity_field.value, 10);
	}
	var gift_quantity = 0;
	if (gift_quantity_field) {
		gift_quantity = Math.min(gift_quantity_field.value, 10);
	}
	var slot_quantity = 0;
	
	if (stw_quantity_field && stw_quantity_field.value != stw_quantity) {
		stw_quantity_field.value = stw_quantity;
	}
	if (gift_quantity_field && gift_quantity_field.value != gift_quantity) {
		gift_quantity_field.value = gift_quantity;
	}
	if (slot_quantity_field && slot_quantity_field.value != slot_quantity) {
 		slot_quantity_field.value = slot_quantity
 	}
	
	var omni_price = <?php echo json_encode($product_details['omni']['price']); ?>;
	var stw_price = <?php echo json_encode($product_details['stw']['price']); ?>;
	var gift_price = <?php echo json_encode($product_details['gift']['price']); ?>;
	var slot_price = 0;
	var total = (stw_price * stw_quantity) + (gift_price * gift_quantity) + (slot_price * slot_quantity);
	if (include_omni) {
		total += omni_price;
	}
	
	document.getElementById('total_field').innerHTML = <?php echo json_encode($currency_symbol); ?> + format_currency(total, <?php echo json_encode($decimal_character); ?>, <?php echo json_encode($thousands_character); ?>) + <?php echo json_encode(' ' . $currency); ?>;
	document.getElementById('stripe_checkout_button').disabled = (total == 0) || validate_email(document.getElementById('checkout_email_field').value) == false;
};

var format_currency = function(amount, decimal_character, thousands_character) {
	var adjusted_amount = Math.round(amount * 100).toString();
	if (adjusted_amount.length < 3) {
		adjusted_amount = '000'.substr(adjusted_amount.length) + adjusted_amount;
	}
	var decimals = adjusted_amount.substr(adjusted_amount.length - 2, 2);
	var whole = adjusted_amount.substr(0, adjusted_amount.length - 2);
	return whole + decimal_character + decimals;
};

var set_view_mode = function() {
	window.scrollTo(window.scrollX, 0);
	if (window.location.hash === '#checkout') {
		document.getElementById('page_landing').className = 'hidden';
		document.getElementById('page_cart').className = '';
	} else {
		document.getElementById('page_landing').className = '';
		document.getElementById('page_cart').className = 'hidden';
	}
};

var update_checkout_components = function() {
	if (slot_quantity_field) {
		if (is_child) {
			document.getElementById('slot_quantity_field').className = 'hidden';
			document.getElementById('slot_quantity_prohibited').className = 'text-lighter';
		} else {
			document.getElementById('slot_quantity_field').className = 'text-center';
			document.getElementById('slot_quantity_prohibited').className = 'hidden';
		}
	}
	if (is_child || owns_omni) {
		document.getElementById('omni_checkbox_frame').className = 'hidden';
		document.getElementById('omni_owned_caption').className = 'text-lighter';
	} else {
		document.getElementById('omni_checkbox_frame').className = '';
		document.getElementById('omni_owned_caption').className = 'hidden';
	}
	update_total();
};

var validate_email = function(email) {
	re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(String(email).trim().toLowerCase());
};

var lookup_email = function(email) {
	if (validate_email(email)) {
		request.get('/omni/lookup', {'email': email}, function(obj) {
			owns_omni = obj.omni;
			is_child = obj.child;
			update_checkout_components();
		}, function(status, body) {
			owns_omni = false;
			is_child = false;
			update_checkout_components();
		});
	} else {
		owns_omni = false;
		is_child = false;
		update_checkout_components();
	}
};

document.addEventListener('DOMContentLoaded', function() {
	stw_quantity_field = document.getElementById('stw_quantity_field');
	slot_quantity_field = document.getElementById('slot_quantity_field');
	gift_quantity_field = document.getElementById('gift_quantity_field');
	
	update_checkout_components();
	set_view_mode();
	
	document.getElementById('buy-button').addEventListener('click', function(ev) {
		history.pushState({}, '', '/omni/#checkout');
		var popStateEvent = new PopStateEvent('popstate', {});
		dispatchEvent(popStateEvent);
		ev.preventDefault();
	});
	
	document.getElementById('cart_back_button').addEventListener('click', function(ev) {
		history.pushState({}, '', '/omni/');
		var popStateEvent = new PopStateEvent('popstate', {});
		dispatchEvent(popStateEvent);
		ev.preventDefault();
	});
	
	if (stw_quantity_field) {
		stw_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	
	if (gift_quantity_field) {
		gift_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	
	if (slot_quantity_field) {
		slot_quantity_field.addEventListener('input', function(ev) {
			update_total();
		});
	}
	
	document.getElementById('omni_checkbox').addEventListener('change', function(ev) {
		update_total();
	});
	
	document.getElementById('stripe_checkout_button').addEventListener('click', function(ev) {
		this.disabled = true;
		
		var include_omni = owns_omni === false && is_child === false && document.getElementById('omni_checkbox').checked;
		var stw_quantity = 0;
		if (stw_quantity_field) {
			stw_quantity = Math.min(stw_quantity_field.value, 10);
		}
		var gift_quantity = 0;
		if (gift_quantity_field) {
			gift_quantity = Math.min(gift_quantity_field.value, 10);
		}
		var slot_quantity = 0;
 		if (is_child === false && slot_quantity_field) {
 			slot_quantity = Math.min(slot_quantity_field.value, 20);
 		}
 		
 		if (owns_omni === false && include_omni === false && slot_quantity > 0) {
 			this.disabled = false;
 			dialog.show('You must own Beacon Omni to purchase team licenses.', 'Team members inherit their license from your account. You must own Beacon Omni to add members to your team.');
 			return;
 		}
 		
 		var checkout_final = function() {
			var url = '/omni/begin';
			var formdata = {
				'email': document.getElementById('checkout_email_field').value,
			};
			if (include_omni) {
				formdata.omni = true;
			}
			if (stw_quantity > 0) {
				formdata.stw = stw_quantity;
			}
			if (gift_quantity > 0) {
				formdata.gift = gift_quantity;
			}
			if (slot_quantity > 0) {
				formdata.slot = slot_quantity;
			}
			
			request.post(url, formdata, function(obj) {
				if (sessionStorage) {
					sessionStorage.setItem('client_reference_id', obj.client_reference_id);
				}
				
				window.location.href = obj.url;
			}, function(status, body) {
				var error = JSON.parse(body);
				var message = body;
				if (error.message) {
					message = error.message;
				}
				dialog.show('There was an issue starting the checkout process.', message);
				document.getElementById('stripe_checkout_button').disabled = false;
			});
		};
		
		if (slot_quantity > 0) {
			dialog.confirm('Beacon Team licenses are not for resale.', 'Team licenses are intended for your admins to help you run your server or cluster. If you are caught abusing this feature in any way, such as reselling licenses, all your licenses will be terminated and you will not receive a refund.', 'I Agree', 'Cancel').then(checkout_final).catch(update_total);
		} else {
			checkout_final();
		}
	});
	
	document.getElementById('checkout_email_field').addEventListener('input', function() {
		var callback = function () {
			lookup_email(this.value);
		};
		callback = callback.bind(this);
		
		if (this.timer) {
			clearTimeout(this.timer);
		}
		this.timer = setTimeout(callback, 250);
	});
	
	var email = null;
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
	
	var currency_links = document.getElementsByClassName('currency-button');
	for (var i = 0; i < currency_links.length; i++) {
		var currency_link = currency_links.item(i);
		currency_link.addEventListener('click', function(ev) {
			var currency_code = this.getAttribute('currency');
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
			<?php if ($stable_version >= 10501300) { ?>
			<tr>
				<td>GameServerApp.com Support<?php if ($stable_version < 10600300) { ?><span class="tag blue mini left-space">New in Beacon 1.5.1</span><?php } ?><br><span class="smaller text-lighter">Import and update GameServerApp.com config templates with only a few clicks.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<?php } ?>
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
				<td>Breeding Multipliers<br><span class="smaller text-lighter">Adjust any of the 8 breeding-related multipliers with realtime display of their effects on Ark's creatures and their imprint times.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<tr>
				<td>Day and Night Cycle<br><span class="smaller text-lighter">Change the length of Ark's days and nights using minutes instead of multipliers.</span></td>
				<td class="text-center bullet-column">&check;</td>
				<td class="text-center bullet-column">&check;</td>
			</tr>
			<?php if ($stable_version >= 10500300) { ?>
			<tr>
				<td>Decay and Spoil<?php if ($stable_version < 10600300) { ?><span class="tag blue mini left-space">New in Beacon 1.5</span><?php } ?><br><span class="smaller text-lighter">Change and preview item decay, decomposition, and spoil times.</span></td>
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
	<table class="generic">
		<tr>
			<td colspan="3">
				<p>Beacon Account E-Mail Address</p>
				<p><input type="email" name="email" id="checkout_email_field" placeholder="E-Mail Address"></p>
				<p class="text-lighter smaller">If you do not already have an account, you will be required to verify this email address before you can use your purchase.</p>
			</td>
		</tr>
		<tr>
			<td>Beacon Omni<br><span class="smaller text-lighter">Purchase a copy of Beacon Omni for yourself.</span></td>
			<td class="quantity_column"><div id="omni_checkbox_frame"><label class="checkbox"><input type="checkbox" name="omni" id="omni_checkbox" checked><span></span></label></div><span id="omni_owned_caption" class="hidden">Owned</span></td>
			<td class="price_column"><?php echo htmlentities($product_details['omni']['price_formatted']); ?></td>
		</tr>
		<?php if ($teams_enabled) { ?><tr id="slots_row">
 			<td><span class="tag red">Beta</span> Team Member Account<br><span class="smaller text-lighter">Need to purchase Beacon Omni for another admin on your team? Additional team member licenses can be purchased at any time. <a href="team">Learn more about Beacon for teams</a>.<br><strong>This feature requires Beacon 1.5, which is currently in testing.</strong></span></td>
 			<td class="quantity_column"><input class="text-center" type="number" value="0" id="slot_quantity_field" min="0" max="20"><span id="slot_quantity_prohibited" class="hidden">N/A</span></td>
 			<td class="price_column"><?php echo htmlentities($product_details['slot']['price_formatted']); ?>
 		</tr><?php } ?>
		<tr>
			<td>Beacon Omni Gift Codes<br><span class="smaller text-lighter">If you would like to purchase a copy of Beacon Omni for somebody else, this is the option for you. You'll be given codes which you can distribute any way you feel like.</span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="gift_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($product_details['gift']['price_formatted']); ?>
		</tr>
		<tr>
			<td>Beacon Share The Wealth<br><span class="smaller text-lighter">Beacon Share The Wealth is an optional purchase that allows you to show further financial support by gifting copies of Beacon Omni to <em>random</em> users at a reduced cost. <a href="stw">Learn More</a></span></td>
			<td class="quantity_column"><input class="text-center" type="number" value="0" id="stw_quantity_field" min="0" max="10"></td>
			<td class="price_column"><?php echo htmlentities($product_details['stw']['price_formatted']); ?>
		</tr>
		<tr>
			<td colspan="2" class="text-right">Total</td>
			<td class="price_column" id="total_field"><?php echo htmlentities($product_details['omni']['price_formatted']); ?></td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
				<div id="checkout_button_cell"><button class="default" id="stripe_checkout_button">Checkout</button></div>
				<div id="checkout_methods_cell" class="<?php echo strtolower($currency); ?>"><?php
				
				$payment_methods = [
					'universal' => ['apple', 'google', 'mastercard', 'visa', 'amex', 'discover', 'dinersclub', 'jcb'],
					'usd' => [],
					'eur' => ['bancontact', 'eps', 'giropay', 'ideal', 'p24']
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