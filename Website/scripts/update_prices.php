#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$usd_prices = $database->Query('SELECT product_id, price FROM product_prices WHERE currency = \'USD\';');
$other_prices = $database->Query('SELECT product_id, price, currency, price_id FROM product_prices WHERE currency != \'USD\';');

$rates = [];
$currencies = $database->Query('SELECT DISTINCT currency FROM product_prices WHERE currency != \'USD\';');
while ($currencies->EOF() === false) {
	$rate = $currencies->Field('currency');
	
	$curl = curl_init('https://api.apilayer.com/exchangerates_data/convert?amount=1&from=USD&to=' . $rate);
	curl_setopt($curl, CURLOPT_HTTPHEADER, [
		'apikey: ' . BeaconCommon::GetGlobal('APILayer Key')
	]);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$body = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($status !== 200) {
		BeaconCommon::PostSlackMessage('Could not retrieve exchange rate to ' . $rate);
		$currencies->MoveNext();
		continue;
	}
	
	$parsed = json_decode($body, true);
	$rates[$rate] = $parsed['result'];
		
	$currencies->MoveNext();
}

$prices = [];
while ($usd_prices->EOF() === false) {
	$prices[$usd_prices->Field('product_id')]['USD'] = $usd_prices->Field('price');	
	$usd_prices->MoveNext();
}

$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
$errors = false;
$changed = false;
while ($other_prices->EOF() === false) {
	$product_id = $other_prices->Field('product_id');
	$currency = $other_prices->Field('currency');
	$current_price = $other_prices->Field('price');
	$stripe_price_id = $other_prices->Field('price_id');
	
	$usd_price = $prices[$product_id]['USD'];
	$new_price = round(($usd_price * $rates[$currency]) * 100) / 100;
	$new_price = ceil($new_price * 4) / 4;
	$prices[$product_id][$currency] = $new_price;
	
	if ($new_price == $current_price) {
		$other_prices->MoveNext();
		continue;
	}
	
	$new_price_id = $api->UpdatedProductPrice($stripe_price_id, $new_price * 100);
	if ($new_price_id === false) {
		$errors = true;
		$other_prices->MoveNext();
		continue;
	}
	
	$database->BeginTransaction();
	$database->Query('UPDATE product_prices SET price_id = $2, price = $3 WHERE price_id = $1;', $stripe_price_id, $new_price_id, $new_price);
	$database->Commit();
	
	$changed = true;
	$other_prices->MoveNext();
}

if ($errors) {
	BeaconCommon::PostSlackMessage('One or more prices needed updating and failed.');
} elseif ($changed) {
	BeaconCommon::PostSlackMessage('Product prices have been updated.');
}

echo "Finished.\n";

?>