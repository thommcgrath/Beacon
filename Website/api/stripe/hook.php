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
	$session = $data['object'];

	if (isset($session['payment_intent'])) {
		$sem = sem_get(crc32($session['payment_intent']));
	} elseif (isset($session['invoice'])) {
		$sem = sem_get(crc32($session['invoice']));
	} else {
		$database->Rollback();
		http_response_code(500);
		echo "Unknown session type.\n";
		exit;
	}
	sem_acquire($sem);

	$database->BeginTransaction();
	$purchase = CreatePurchaseFromCheckoutSession($session);
	$customerId = $session['customer'];

	$email = $session['customer_details']['email'];
	$user = User::Fetch($purchase->Email());
	if (is_null($user)) {
		EmailVerificationCode::Create($email);
	}

	$purchase->SaveTo($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Query('UPDATE public.users SET stripe_id = $2 WHERE email_id = uuid_for_email($1::email, TRUE) AND stripe_id IS DISTINCT FROM $2;', $email, $customerId);
	if (is_null($purchase->ClientReferenceId()) === false) {
		$database->Query('UPDATE public.affiliate_tracking SET purchase_id = $1 WHERE client_reference_id = $2 AND purchase_id IS NULL;', $purchase->PurchaseId(), $purchase->ClientReferenceId());
	}
	$database->Commit();

	sem_release($sem);

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

	$sem = sem_get(crc32($invoiceId));
	sem_acquire($sem);

	$database->BeginTransaction();
	$rows = $database->Query('SELECT purchase_id FROM public.purchases WHERE merchant_reference = $1;', $invoiceId);
	if ($rows->RecordCount() === 1) {
		$database->Rollback();
		sem_release($sem);
		ReportSuccess('Invoice was created by another event.');
		return;
	}

	try {
		$purchase = CreatePurchaseFromInvoice($invoice);
	} catch (Exception $err) {
		$database->Rollback();
		sem_release($sem);
		http_response_code(500);
		echo "{$err->getMessage()}\n";
		exit;
	}

	$customerId = $invoice['customer'];
	$email = $invoice['customer_email'];
	if (!empty($email)) {
		$database->Query('UPDATE public.users SET stripe_id = $2 WHERE email_id = uuid_for_email($1::email, TRUE) AND stripe_id IS DISTINCT FROM $2;', $email, $customerId);
	}

	$purchase->SaveTo($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Commit();
	sem_release($sem);

	ReportSuccess('Invoice created');
	break;
case 'invoice.paid':
	$invoice = $data['object'];
	$invoiceId = $invoice['id'];

	$sem = sem_get(crc32($invoiceId));
	sem_acquire($sem);

	$database->BeginTransaction();
	$purchase = BeaconPurchase::Load($database, $invoiceId);
	if (is_null($purchase)) {
		try {
			$purchase = CreatePurchaseFromInvoice($invoice);
		} catch (Exception $err) {
			$database->Rollback();
			sem_release($sem);
			http_response_code(500);
			echo "{$err->getMessage()}\n";
			exit;
		}
	} else {
		UpdatePurchaseWithInvoice($purchase, $invoice);
	}

	$customerId = $invoice['customer'];
	$email = $invoice['customer_email'];
	if (!empty($email)) {
		$database->Query('UPDATE public.users SET stripe_id = $2 WHERE email_id = uuid_for_email($1::email, TRUE) AND stripe_id IS DISTINCT FROM $2;', $email, $customerId);
	}

	$purchase->SaveTo($database);
	BeaconShop::IssuePurchases($purchase->PurchaseId());
	$database->Commit();
	sem_release($sem);

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
case 'customer.subscription.created':
case 'customer.subscription.updated':
	$subscription = $data['object'];

	$invoiceSem = sem_get(crc32($subscription['latest_invoice']));
	sem_acquire($invoiceSem);
	$subSem = sem_get(crc32($subscription['id']));
	sem_acquire($subSem);

	$database->BeginTransaction();
	try {
		$subscriptionId = SaveSubscription($subscription);
	} catch (Exception $err) {
		$database->Rollback();
		sem_release($subSem);
		sem_release($invoiceSem);
		http_response_code(500);
		echo "{$err->getMessage()}\n";
		exit;
	}
	$database->Commit();
	sem_release($subSem);
	sem_release($invoiceSem);

	$rows = $database->Query('SELECT user_id FROM public.user_subscriptions WHERE subscription_id = $1;', $subscriptionId); // If the user does not exist, there will be nothing in user_subscriptions for this subscription.
	if ($rows->RecordCount() > 0) {
		$user = User::Fetch($rows->Field('user_id'));
		if (is_null($user) === false) {
			$events = [
				new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($user->UserId()), eventName: 'user-updated', body: ''),
				new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelname($user->UserId()), eventName: 'userUpdated', body: ''),
			];
			BeaconPusher::SharedInstance()->SendEvents($events);
		}
	}

	if ($type === 'customer.subscription.updated') {
		BeaconRabbitMQ::SendMessage('sentinel_exchange', "sentinel.notifications.{$subscriptionId}", json_encode([
			'event' => 'subscriptionUpdated',
			'subscriptionId' => $subscriptionId,
		]));
	}

	ReportSuccess('Subscription saved');
	break;
