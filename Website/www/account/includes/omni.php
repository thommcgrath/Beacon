<?php

$database = BeaconCommon::Database();
$licenses = $database->Query('SELECT purchase_id, product_id, product_name, purchase_date, EXTRACT(epoch FROM expiration) AS expiration FROM purchased_products WHERE purchaser_email = $1;', $user->EmailID());
$has_purchased = $licenses->RecordCount() > 0;
$purchases = $database->Query('SELECT purchase_id, EXTRACT(epoch FROM purchase_date) AS purchase_date, total_paid, currency, refunded FROM purchases WHERE purchaser_email = $1 ORDER BY purchase_date DESC;', $user->EmailID());

if (!$has_purchased) {
	echo '<div class="small_section"><p>You have not purchased Beacon Omni. <a href="/omni/">Learn more about Beacon Omni here.</a></p></div>';
	ShowGiftCodes();
	return;
}

BeaconTemplate::StartStyles(); ?>
<style>

#omni_instructions_internet, #omni_instructions_no_internet {
	margin-top: 40px;
	margin-bottom: 40px;
}

#drop_area, #drop_hover_instructions {
	display: none;
}

#upload_container.live-supported {
	#upload_activation_form {
		display: none;
	}
	
	#drop_area {
		display: block;
		text-align: center;
		border-width: 1px;
		border-style: solid;
		padding: 30px 15px;
		margin-left: auto;
		margin-right: auto;
		max-width: 500px;
		box-sizing: border-box;
		
		&.highlight {
			#drop_hover_instructions {
				display: inline;
			}
			
			#drop_initial_instructions {
				display: none;
			}
		}
	}
}

#img_signin_auth {
	background-image: url(/omni/welcome/auth.png);
	width: 150px;
	height: 118px;
}

#img_signin_import {
	background-image: url(/omni/welcome/import.png);
	width: 150px;
	height: 59px;
}

#img_signin_password {
	background-image: url(/omni/welcome/password.png);
	width: 150px;
	height: 59px;
	clear: left;
	margin-top: 6px;
}

.omni-section {
	width: 95%;
	margin-left: auto;
	margin-right: auto;
	margin-top: 3em;
	margin-bottom: 3em;
	box-sizing: border-box;
}

.action-link+.action-link {
	margin-left: 12px;
}

</style><?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	document.getElementById('omni_show_instructions_internet').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var instructions = document.getElementById('omni_instructions_internet');
		if (instructions.className == 'hidden') {
			instructions.className = '';
		} else {
			instructions.className = 'hidden';
		}
	});
	
	document.getElementById('omni_show_instructions_no_internet').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var instructions = document.getElementById('omni_instructions_no_internet');
		if (instructions.className == 'hidden') {
			instructions.className = '';
		} else {
			instructions.className = 'hidden';
		}
	});
	
	let drag_and_drop_supported = self.fetch && window.FileReader && ('classList' in document.createElement('a'));
	if (drag_and_drop_supported) {
		var upload_file = function(file) {
			let formData = new FormData();
			formData.append('file', file);
			
			fetch(document.getElementById('upload_activation_form').getAttribute('action'), { method: 'POST', body: formData, credentials: 'same-origin', headers: {'Accept': 'application/json'} }).then(function(response) {
				if (!response.ok) {
					let obj = response.json().then(function(obj) {
						let message = 'Sorry, there was an error creating the authorization file.';
						if (obj.message) {
							message += ' ' + obj.message.trim();
						}
						if (!message.endsWith('.')) {
							message += '.';
						}
						dialog.show('Unable to create authorization file', message);
					});
					return;
				}
				
				let disposition = response.headers.get('content-disposition');
				let matches = /"([^"]*)"/.exec(disposition);
				let filename = (matches != null && matches[1] ? matches[1] : 'Default.beaconidentity');
				
				response.blob().then(function(blob) {
					let link = document.createElement('a');
					link.href = window.URL.createObjectURL(blob);
					link.download = filename;
					
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				});
			}).catch(function(error) {
				dialog.show('Unable to create authorization file', 'There was a network error: ' + error);
			});
		};
		
		var upload_container = document.getElementById('upload_container');
		upload_container.classList.add('live-supported');
		
		var drop_area = document.getElementById('drop_area');
		
		['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				e.preventDefault();
				e.stopPropagation();
			}, false);
		});
		
		['dragenter', 'dragover'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				this.classList.add('highlight');
			}, false);
		});
		
		['dragleave', 'drop'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				this.classList.remove('highlight');
			}, false);
		});
		
		document.getElementById('choose_file_button').addEventListener('click', function(ev) {
			ev.preventDefault();
			
			let chooser = document.getElementById('file_chooser');
			if (chooser) {
				chooser.addEventListener('change', function(ev) {
					upload_file(this.files[0]);
				});
				
				chooser.click();
			}
		});
		
		drop_area.addEventListener('drop', function(e) {
			upload_file(e.dataTransfer.files[0]);
		}, false);
	}
});
</script><?php
BeaconTemplate::FinishScript();

