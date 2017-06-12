<?php

class BeaconPostgreSQLDatabase extends BeaconDatabase {
	protected $transactions = array();
	
	public function Connect() {
		if ($this->IsConnected()) {
			return;
		}
		$this->connection = null;
		
		$pieces = array();
		$is_ip = ip2long($this->host);
		if ($is_ip) {
			$pieces['hostaddr'] = $this->host;
		} else {
			$pieces['host'] = $this->host;
		}
		$pieces['port'] = $this->port;
		$pieces['dbname'] = $this->databasename;
		$pieces['user'] = $this->username;
		$pieces['password'] = $this->password;
		if (($this->host != '127.0.0.1') && ($this->host != 'localhost') && ($this->host != '')) {
			$pieces['sslmode'] = 'require';
		}
		$pieces['options'] = '--client_encoding=UTF8 --application_name=Website';
		
		$options = array();
		foreach ($pieces as $key => $value) {
			$options[] = $key . "='" . str_replace(array("'", "\\"), array("\\'", "\\\\"), $value) . "'";
		}
		
		$connection = pg_connect(implode(' ', $options));
		if ($connection === false) {
			throw new Exception('Unable to connect to database');
		} else {
			$this->connection = $connection;
		}	
	}
	
	public function Reconnect () {
		$success = @pg_connection_reset($this->connection);
		if ($success === false) {
			throw new Exception('Unable to reconnect to database');
		}
	}
	
	public function IsConnected() {
		if ($this->connection == null) {
			return false;
		} else {
			return pg_connection_status($this->connection) == PGSQL_CONNECTION_OK;
		}
	}
	
	public function Close() {
		if ($this->connection != null) {
			if ($this->IsConnected()) {
				pg_close($this->connection);
			}
			$this->connection = null;
			$this->transactions = array();
		}
	}
	
	public function BeginTransaction() {
		$this->Connect();
		if (count($this->transactions) == 0) {
			$this->Query('BEGIN TRANSACTION');
			$this->transactions[] = '';
		} else {
			$savepoint = 'savepoint_' . BeaconCommon::GenerateRandomKey(8);
			array_unshift($this->transactions, $savepoint);
			$this->Query('SAVEPOINT ' . $this->EscapeIdentifier($savepoint));
		}
	}
	
	public function InTransaction() {
		return count($this->transactions) > 0;
	}
	
	public function Commit() {
		$this->Connect();
		if (count($this->transactions) > 0) {
			$savepoint = array_shift($this->transactions);
			if ($savepoint == '') {
				$this->Query('COMMIT TRANSACTION');
			} else {
				$this->Query('RELEASE SAVEPOINT ' . $this->EscapeIdentifier($savepoint));
			}
		}
	}
	
	public function Rollback() {
		$this->Connect();
		if (count($this->transactions) > 0) {
			$savepoint = array_shift($this->transactions);
			if ($savepoint == '') {
				$this->Query('ROLLBACK TRANSACTION');
			} else {
				$this->Query('ROLLBACK TO SAVEPOINT ' . $this->EscapeIdentifier($savepoint));
				$this->Query('RELEASE SAVEPOINT ' . $this->EscapeIdentifier($savepoint));
			}
		}
	}
	
	private function ResetTransactions() {
		$this->transactions = array();
		$state = pg_transaction_status($this->connection);
		if ($state === PGSQL_TRANSACTION_ACTIVE) {
			pg_query($this->connection, 'ROLLBACK TRANSACTION');
		}
	}
	
	public function Query(string $sql, ...$params) {
		$this->Connect(); // Will only actually connect if necessary
		if (!is_array($params)) {
			$params = array();
		}
		
		// for backwards compatibility, if $params contains a single array element,
		// it is being called with the legacy signature of ($sql, array($param1, $param2, ...))
		if ((count($params) == 1) && (is_array($params[0]))) {
			$params = $params[0];
		}
		
		for ($i = 0; $i < count($params); $i++) {
			if (is_bool($params[$i])) {
				$params[$i] = $params[$i] ? 't' : 'f';
			}
		}
		
		if (count($params) > 0) {
			$success = pg_send_query_params($this->connection, $sql, $params);
		} else {
			$success = pg_send_query($this->connection, $sql);
		}
		if ($success === true) {
			while (pg_connection_busy($this->connection)) {
				usleep(250);
			}
			$result = pg_get_result($this->connection);
			$state = pg_result_error($result);
			if (is_string($state)) {
				if ($state === '') {
					return new BeaconPostgreSQLRecordSet($result);
				} else {
					$this->ResetTransactions();
					throw new BeaconQueryException($state, $sql);
				}
			}
		}
		$error = pg_last_error();
		$this->ResetTransactions();
		throw new BeaconQueryException($error, $sql);
	}
	
	public function Insert(string $table, array $data) {
		$i = 1;
		$columns = array();
		$values = array_values($data);
		$placeholders = array();
		foreach ($data as $column => $value) {
			$columns[] = $this->EscapeIdentifier($column);
			$placeholders[] = '$' . $i;
			$i++;
		}
		$sql = 'INSERT INTO ' . $this->EscapeIdentifier($table) . '(' . implode(', ', $columns) . ') VALUES (' . implode(', ', $placeholders) . ');';
		$this->BeginTransaction();
		$this->Query($sql, $values);
		$this->Commit();
	}
	
	public function Update(string $table, array $data, array $conditions) {
		$i = 1;
		$set_columns = array();
		$select_columns = array();
		$values = array_merge(array_values($data), array_values($conditions));
		foreach ($data as $column => $value) {
			$set_columns[] = $this->EscapeIdentifier($column) . ' = $' . $i;
			$i++;
		}
		foreach ($conditions as $column => $value) {
			$select_columns[] = $this->EscapeIdentifier($column) . ' = $' . $i;
			$i++;
		}
		$sql = 'UPDATE ' . $this->EscapeIdentifier($table) . ' SET ' . implode(', ', $set_columns) . ' WHERE ' . implode(' AND ', $select_columns);
		$this->BeginTransaction();
		$this->Query($sql, $values);
		$this->Commit();
	}
	
	public function Host() {
		if ($this->IsConnected()) {
			return pg_host($this->connection);
		} else {
			return $this->host;
		}
	}
	
	public function EscapeIdentifier(string $identifier) {
		$this->Connect();
		return pg_escape_identifier($this->connection, $identifier);
	}
	
	public function EscapeLiteral(string $literal) {
		$this->Connect();
		return pg_escape_literal($this->connection, $literal);
	}
	
	public function EscapeBinary(string $binary) {
		$this->Connect();
		return pg_escape_bytea($this->connection, $binary);
	}
	
	public function UnescapeBinary(string $string) {
		return pg_unescape_bytea($string);
	}
}

?>