<?php

abstract class BeaconShop {
	const ARK_PRODUCT_ID = '972f9fc5-ad64-4f9c-940d-47062e705cc5';
	const ARK_GIFT_ID = '2207d5c1-4411-4854-b26f-bc4b48aa33bf';
	const ARK2_PRODUCT_ID = '02206d4b-e3b2-40d8-a9b9-627fed0744b0';
	const ARK2_GIFT_ID = '61653d69-2ccc-4f29-857a-7e44f1010d57';
	const ARKSA_PRODUCT_ID = '86140896-a825-4010-a215-c8f1b9c4688e';
	const ARKSA_GIFT_ID = 'ec1ac54a-85fb-40a2-9982-08b4fe629c75';
	const STW_ID = 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015';
	
	public static function IssuePurchases(string $purchase_id): void {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT issued, refunded, purchaser_email FROM purchases WHERE purchase_id = $1;', $purchase_id);
		if ($results->RecordCount() === 0 || $results->Field('issued') === true || $results->Field('refunded') === true) {
			return;
		}
		
		$database->BeginTransaction();
		$email_id = $results->Field('purchaser_email');
		$results = $database->Query('SELECT products.product_id, EXTRACT(epoch FROM products.updates_length) AS updates_length_seconds, products.flags, purchase_items.quantity FROM purchase_items INNER JOIN products ON (purchase_items.product_id = products.product_id) WHERE purchase_id = $1;', $purchase_id);
		while ($results->EOF() === false) {
			$product_id = $results->Field('product_id');
			$quantity = intval($results->Field('quantity'));
			$update_seconds = $results->Field('updates_length_seconds');
			switch ($product_id) {
			case self::ARK_PRODUCT_ID:
			case self::ARK2_PRODUCT_ID:
			case self::ARKSA_PRODUCT_ID:
				if (is_null($update_seconds)) {
					$database->Query('INSERT INTO licenses (purchase_id, product_id) VALUES ($1, $2);', $purchase_id, $product_id);
				} else {
					$update_seconds = intval($update_seconds) * $quantity;
					$licenses = $database->Query('SELECT EXTRACT(epoch FROM GREATEST(MAX(expiration), DATE_TRUNC(\'day\', CURRENT_TIMESTAMP + \'1 day\'))) AS base_expiration FROM licenses INNER JOIN purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 AND licenses.product_id = $2;', $email_id, $product_id);
					$database->Query('INSERT INTO licenses (purchase_id, product_id, expiration) VALUES ($1, $2, to_timestamp($3));', $purchase_id, $product_id, $update_seconds + intval($licenses->Field('base_expiration')));
				}
				$database->Query('DELETE FROM stw_applicants WHERE email_id = $1 AND desired_product = $2 AND generated_purchase_id IS NULL;', $email_id, $product_id);
				break;
			case self::ARK_GIFT_ID:
			case self::ARK2_GIFT_ID:
			case self::ARKSA_GIFT_ID:
				for ($i = 1; $i <= $quantity; $i++) {
					$code = \BeaconCommon::CreateGiftCode();
					$database->Query('INSERT INTO gift_codes (code, source_purchase_id, product_id) VALUES ($1, $2, $3);', $code, $purchase_id, $product_id);
				}
				break;
			case self::STW_ID:
				for ($i = 1; $i <= $quantity; $i++) {
					$database->Query('INSERT INTO stw_purchases (original_purchase_id) VALUES ($1);', $purchase_id);
				}
				break;
			}
			$results->MoveNext();
		}
		$database->Query('UPDATE purchases SET issued = TRUE WHERE purchase_id = $1;', $purchase_id);
		$database->Commit();
	}
	
	public static function RevokePurchases(string $purchase_id, bool $is_disputed = false): bool {
		$database = \BeaconCommon::Database();
		if (BeaconCommon::IsUUID($purchase_id) === false) {
			$results = $database->Query('SELECT purchase_id FROM purchases WHERE merchant_reference = $1;', $purchase_id);
			if ($results->RecordCount() !== 1) {
				return false;
			}
			$purchase_id = $results->Field('purchase_id');
		}
		
		$results = $database->Query('SELECT issued, purchaser_email FROM purchases WHERE purchase_id = $1;', $purchase_id);
		if ($results->RecordCount() === 0) {
			return false;
		}
		$email_id = $results->Field('purchaser_email');
		$was_issued = $results->Field('issued');
		
		$database->BeginTransaction();
		$database->Query('UPDATE purchases SET refunded = TRUE WHERE purchase_id = $1 AND refunded = FALSE;', $purchase_id);
		if ($is_disputed) {
			$database->Query('UPDATE users SET banned = TRUE WHERE email_id = $1;', $email_id);
		}
		
		if ($was_issued) {
			$database->Query('DELETE FROM licenses WHERE purchase_id = $1;', $purchase_id);
			
			// Also revoke gift redemptions
			$results = $database->Query('SELECT redemption_purchase_id FROM gift_codes WHERE source_purchase_id = $1 AND redemption_purchase_id IS NOT NULL;', $purchase_id);
			while ($results->EOF() === false) {
				self::RevokePurchases($results->Field('redemption_purchase_id'));
				$results->MoveNext();
			}
			$database->Query('DELETE FROM gift_codes WHERE source_purchase_id = $1;', $purchase_id);
			
			// Revoke STW purchases that have NOT been awarded yet. Don't punish somebody who won.
			$database->Query('DELETE FROM stw_purchases WHERE original_purchase_id = $1 AND generated_purchase_id IS NULL;', $purchase_id);
		}
		$database->Commit();
		
		return true;
	}
	
