<?php

class BeaconQueryException extends Exception {
	protected $sql;
	
	public function __construct(string $message, string $sql, int $code = 0, \Throwable $previous = null) {
		parent::__construct($message, $code, $previous);
		$this->sql = $sql;
	}
	
	public function getSQL() {
		return $this->sql;
	}
}

?>