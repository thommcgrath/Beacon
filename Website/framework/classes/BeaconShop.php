<?php

abstract class BeaconShop {
	private static $products = [];
	
	public static function CacheProducts(string $currencyCode): void {
		if (isset(static::$products[$currencyCode])) {
			return;
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT products.product_id, products.product_name, EXTRACT(epoch FROM products.updates_length) AS plan_length_seconds, products.flags, products.round_to, products.game_id, products.tag, product_prices.price FROM public.product_prices INNER JOIN public.products ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1 AND products.active = TRUE;', $currencyCode);
		$cache = [];
		while (!$results->EOF()) {
			$productId = $results->Field('product_id');
			$name = $results->Field('product_name');
			$planLength = is_null($results->Field('plan_length_seconds')) ? null : intval($results->Field('plan_length_seconds'));
			$flags = $results->Field('flags');
			$productRoundingMultiplier = $results->Field('round_to');
			$gameId = $results->Field('game_id');
			$tag = $results->Field('tag');
			$price = $results->Field('price');
			
			$product = [
				'ProductId' => $productId,
				'GameId' => $gameId,
				'Tag' => $tag,
				'Name' => $name,
				'Price' => $price,
				'PlanLength' => $planLength,
				'Flags' => $flags,
				'RoundTo' => $productRoundingMultiplier
			];
			
			$cache[$productId] = $product;
			$cache[$gameId][$tag] = $product;
			
			$results->MoveNext();
		}
		static::$products[$currencyCode] = $cache;
	}
	
	public static function GetProductById(string $currencyCode, string $productId): ?array {
		if (isset(static::$products[$currencyCode]) === false) {
			static::CacheProducts($currencyCode);
		}
		
		return static::$products[$currencyCode][$productId] ?? null;
	}
	
	public static function GetProductByTag(string $currencyCode, string $gameId, string $tag): ?array {
		if (isset(static::$products[$currencyCode]) === false) {
			static::CacheProducts($currencyCode);
		}
		
		return static::$products[$currencyCode][$gameId][$tag] ?? null;
	}
	
	public static function CreateBundle(array $quantities, bool $isGift): array {
		return [
			'isGift' => $isGift,
			'products' => $quantities
		];
	}
	
	public static function IssuePurchases(string $purchaseId, array $bundles): void {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT issued, refunded, purchaser_email, currency FROM public.purchases WHERE purchase_id = $1;', $purchaseId);
		if ($results->RecordCount() === 0 || $results->Field('issued') === true || $results->Field('refunded') === true) {
			return;
		}
		$emailId = $results->Field('purchaser_email');
		$currencyCode = $results->Field('currency');
		
		$database->BeginTransaction();
		
		$results = $database->Query("SELECT EXTRACT(epoch FROM DATE_TRUNC('day', CURRENT_TIMESTAMP + '1 day')) AS base_expiration;");
		$newLicenseStartTimestamp = intval($results->Field('base_expiration'));
		
		foreach ($bundles as $bundle) {
			$purchasedProducts = $bundle['products'];
			$isGift = $bundle['isGift'];
			
			if ($isGift) {
				$code = BeaconCommon::CreateGiftCode();
				$database->Query('INSERT INTO public.gift_codes (code, source_purchase_id) VALUES ($1, $2);', $code, $purchaseId);
				foreach ($purchasedProducts as $productId => $quantity) {
					$database->Query('INSERT INTO public.gift_code_products (code, product_id, quantity) VALUES ($1, $2, $3);', $code, $productId, $quantity);
				}
				continue;
			}
			
			foreach ($purchasedProducts as $productId => $quantity) {
				$product = static::GetProductById($currencyCode, $productId);
				
				// Renewals and upgrades need to use the base product id. Keep $product pointing to the correct product,
				// in case the upgrade or renewal has a special behavior such as length.
				if ($product['Tag'] === 'Renewal' || $product['Tag'] === 'Upgrade') {
					$productId = static::GetProductByTag($currencyCode, $product['Game'], 'Base')['ProductId'];
				}
				
				if (is_null($product['PlanLength'])) {
					$database->Query('INSERT INTO public.licenses (purchase_id, product_id) VALUES ($1, $2);', $purchaseId, $productId);
				} else {
					$updateSeconds = $product['PlanLength'] * $quantity;
					$startTimestamp = $newLicenseStartTimestamp;
					
					$licenses = $database->Query('SELECT license_id, EXTRACT(epoch FROM expiration) AS expiration_timestamp FROM public.licenses INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 AND licenses.product_id = $2;', $emailId, $productId);
					if ($licenses->RecordCount() > 0) {
						$licenseId = $licenses->Field('license_id');
						$startTimestamp = max($startTimestamp, intval($licenses->Field('expiration_timestamp')));
						$database->Query('UPDATE public.licenses SET expiration = to_timestamp($2), purchase_id = $3 WHERE license_id = $1;', $licenseId, $startTimestamp + $updateSeconds, $purchaseId);
					} else {
						$database->Query('INSERT INTO public.licenses (purchase_id, product_id, expiration) VALUES ($1, $2, to_timestamp($3));', $purchaseId, $productId, $startTimestamp + $updateSeconds);
					}
				}
			}
		}
		
		$database->Query('UPDATE purchases SET issued = TRUE WHERE purchase_id = $1;', $purchaseId);
		$database->Commit();
	}
	
	public static function RevokePurchases(string $purchaseId, bool $isDisputed = false): bool {
		$database = BeaconCommon::Database();
		if (BeaconCommon::IsUUID($purchaseId) === false) {
			$results = $database->Query('SELECT purchase_id FROM purchases WHERE merchant_reference = $1;', $purchaseId);
			if ($results->RecordCount() !== 1) {
				return false;
			}
			$purchaseId = $results->Field('purchase_id');
		}
		
		$results = $database->Query('SELECT issued, purchaser_email FROM purchases WHERE purchase_id = $1;', $purchaseId);
		if ($results->RecordCount() === 0) {
			return false;
		}
		$emailId = $results->Field('purchaser_email');
		$wasIssued = $results->Field('issued');
		
		$database->BeginTransaction();
		$database->Query('UPDATE purchases SET refunded = TRUE WHERE purchase_id = $1 AND refunded = FALSE;', $purchaseId);
		if ($isDisputed) {
			$database->Query('UPDATE users SET banned = TRUE WHERE email_id = $1;', $emailId);
		}
		
		if ($wasIssued) {
			$database->Query('DELETE FROM licenses WHERE purchase_id = $1;', $purchaseId);
			
			// Also revoke gift redemptions
			$results = $database->Query('SELECT redemption_purchase_id FROM gift_codes WHERE source_purchase_id = $1 AND redemption_purchase_id IS NOT NULL;', $purchaseId);
			while ($results->EOF() === false) {
				self::RevokePurchases($results->Field('redemption_purchase_id'));
				$results->MoveNext();
			}
			$database->Query('DELETE FROM gift_codes WHERE source_purchase_id = $1;', $purchaseId);
			
			// Revoke STW purchases that have NOT been awarded yet. Don't punish somebody who won.
			$database->Query('DELETE FROM stw_purchases WHERE original_purchase_id = $1 AND generated_purchase_id IS NULL;', $purchaseId);
		}
		$database->Commit();
		
		return true;
	}
	
	public static function CreateGiftPurchase(string $email, string $productId, int $quantity, string $notes, bool $process = false): string {
		return static::GrantProducts($email, [static::CreateBundle(false, [$productId => $quantity])], $notes, $process);
	}
	
	public static function GrantProducts(string $email, array $bundles, string $notes, bool $process = false): string {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		
		if (BeaconCommon::IsUUID($email)) {
			$emailId = $email;
		} else {
			// get a uuid for this address
			$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
			$emailId = $results->Field('email_id');
		}
		
		$quantities = [];
		foreach ($bundles as $bundle) {
			foreach ($bundle['products'] as $productId => $quantity) {
				$quantities[$productId] = ($quantities[$productId] ?? 0) + $quantity;
			}
		}
		
		$subtotal = 0;
		$purchaseId = BeaconCommon::GenerateUUID();
		foreach ($quantities as $productId => $quantity) {
			$price = static::GetProductById('USD', $productId)['Price'];
			$lineTotal = $price * $quantity;
			$subtotal += $lineTotal;
			$database->Query('INSERT INTO purchase_items (purchase_id, product_id, currency, quantity, unit_price, subtotal, discount, tax, line_total) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);', $purchaseId, $productId, 'USD', $quantity, $price, $lineTotal, $lineTotal, 0, 0);
		}
		
		$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, tax_locality, total_paid, merchant_reference, currency, notes) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);', $purchaseId, $emailId, $subtotal, $subtotal, 0, 'US CT', 0, $purchaseId, 'USD', $notes);
		
