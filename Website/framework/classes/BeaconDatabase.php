<?php

abstract class BeaconDatabase {
	protected $host;
	protected $port;
	protected $databasename;
	protected $username;
	protected $password;
	protected $connection;
	
	abstract public function Connect();
	abstract public function IsConnected();
	abstract public function Close();
	abstract public function BeginTransaction();
	abstract public function InTransaction();
	abstract public function Commit();
	abstract public function Rollback();
	abstract public function Query(string $sql, ...$params);
	abstract public function Insert(string $table, array $dict);
	abstract public function Update (string $table, array $data, array $conditions);
	abstract public function Upsert(string $table, array $data, array $conflict_columns);
	abstract public function Host();
	abstract public function EscapeIdentifier(string $identifier);
	abstract public function EscapeLiteral(string $literal);
	abstract public function EscapeBinary(string $binary);
	abstract public function UnescapeBinary(string $string);
	
	public function __construct(string $host, int $port, string $databasename, string $username, string $password) {
		$this->host = $host;
		$this->port = $port;
		$this->databasename = $databasename;
		$this->username = $username;
		$this->password = $password;
	}
}

?>