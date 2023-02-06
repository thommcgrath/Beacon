<?php

namespace BeaconAPI\v4;

class BatchResponse extends Response {
	protected $responses = [];
	protected $keyProperty = '';
	
	public function __construct(string $keyProperty) {
		$this->keyProperty = $keyProperty;
		$this->headers['Content-Type'] = 'application/json';
	}
	
	public function AddResponse(string $keyPropertyValue, Response $response): void {
		$this->responses[$keyPropertyValue] = $response;	
	}
	
	public function Body(): string {
		$pieces	= [];
		
		foreach ($this->responses as $keyPropertyValue => $response) {
			$headers = [];
			$keys = $response->HeaderKeys();
			$isJson = false;
			foreach ($keys as $key) {
				$value = $response->Header($key);
				$headers[$key] = $value;
				if ($key === 'Content-Type' && ($value === 'application/json' || str_starts_with($value, 'application/json;'))) {
					$isJson = true;
				}
			}
			
			$body = $response->Body();
			if ($isJson) {
				$body = json_decode($body, true);
			}
			
			$pieces[] = [
				$this->keyProperty => $keyPropertyValue,
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
		foreach ($this->responses as $keyPropertyValue => $response) {
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
