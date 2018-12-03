<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');
http_response_code(400);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	http_response_code(405);
	echo 'Method not allowed';
	exit;
}

$body = @file_get_contents('php://input');
$signature = $_SERVER['HTTP_STRIPE_SIGNATURE'];
$endpoint_secret = BeaconCommon::GetGlobal('Stripe_Endpoint_Secret');

$signature_parts = explode(',', $signature);
$signature_values = array();
foreach ($signature_parts as $part) {
	list($key, $value) = explode('=', trim($part), 2);
	$signature_values[$key] = $value;
}
$time = $signature_values['t'];
$signature_hex = $signature_values['v1'];

$signed_payload = $time . '.' . $body;
$expected_signature = hash_hmac('sha256', $time . '.' . $body, $endpoint_secret);
if ($signature_hex != $expected_signature) {
	ReplyError('Invalid signature', 400);
}

$json = json_decode($body, true);
if (is_null($json)) {
	echo 'Invalid JSON';
	exit;
}

$data = $json['data'];
$type = $json['type'];
switch ($type) {
case 'checkout_beta.session_succeeded':
	$obj = $data['object'];
	$items = $obj['display_items'];
	$intent_id = $obj['payment_intent'];
	$client_reference_id = $obj['client_reference_id'];
	
	$curl = curl_init('https://api.stripe.com/v1/payment_intents/' . $intent_id);
	$headers = array('Authorization: Bearer ' . BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$pi_body = curl_exec($curl);
	$pi_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($pi_status != 200) {
		echo 'Unable to retrieve payment intent ' . $intent_id;
		exit;
	}
	$pi_json = json_decode($pi_body, true);
	if (is_null($pi_json)) {
		echo 'Unable to parse payment intent JSON';
		exit;
	}
	$source_id = $pi_json['source'];
	
	$curl = curl_init('https://api.stripe.com/v1/sources/' . $source_id);
	$headers = array('Authorization: Bearer ' . BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$source_body = curl_exec($curl);
	$source_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($source_status != 200) {
		echo 'Unable to retrieve source ' . $source_id;
		exit;
	}
	$source_json = json_decode($source_body, true);
	if (is_null($source_json)) {
		echo 'Unable to parse source JSON';
		exit;
	}
	
	$owner = $source_json['owner'];
	$email = $owner['email'];
	
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$purchase_id = BeaconCommon::GenerateUUID();
	$subtotal = 0;
	$total = 0;
	$line_count = 0;
	foreach ($items as $item) {
		if ($item['type'] != 'sku') {
			continue;
		}
		
		$sku = $item['sku'];
		$amount = $item['amount'] / 100;
		$results = $database->Query('SELECT retail_price, product_id FROM products WHERE stripe_sku = $1;', $sku);
		if ($results->RecordCount() == 0) {
			$database->Rollback();
			echo 'Unknown SKU ' . $sku;
			exit;
		}
		
		$retail_price = $results->Field('retail_price');
		$product_id = $results->Field('product_id');
		
		$subtotal += $retail_price;
		$total += $amount;
		$discount = $retail_price - $amount;
		$line_count++;
		
		$database->Query('INSERT INTO purchase_items (purchase_id, product_id, retail_price, discount, line_total) VALUES ($1, $2, $3, $4, $5);', $purchase_id, $product_id, $retail_price, $discount, $amount);
	}
	if ($line_count == 0) {
		$database->Rollback();
		echo 'No items in purchase';
		exit;
	}
	$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference, client_reference_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);', $purchase_id, $email, $subtotal, $subtotal - $total, 0, $total, $intent_id, $client_reference_id);
	$database->Commit();
	
	http_response_code(200);
	echo 'Success';
	break;
}

?>