	public static function CreateGiftPurchase(string $email, string $product_id, int $quantity, string $notes, bool $process = false): string {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		
		if (BeaconCommon::IsUUID($email)) {
			$email_id = $email;
		} else {
			// get a uuid for this address
			$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
			$email_id = $results->Field('email_id');
		}
		
		// find the current price of the product in USD
		$results = $database->Query('SELECT price FROM product_prices WHERE product_id = $1 AND currency = $2;', $product_id, 'USD');
		$retail_price = $results->Field('price');
		$subtotal = $retail_price * $quantity;
		
		// generate the purchase record
		$purchase_id = BeaconCommon::GenerateUUID();
		$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, tax_locality, total_paid, merchant_reference, currency, notes) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);', $purchase_id, $email_id, $subtotal, $subtotal, 0, 'US CT', 0, $purchase_id, 'USD', $notes);
		$database->Query('INSERT INTO purchase_items (purchase_id, product_id, currency, quantity, unit_price, subtotal, discount, tax, line_total) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);', $purchase_id, $product_id, 'USD', $quantity, $retail_price, $subtotal, $subtotal, 0, 0);
		if ($process === true) {
			self::IssuePurchases($purchase_id);
		}
		$database->Commit();
		
		return $purchase_id;
	}
	
	public static function TrackAffiliateClick(string $code): string {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT code FROM affiliate_links WHERE code = $1;', $code);
		$client_reference_id = BeaconCommon::GenerateUUID();
		
		if ($rows->RecordCount() === 1) {
			$code = $rows->Field('code'); // Just because
			
			$database->BeginTransaction();
			$database->Query('INSERT INTO affiliate_tracking (code, client_reference_id, click_time) VALUES ($1, $2, CURRENT_TIMESTAMP);', $code, $client_reference_id);
			$database->Commit();
			
			setcookie('beacon_affiliate', $client_reference_id, [
				'expires' => time() + 86430,
				'path' => '/omni',
				'domain' => '',
				'secure' => true,
				'httponly' => true,
				'samesite' => 'Strict'
			]);
		}
		
		return $client_reference_id;
	}
	
	public static function SyncWithStripe(): void {
		$api_secret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
		$api = new BeaconStripeAPI($api_secret, '2022-08-01');
		$database = BeaconCommon::Database();
			
		$results = $database->Query('SELECT code, usd_conversion_rate FROM public.currencies;');
		$rates = [];
		while (!$results->EOF()) {
			$rates[$results->Field('code')] = $results->Field('usd_conversion_rate');
			$results->MoveNext();
		}
		
		$products = $database->Query('SELECT product_id, product_name, retail_price, updates_length, round_to FROM public.products;');
		while (!$products->EOF()) {
			$product_id = $products->Field('product_id');
			$product_name = $products->Field('product_name');
			$retail_price = $products->Field('retail_price');
			$round_to = $products->Field('round_to');
			
			$product = $api->GetProductByUUID($product_id);
			if (is_null($product)) {
				$products->MoveNext();
				continue;
			}
			
			$product_code = $product['id'];
			$default_price = $product['default_price'];
			foreach ($rates as $currency => $rate) {
				// The price should be an even multiple, plus 1% for conversion fees
				$converted_price = ceil(($retail_price * ($currency === 'USD' ? 1.0 : 1.01) * $rate) / $round_to) * $round_to;
				$converted_price_stripe = $converted_price * 100;
				$prices = $api->GetProductPrices($product_code, $currency);
				$active_price_id = null;
				foreach ($prices as $price) {
					$price_id = $price['id'];
					$should_be_active = $price['unit_amount'] == $converted_price_stripe && $price['tax_behavior'] === 'exclusive';
					if ($should_be_active) {
						$active_price_id = $price_id;
					}
					if ($should_be_active == true && $price['active'] == false) {
						$api->EditPrice($price_id, ['active' => 'true']);
					} else if ($should_be_active == false && $price['active'] == true) {
						$api->EditPrice($price_id, ['active' => 'false']);
					}
				}
				if (is_null($active_price_id)) {
					// Create a new price
					$active_price_id = $api->CreatePrice($product_code, $currency, $converted_price_stripe);
				}
				
				if ($currency === 'USD' && $active_price_id !== $default_price) {
					$api->EditProduct($product_code, ['default_price' => $active_price_id]);
				}
				
				$database->BeginTransaction();
				$database->Query('INSERT INTO public.product_prices (price_id, product_id, currency, price) VALUES ($1, $2, $3, $4) ON CONFLICT (product_id, currency) DO UPDATE SET price_id = EXCLUDED.price_id, price = EXCLUDED.price WHERE product_prices.price_id != EXCLUDED.price_id;', $active_price_id, $product_id, $currency, $converted_price);
				$database->Commit();
			}
			
			$products->MoveNext();
		}
	}
}

?>
