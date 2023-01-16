<?php

namespace BeaconAPI\v4;

class APIResponse {
	protected $headers = [];
	protected $body = null;
	protected $code = null;
	
	public function __construct(int $code, ?string $body, array $headers = []) {
		$this->headers = $headers;
		$this->body = $body;
		$this->code = $code;
	}
	
	public static function NewJSON(mixed $obj, int $code): APIResponse {
		return new static($code, json_encode($obj, JSON_PRETTY_PRINT), ['Content-Type' => 'application/json']);
	}
	
	public static function NewJSONError(string $message, mixed $details, int $code): APIResponse {
		return APIResponse::NewJSON([
			'message' => $message,
			'details' => $details
		], $code);
	}
	
	public static function NewNoContent(): APIResponse {
		return new static(204, null);
	}
	
	public function Flush(): void {
		http_response_code($this->code);
		foreach ($this->headers as $header => $value) {
			header("{$header}: {$value}");
		}
		if (empty($this->body) === false) {
			echo $this->body;
		}
	}
}

?>