case 'customer.subscription.deleted':
	$subscription = $data['object'];
	$stripeSubscription = $subscription['id'];
	$subscriptionId = BeaconUUID::v5($stripeSubscription);

	$sem = sem_get(crc32($subscriptionId));
	sem_acquire($sem);

	$database->BeginTransaction();
	$rows = $database->Query('SELECT user_id FROM public.user_subscriptions WHERE subscription_id = $1;', $subscriptionId);
	$database->Query('UPDATE public.subscriptions SET date_expires = CURRENT_TIMESTAMP(0) WHERE subscription_id = $1;', $subscriptionId);
	$database->Commit();

	sem_release($sem);

	if ($rows->RecordCount() > 0) {
		$user = User::Fetch($rows->Field('user_id'));
		if (is_null($user) === false) {
			$events = [
				new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($user->UserId()), eventName: 'user-updated', body: ''),
				new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelname($user->UserId()), eventName: 'userUpdated', body: ''),
			];
			BeaconPusher::SharedInstance()->SendEvents($events);
		}
	}

	BeaconRabbitMQ::SendMessage('sentinel_exchange', "sentinel.notifications.{$subscriptionId}", json_encode([
		'event' => 'subscriptionUpdated',
		'subscriptionId' => $subscriptionId,
	]));

	ReportSuccess('Subscription deleted');
	break;
default:
	http_response_code(400);
	echo 'Unknown hook type.';
	exit;
}

function ReportSuccess(string $message): void {
	global $eventId, $database;

	$database->BeginTransaction();
	$database->Query('INSERT INTO public.processed_webhooks (event_id) VALUES ($1);', $eventId);
	$database->Commit();

	http_response_code(200);
	echo "{$message}\n";
	exit;
}

function CreatePurchaseFromInvoice(array $invoice): BeaconPurchase {
	global $api, $database;

	$invoiceId = $invoice['id'];
	$email = $invoice['customer_email'];
	$customerId = $invoice['customer'];
	$address = $invoice['customer_address'];
	$billingLocality = $address['country'] ?? '';
	if (isset($address['state'])) {
		$billingLocality .= ' ' . $address['state'];
	}
	$purchaseDate = $invoice['created'];

	$currencyCode = strtoupper($invoice['currency']);
	$currencyRows = $database->Query('SELECT stripe_multiplier, usd_conversion_rate FROM public.currencies WHERE code = $1;', $currencyCode);
	if ($currencyRows->RecordCount() !== 1) {
		throw new Exception("Unknown currency {$currencyCode}");
	}
	$currencyMultiplier = $currencyRows->Field('stripe_multiplier');
	$conversionRate = $currencyRows->Field('usd_conversion_rate'); // This is low accuracy, but it's the best way have.

	$purchase = new BeaconPurchase($invoiceId, $email, $purchaseDate, $billingLocality ?? 'US CT', $currencyCode, $conversionRate, $currencyMultiplier);

	$lines = $invoice['lines']['data'];
	foreach ($lines as $line) {
		$stripeProductId = $line['price']['product'];
		$stripeProduct = $api->GetProduct($stripeProductId);
		$productId = $stripeProduct['metadata']['beacon-uuid'];


		echo json_encode($line, JSON_PRETTY_PRINT);
		$linePrice = $line['amount_excluding_tax'];
		$quantity = $line['quantity'] ?? 1;
		if ($quantity === 0) {
			// it's a fee item
			$unitPrice = $linePrice;
		} else {
			$unitPrice = $linePrice / $quantity;
		}
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
		throw new Exception('No products for invoice');
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

	// Do more work if the invoice is already paid
	UpdatePurchaseWithInvoice($purchase, $invoice);

	return $purchase;
}

function UpdatePurchaseWithInvoice(BeaconPurchase $purchase, array $invoice): bool {
	global $api;

	if ($invoice['paid'] !== true) {
		return false;
	}

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

	return true;
}

function CreatePurchaseFromCheckoutSession(array $session): BeaconPurchase {
	global $api, $database;

	if (isset($session['payment_intent'])) {
		$intentId = $session['payment_intent'];
		$intent = $api->GetPaymentIntent($intentId);
		if (is_null($intent)) {
			throw new Exception("Could not get payment intent {$intentId}");
		}

		$purchaseDate = $session['created'];
		$amountPaid = $intent['amount_received'];

		$purchase = BeaconPurchase::Load($database, $intentId);
		if (is_null($purchase)) {
			$email = $session['customer_details']['email'];
			$billingLocality = $session['customer_details']['address']['country'];
			if (isset($session['customer_details']['address']['state'])) {
				$billingLocality .= ' ' . $session['customer_details']['address']['state'];
			}
			$currencyCode = strtoupper($session['currency']);

			$charges = [];
			if (isset($intent['charges']['data']) && is_array($intent['charges']['data'])) {
				$charges = $intent['charges']['data'];
			}
			$paidCharge = null;
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
				throw new Exception("Unknown currency code {$currencyCode}.");
			}
			$currencyMultiplier = $currencyRows->Field('stripe_multiplier');
			$conversionRate = $conversionRate / (100 / $currencyMultiplier);

			$purchase = new BeaconPurchase($intentId, $email, $purchaseDate, $billingLocality ?? 'US CT', $currencyCode, $conversionRate, $currencyMultiplier);
			$lineItems = $api->GetLineItems($session['id']);
			if (is_null($lineItems)) {
				throw new Exception('Unable to retrieve items for checkout session');
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
				throw new Exception('No products for this checkout session.');
			}
		}

		$purchase->SetAmountPaid($amountPaid);
		if ($amountPaid === $purchase->Total()) {
			$purchase->SetDateFulfilled($purchaseDate);
		}
	} elseif (isset($session['invoice'])) {
		$invoiceId = $session['invoice'];
		$invoice = $api->GetInvoice($invoiceId);
		if (is_null($invoice)) {
			throw new Exception("Could not get invoice {$invoiceId}");
		}
		$purchase = BeaconPurchase::Load($database, $invoiceId);
		if (is_null($purchase)) {
			$purchase = CreatePurchaseFromInvoice($invoice);
		} else {
			UpdatePurchaseWithInvoice($purchase, $invoice);
		}
	} else {
		ReportSuccess('What is this object?');
	}

	if (isset($session['client_reference_id'])) {
		$purchase->SetClientReferenceId($session['client_reference_id']);
	}

	if (isset($session['metadata']) && isset($session['metadata']['Beacon Cart'])) {
		$bundles = json_decode(gzdecode(BeaconCommon::Base64UrlDecode($session['metadata']['Beacon Cart'])), true);
		$purchase->SetMetadata([
			'bundles' => $bundles,
		]);
	}

	return $purchase;
}

