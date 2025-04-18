<?php

$database = BeaconCommon::Database();
$licenses = $user->Licenses();
$has_purchased = count($licenses) > 0;

if (!$has_purchased) {
	echo '<p class="text-center">You have not purchased Beacon Omni.<br><a href="/omni/">Learn more about Beacon Omni here.</a></p>';
	ShowGiftCodes();
	return;
}

$purchases = $database->Query('SELECT purchase_id, EXTRACT(epoch FROM purchase_date) AS purchase_date, total, currency, refunded FROM purchases WHERE purchaser_email = $1 ORDER BY purchase_date DESC;', $user->EmailID());

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));

?><p>Thanks for purchasing Beacon Omni! Your support means a lot.</p>
<div id="section-activation" class="visual-group">
	<h3>Activating Beacon Omni</h3>
	<div id="omni_instructions_internet"><?php include(BeaconCommon::WebRoot() . '/omni/welcome/instructions.php'); ?></div>
</div><?php

ShowLicenses();
ShowGiftCodes();
ShowPurchases();

function ShowGiftCodes() {
	global $user;

	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT gift_codes.code, gift_codes.redemption_date, (SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(products_template))) FROM (SELECT products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = gift_codes.code) AS products_template) AS products FROM gift_codes INNER JOIN purchases ON (gift_codes.source_purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 ORDER BY purchases.purchase_date DESC;', $user->EmailID());
	if ($results->RecordCount() == 0) {
		return;
	}

	echo '<div id="section-gifts" class="visual-group">';
	echo '<h3>Gift Codes</h3>';
	echo '<p>Codes can be redeemed at <a href="/redeem">' . BeaconCommon::AbsoluteURL('/redeem') . '</a> or using the link next to each code.</p>';
	echo '<table class="generic"><thead><tr><th class="w-40">Code</th><th class="low-priority w-60">Redemption Link</th></thead>';
	while (!$results->EOF()) {
		$code = $results->Field('code');
		$redeemed = is_null($results->Field('redemption_date')) === false;
		$products = json_decode($results->Field('products'), true);
		$products_list = [];
		foreach ($products as $product) {
			if ($product['quantity'] > 1) {
				$products_list[] = $product['quantity'] . ' x ' . $product['product_name'];
			} else {
				$products_list[] = $product['product_name'];
			}
		}

		echo '<tr><td class="w-40"><span class="text-lighter smaller">' . htmlentities(BeaconCommon::ArrayToEnglish($products_list)) . '</span><br>' . htmlentities($code) . '<div class="row-details"><span class="detail">' . ($redeemed ? 'Redeemed' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '<span></div></td><td class="low-priority w-40">' . ($redeemed ? 'Redeemed' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '</td></tr>';
		$results->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

function ShowLicenses() {
	global $user, $licenses, $database;

	if (count($licenses) === 0) {
		return;
	}

	echo '<div id="section-licenses" class="visual-group">';
	echo '<h3>Licenses</h3>';
	echo '<table class="generic"><thead><tr><th class="w-50">Product</th><th class="low-priority w-30">Updates Until</th><th class="low-priority w-20">Actions</th></thead>';
	$now = new DateTime();
	foreach ($licenses as $license) {
		$licenseId = $license->LicenseId();
		$purchaseId = $license->PurchaseId();
		$productId = $license->ProductId();
		$productName = $license->ProductName();
		$expiration = $license->Expiration();
		$actions = [
			'View' => '/account/purchase/' . $purchaseId
		];

		if (is_null($expiration)) {
			$expirationText = 'Forever';
		} else {
			$exp = new DateTime($expiration);
			$expirationText = '<time datetime="' . htmlentities($exp->format('Y-m-d H:i:s.000O')) . '">' . htmlentities($exp->format('F jS Y')) . '</time>';
			$renew_caption = ($exp->getTimestamp() < time() ? 'Renew' : 'Extend');
			$actions[$renew_caption] = '/omni/license/' . urlencode($licenseId);

			if ($exp < $now) {
				// The license has expired
				$maxBuild = $license->NewestLicensedBuild();
				$versions = $database->Query('SELECT build_number, build_display FROM public.updates WHERE published IS NOT NULL AND build_number <= $1 ORDER BY build_number DESC LIMIT 1;', $maxBuild);
				$maxBuild = $versions->Field('build_number');
				$maxVersion = $versions->Field('build_display');
				$downloadTokenExpiration = time() + 900;
				$downloadTokenSecret = BeaconCommon::GetGlobal('Legacy Download Secret');
				$downloadToken = BeaconCommon::Base64UrlEncode(hash('sha3-512', "{$maxBuild}:{$downloadTokenExpiration}:{$downloadTokenSecret}", true));
				$actions["Download {$maxVersion}"] = "/download?build={$maxBuild}&token={$downloadToken}&expires={$downloadTokenExpiration}";
			}
		}

		$actionHtmlMembers = [];
		foreach ($actions as $text => $url) {
			$actionHtmlMembers[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actionsHtml = implode(' ', $actionHtmlMembers);

		echo '<tr><td class="w-50">' . htmlentities($productName) . '<div class="row-details"><span class="detail">Receives updates through ' . $expirationText . '</span><span class="detail">Actions: ' . $actionsHtml . '</div></td><td class="low-priority w-30 smaller">' . $expirationText . '</td><td class="low-priority w-20 text-center">' . $actionsHtml . '</td></tr>';
	}
	echo '</table>';
	echo '</div>';
}

function ShowPurchases() {
	global $user, $purchases;

	if ($purchases->RecordCount() === 0) {
		return;
	}

	echo '<div id="section-licenses" class="visual-group">';
	echo '<h3>All Purchases</h3>';
	echo '<table class="generic"><thead><tr><th class="w-60">Purchase Date</th><th class="w-20">Total</th><th class="low-priority w-20">Actions</th></thead>';
	while ($purchases->EOF() === false) {
		$purchase_id = $purchases->Field('purchase_id');
		$actions = ['View' => '/account/purchase/' . $purchase_id];
		$purchase_time = intval($purchases->Field('purchase_date'));
		$purchase_time_str = '<time datetime="' . date(DATE_ISO8601, $purchase_time) . '">' . htmlentities(date('F jS Y g:i:s A e', $purchase_time)) . '</time>';
		$refunded = $purchases->Field('refunded');

		$actions_html_members = [];
		foreach ($actions as $text => $url) {
			$actions_html_members[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actions_html = implode(' ', $actions_html_members);

		$total = $purchases->Field('total');
		$currency = $purchases->Field('currency');

		if ($refunded) {
			$purchase_time_str = '<span class="redacted text-red">' . $purchase_time_str . '</span> Refunded';
		}

		echo '<tr><td class="w-60">' . $purchase_time_str . '<div class="row-details"><span class="detail">Actions: ' . $actions_html . '</span></div></td><td class="w-20 text-right nowrap formatted-price" beacon-currency="' . htmlentities($currency) . '">' . htmlentities($total) . '</td><td class="low-priority w-20 text-center">' . $actions_html . '</td>';

		$purchases->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

?>
