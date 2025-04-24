<?php

$purchases = $database->Query('SELECT purchase_id, EXTRACT(epoch FROM purchase_date) AS purchase_date, total, currency, refunded FROM purchases WHERE purchaser_email = $1 ORDER BY purchase_date DESC;', $user->EmailID());
$hasPurchases = $purchases->RecordCount() > 0;

if ($hasPurchases) {
	echo '<div id="section-billing-portal" class="visual-group">';
	echo '<h3>Billing Portal</h3>';
	echo '<p>Beacon uses Stripe for checkout and billing. The button below will open your billing portal at Stripe where you can make changes and see additional information.</p>';
	echo '<p><button class="default" id="openBillingPortalButton" return-url="' . htmlentities(BeaconCommon::AbsoluteUrl('/account/#billing')) . '">Go To Stripe Billing Portal</button></p>';
	echo '<p class="italic smaller">Note: Beacon Omni is not a subscription and does not store payment information.</p>';
	echo '</div>';
}

echo '<div id="section-licenses" class="visual-group">';
echo '<h3>All Purchases</h3>';

if ($hasPurchases) {
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
} else {
	echo '<p>You have not made any purchases yet. That&apos;s ok.</p>';
}

echo '</div>';

?>
