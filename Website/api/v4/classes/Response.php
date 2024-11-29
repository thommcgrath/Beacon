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

	public static function NewJson(mixed $obj, int $code): static {
		return new static($code, json_encode($obj, JSON_PRETTY_PRINT), ['Content-Type' => 'application/json']);
	}

	public static function NewJsonError(string $message, mixed $details = null, int $httpStatus = 500, ?string $code = null): static {
		$error = [
			'type' => 'beacon.error',
		];
		if (is_null($code) === false) {
			$error['code'] = $code;
		}
		$error['message'] = $message;
		$error['details'] = $details;
		return static::NewJson($error, $httpStatus);
	}

	public static function NewNoContent(): static {
		return new static(204);
	}

	public static function NewRedirect(string $destination, bool $temporary = true): static {
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
		header('Cache-Control: no-store');
		echo $this->Body();
	}
}

?>
