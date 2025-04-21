<?php

namespace BeaconAPI\v4;
use Exception;

class APIException extends Exception {
	protected string $beaconErrorCode;
	protected int $httpStatus;

	public function __construct(string $message, string $code, int $httpStatus = 400) {
		parent::__construct($message);
		$this->beaconErrorCode = $code;
		$this->httpStatus = $httpStatus;
	}

	public function getBeaconErrorCode(): string {
		return $this->beaconErrorCode;
	}

	public function getHttpStatus(): int {
		return $this->httpStatus;
	}
}

?>