function SaveSubscription(array $subscription): string {
	global $api, $database;

	$stripeSubscription = $subscription['id'];
	$subscriptionId = BeaconUUID::v5($stripeSubscription);

	$startDate = $subscription['current_period_start'];
	$endDate = $subscription['current_period_end'];
	$stripeProductId = $subscription['plan']['product'];
	$stripeProduct = $api->GetProduct($stripeProductId);
	$productId = $stripeProduct['metadata']['beacon-uuid'];
	$latestInvoiceId = $subscription['latest_invoice'];
	$latestPurchaseId = BeaconUUID::v5($latestInvoiceId);
	$planQuantity = $subscription['quantity'];

	$database->Query('INSERT INTO public.subscription_purchases (subscription_id, purchase_id) VALUES ($1, $2) ON CONFLICT (subscription_id, purchase_id) DO NOTHING;', $subscriptionId, $latestPurchaseId);

	$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM public.subscriptions WHERE subscription_id = $1) AS exists;', $subscriptionId);
	if ($rows->Field('exists')) {
		$database->Query('UPDATE public.subscriptions SET date_expires = TO_TIMESTAMP($2), product_id = $3, last_purchase_id = $4, product_quantity = $5 WHERE subscription_id = $1 AND (date_expires != TO_TIMESTAMP($2) OR product_id != $3 OR last_purchase_id != $4 OR product_quantity != $5);', $subscriptionId, $endDate, $productId, $latestPurchaseId, $planQuantity);
	} else {
		$database->Query('INSERT INTO public.subscriptions (subscription_id, stripe_id, product_id, date_created, date_expires, initial_purchase_id, last_purchase_id, product_quantity) VALUES ($1, $2, $3, TO_TIMESTAMP($4), TO_TIMESTAMP($5), $6, $6, $7);', $subscriptionId, $stripeSubscription, $productId, $startDate, $endDate, $latestPurchaseId, $planQuantity);
	}

	$saveInvoice = false;
	$invoicePurchase = BeaconPurchase::Load($database, $latestPurchaseId);
	if (is_null($invoicePurchase)) {
		$invoice = $api->GetInvoice($latestInvoiceId);
		if (is_null($invoice)) {
			throw new Exception("Unable to download invoice {$latestInvoiceId}");
		}
		$invoicePurchase = CreatePurchaseFromInvoice($invoice);
		$saveInvoice = true;
	}
	if (is_null($invoicePurchase->ClientReferenceId())) {
		$rows = $database->Query('SELECT client_reference_id FROM public.subscriptions INNER JOIN public.purchases ON (purchases.purchase_id = subscriptions.initial_purchase_id) WHERE subscription_id = $1;', $subscriptionId);
		if ($rows->RecordCount() === 1 && $invoicePurchase->ClientReferenceId() !== $rows->Field('client_reference_id')) {
			$invoicePurchase->SetClientReferenceId($rows->Field('client_reference_id'));
			$saveInvoice = true;
		}
	}
	if ($saveInvoice) {
		$invoicePurchase->SaveTo($database);
	}

	return $subscriptionId;
}

function UpdateSubscription(array $subscription): void {

}

?>
