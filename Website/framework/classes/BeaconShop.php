<?php

abstract class BeaconShop {
	const ARK_PRODUCT_ID = '972f9fc5-ad64-4f9c-940d-47062e705cc5';
	const ARK_GIFT_ID = '2207d5c1-4411-4854-b26f-bc4b48aa33bf';
	const ARK2_PRODUCT_ID = '02206d4b-e3b2-40d8-a9b9-627fed0744b0';
	const ARK2_GIFT_ID = '61653d69-2ccc-4f29-857a-7e44f1010d57';
	const STW_ID = 'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015';
	
	public static function IssuePurchases(string $purchase_id) {
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
				for ($i = 1; $i <= $quantity; $i++) {
					$code = \BeaconCommon::CreateGiftCode();
					$database->Query('INSERT INTO gift_codes (code, source_purchase_id, product_id) VALUES ($1, $2, $3);', $code, $purchase_id, self::ARK_PRODUCT_ID);
				}
				break;
			case self::ARK2_GIFT_ID:
				for ($i = 1; $i <= $quantity; $i++) {
					$code = \BeaconCommon::CreateGiftCode();
					$database->Query('INSERT INTO gift_codes (code, source_purchase_id, product_id) VALUES ($1, $2, $3);', $code, $purchase_id, self::ARK2_PRODUCT_ID);
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
	
	public static function RevokePurchases(string $purchase_id, bool $is_disputed = false) {
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
			$results = $database->Query('SELECT redemption_purchase_id FROM gift_codes WHERE source_purchase_id = $1;', $purchase_id);
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
	
	public static function FormatPrice(float $price, string $currency, bool $with_suffix = true) {
		switch ($currency) {
		case 'USD':
			$decimal_character = '.';
			$thousands_character = ',';
			$currency_symbol = '$';
			break;
		case 'EUR':
			$decimal_character = ',';
			$thousands_character = '.';
			$currency_symbol = '€';
			break;
		}
		
		return $currency_symbol . number_format($price, 2, $decimal_character, $thousands_character) . ($with_suffix ?  ' ' . $currency : '');
	}
	
	public static function CreateGiftPurchase(string $email, string $product_id, int $quantity, string $notes, bool $process = false) {
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
}

?>
