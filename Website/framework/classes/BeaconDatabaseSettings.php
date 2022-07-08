<?php

class BeaconDatabaseSettings {
	private string $host;
	private string $port;
	private string $databasename;
	private string $username;
	private string $password;
	
	public function __construct(string $host, int $port, string $databasename, string $username, string $password) {
		$this->host = $host;
		$this->port = $port;
		$this->databasename = $databasename;
		$this->username = $username;
		$this->password = $password;
	}
	
	public function Host(): string {
		return $this->host;
	}
	
	public function Port(): string {
		return $this->port;
	}
	
	public function DatabaseName(): string {
		return $this->databasename;
	}
	
	public function Username(): string {
		return $this->username;
	}
	
	public function Password(): string {
		return $this->password;
	}
}

?>