?><p>Thanks for purchasing Beacon Omni! Your support means a lot.</p>
<div id="section-activation" class="omni-section">
	<h2>Activating Beacon Omni</h2>
	<h3><a href="#with-internet" id="omni_show_instructions_internet">Option 1: Sign into your account in Beacon</a></h3>
	<div id="omni_instructions_internet" class="hidden"><?php include(BeaconCommon::WebRoot() . '/omni/welcome/instructions.php'); ?></div>
	<h3><a href="#without-internet" id="omni_show_instructions_no_internet">Option 2: Use an activation file for a computer without internet</a></h3>
	<div id="omni_instructions_no_internet" class="hidden">
		<div class="signin_step separator-color">
			<div id="img_signin_auth" class="img_signin separator-color">&nbsp;</div>
			<div class="signin_text">
				<h4>Create an Offline Authorization Request</h4>
				<p>Using the Help menu, choose &quot;Create Offline Authorization Request&quot; and save the file when prompted. You will need to transfer the to this computer. A USB memory stick is usually the easiest way to do it.</p>
			</div>
			<div class="push">&nbsp;</div>
		</div>
		<div class="signin_step separator-color" id="upload_container">
			<form id="upload_activation_form" method="post" action="/account/actions/activate" enctype="multipart/form-data">
				<input type="file" name="file" accept=".beaconauth" id="file_chooser"><input type="submit" value="Upload">
			</form>
			<div id="drop_area" class="separator-color"><span id="drop_initial_instructions">Drop your activation file here or <a href="" id="choose_file_button">choose the file</a>.</span><span id="drop_hover_instructions">Do it!</span></div>
		</div>
		<div class="signin_step separator-color">
			<div id="img_signin_import" class="img_signin separator-color">&nbsp;</div>
			<div id="img_signin_password" class="img_signin separator-color">&nbsp;</div>
			<div class="signin_text">
				<h4>Import your identity file</h4>
				<p>After uploading your activation file, you will have downloaded an identity file. Transfer the identity file back to the computer which created the authorization request.</p>
				<p>In Beacon, use the File menu, choose &quot;Import&quot; and select the identity file. When prompted, enter your account password.</p>
				<p>That's it, Beacon Omni will be ready for use.</p>
			</div>
			<div class="push">&nbsp;</div>
		</div>
	</div>
</div><?php

ShowLicenses();
ShowGiftCodes();
ShowPurchases();

