<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');
http_response_code(400);

use BeaconAPI\v4\{EmailVerificationCode, User};

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
		echo "Invalid signature";
		exit;
	}
}

$json = json_decode($body, true);
if (is_null($json)) {
	echo 'Invalid JSON';
	exit;
}

/*
charge.dispute.closed
charge.refunded
checkout.session.completed
customer.subscription.created
customer.subscription.deleted
customer.subscription.paused
customer.subscription.resumed
customer.subscription.updated
invoice.created
invoice.paid
*/

$database = BeaconCommon::Database();
$eventId = BeaconUUID::v5($json['id']);
$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM public.processed_webhooks WHERE event_id = $1);', $eventId);
if ($rows->Field('exists')) {
	http_response_code(200);
	echo "Notification already handled.\n{$eventId}\n";
	exit;
}

$data = $json['data'];
$type = $json['type'];
$api = new BeaconStripeAPI($api_secret, '2022-08-01');
switch ($type) {
case 'checkout.session.completed':
	$obj = $data['object'];
	if (isset($obj['payment_intent']) === false || empty($obj['payment_intent'])) {
		$database->BeginTransaction();
		$database->Query('INSERT INTO public.processed_webhooks (event_id) VALUES ($1);', $eventId);
		$database->Commit();

		http_response_code(200);
		echo 'Not a payment intent.';
		exit;
	}
	$intentId = $obj['payment_intent'];
	$customerId = $obj['customer'];

	$intent = $api->GetPaymentIntent($intentId);
	if (is_null($intent)) {
		http_response_code(400);
		echo 'Could not get payment intent ' . $intentId;
		exit;
	}
	$purchaseDate = $obj['created'];

	if (isset($obj['customer_details']['email'])) {
		$email = $obj['customer_details']['email'];
	}
	if (isset($email) === false) {
		$email = $api->EmailForPaymentIntent($intent);
		if (is_null($email)) {
			echo 'Unable to find email address for this payment intent';
			exit;
		}
	}
	$billingLocality = $api->GetBillingLocality($intent);
	$currencyCode = strtoupper($obj['currency']);
	$clientReferenceId = $obj['client_reference_id'];

	$charges = [];
	if (isset($intent['charges']['data']) && is_array($intent['charges']['data'])) {
		$charges = $intent['charges']['data'];
	}
	$paidCharge = null;
	$amountPaid = $intent['amount_received'];
	$datePaid = null;
	foreach ($charges as $charge) {
		if ($charge['paid'] !== true) {
			continue;
		}

		$paidCharge = $charge;
		$datePaid = $charge['created'];
		break;
	}
	$conversionRate = 1.0;
	if (is_null($paidCharge) === false) {
		if (strtoupper($paidCharge['currency']) !== 'USD') {
			$transactions = $api->GetBalanceTransactionsForSource($paidCharge['id']);
			if (is_null($transactions) === false && isset($transactions['data']) && is_array($transactions['data'])) {
				foreach ($transactions['data'] as $transaction) {
					$conversionRate = $transaction['exchange_rate'];
					$currencyCode = strtoupper($paidCharge['currency']);
					break;
				}
			}
		}
	}
	$currencyRows = $database->Query('SELECT stripe_multiplier FROM public.currencies WHERE code = $1;', $currencyCode);
	if ($currencyRows->RecordCount() !== 1) {
		echo "Unknown currency code {$currencyCode}.\n";
		exit;
	}
	$currencyMultiplier = $currencyRows->Field('stripe_multiplier');
	$conversionRate = $conversionRate / (100 / $currencyMultiplier);

	$purchase = new BeaconPurchase($intentId, $email, $purchaseDate, $billingLocality, $currencyCode, $conversionRate, $currencyMultiplier);
	$purchase->SetClientReferenceId($clientReferenceId);
	$purchase->SetAmountPaid($amountPaid);
	$purchase->SetDateFulfilled($datePaid);

	$lineItems = $api->GetLineItems($obj['id']);
	if (is_null($lineItems)) {
		echo 'Unable to retrieve items for checkout session';
		exit;
	}
	$items = $lineItems['data'];
	foreach ($items as $item) {
		$priceId = $item['price']['id'];
		$quantity = $item['quantity'];
		$lineTotal = $item['amount_total'];
		$subtotal = $item['amount_subtotal'];
		$unitPrice = $subtotal / $quantity;
		$taxTotal = 0;
		foreach ($item['taxes'] as $tax) {
			$taxTotal += $tax['amount'];
		}
		$discountTotal = 0;
		foreach ($item['discounts'] as $discount) {
			$discountTotal += $discount['amount'];
		}

		$rows = $database->Query('SELECT product_id FROM product_prices WHERE price_id = $1;', $priceId);
		if ($rows->RecordCount() === 1) {
			$item = new BeaconLineItem($rows->Field('product_id'), $unitPrice, $quantity, $discountTotal, $taxTotal, $currencyCode, $conversionRate, $currencyMultiplier);
			$purchase->AddLine($item);
		}
	}

	if ($purchase->LineCount() == 0) {
		http_response_code(200);
		echo 'No products to be handled by this hook';
		exit;
	}

	$user = User::Fetch($email);
	if (is_null($user)) {
		EmailVerificationCode::Create($email);
	}

	$metadata = $obj['metadata'];
	$bundles = json_decode(gzdecode(BeaconCommon::Base64UrlDecode($metadata['Beacon Cart'])), true);
	$purchase->SetMetadata([
		'bundles' => $bundles,
	]);

	$database->BeginTransaction();
	$purchase->SaveTo($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Query('UPDATE affiliate_tracking SET purchase_id = $2 WHERE client_reference_id = $1 AND purchase_id IS NULL;', $clientReferenceId, $purchase->PurchaseId());
	$database->Query('UPDATE public.users SET stripe_id = $2 WHERE email_id = uuid_for_email($1::email) AND stripe_id IS DISTINCT FROM $2;', $email, $customerId);
	$database->Commit();

	// Look up gift codes and email them
	$codes = [];
	$results = $database->Query('SELECT code FROM public.gift_codes WHERE source_purchase_id = $1;', $purchase->PurchaseId());
	$codeCount = $results->RecordCount();
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

	if ($codeCount > 0) {
		$emailBodyPlain = 'Thanks for purchasing ' . ($codeCount > 1 ? 'gift codes' : 'a gift code') . ' for Beacon Omni! Codes can be redeemed at <https://usebeacon.app/redeem>.';
		$emailBodyHtml = '<p>Thanks for purchasing ' . ($codeCount > 1 ? 'gift codes' : 'a gift code') . ' for Beacon Omni! Codes can be redeemed at <a href="https://usebeacon.app/redeem">https://usebeacon.app/redeem</a> or by the direct link for a code below.</p>';
		foreach ($codes as $code => $product_names) {
			$emailBodyPlain .= "\n\nCode {$code}:\n    Redeem Link: https://usebeacon.app/redeem/{$code}";
			$emailBodyHtml .= "\n\n<p>Code {$code}<br />&nbsp;&nbsp;&nbsp;&nbsp;Redeem Link: https://usebeacon.app/redeem/{$code}";

			foreach ($product_names as $product_name) {
				$emailBodyPlain .= "\n    {$product_name}";
				$emailBodyHtml .= "<br />&nbsp;&nbsp;&nbsp;&nbsp;" . htmlentities($product_name);
			}

			$emailBodyHtml .= "</p>";
		}
		$emailBodyPlain .= "\n\nYou can also view the status of all purchased gift codes at <https://usebeacon.app/account/#omni>.";
		$emailBodyHtml .= '<p>You can also view the status of all purchased gift codes at <a href="https://usebeacon.app/account/#omni">https://usebeacon.app/account/#omni</a></p>';

		BeaconEmail::SendMail($email, 'Your Beacon Omni Gift', $emailBodyPlain, $emailBodyHtml);
	}

	ReportSuccess('Purchase completed');
	break;
case 'invoice.created':
	$invoice = $data['object'];
	$invoiceId = $invoice['id'];
	$email = $invoice['customer_email'];
	$customerId = $invoice['customer'];
	$address = $invoice['customer_address'];
	$billingLocality = $address['country'];
	if (isset($address['state'])) {
		$billingLocality .= ' ' . $address['state'];
	}
	$purchaseDate = $invoice['created'];

	$currencyCode = strtoupper($invoice['currency']);
	$currencyRows = $database->Query('SELECT stripe_multiplier, usd_conversion_rate FROM public.currencies WHERE code = $1;', $currencyCode);
	if ($currencyRows->RecordCount() !== 1) {
		echo "Unknown currency code {$currencyCode}.\n";
		exit;
	}
	$currencyMultiplier = $currencyRows->Field('stripe_multiplier');
	$conversionRate = $currencyRows->Field('usd_conversion_rate'); // This is low accuracy, but it's the best way have.

	$purchase = new BeaconPurchase($invoiceId, $email, $purchaseDate, $billingLocality, $currencyCode, $conversionRate, $currencyMultiplier);

	$lines = $invoice['lines']['data'];
	foreach ($lines as $line) {
		$stripeProductId = $line['price']['product'];
		$stripeProduct = $api->GetProduct($stripeProductId);
		$productId = $stripeProduct['metadata']['beacon-uuid'];

		$linePrice = $line['amount_excluding_tax'];
		$quantity = $line['quantity'] ?? 1;
		$unitPrice = $linePrice / $quantity;
		$subtotal = $line['amount_excluding_tax'];
		$taxTotal = 0;
		foreach ($line['tax_amounts'] as $tax) {
			$taxTotal += $tax['amount'];
		}
		$discountTotal = 0;
		foreach ($line['discounts'] as $discount) {
			$discountTotal += $discount['amount'];
		}

		$lineItem = new BeaconLineItem($productId, $unitPrice, $quantity, $discountTotal, $taxTotal, $currencyCode, $conversionRate, $currencyMultiplier);
		$purchase->AddLine($lineItem);
	}

	if ($purchase->LineCount() === 0) {
		http_response_code(200);
		echo 'No products to be handled by this hook';
		exit;
	}

	$total = $invoice['total'];
	$subtotal = $invoice['subtotal'];

	$taxTotal = 0;
	foreach ($invoice['total_tax_amounts'] as $tax) {
		$taxTotal += $tax['amount'];
	}

	$discountTotal = 0;
	foreach ($invoice['total_discount_amounts'] as $discount) {
		$discountTotal += $discount['amount'];
	}

	$purchase->SetTotal($total);
	$purchase->SetSubtotal($subtotal);
	$purchase->SetTaxes($taxTotal);
	$purchase->SetDiscounts($discountTotal);

	$database->BeginTransaction();
	$purchase->SaveTo($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Query('UPDATE public.users SET stripe_id = $2 WHERE email_id = uuid_for_email($1::email) AND stripe_id IS DISTINCT FROM $2;', $email, $customerId);
	$database->Commit();

	ReportSuccess('Invoice created');
	break;
case 'invoice.paid':
	$invoice = $data['object'];
	$invoiceId = $invoice['id'];
	if ($invoice['paid'] !== true) {
		ReportSuccess('Um... ok');
	}

	$database = BeaconCommon::Database();
	$purchase = BeaconPurchase::Load($database, $invoiceId);

	$purchase->SetDateFulfilled($invoice['status_transitions']['finalized_at']);
	$purchase->SetAmountPaid($invoice['amount_paid']);

	$chargeId = $invoice['charge'];
	if (is_null($chargeId) === false) {
		$charge = $api->GetCharge($chargeId);
		if (strtoupper($charge['currency']) !== 'USD') {
			$transactions = $api->GetBalanceTransactionsForSource($chargeId);
			if (is_null($transactions) === false && isset($transactions['data']) && is_array($transactions['data'])) {
				foreach ($transactions['data'] as $transaction) {
					$purchase->SetConversionRate($transaction['exchange_rate']);
					$purchase->SetCurrencyCode($charge['currency']);
					break;
				}
			}
		}
	}

	$database->BeginTransaction();
	$purchase->Update($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Commit();

	ReportSuccess('Invoice paid');

	break;
case 'charge.refunded':
	$charge_data = $data['object'];
	$merchantReference = $charge_data['payment_intent'];

	if (BeaconShop::RevokePurchases($merchantReference)) {
		ReportSuccess('Refund processed');
	}

	BeaconCommon::PostSlackMessage('The refund webhook failed');
	echo 'Did not process refund';

	break;
case 'charge.dispute.created':
	$dispute = $data['object'];
	$merchantReference = $dispute['payment_intent'];

	if (BeaconShop::RevokePurchases($merchantReference, true)) {
		ReportSuccess('Dispute processed');
	}

	BeaconCommon::PostSlackMessage('The dispute webhook failed');
	echo 'Did not process dispute';

	break;
case 'customer.subscription.updated':
	$subscription = $data['object'];
	$stripeSubscription = $subscription['id'];
	$subscriptionId = BeaconUUID::v5($stripeSubscription);
	$endDate = $subscription['current_period_end'];
	$stripeProductId = $subscription['plan']['product'];
	$stripeProduct = $api->GetProduct($stripeProductId);
	$productId = $stripeProduct['metadata']['beacon-uuid'];
	$latestInvoice = $subscription['latest_invoice'];
	$purchaseId = BeaconUUID::v5($latestInvoice);

	$database->BeginTransaction();
	$database->Query('UPDATE public.subscriptions SET date_expires = TO_TIMESTAMP($2), product_id = $3, last_purchase_id = $4 WHERE subscription_id = $1;', $subscriptionId, $endDate, $productId, $purchaseId);
	$rows = $database->Query('SELECT user_id FROM public.user_subscriptions WHERE subscription_id = $1;', $subscriptionId);
	$database->Commit();

	$user = User::Fetch($rows->Field('user_id'));
	if (is_null($user) === false) {
		BeaconPusher::SharedInstance()->TriggerEvent($user->PusherChannelName(), 'user-updated', '');
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', "sentinel.notifications.{$subscriptionId}", json_encode([
		'event' => 'subscriptionUpdated',
		'subscriptionId' => $subscriptionId,
	]));

	ReportSuccess('Subscription updated');
	break;
case 'customer.subscription.deleted':
	$subscription = $data['object'];
	$stripeSubscription = $subscription['id'];
	$subscriptionId = BeaconUUID::v5($stripeSubscription);

	$database->BeginTransaction();
	$rows = $database->Query('SELECT user_id FROM public.user_subscriptions WHERE subscription_id = $1;', $subscriptionId);
	$database->Query('DELETE FROM public.subscriptions WHERE subscription_id = $1;', $subscriptionId);
	$database->Commit();

	$user = User::Fetch($rows->Field('user_id'));
	if (is_null($user) === false) {
		BeaconPusher::SharedInstance()->TriggerEvent($user->PusherChannelName(), 'user-updated', '');
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', "sentinel.notifications.{$subscriptionId}", json_encode([
		'event' => 'subscriptionUpdated',
		'subscriptionId' => $subscriptionId,
	]));

	ReportSuccess('Subscription deleted');
	break;