		if ($process === true) {
			self::IssuePurchases($purchaseId, $bundles);
		}
		
		$database->Commit();
		
		return $purchaseId;
	}
	
	public static function TrackAffiliateClick(string $code): string {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT code FROM affiliate_links WHERE code = $1;', $code);
		$clientReferenceId = BeaconCommon::GenerateUUID();
		
		if ($rows->RecordCount() === 1) {
			$code = $rows->Field('code'); // Just because
			
			$database->BeginTransaction();
			$database->Query('INSERT INTO affiliate_tracking (code, client_reference_id, click_time) VALUES ($1, $2, CURRENT_TIMESTAMP);', $code, $clientReferenceId);
			$database->Commit();
			
			setcookie('beacon_affiliate', $clientReferenceId, [
				'expires' => time() + 86430,
				'path' => '/omni',
				'domain' => '',
				'secure' => true,
				'httponly' => true,
				'samesite' => 'Strict'
			]);
		}
		
		return $clientReferenceId;
	}
	
	public static function SyncWithStripe(): void {
		$apiSecret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
		$api = new BeaconStripeAPI($apiSecret, '2022-08-01');
		$database = BeaconCommon::Database();
			
		$results = $database->Query('SELECT code, usd_conversion_rate, rounding_multiplier, fee_multiplier, stripe_multiplier FROM public.currencies ORDER BY code;');
		$rates = [];
		while (!$results->EOF()) {
			$rates[$results->Field('code')] = [
				'rate' => $results->Field('usd_conversion_rate'),
				'multipliers' => [
					'rounding' => $results->Field('rounding_multiplier'),
					'fee' => $results->Field('fee_multiplier'),
					'stripe' => $results->Field('stripe_multiplier')
				]
			];
			$results->MoveNext();
		}
		
		// Include all products, so that prices can be ready before products are activated
		$products = $database->Query('SELECT product_id, product_name, retail_price, updates_length, round_to FROM public.products ORDER BY product_name;');
		while (!$products->EOF()) {
			$productId = $products->Field('product_id');
			$productName = $products->Field('product_name');
			$retailPrice = $products->Field('retail_price');
			$productRoundingMultiplier = $products->Field('round_to');
			
			$product = $api->GetProductByUUID($productId);
			if (is_null($product)) {
				$products->MoveNext();
				continue;
			}
			
			$productCode = $product['id'];
			$defaultPrice = $product['default_price'];
			$productPrices = $api->GetProductPrices($productCode);
			
			$prices = [];
			foreach ($rates as $currency => $rate) {
				$prices[$currency] = [];
			}
			foreach ($productPrices as $price) {
				$prices[strtoupper($price['currency'])][] = $price;
			}
			
			foreach ($rates as $currency => $rateInfo) {
				echo "Syncing {$productName} {$currency}\n";
				
				$rate = $rateInfo['rate'];
				$currencyRoundingMultiplier = $rateInfo['multipliers']['rounding'];
				$currencyFeeMultiplier = $rateInfo['multipliers']['fee'];
				$currencyStripeMultiplier = $rateInfo['multipliers']['stripe'];
				
				$convertedPrice = $retailPrice * $currencyFeeMultiplier * $rate;
				$convertedPrice = ceil($convertedPrice / $currencyRoundingMultiplier) * $currencyRoundingMultiplier;
				$convertedPrice = ceil($convertedPrice / $productRoundingMultiplier) * $productRoundingMultiplier;
				$convertedPriceStripe = $convertedPrice * $currencyStripeMultiplier;
				
				$activePriceId = null;
				foreach ($prices[$currency] as $price) {
					$priceId = $price['id'];
					$shouldBeActive = $price['unit_amount'] == $convertedPriceStripe && $price['tax_behavior'] === 'exclusive';
					if ($shouldBeActive) {
						$activePriceId = $priceId;
					}
					if ($shouldBeActive == true && $price['active'] == false) {
						echo "Enabling price {$price['unit_amount']} {$currency}…\n";
						$api->EditPrice($priceId, ['active' => 'true']);
					} else if ($shouldBeActive == false && $price['active'] == true) {
						echo "Disabling price {$price['unit_amount']} {$currency}…\n";
						$api->EditPrice($priceId, ['active' => 'false']);
					}
				}
				if (is_null($activePriceId)) {
					// Create a new price
					echo "Creating price for {$convertedPriceStripe} {$currency}…\n";
					$activePriceId = $api->CreatePrice($productCode, $currency, $convertedPriceStripe);
					echo "Created price {$activePriceId}\n";
				}
				
				if ($currency === 'USD' && $activePriceId !== $defaultPrice) {
					echo "Setting default price…\n";
					$api->EditProduct($productCode, ['default_price' => $activePriceId]);
				}
				
				$database->BeginTransaction();
				$database->Query('INSERT INTO public.product_prices (price_id, product_id, currency, price) VALUES ($1, $2, $3, $4) ON CONFLICT (product_id, currency) DO UPDATE SET price_id = EXCLUDED.price_id, price = EXCLUDED.price WHERE product_prices.price_id != EXCLUDED.price_id;', $activePriceId, $productId, $currency, $convertedPrice);
				$database->Commit();
			}
			
			$products->MoveNext();
		}
		
		echo "Finished\n";
	}
	
	private static function LoadCurrencyData(): void {
		if (isset($_SESSION['store_currency_options']) && isset($_SESSION['store_currency']) && empty($_SESSION['store_currency_options']) === false && empty($_SESSION['store_currency']) === false) {
			return;
		}
		
		$stripe_api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'), '2022-08-01');
		$country = BeaconCommon::RemoteCountry();
		if ($country === 'XX') {
			$country = 'US';
		}
		$countries = [$country];
		if ($country !== 'US') {
			$countries[] = 'US';
		}
		
		foreach ($countries as $country) {
			$cache_key = 'country:' . $country;
			$spec = BeaconCache::Get($cache_key);
			if (is_null($spec)) {
				$spec = $stripe_api->GetCountrySpec($country);
				if (is_null($spec) === false) {
					BeaconCache::Set($cache_key, $spec);
					break;
				}
			}
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT code, name FROM public.currencies WHERE code = ANY($1) ORDER BY name;', '{' . implode(',', $spec['supported_payment_currencies']) . '}');
		$supported_currencies = [];
		while (!$results->EOF()) {
			$supported_currencies[$results->Field('code')] = $results->Field('name');
			$results->MoveNext();
		}
		$_SESSION['store_currency_options'] = $supported_currencies;
		$_SESSION['store_default_currency'] = strtoupper($spec['default_currency']);
		$_SESSION['store_currency'] = $_SESSION['store_default_currency'];
	}
	
	public static function GetCurrencyOptions(): array {
		static::LoadCurrencyData();
		return $_SESSION['store_currency_options'];
	}
	
	public static function GetCurrency(): string {
		static::LoadCurrencyData();
		return $_SESSION['store_currency'];
	}
	
	public static function SetCurrency(string $currency): string {
		$currencyOptions = static::GetCurrencyOptions();
		if (array_key_exists($currency, $currencyOptions)) {
			$_SESSION['store_currency'] = $currency;
		} else {
			$_SESSION['store_currency'] = $_SESSION['store_default_currency'];
		}
		return $_SESSION['store_currency'];
	}
	
	public static function EmailOwns(string $email, string $productId): bool {
		$database = BeaconCommon::Database();
		$rows = $database->Query("SELECT COUNT(license_id) AS license_count FROM public.licenses WHERE product_id = $1 AND purchase_id IN (SELECT purchase_id FROM public.purchases WHERE purchaser_email = uuid_for_email($2) AND refunded != TRUE);", $productId, $email);
		return intval($rows->Field('license_count')) > 0;
	}
}

?>
