#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$database = BeaconCommon::Database();
	
$currency_codes = [];
$results = $database->Query("SELECT code FROM public.currencies WHERE code != 'USD';");
while ($results->EOF() === false) {
	$currency_codes[] = $results->Field('code');
	$results->MoveNext();
}

$curl = curl_init('https://api.apilayer.com/exchangerates_data/latest?base=USD&symbols=' . implode(',', $currency_codes));
curl_setopt($curl, CURLOPT_HTTPHEADER, [
	'apikey: ' . BeaconCommon::GetGlobal('APILayer Key')
]);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$body = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);
if ($status !== 200) {
	echo "Could not retrieve exchange rate info: $body\n";
	BeaconCommon::PostSlackMessage('Could not retrieve exchange rate info');
	exit;
}
$response = json_decode($body, true);
$rates = $response['rates'];

$database->BeginTransaction();
foreach ($rates as $code => $rate) {
	$database->Query('UPDATE public.currencies SET usd_conversion_rate = $2 WHERE code = $1 AND usd_conversion_rate != $2;', $code, $rate);
}
$database->Commit();

// With the conversion rates at updated, we can now sync the with Stripe
BeaconShop::SyncWithStripe();

echo "Finished.\n";

?>