case 'customer.subscription.created':
	$subscription = $data['object'];
	$stripeSubscription = $subscription['id'];
	$subscriptionId = BeaconUUID::v5($stripeSubscription);
	$startDate = $subscription['current_period_start'];
	$endDate = $subscription['current_period_end'];
	$stripeProductId = $subscription['plan']['product'];
	$stripeProduct = $api->GetProduct($stripeProductId);
	$productId = $stripeProduct['metadata']['beacon-uuid'];
	$latestInvoice = $subscription['latest_invoice'];
	$purchaseId = BeaconUUID::v5($latestInvoice);

	$database->BeginTransaction();
	$database->Query('INSERT INTO public.subscriptions (subscription_id, stripe_id, product_id, date_created, date_expires, last_purchase_id) VALUES ($1, $2, $3, TO_TIMESTAMP($4), TO_TIMESTAMP($5), $6);', $subscriptionId, $stripeSubscription, $productId, $startDate, $endDate, $purchaseId);
	$database->Query('INSERT INTO public.subscription_purchases (subscription_id, purchase_id) VALUES ($1, $2);', $subscriptionId, $purchaseId);
	$rows = $database->Query('SELECT user_id FROM public.user_subscriptions WHERE subscription_id = $1;', $subscriptionId); // If the user does not exist, there will be nothing in user_subscriptions for this subscription.
	$database->Commit();

	$user = User::Fetch($rows->Field('user_id'));
	if (is_null($user) === false) {
		BeaconPusher::SharedInstance()->TriggerEvent($user->PusherChannelName(), 'user-updated', '');
	}

	ReportSuccess('Subscription created');
	break;
default:
	http_response_code(400);
	echo 'Unknown hook type.';
	exit;
}

function ReportSuccess(string $message): void {
	global $eventId;

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO public.processed_webhooks (event_id) VALUES ($1);', $eventId);
	$database->Commit();

	http_response_code(200);
	echo "{$message}\n";
	exit;
}

?>
