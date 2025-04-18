<?php

use BeaconAPI\v4\User;

class BeaconStripeAPI {
	private $apiSecret = '';
	private $stripeVersion = '';

	public function __construct(string $apiSecret, string $stripeVersion = '2020-08-27') {
		$this->apiSecret = $apiSecret;
		$this->stripeVersion = $stripeVersion;
	}

	protected function GetURL(string $url, bool $noCache = true): ?array {
		if ($noCache === false) {
			$json = BeaconCache::Get($url);
			if (is_null($json) === false) {
				return $json;
			}
		}

		$curl = curl_init($url);
		$headers = [
			'Authorization: Bearer ' . $this->apiSecret,
			'Stripe-Version: ' . $this->stripeVersion
		];
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$body = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if ($status != 200) {
			return null;
		}
		$json = json_decode($body, true);
		if (is_null($json)) {
			return null;
		}

		if ($noCache === false) {
			BeaconCache::Set($url, $json, 300);
		}
		return $json;
	}

	protected function PostURL(string $url, array $formdata): ?array {
		$curl = curl_init($url);
		$headers = [
			'Authorization: Bearer ' . $this->apiSecret,
			'Stripe-Version: ' . $this->stripeVersion
		];
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, 1);
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($formdata));
		$body = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if ($status === 200) {
			return json_decode($body, true);
		} else {
			return null;
		}
	}

	protected function DeleteURL(string $url): ?array {
		$curl = curl_init($url);
		$headers = [
			'Authorization: Bearer ' . $this->apiSecret,
			'Stripe-Version: ' . $this->stripeVersion
		];
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
		$body = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if ($status === 200) {
			return json_decode($body, true);
		} else {
			return null;
		}
	}

	public function GetPaymentIntent(string $intentId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/payment_intents/' . $intentId);
	}

	public function GetInvoice(string $invoiceId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/invoices/' . $invoiceId);
	}

	public function GetLineItems(string $sessionId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/checkout/sessions/' . $sessionId . '/line_items?expand%5B%5D=data.discounts&expand%5B%5D=data.taxes');
	}

	public function GetCustomer(string $customerId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/customers/' . $customerId);
	}

	public function GetCustomersByEmail(string $customerEmail): ?array {
		return $this->GetURL('https://api.stripe.com/v1/customers/search?query=' . urlencode("email:'{$customerEmail}'"));
	}

	public function GetCustomerIdForUser(User|string $user): ?string {
		if (is_string($user)) {
			$user = User::Fetch($user);
			if (is_null($user)) {
				return null;
			}
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT stripe_id FROM public.users WHERE user_id = $1;', $user->UserId());
		if ($rows->RecordCount() === 1 AND is_null($rows->Field('stripe_id')) === false) {
			return $rows->Field('stripe_id');
		}

		$results = $this->GetURL('https://api.stripe.com/v1/customers/search?query=' . urlencode("metadata['beacon-uuid']:'{$user->UserId()}'"));
		if (count($results['data']) > 0) {
			$database->BeginTransaction();
			$database->Query('UPDATE public.users SET stripe_id = $2 WHERE user_id = $1;', $user->UserId(), $results['data'][0]['id']);
			$database->Commit();
			return $results['data'][0]['id'];
		}

		$results = $database->Query('SELECT merchant_reference FROM public.purchases INNER JOIN public.users ON (purchases.purchaser_email = users.email_id) WHERE users.user_id = $1 AND purchases.merchant_reference LIKE \'pi_%\' ORDER BY purchase_date DESC LIMIT 1;', $user->UserId());
		if ($results->RecordCount() === 0) {
			return null;
		}

		$intentId = $results->Field('merchant_reference');
		$intent = $this->GetURL('https://api.stripe.com/v1/payment_intents/' . $intentId);
		if (is_null($intent)) {
			return null;
		}
		$customerId = $intent['customer'];
		$database->BeginTransaction();
		$database->Query('UPDATE public.users SET stripe_id = $2 WHERE user_id = $1;', $user->UserId(), $customerId);
		$database->Commit();
		$this->UpdateCustomer($customerId, [
			'metadata' => [
				'beacon-uuid' => $user->UserId(),
			],
		]);
		return $customerId;
	}

	public function GetBalanceTransactionsForSource(string $sourceId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/balance_transactions?source=' . urlencode($sourceId));
	}

	public function GetProductByUUID(string $productId): ?array {
		$results = $this->GetURL('https://api.stripe.com/v1/products/search?query=' . urlencode("metadata['beacon-uuid']:'{$productId}'"));
		if (count($results['data']) > 0) {
			return $results['data'][0];
		} else {
			return null;
		}
	}

	public function GetProduct(string $productId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/products/' . $productId);
	}

	public function GetProductPrices(string $productCode, ?string $currency = null): ?array {
		$query = "product:'{$productCode}'";
		if (is_null($currency) === false) {
			$query .= " AND currency:'{$currency}'";
		}
		$results = $this->GetURL('https://api.stripe.com/v1/prices/search?query=' . urlencode($query) . '&limit=100');
		if ($results['has_more'] == true) {
			echo "Partial results\n";
		}
		return $results['data'];
	}

	public function GetBillingLocality(string|array $intentId): ?string {
		if (is_array($intentId)) {
			$intent = $intentId;
			$intentId = $intent['id'];
		} else {
			$intent = $this->GetPaymentIntent($intentId);
			if (is_null($intent)) {
				return null;
			}
		}

		$charges = $intent['charges']['data'];
		if (is_array($charges) == false || count($charges) == 0) {
			return null;
		}

		$charge = $charges[0];

		if (array_key_exists('billing_details', $charge) == false) {
			return null;
		}
		$billing = $charge['billing_details'];

		if (array_key_exists('address', $billing) == false) {
			return null;
		}

		$address = $billing['address'];
		if (array_key_exists('country', $address) == false || is_null($address['country'])) {
			return null;
		}

		if (array_key_exists('state', $address) == false || is_null($address['state'])) {
			return $address['country'];
		} else {
			return $address['country'] . ' ' . $address['state'];
		}
	}

	public function UpdateCustomer(string $customerId, array $fields): bool {
		$customer = $this->PostURL('https://api.stripe.com/v1/customers/' . $customerId, $fields);
		return (is_null($customer) === false);
	}

	public function CreateCustomer(string $email): string {
		$fields = [
			'email' => $email
		];

		$response = $this->PostURL('https://api.stripe.com/v1/customers', $fields);
		return $response['id'];
	}

	public function EmailForPaymentIntent(string|array $intentId): ?string {
		if (is_array($intentId)) {
			$intent = $intentId;
			$intentId = $intent['id'];
		}

		$cache_key = 'email_' . $intentId;
		$email = BeaconCache::Get($cache_key);
		if (!is_null($email)) {
			return $email;
		}

		$piJson = $this->GetPaymentIntent($intentId);
		if (is_null($piJson)) {
			return null;
		}
		if (array_key_exists('customer', $piJson) == false || empty($piJson['customer'])) {
			return null;
		}

		$customerId = $piJson['customer'];
		$customerJson = $this->GetCustomer($customerId);
		if (is_null($customerJson)) {
			return null;
		}

		$email = $customerJson['email'];
		BeaconCache::Set($cache_key, $email, 3600);
		return $email;
	}

	public function ChangeEmailForPaymentIntent(string $intentId, string $newEmail): bool {
		$cache_key = 'email_' . $intentId;

		$piJson = $this->GetPaymentIntent($intentId);
		if (is_null($piJson)) {
			return false;
		}

		if (array_key_exists('customer', $piJson) == false || empty($piJson['customer'])) {
			return false;
		}

		$customerId = $piJson['customer'];
		$customerJson = $this->GetCustomer($customerId);
		if (is_null($customerJson)) {
			return false;
		}

		if (strtolower($customerJson['email']) == strtolower($newEmail)) {
			return true;
		}

		if (!$this->UpdateCustomer($customerId, ['email' => $newEmail])) {
			return false;
		}

		BeaconCache::Set($cache_key, $newEmail, 3600);
		return true;
	}

	public function CreateCheckoutSession(array $details): ?array {
		return $this->PostURL('https://api.stripe.com/v1/checkout/sessions', $details);
	}

	public function GetCheckoutSession(string $sessionId): ?array {
		return $this->GetURL("https://api.stripe.com/v1/checkout/sessions/{$sessionId}");
	}

	public function CreateCustomerSession(array $details): ?array {
		return $this->PostUrl('https://api.stripe.com/v1/customer_sessions', $details);
	}

	public function GetCountrySpec(string $countryCode): ?array {
		return $this->GetURL('https://api.stripe.com/v1/country_specs/' . $countryCode, false);
	}

	public function UpdatedProductPrice(string $priceId, int $amount): string|bool {
		$response = $this->GetURL('https://api.stripe.com/v1/prices/' . $priceId);
		if (is_null($response)) {
			return false;
		}

		$newPriceId = null;
		$productId = $response['product'];
		$currency = $response['currency'];
		$old_amount = $response['unit_amount'];
		if ($old_amount === $amount) {
			return $priceId;
		}

		// See if there is already an archived price
		$response = $this->GetURL('https://api.stripe.com/v1/prices/search?query=' . urlencode("product:'$productId' AND currency:'$currency'"));
		if (is_null($response)) {
			return false;
		}
		$results = $response['data'];
		foreach ($results as $price) {
			if ($price['unit_amount'] != $amount) {
				continue;
			}

			$newPriceId = $price['id'];
			if ($price['active'] == false) {
				// Need to reactivate the price
				$response = $this->PostURL('https://api.stripe.com/v1/prices/' . $newPriceId, ['active' => 'true']);
				if (is_null($response)) {
					return false;
				}
			}

			break;
		}

		if (is_null($newPriceId)) {
			$response = $this->PostURL('https://api.stripe.com/v1/prices', [
				'unit_amount' => $amount,
				'currency' => $currency,
				'product' => $productId,
				'tax_behavior' => 'exclusive'
			]);

			if (is_null($response)) {
				return false;
			}

			$newPriceId = $response['id'];
		}

		// Deactivate the old price
		$response = $this->PostURL('https://api.stripe.com/v1/prices/' . $priceId, ['active' => 'false']);

		return $newPriceId;
	}

	public function CreatePrice(string $product_code, string $currency, int $amount): string|bool {
		$response = $this->PostURL('https://api.stripe.com/v1/prices', [
			'unit_amount' => $amount,
			'currency' => $currency,
			'product' => $product_code,
			'tax_behavior' => 'exclusive'
		]);

		if (is_null($response)) {
			return false;
		}

		return $response['id'];
	}

	public function EditPrice(string $price_id, array $changes): ?array {
		return $this->PostURL('https://api.stripe.com/v1/prices/' . $price_id, $changes);
	}

	public function EditProduct(string $product_code, array $changes): ?array {
		return $this->PostURL('https://api.stripe.com/v1/products/' . $product_code, $changes);
	}

	public function GetValueLists(string|array|null $containing = null): ?array {
		$lists = $this->GetURL('https://api.stripe.com/v1/radar/value_lists?limit=100');
		if (is_null($lists)) {
			return null;
		}

		if (is_null($containing)) {
			return $lists;
		} elseif (is_string($containing)) {
			$containing = [$containing];
		}
		$containing = array_map('strtolower', $containing);
		$filtered = [];
		foreach ($lists['data'] as $list) {
			$items = $list['list_items']['data'];
			foreach ($items as $item) {
				$value = strtolower($item['value']);
				if (in_array($value, $containing)) {
					$filtered[] = $list;
					break;
				}
			}
		}
		return $filtered;
	}

	public function GetFailuresByCustomer(string $customerId): ?array {
		$charges = $this->GetURL('https://api.stripe.com/v1/charges/search?query=' . urlencode("customer:'{$customerId}' AND status:'failed'"));
		if (is_null($charges)) {
			return null;
		}
		return $charges['data'];
	}

	public function GetBillingPortalUrl(string $customerId, string $returnUrl): ?string {
		$response = $this->PostURL('https://api.stripe.com/v1/billing_portal/sessions', [
			'customer' => $customerId,
			'return_url' => $returnUrl,
		]);

		if (is_null($response)) {
			return false;
		}

		return $response['url'];
	}

	public function GetCharge(string $chargeId): ?array {
		return $this->GetUrl("https://api.stripe.com/v1/charges/{$chargeId}");
	}
}

?>
