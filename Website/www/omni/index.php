<?php
	
define('OMNI_UUID', '972f9fc5-ad64-4f9c-940d-47062e705cc5');
define('STW_UUID', 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015');
define('GIFT_UUID', '2207d5c1-4411-4854-b26f-bc4b48aa33bf');
define('SLOT_UUID', '10b653d8-1e17-4b5c-bb01-bca9e86149f9');

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::AddHeaderLine('<script src="https://js.stripe.com/v3/"></script>');

$database = BeaconCommon::Database();

$results = $database->Query('SELECT product_id, stripe_sku, retail_price FROM products;');
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
		'price' => $results->Field('retail_price'),
		'price_formatted' => '$' . number_format($results->Field('retail_price'), 2, '.', ',') . ' USD',
		'sku' => $results->Field('stripe_sku')
	];
	
	$results->MoveNext();
}

if (isset($product_details['omni']) === false) {
	throw new Exception('Unable to find Omni product');
	exit;
}

BeaconTemplate::StartStyles(); ?>
<style type="text/css">

table.generic .bullet-column {
	width: 100px;
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

</style>
<?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript();
?>
<script>
var owns_omni = false;
var is_child = false;

var update_total = function() {
	var include_omni = owns_omni === false && is_child === false && document.getElementById('omni_checkbox').checked;
	var stw_quantity = Math.min(document.getElementById('stw_quantity_field').value, 10);
	var gift_quantity = Math.min(document.getElementById('gift_quantity_field').value, 10);
	var slot_quantity = 0;
 	if (is_child === false) {
 		slot_quantity = Math.min(document.getElementById('slot_quantity_field').value, 20);
 	}
	
	if (document.getElementById('stw_quantity_field').value != stw_quantity) {
		document.getElementById('stw_quantity_field').value = stw_quantity;
	}
	if (document.getElementById('gift_quantity_field').value != gift_quantity) {
		document.getElementById('gift_quantity_field').value = gift_quantity;
	}
	if (document.getElementById('slot_quantity_field').value != slot_quantity) {
 		document.getElementById('slot_quantity_field').value = slot_quantity
 	}
	
	var omni_price = <?php echo json_encode($product_details['omni']['price'] * 100); ?>;
	var stw_price = <?php echo json_encode($product_details['stw']['price'] * 100); ?>;
	var gift_price = <?php echo json_encode($product_details['gift']['price'] * 100); ?>;
	var slot_price = <?php echo json_encode($product_details['slot']['price'] * 100); ?>;
	var total = (stw_price * stw_quantity) + (gift_price * gift_quantity) + (slot_price * slot_quantity);
	if (include_omni) {
		total += omni_price;
	}
	
	document.getElementById('total_field').innerHTML = '$' + (total / 100).toFixed(2) + ' USD';
	document.getElementById('stripe_checkout_button').disabled = (total == 0);
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
	if (is_child) {
		document.getElementById('slot_quantity_field').className = 'hidden';
		document.getElementById('slot_quantity_prohibited').className = 'text-lighter';
	} else {
		document.getElementById('slot_quantity_field').className = 'text-center';
		document.getElementById('slot_quantity_prohibited').className = 'hidden';
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

var lookup_email = function(email) {
	request.get('/omni/lookup', {'email': email}, function(obj) {
		owns_omni = obj.omni;
 		is_child = obj.child;
		update_checkout_components();
	}, function(status, body) {
		owns_omni = false;
		is_child = fase;
		update_checkout_components();
	});
};

var validate_email = function(email) {
	const re = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
	return re.test(String(email).toLowerCase());
};

document.addEventListener('DOMContentLoaded', function() {
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
	
	document.getElementById('stw_quantity_field').addEventListener('input', function(ev) {
		update_total();
	});
	
	document.getElementById('gift_quantity_field').addEventListener('input', function(ev) {
		update_total();
	});
	
	document.getElementById('slot_quantity_field').addEventListener('input', function(ev) {
 		update_total();
 	});
	
	document.getElementById('omni_checkbox').addEventListener('change', function(ev) {
		update_total();
	});
	
	document.getElementById('stripe_checkout_button').addEventListener('click', function(ev) {
		if (validate_email(document.getElementById('checkout_email_field').value) === false) {
			dialog.show('Please enter a valid email address.', 'Without a real email address, you would not be able to use your purchase.');
			return;
		}
		
		this.disabled = true;
		
		var include_omni = owns_omni === false && is_child === false && document.getElementById('omni_checkbox').checked;
		var stw_quantity = Math.min(document.getElementById('stw_quantity_field').value, 10);
		var gift_quantity = Math.min(document.getElementById('gift_quantity_field').value, 10);
		var slot_quantity = 0;
 		if (is_child === false) {
 			slot_quantity = Math.min(document.getElementById('slot_quantity_field').value, 20);
 		}
 		
 		if (owns_omni === false && include_omni === false && slot_quantity > 0) {
 			this.disabled = false;
 			dialog.show('You must own Beacon Omni to purchase team licenses.', 'Team members inherit their license from your account. You must own Beacon Omni to add members to your team.');
 			return;
 		}
 		
 		let checkout_final = function() {
	 		var items = [];
			if (include_omni) {
				items.push({sku: <?php echo json_encode($product_details['omni']['sku']); ?>, quantity: 1});
			}
			if (stw_quantity > 0) {
				items.push({sku: <?php echo json_encode($product_details['stw']['sku']); ?>, quantity: stw_quantity});
			}
			if (gift_quantity > 0) {
				items.push({sku: <?php echo json_encode($product_details['gift']['sku']); ?>, quantity: gift_quantity});
			}
			if (slot_quantity > 0) {
	 			items.push({sku: <?php echo json_encode($product_details['slot']['sku']); ?>, quantity: slot_quantity});
	 		}
			
			var stripe = Stripe(<?php echo json_encode(BeaconCommon::GetGlobal('Stripe_Public_Key')); ?>, {});
			
			function uuidv4() {
				return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16));
			}
			
			var client_reference_id = uuidv4();
			if (sessionStorage) {
				sessionStorage.setItem('client_reference_id', client_reference_id);
			}
			
			var checkout = {
				items: items,
				successUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/welcome/')); ?>,
				cancelUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/#checkout')); ?>,
				clientReferenceId: client_reference_id,
				billingAddressCollection: 'required',
				customerEmail: document.getElementById('checkout_email_field').value
			};
			
			stripe.redirectToCheckout(checkout).then(function (result) {
				if (result.error) {
					dialog.show('Unable to start Stripe checkout', result.error.message);
				}
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
				<td>Loot Drops<br><span class="smaller text-lighter">Beacon's original purpose, editing loot drops, is what it does best.</span></td>
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
				<td>Day and Night Cycle<br><span class="smaller text-lighter">Change the length of Ark's days and nights using minutes instead of multipliers.</span></td>
				<td class="text-center bullet-column">&#10687;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>Player and Creature Stat Multipliers<br><span class="smaller text-lighter">Change the stats of players, wild creatures, and tamed creatures.</span></td>
				<td class="text-center bullet-column">&#10687;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>Item Stat Limits<br><span class="smaller text-lighter">Globally limit item stats to precise admin-defined amounts, just like official servers.</span></td>
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
				<td>Creature Spawn Points<br><span class="smaller text-lighter">Add, remove, or change the creatures available on any map. Want to add lots of Featherlights to The Island, or put one really high level Pteranodon on Aberration? It's possible.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>Engram Control<br><span class="smaller text-lighter">Change when engrams are unlockable, if they auto-unlock, and the number of engram points awarded each level. Beacon's powerful wizard allows users to instantly build full engram designs, such as auto-unlocking everything except tek items at spawn.</span></td>
				<td class="text-center bullet-column">&nbsp;</td>
				<td class="text-center bullet-column">&#10687;</td>
			</tr>
			<tr>
				<td>More config types on the way<br><span class="smaller text-lighter">With each major release, Beacon adds new editor types to both the free edition and Beacon Omni.</span></td>
				<td class="text-center bullet-column">&#10687;</td>
				<td class="text-center bullet-column">&#10687;</td>
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
		<tr id="slots_row">
 			<td>Team Member Account<br><span class="smaller text-lighter">Need to purchase Beacon Omni for another admin on your team? Additional team member licenses can be purchased at any time. <a href="#">Learn more about Beacon for teams</a>.</span></td>
 			<td class="quantity_column"><input class="text-center" type="number" value="0" id="slot_quantity_field" min="0" max="20"><span id="slot_quantity_prohibited" class="hidden">N/A</span></td>
 			<td class="price_column"><?php echo htmlentities($product_details['slot']['price_formatted']); ?>
 		</tr>
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
			<td colspan="3" class="text-center"><button class="default" id="stripe_checkout_button">Checkout</button></td>
		</tr>
	</table>
</div>