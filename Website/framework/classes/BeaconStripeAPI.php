<?php

class BeaconStripeAPI {
	private $apiSecret = '';
	private $stripeVersion = '';
	
	public function __construct(string $apiSecret, string $stripeVersion = '2020-08-27') {
		$this->apiSecret = $apiSecret;
		$this->stripeVersion = $stripeVersion;
	}
	
	protected function GetURL(string $url): ?array {
		$json = BeaconCache::Get($url);
		if (is_null($json) === false) {
			return $json;
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
		
		BeaconCache::Set($url, $json, 300);
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
	
	public function GetLineItems(string $sessionId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/checkout/sessions/' . $sessionId . '/line_items?expand%5B%5D=data.discounts&expand%5B%5D=data.taxes');
	}
	
	public function GetCustomer(string $customerId): ?array {
		return $this->GetURL('https://api.stripe.com/v1/customers/' . $customerId);
	}
	
	public function GetCustomersByEmail(string $customerEmail): ?array {
		return $this->GetURL('https://api.stripe.com/v1/customers/search?query=' . urlencode("email:'$customerEmail'"));
	}
	
	public function GetBillingLocality(string $intentId): ?string {
		$intent = $this->GetPaymentIntent($intentId);
		if (is_null($intent)) {
			return null;
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
	
	public function EmailForPaymentIntent(string $intentId): ?string {
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
	
	public function GetCountrySpec(string $countryCode): ?array {
		return $this->GetURL('https://api.stripe.com/v1/country_specs/' . $countryCode);
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
}

?>