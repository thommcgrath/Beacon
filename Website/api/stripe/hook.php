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

if (BeaconCommon::InProduction()) {
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
}

$json = json_decode($body, true);
if (is_null($json)) {
	echo 'Invalid JSON';
	exit;
}

$database = BeaconCommon::Database();
$data = $json['data'];
$type = $json['type'];
$api = new BeaconStripeAPI($api_secret, '2022-08-01');
switch ($type) {
case 'checkout.session.completed':
	$obj = $data['object'];
	$intent_id = $obj['payment_intent'];
	$rows = $database->Query('SELECT purchase_id FROM purchases WHERE merchant_reference = $1;', $intent_id);
	if ($rows->RecordCount() > 0) {
		http_response_code(200);
		echo 'Notification already handled.';
		exit;
	}
	
	$line_items = $api->GetLineItems($obj['id']);
	if (is_null($line_items)) {
		echo 'Unable to retrieve items for checkout session';
		exit;
	}
	$items = $line_items['data'];
	$purchased_products = [];
	foreach ($items as $item) {
		$price_id = $item['price']['id'];
		$quantity = $item['quantity'];
		$line_total = $item['amount_total'];
		$subtotal = $item['amount_subtotal'];
		$product_price = $subtotal / $quantity;
		$currency = strtoupper($item['currency']);
		$tax_total = 0;
		foreach ($item['taxes'] as $tax) {
			$tax_total += $tax['amount'];
		}
		$discount_total = 0;
		foreach ($item['discounts'] as $discount) {
			$discount_total += $discount['amount'];
		}
		
		$rows = $database->Query('SELECT product_id FROM product_prices WHERE price_id = $1;', $price_id);
		if ($rows->RecordCount() === 1) {
			$purchased_products[] = [
				'product_id' => $rows->Field('product_id'),
				'quantity' => $quantity,
				'unit_price' => $product_price / 100,
				'subtotal' => $subtotal / 100,
				'total_tax' => $tax_total / 100,
				'total_discount' => $discount_total / 100,
				'total' => $line_total / 100,
				'currency' => $currency
			];
		}
	}
	
	if (count($purchased_products) == 0) {
		http_response_code(200);
		echo 'No products to be handled by this hook';
		exit;
	}
	
	$client_reference_id = $obj['client_reference_id'];
	if (isset($obj['customer_details']['email'])) {
		$email = $obj['customer_details']['email'];
	}
	if (isset($email) === false) {
		$email = $api->EmailForPaymentIntent($intent_id);
		if (is_null($email)) {
			echo 'Unable to find email address for this payment intent';
			exit;
		}
	}
	$billing_locality = $api->GetBillingLocality($intent_id);
	$purchase_currency = strtoupper($obj['currency']);
	
	$user = BeaconUser::GetByEmail($email);
	if (is_null($user)) {
		BeaconLogin::SendVerification($email);
	}
	
	$metadata = $obj['metadata'];
	$bundles = json_decode(gzdecode(BeaconCommon::Base64UrlDecode($metadata['Beacon Cart'])), true);
	
	$purchase_subtotal = $obj['amount_subtotal'] / 100;
	$purchase_total = $obj['amount_total'] / 100;
	$purchase_discount = $obj['total_details']['amount_discount'] / 100;
	$purchase_tax = $obj['total_details']['amount_tax'] / 100;
	$purchase_id = BeaconCommon::GenerateUUID();
	
	$database->BeginTransaction();
	$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference, client_reference_id, tax_locality, currency) VALUES ($1, uuid_for_email($2::email, TRUE), $3, $4, $5, $6, $7, $8, $9, $10);', $purchase_id, $email, $purchase_subtotal, $purchase_discount, $purchase_tax, $purchase_total, $intent_id, $client_reference_id, $billing_locality, $purchase_currency);
	foreach ($purchased_products as $item) {
		$product_id = $item['product_id'];
		$unit_price = $item['unit_price'];
		$quantity = $item['quantity'];
		$subtotal = $item['subtotal'];
		$discount = $item['total_discount'];
		$tax = $item['total_tax'];
		$line_total = $item['total'];
		$currency = $item['currency'];
		
		$database->Query('INSERT INTO purchase_items (purchase_id, product_id, currency, quantity, unit_price, subtotal, discount, tax, line_total) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);', $purchase_id, $product_id, $currency, $quantity, $unit_price, $subtotal, $discount, $tax, $line_total);
	}
	BeaconShop::IssuePurchases($purchase_id, $bundles);
	$database->Query('UPDATE affiliate_tracking SET purchase_id = $2 WHERE client_reference_id = $1 AND purchase_id IS NULL;', $client_reference_id, $purchase_id);
	$database->Commit();
		
	// Look up gift codes and email them
	$codes = [];
	$results = $database->Query('SELECT code FROM public.gift_codes WHERE source_purchase_id = $1;', $purchase_id);
	$code_count = $results->RecordCount();
	while ($results->EOF() === false) {
		$code = $results->Field('code');
		$code_products = $database->Query('SELECT products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = $1;', $code);
		while ($code_products->EOF() === false) {
			$product_name = $code_products->Field('quantity') . ' x ' . $code_products->Field('product_name');
			
			if (array_key_exists($code, $codes)) {
				$codes[$code][] = $product_name;
			} else {
				$codes[$code] = [$product_name];
			}
			
			$code_products->MoveNext();
		}
		
		$results->MoveNext();
	}
	
	if ($code_count > 0) {
		$email_body_plain = 'Thanks for purchasing ' . ($code_count > 1 ? 'gift codes' : 'a gift code') . ' for Beacon Omni! Codes can be redeemed at <https://usebeacon.app/redeem>.';
		$email_body_html = '<p>Thanks for purchasing ' . ($code_count > 1 ? 'gift codes' : 'a gift code') . ' for Beacon Omni! Codes can be redeemed at <a href="https://usebeacon.app/redeem">https://usebeacon.app/redeem</a> or by the direct link for a code below.</p>';
		foreach ($codes as $code => $product_names) {
			$email_body_plain .= "\n\nCode {$code}:\n    Redeem Link: https://usebeacon.app/redeem/{$code}";
			$email_body_html .= "\n\n<p>Code {$code}<br />&nbsp;&nbsp;&nbsp;&nbsp;Redeem Link: https://usebeacon.app/redeem/{$code}";
			
			foreach ($product_names as $product_name) {
				$email_body_plain .= "\n    {$product_name}";
				$email_body_html .= "<br />&nbsp;&nbsp;&nbsp;&nbsp;" . htmlentities($product_name);
			}
			
			$email_body_html .= "</p>";
		}
		$email_body_plain .= "\n\nYou can also view the status of all purchased gift codes at <https://usebeacon.app/account/#omni>.";
		$email_body_html .= '<p>You can also view the status of all purchased gift codes at <a href="https://usebeacon.app/account/#omni">https://usebeacon.app/account/#omni</a></p>';
		
		BeaconEmail::SendMail($email, 'Your Beacon Omni Gift', $email_body_plain, $email_body_html);
	}
	
	http_response_code(200);
	echo 'Purchase redeemed successfully';
	exit;
	
	break;
case 'charge.refunded':
	$charge_data = $data['object'];
	$merchant_reference = $charge_data['payment_intent'];
	
	http_response_code(200);
	if (BeaconShop::RevokePurchases($merchant_reference)) {
		echo 'Refund processed';
	} else {
		BeaconCommon::PostSlackMessage('The refund webhook failed');
		echo 'Did not process refund';
	}
	
	break;
case 'charge.dispute.created':
	$dispute = $data['object'];
	$merchant_reference = $dispute['payment_intent'];
	
	http_response_code(200);
	if (BeaconShop::RevokePurchases($merchant_reference, true)) {
		echo 'Despite processed';
	} else {
		BeaconCommon::PostSlackMessage('The dispute webhook failed');
		echo 'Did not process dispute';
	}
	
	break;
default:
	http_response_code(200);
	echo 'Unknown hook type. Just assumed this worked, ok?';
	exit;
}

?>