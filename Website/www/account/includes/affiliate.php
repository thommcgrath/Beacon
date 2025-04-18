<?php

$database = BeaconCommon::Database();
foreach ($affiliateCodes as $affiliate) {
	$rows = $database->Query('SELECT SUM(total) AS total, SUM(commission) AS commission, LEFT(purchase_date::TEXT, 7) AS month FROM public.affiliate_purchases WHERE affiliate_id = $1 GROUP BY month ORDER BY month DESC;', $affiliate->Code());
	if ($rows->RecordCount() === 0) {
		continue;
	}

	$tracking = $database->Query('SELECT COUNT(track_id) AS clicks, COUNT(purchase_id) AS purchases, LEFT(click_time::TEXT, 7) AS month FROM public.affiliate_tracking WHERE code = $1 GROUP BY month;', $affiliate->Code());
	$clickStats = [];
	while (!$tracking->EOF()) {
		$clickStats[$tracking->Field('month')] = [
			'clicks' => $tracking->Field('clicks'),
			'sales' => $tracking->Field('purchases'),
		];
		$tracking->MoveNext();
	}

	$share = $affiliate->RevenueShare();
	$header = $affiliate->Description();
	if ($share > 0) {
		$header .= ' (' . number_format($share * 100, 1) . '%)';
	}
	echo '<h3>' . htmlentities($header) . '</h3>';

	echo '<table class="generic"><thead><tr><td>Month</td><td>Clicks</td><td>Sales</td><td>CTR</td>';
	if ($share > 0) {
		echo '<td>Sales</td><td>Commission</td>';
	}
	echo '</tr></thead><tbody>';
	while (!$rows->EOF()) {
		$month = $rows->Field('month');
		$clicks = 0;
		$purchases = 0;
		$ctr = 0;
		if (isset($clickStats[$month])) {
			$clicks = $clickStats[$month]['clicks'];
			$sales = $clickStats[$month]['sales'];
			if ($clicks === 0) {
				$ctr = 0;
			} else {
				$ctr = $sales / $clicks;
			}
		}

		echo '<tr>';
		echo '<td>' . htmlentities($rows->Field('month')) . '</td>';
		echo '<td class="text-right">' . number_format($clicks, 0) . '</td>';
		echo '<td class="text-right">' . number_format($purchases, 0) . '</td>';
		echo '<td class="text-right">' . number_format($ctr * 100, 2) . '%</td>';
		if ($share > 0) {
			echo '<td class="text-right">$' . htmlentities($rows->Field('total'), 2) . '</td>';
			echo '<td class="text-right">$' . htmlentities($rows->Field('commission'), 2) . '</td>';
		}
		$rows->MoveNext();
	}
	echo '</tbody></table>';
}
