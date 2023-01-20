<?php

namespace BeaconAPI\v4;

class APIResponseBatch extends APIResponse {
	protected $responses = [];
	protected $key_property = '';
	
	public function __construct(string $key_property) {
		$this->key_property = $key_property;
		$this->headers['Content-Type'] = 'application/json';
	}
	
	public function AddResponse(string $key_property_value, APIResponse $response): void {
		$this->responses[$key_property_value] = $response;	
	}
	
	public function Body(): string {
		$pieces	= [];
		
		foreach ($this->responses as $key_property_value => $response) {
			$headers = [];
			$keys = $response->HeaderKeys();
			$is_json = false;
			foreach ($keys as $key) {
				$value = $response->Header($key);
				$headers[$key] = $value;
				if ($key === 'Content-Type' && ($value === 'application/json' || str_starts_with($value, 'application/json;'))) {
					$is_json = true;
				}
			}
			
			$body = $response->Body();
			if ($is_json) {
				$body = json_decode($body, true);
			}
			
			$pieces[] = [
				$this->key_property => $key_property_value,
				'headers' => $headers,
				'status' => $response->Code(),
				'body' => $body
			];
		}
		
		return json_encode($pieces, JSON_PRETTY_PRINT);
	}
	
	public function Code(): int {
		$num_responses = count($this->responses);
		$statuses = [];
		$num_server_error = 0;
		$num_client_error = 0;
		$num_success = 0;
		foreach ($this->responses as $key_property_value => $response) {
			$status = $response->Code();
			if ($status >= 500) {
				$num_server_error++;
			} else if ($status >= 400) {
				$num_client_error++;
			} else {
				$num_success++;
			}
			
			$statuses[$status] = true;
		}
		
		if (count($statuses) === 1) {
			$status = array_keys($statuses)[0];
			if ($status === 204) {
				$status = 200;
			}
			return $status;
		}
		
		if ($num_success > 0) {
			if ($num_client_error > 0 || $num_server_error > 0) {
				return 207;
			} else {
				return 200;
			}
		} else if ($num_server_error > 0) {
			return 500;
		} else if ($num_client_error > 0) {
			return 400;
		} else {
			// They're all zero?
			return 200;
		}
	}
}

?>