function ShowGiftCodes() {
	global $user;
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT gift_codes.code, gift_codes.redemption_date, products.product_name FROM gift_codes INNER JOIN purchases ON (gift_codes.source_purchase_id = purchases.purchase_id) INNER JOIN products ON (gift_codes.product_id = products.product_id) WHERE purchases.purchaser_email = $1 ORDER BY purchases.purchase_date DESC;', $user->EmailID());
	if ($results->RecordCount() == 0) {
		return;
	}
	
	echo '<div id="section-gifts" class="omni-section">';
	echo '<h2>Gift Codes</h2>';
	echo '<p>Codes can be redeemed at <a href="/redeem">' . BeaconCommon::AbsoluteURL('/redeem') . '</a> or using the link next to each code.</p>';
	echo '<table class="generic"><thead><tr><th class="w-40">Code</th><th class="low-priority w-20">Status</th><th class="low-priority w-40">Redeem Link</th></thead>';
	while (!$results->EOF()) {
		$code = $results->Field('code');
		$redeemed = is_null($results->Field('redemption_date')) === false;
		$product_name = $results->Field('product_name');
		
		echo '<tr><td class="w-40"><span class="text-lighter smaller">' . htmlentities($product_name) . '</span><br>' . htmlentities($code) . '<div class="row-details"><span class="detail">' . ($redeemed ? 'Redeemed' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '<span></div></td><td class="low-priority w-20">' . ($redeemed ? 'Redeemed' : '&nbsp;') . '</td><td class="low-priority w-40">' . ($redeemed ? '&nbsp;' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '</td>';
		$results->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

function ShowLicenses() {
	global $user, $licenses;
	
	if ($licenses->RecordCount() === 0) {
		return;
	}
	
	echo '<div id="section-licenses" class="omni-section">';
	echo '<h2>Beacon Licenses</h2>';
	echo '<table class="generic"><thead><tr><th class="w-50">Product</th><th class="low-priority w-25">Updates Until</th><th class="low-priority w-25">Actions</th></thead>';
	while ($licenses->EOF() === false) {
		$purchase_id = $licenses->Field('purchase_id');
		$product_id = $licenses->Field('product_id');
		$product_name = $licenses->Field('product_name');
		$expiration_seconds = $licenses->Field('expiration');
		$actions = [
			'View' => '/account/purchase/' . $purchase_id
		];
		
		if (is_null($expiration_seconds)) {
			$expiration_str = 'Forever';
		} else {
			$expiration_str = '<time datetime="' . date('Y-m-d H:i:s.000O', $expiration_seconds) . '">' . htmlentities(date('F jS Y', $expiration_seconds)) . '</time>';
			$renew_caption = ($expiration_seconds < time() ? 'Renew' : 'Extend');
			$actions[$renew_caption] = '/omni/buy/' . $product_id;
		}
		
		$actions_html_members = [];
		foreach ($actions as $text => $url) {
			$actions_html_members[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actions_html = implode(' ', $actions_html_members);
		
		echo '<tr><td class="w-50">' . htmlentities($product_name) . '<div class="row-details"><span class="detail">Receives updates through ' . $expiration_str . '</span><span class="detail">Actions: ' . $actions_html . '</div></td><td class="low-priority w-25">' . $expiration_str . '</td><td class="low-priority w-25 text-center">' . $actions_html . '</td></tr>';
		
		$licenses->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

function ShowPurchases() {
	global $user, $purchases;
	
	if ($purchases->RecordCount() === 0) {
		return;
	}
	
	echo '<div id="section-licenses" class="omni-section">';
	echo '<h2>All Purchases</h2>';
	echo '<table class="generic"><thead><tr><th class="w-60">Purchase Date</th><th class="w-20">Total</th><th class="low-priority w-20">Actions</th></thead>';
	while ($purchases->EOF() === false) {
		$purchase_id = $purchases->Field('purchase_id');
		$actions = ['View' => '/account/purchase/' . $purchase_id];
		$purchase_time = intval($purchases->Field('purchase_date'));
		$purchase_time_str = '<time datetime="' . date('Y-m-d H:i:s.000O', $purchase_time) . '">' . htmlentities(date('F jS Y g:i:s A e', $purchase_time)) . '</time>';
		$refunded = $purchases->Field('refunded');
		
		$actions_html_members = [];
		foreach ($actions as $text => $url) {
			$actions_html_members[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actions_html = implode(' ', $actions_html_members);
		
		$total = $purchases->Field('total_paid');
		$currency = $purchases->Field('currency');
		$total_formatted = BeaconShop::FormatPrice($total, $currency);
			
		if ($refunded) {
			$purchase_time_str = '<span class="redacted text-red">' . $purchase_time_str . '</span> Refunded';
		}
		
		echo '<tr><td class="w-60">' . $purchase_time_str . '<div class="row-details"><span class="detail">Actions: ' . $actions_html . '</span></div></td><td class="w-20 text-right nowrap">' . htmlentities($total_formatted) . '</td><td class="low-priority w-20 text-center">' . $actions_html . '</td>';
		
		$purchases->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

?>
