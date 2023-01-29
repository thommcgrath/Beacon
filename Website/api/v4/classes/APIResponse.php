<?php

namespace BeaconAPI\v4;

class APIResponse {
	protected $headers = [];
	protected $body = '';
	protected $code = 500;
	
	public function __construct(int $code, string $body = '', array $headers = []) {
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
		return new static(204);
	}
	
	public static function NewRedirect(string $destination, bool $temporary = true): APIResponse {
		return new static(($temporary ? 302 : 301), "Redirect to {$destination}", ['Location' => $destination]);
	}
	
	public function Body(): string {
		return $this->body;
	}
	
	public function Code(): int {
		return $this->code;
	}
	
	public function HeaderKeys(): array {
		return array_keys($this->headers);
	}
	
	public function Header(string $key): string {
		return $this->headers[$key];
	}
	
	public function Flush(): void {
		http_response_code($this->Code());
		foreach ($this->headers as $header => $value) {
			header("{$header}: {$value}");
		}
		echo $this->Body();
	}
}

?>
