#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$format = 'Y-m-d H:i:sO';
$database = BeaconCommon::Database();
$timezone = new DateTimeZone('America/New_York');
$today = new DateTime('now', $timezone);
$today->modify('today');
$yesterday = clone $today;
$yesterday->sub(new DateInterval('P1D'));
$isFirstOfMonth = $today->format('j') == 1;

if ($isFirstOfMonth) {
	$firstOfMonth = clone $yesterday;
} else {
	$firstOfMonth = clone $today;
}
$firstOfMonth->modify('first day of');
$lastOfMonth = clone $firstOfMonth;
$lastOfMonth->modify('last day of');
$lastOfMonth->modify('tomorrow');
$daysElapsed = $yesterday->format('j');
$numberOfDays = $firstOfMonth->format('t');

$dailyRows = $database->Query("SELECT SUM(total_paid_usd - tax_usd) AS total_usd, COUNT(purchase_id) AS num_sales FROM purchases WHERE purchase_date >= $1 AND purchase_date < $2 AND refunded = FALSE AND total_paid > 0;", $yesterday->format($format), $today->format($format));
$monthlyRows = $database->Query("SELECT SUM(total_paid_usd - tax_usd) AS total_usd, COUNT(purchase_id) AS num_sales FROM purchases WHERE purchase_date >= $1 AND purchase_date < $2 AND refunded = FALSE AND total_paid > 0;", $firstOfMonth->format($format), $lastOfMonth->format($format));

$yesterdayTotal = $dailyRows->Field('total_usd');
$yesterdayTransactions = $dailyRows->Field('num_sales');
$monthTotal = $monthlyRows->Field('total_usd');
$monthTransactions = $monthlyRows->Field('num_sales');
$dailyAverage = $monthTotal / $daysElapsed;
$projection = $dailyAverage * $numberOfDays;

$arr = [
	'attachments' => [
		[
			'title' => 'Daily Sales Report',
			'text' => "Sales report for {$yesterday->format('Y-m-d')}",
			'fields' => [
				[
					'title' => "Yesterday's Sales",
					'value' => '$' . number_format($yesterdayTotal, 2),
					'short' => true
				],
				[
					'title' => "Yesterday's Transactions",
					'value' => number_format($yesterdayTransactions),
					'short' => true
				],
				[
					'title' => "MTD Sales",
					'value' => '$' . number_format($monthTotal, 2),
					'short' => true
				],
				[
					'title' => "MTD Transactions",
					'value' => number_format($monthTransactions),
					'short' => true
				],
				[
					'title' => "Daily Average",
					'value' => '$' . number_format($dailyAverage, 2),
					'short' => true
				],
				[
					'title' => "Projection",
					'value' => '$' . number_format($projection, 2),
					'short' => true
				],
			],
		],
	],
];
BeaconCommon::PostSlackRaw(json_encode($arr));

?>
