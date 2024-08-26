#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

define('SQL_DATE_FORMAT', 'Y-m-d H:i:sO');
$query = "SELECT COALESCE(SUM(purchases.total_paid_usd - purchases.tax_usd), 0) AS total_usd, COUNT(purchases.purchase_id) AS num_sales FROM public.purchases WHERE purchases.purchase_date >= $1 AND purchases.purchase_date < $2 AND purchases.refunded = FALSE AND purchases.total_paid > 0;";
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

$gameRows = $database->Query("SELECT game_id FROM public.games WHERE public = TRUE ORDER BY game_id;");

$fields = [];
$figures = [];
$dailyTotal = RunReport("Day's", null, $yesterday, $today, $fields);
$monthTotal = RunReport('MTD', null, $firstOfMonth, $lastOfMonth, $fields);
while (!$gameRows->EOF()) {
	$gameId = $gameRows->Field('game_id');
	RunReport("Daily {$gameId}", $gameId, $yesterday, $today, $fields, $dailyTotal);
	RunReport("MTD {$gameId}", $gameId, $firstOfMonth, $lastOfMonth, $fields, $monthTotal);
	$gameRows->MoveNext();
}

$remainingDays = ($daysInMonth - $today->format('d')) + 1; // Removes today, so +1 puts it back.
$projection = ($rollingAverage * $remainingDays);
if ($remainingDays < $daysInMonth) {
	$projection = $projection + $figures['MTD'];
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

$firstOfYear = new DateTime('first day of january this year', $timezone);
$firstOfNextYear = new DateTime('first day of january next year', $timezone);
$yearRows = $database->Query($query, $firstOfYear->format(SQL_DATE_FORMAT), $firstOfNextYear->format(SQL_DATE_FORMAT));
$yearToDate = $yearRows->Field('total_usd');

$taxable = $yearToDate + 63800; // Other income minus standard deduction and child tax credit

// federal
$estimatedTaxes = CalculateTax($taxable, 0, 23200, 0.10);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 23200, 94300, 0.12);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 94300, 201050, 0.22);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 201050, 383900, 0.24);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 383900, 487450, 0.32);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 487450, 731200, 0.25);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 731200, 999999999999, 0.37);

// state
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 0, 20000, 0.03);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 20000, 100000, 0.05);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 100000, 200000, 0.055);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 200000, 400000, 0.06);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 400000, 500000, 0.065);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 500000, 1000000, 0.069);
$estimatedTaxes = $estimatedTaxes + CalculateTax($taxable, 1000000, 999999999999, 0.0699);

// Amount already withheld
$estimatedTaxes = max($estimatedTaxes - 10900, 0);

$fields[] = [
	'title' => "Year To Date",
	'value' => '$' . number_format($yearToDate, 2),
	'short' => true,
];
$fields[] = [
	'title' => "Expected Taxes",
	'value' => '$' . number_format($estimatedTaxes, 2),
	'short' => true,
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
	echo json_encode($figures, JSON_PRETTY_PRINT);
	echo json_encode($arr, JSON_PRETTY_PRINT);
}

function RunReport(string $label, ?string $gameId, DateTime $periodStart, DateTime $periodEnd, array &$fields, ?float $periodTotal = null): float {
	global $query, $figures;

	$database = BeaconCommon::Database();
	if (is_null($gameId)) {
		$rows = $database->Query($query, $periodStart->format(SQL_DATE_FORMAT), $periodEnd->format(SQL_DATE_FORMAT));
	} else {
		$rows = $database->Query("SELECT COALESCE(SUM(purchase_items.line_total_usd - purchase_items.tax_usd), 0) AS total_usd, COUNT(purchase_items.line_id) AS num_sales FROM public.purchase_items INNER JOIN public.purchases ON (purchase_items.purchase_id = purchases.purchase_id) WHERE purchases.purchase_date >= $1 AND purchases.purchase_date < $2 AND purchases.refunded = FALSE AND purchases.total_paid > 0 AND purchase_items.product_id IN (SELECT products.product_id FROM public.products WHERE game_id = $3);", $periodStart->format(SQL_DATE_FORMAT), $periodEnd->format(SQL_DATE_FORMAT), $gameId);
	}

	$total = $rows->Field('total_usd');
	$numSales = number_format($rows->Field('num_sales'));
	$figures[$label] = $total;
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

function CalculateTax(float $taxable, float $rangeMin, float $rangeMax, float $rate) {
	return max(min($taxable - $rangeMin, $rangeMax - $rangeMin), 0) * $rate;
}

?>
