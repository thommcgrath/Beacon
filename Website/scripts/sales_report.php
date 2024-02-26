#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

define('SQL_DATE_FORMAT', 'Y-m-d H:i:sO');
$query = "SELECT SUM(total_paid_usd - tax_usd) AS total_usd, COUNT(purchase_id) AS num_sales FROM purchases WHERE purchase_date >= $1 AND purchase_date < $2 AND refunded = FALSE AND total_paid > 0;";
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
$lastOfMonth = clone $today;
$daysInMonth = $today->format('t');
$monthName = $today->format('M');

$rollingDays = 28;
$rollingStart = clone $today;
$rollingStart->sub(new DateInterval('P' . $rollingDays . 'D'));
$rollingEnd = clone $today;
$rollingRows = $database->Query("SELECT COALESCE(SUM(purchases.total_paid_usd - purchases.tax_usd), 0) AS total_usd FROM public.purchases WHERE purchases.purchase_date >= $1 AND purchases.purchase_date < $2 AND purchases.refunded = FALSE AND purchases.total_paid > 0;", $rollingStart->format(SQL_DATE_FORMAT), $rollingEnd->format(SQL_DATE_FORMAT));
$rollingTotal = $rollingRows->Field('total_usd');
$rollingAverage = $rollingTotal / $rollingDays;
$projection = $rollingAverage * $daysInMonth;

$gameRows = $database->Query("SELECT game_id FROM public.games WHERE public = TRUE ORDER BY game_id;");

$fields = [];
$dailyTotal = RunReport("Day's", null, $yesterday, $today, $fields);
$monthTotal = RunReport('MTD', null, $firstOfMonth, $lastOfMonth, $fields);
while (!$gameRows->EOF()) {
	$gameId = $gameRows->Field('game_id');
	RunReport("Daily {$gameId}", $gameId, $yesterday, $today, $fields, $dailyTotal);
	RunReport("MTD {$gameId}", $gameId, $firstOfMonth, $lastOfMonth, $fields, $monthTotal);
	$gameRows->MoveNext();
}
$fields[] = [
	'title' => "Daily Average",
	'value' => '$' . number_format($rollingAverage, 2),
	'short' => true
];
$fields[] = [
	'title' => "{$monthName} Projection",
	'value' => '$' . number_format($projection, 2),
	'short' => true
];

$arr = [
	'attachments' => [
		[
			'title' => 'Daily Sales Report',
			'text' => "Sales report for {$yesterday->format('Y-m-d')}",
			'fields' => $fields,
		],
	],
];
if (BeaconCommon::InProduction()) {
	BeaconCommon::PostSlackRaw(json_encode($arr));
} else {
	echo json_encode($arr, JSON_PRETTY_PRINT);
}

function RunReport(string $label, ?string $gameId, DateTime $periodStart, DateTime $periodEnd, array &$fields, ?float $periodTotal = null): float {
	$database = BeaconCommon::Database();
	if (is_null($gameId)) {
		$rows = $database->Query("SELECT COALESCE(SUM(purchases.total_paid_usd - purchases.tax_usd), 0) AS total_usd, COUNT(purchases.purchase_id) AS num_sales FROM public.purchases WHERE purchases.purchase_date >= $1 AND purchases.purchase_date < $2 AND purchases.refunded = FALSE AND purchases.total_paid > 0;", $periodStart->format(SQL_DATE_FORMAT), $periodEnd->format(SQL_DATE_FORMAT));
	} else {
		$rows = $database->Query("SELECT COALESCE(SUM(purchase_items.line_total_usd - purchase_items.tax_usd), 0) AS total_usd, COUNT(purchase_items.line_id) AS num_sales FROM public.purchase_items INNER JOIN public.purchases ON (purchase_items.purchase_id = purchases.purchase_id) WHERE purchases.purchase_date >= $1 AND purchases.purchase_date < $2 AND purchases.refunded = FALSE AND purchases.total_paid > 0 AND purchase_items.product_id IN (SELECT products.product_id FROM public.products WHERE game_id = $3);", $periodStart->format(SQL_DATE_FORMAT), $periodEnd->format(SQL_DATE_FORMAT), $gameId);
	}

	$total = $rows->Field('total_usd');
	$numSales = number_format($rows->Field('num_sales'));
	$salesFormatted = '$' . number_format($total, 2);
	if (is_null($gameId) === false) {
		if ($periodTotal > 0) {
			$percentage = $total / $periodTotal;
		} else {
			$percentage = 0;
		}
		$salesFormatted .= ' (' . number_format($percentage * 100, 1) . '%)';
	}

	$fields[] = [
		'title' => "{$numSales} {$label} Sales",
		'value' => $salesFormatted,
		'short' => true,
	];

	return $total;
}

?>
