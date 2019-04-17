<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');
http_response_code(400);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	http_response_code(405);
	echo 'Method not allowed';
	exit;
}

$endpoint_secret = BeaconCommon::GetGlobal('Stripe_Webhook_Secret');
$api_secret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
$body = @file_get_contents('php://input');
$signature = $_SERVER['HTTP_STRIPE_SIGNATURE'];

$signature_parts = explode(',', $signature);
$signature_values = array();
foreach ($signature_parts as $part) {
	list($key, $value) = explode('=', trim($part), 2);
	$signature_values[$key] = $value;
}
$time = $signature_values['t'];
$expected_signature = $signature_values['v1'];

$signed_payload = $time . '.' . $body;
$computed_signature = hash_hmac('sha256', $signed_payload, $endpoint_secret);
if ($computed_signature != $expected_signature) {
	echo "Invalid signature, expected $expected_signature but computed $computed_signature";
	exit;
}

$json = json_decode($body, true);
if (is_null($json)) {
	echo 'Invalid JSON';
	exit;
}

$database = BeaconCommon::Database();
$data = $json['data'];
$type = $json['type'];
$api = new BeaconStripeAPI($api_secret);
switch ($type) {
case 'checkout.session.completed':
	$obj = $data['object'];
	$items = $obj['display_items'];
	$purchased_products = array();
	foreach ($items as $item) {
		if ($item['type'] != 'sku') {
			continue;
		}
		
		$sku = $item['sku']['id'];
		
		$results = $database->Query('SELECT product_id, retail_price FROM products WHERE stripe_sku = $1;', $sku);
		if ($results->RecordCount() == 1) {
			$purchased_products[] = array('product_id' => $results->Field('product_id'), 'quantity' => $item['quantity'], 'price' => $results->Field('retail_price'), 'paid' => $item['amount'] / 100);
			continue;
		}
	}
	
	if (count($purchased_products) == 0) {
		http_response_code(200);
		echo 'No products to be handled by this hook';
		exit;
	}
	
	$intent_id = $obj['payment_intent'];
	$client_reference_id = $obj['client_reference_id'];
	$email = $api->EmailForPaymentIntent($intent_id);
	if (is_null($email)) {
		echo 'Unable to find email address for this payment intent';
		exit;
	}
	
	$user = BeaconUser::GetByEmail($email);
	if (is_null($user)) {
		BeaconLogin::SendVerification($email);
	}
	
	$purchase_subtotal = 0;
	$purchase_total = 0;
	$purchase_discount = 0;
	$purchase_id = BeaconCommon::GenerateUUID();
	$stw_copies = 0;
	$database->BeginTransaction();
	foreach ($purchased_products as $item) {
		$product_id = $item['product_id'];
		$paid_unit_price = $item['paid'];
		$full_unit_price = $item['price'];
		$discount_per_unit = $full_unit_price - $paid_unit_price;
		$quantity = $item['quantity'];
		$line_total = $paid_unit_price * $quantity;
		
		$purchase_subtotal += ($full_unit_price * $quantity);
		$purchase_total += $line_total;
		$purchase_discount += ($discount_per_unit * $quantity);
		
		if ($product_id == 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015') {
			$stw_copies += $quantity;
		}
		
		$database->Query('INSERT INTO purchase_items (purchase_id, product_id, retail_price, discount, quantity, line_total) VALUES ($1, $2, $3, $4, $5, $6);', $purchase_id, $product_id, $full_unit_price, $discount_per_unit, $quantity, $line_total);
	}
	$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference, client_reference_id) VALUES ($1, uuid_for_email($2::email, TRUE), $3, $4, $5, $6, $7, $8);', $purchase_id, $email, $purchase_subtotal, $purchase_discount, 0, $purchase_total, $intent_id, $client_reference_id);
	
	// Make sure the user's email is removed from the raffle
	$database->Query('DELETE FROM stw_applicants WHERE email_id = uuid_for_email($1);', $email);
	
	// And add more prizes to the raffle
	for ($i = 0; $i < $stw_copies; $i++) {
		$database->Query('INSERT INTO stw_purchases (original_purchase_id) VALUES ($1);', $purchase_id);
	}
	$database->Commit();
	
	http_response_code(200);
	echo 'Purchase redeemed successfully';
	exit;
	
	break;
default:
	http_response_code(200);
	echo 'Unknown hook type. Just assumed this worked, ok?';
	exit;
}

?>