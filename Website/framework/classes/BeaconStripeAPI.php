<?php

class BeaconStripeAPI {
	private $api_secret = '';
	
	public function __construct(string $api_secret) {
		$this->api_secret = $api_secret;
	}
	
	public function GetPaymentIntent(string $intent_id) {
		$curl = curl_init('https://api.stripe.com/v1/payment_intents/' . $intent_id);
		$headers = array('Authorization: Bearer ' . $this->api_secret);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$pi_body = curl_exec($curl);
		$pi_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($pi_status != 200) {
			return null;
		}
		$pi_json = json_decode($pi_body, true);
		if (is_null($pi_json)) {
			return null;
		}
		
		return $pi_json;
	}
	
	public function GetPaymentSource(string $source_id) {
		$curl = curl_init('https://api.stripe.com/v1/sources/' . $source_id);
		$headers = array('Authorization: Bearer ' . $this->api_secret);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$source_body = curl_exec($curl);
		$source_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($source_status != 200) {
			return null;
		}
		$source_json = json_decode($source_body, true);
		if (is_null($source_json)) {
			return null;
		}
		
		return $source_json;
	}	
	
	public function EmailForPaymentIntent(string $intent_id) {
		$pi_json = $this->GetPaymentIntent($intent_id);
		if (is_null($pi_json)) {
			return null;
		}
		$source_json = $this->GetPaymentSource($pi_json['source']);
		if (is_null($source_json)) {
			return null;
		}
		
		$owner = $source_json['owner'];
		return $owner['email'];
	}
}

?>