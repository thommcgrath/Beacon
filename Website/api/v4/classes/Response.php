<?php

namespace BeaconAPI\v4;

class Response {
	protected $headers = [];
	protected $body = '';
	protected $code = 500;
	
	public function __construct(int $code, string $body = '', array $headers = []) {
		$this->headers = $headers;
		$this->body = $body;
		$this->code = $code;
	}
	
	public static function NewJson(mixed $obj, int $code): Response {
		return new static($code, json_encode($obj, JSON_PRETTY_PRINT), ['Content-Type' => 'application/json']);
	}
	
	public static function NewJsonError(string $message, mixed $details, int $code): Response {
		return Response::NewJson([
			'message' => $message,
			'details' => $details
		], $code);
	}
	
	public static function NewNoContent(): Response {
		return new static(204);
	}
	
	public static function NewRedirect(string $destination, bool $temporary = true): Response {
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
