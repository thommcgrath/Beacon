<?php

class BeaconPostgreSQLDatabase extends BeaconDatabase {
	protected $transactions = [];
	
	public function Connect() {
		if ($this->IsConnected()) {
			return;
		}
		$this->SetConnection(null);
		$settings = $this->Settings();
		
		$pieces = [];
		$is_ip = ip2long($settings->Host());
		if ($is_ip) {
			$pieces['hostaddr'] = $settings->Host();
		} else {
			$pieces['host'] = $settings->Host();
		}
		$pieces['port'] = $settings->Port();
		$pieces['dbname'] = $settings->DatabaseName();
		$pieces['user'] = $settings->Username();
		$pieces['password'] = $settings->Password();
		if (($settings->Host() != '127.0.0.1') && ($settings->Host() != 'localhost') && ($settings->Host() != '')) {
			$pieces['sslmode'] = 'require';
		}
		$pieces['options'] = '--client_encoding=UTF8 --application_name=Website';
		
		$options = [];
		foreach ($pieces as $key => $value) {
			$options[] = $key . "='" . str_replace(["'", "\\"], ["\\'", "\\\\"], $value) . "'";
		}
		
		$connection = pg_connect(implode(' ', $options));
		if ($connection === false) {
			throw new Exception('Unable to connect to database');
		} else {
			$this->SetConnection($connection);
		}	
	}
	
	public function Reconnect () {
		$success = @pg_connection_reset($this->Connection());
		if ($success === false) {
			throw new Exception('Unable to reconnect to database');
		}
	}
	
	public function IsConnected() {
		if (is_null($this->Connection())) {
			return false;
		} else {
			return pg_connection_status($this->Connection()) == PGSQL_CONNECTION_OK;
		}
	}
	
	public function Close() {
		if (is_null($this->Connection()) === false) {
			if ($this->IsConnected()) {
				pg_close($this->Connection());
			}
			$this->SetConnection(null);
			$this->transactions = [];
		}
	}
	
	public function BeginTransaction() {
		$this->SetConnectionMode(static::CONNECTION_WRITABLE);
		
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
		$this->transactions = [];
		$state = pg_transaction_status($this->Connection());
		if ($state === PGSQL_TRANSACTION_ACTIVE) {
			pg_query($this->Connection(), 'ROLLBACK TRANSACTION');
		}
	}
	
	public function Query(string $sql, ...$params) {
		$this->Connect(); // Will only actually connect if necessary
		if (!is_array($params)) {
			$params = [];
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
			$success = pg_send_query_params($this->Connection(), $sql, $params);
		} else {
			$success = pg_send_query($this->Connection(), $sql);
		}
		if ($success === true) {
			while (pg_connection_busy($this->Connection())) {
				usleep(250);
			}
			$result = pg_get_result($this->Connection());
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
	
	public function ExamineQuery(string $sql, ...$params) {
		if (!is_array($params)) {
			$params = [];
		}
		
		if ((count($params) == 1) && (is_array($params[0]))) {
			$params = $params[0];
		}
		
		for ($i = 0; $i < count($params); $i++) {
			if (is_bool($params[$i])) {
				$params[$i] = $params[$i] ? 't' : 'f';
			}
			
			$sql = str_replace('$' . ($i + 1), $this->EscapeLiteral($params[$i]), $sql);
		}
		
		return $sql;
	}
	
	public function Insert(string $table, array $data) {
		$i = 1;
		$columns = [];
		$values = array_values($data);
		$placeholders = [];
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
		$set_columns = [];
		$select_columns = [];
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
	
	public function Upsert(string $table, array $data, array $conflict_columns) {
		$i = 1;
		$columns = [];
		$values = array_values($data);
		$placeholders = [];
		$conflicts = [];
		$assignments = [];
		$clauses = [];
		$table_escaped = $this->EscapeIdentifier($table);
		foreach ($conflict_columns as $column) {
			$conflicts[] = $this->EscapeIdentifier($column);
		}
		foreach ($data as $column => $value) {
			$column_escaped = $this->EscapeIdentifier($column);
			$placeholder = '$' . $i;
			$i++;
			
			$columns[] = $column_escaped;
			$placeholders[] = $placeholder;			
			if (in_array($column, $conflict_columns) === false) {
				$assignments[] = $column_escaped . ' = ' . $placeholder;
				$clauses[] = $table_escaped . '.' . $column_escaped . ' IS DISTINCT FROM ' . $placeholder;
			}
		}
		$sql = 'INSERT INTO ' . $table_escaped . ' (' . implode(', ', $columns) . ') VALUES (' . implode(', ', $placeholders) . ') ON CONFLICT (' . implode(', ', $conflicts) . ') DO UPDATE SET ' . implode(', ', $assignments) . ' WHERE ' . implode(' OR ', $clauses) . ' RETURNING *;';
		$this->BeginTransaction();
		$inserted = $this->Query($sql, $values);
		if ($inserted->RecordCount() === 0) {
			// No changes were made, need to look up the original record
			$clauses = [];
			$values = [];
			$i = 1;
			foreach ($conflict_columns as $column) {
				$values[] = $data[$column];
				$clauses[] = $this->EscapeIdentifier($column) . ' = $' . $i;
				$i++;
			}
			$inserted = $this->Query('SELECT * FROM ' . $table_escaped . ' WHERE ' . implode(' AND ', $clauses) . ' LIMIT 1;', $values);
		}
		$this->Commit();
		
		return $inserted;
	}
	
	public function Host() {
		if ($this->IsConnected()) {
			return pg_host($this->Connection());
		} else {
			return $this->Settings()->Host();
		}
	}
	
	public function EscapeIdentifier(string $identifier) {
		$this->Connect();
		$pieces = explode('.', $identifier);
		for ($idx = 0; $idx < count($pieces); $idx++) {
			$pieces[$idx] = pg_escape_identifier($this->Connection(), $pieces[$idx]);
		}
		return implode('.', $pieces);
	}
	
	public function EscapeLiteral(string $literal) {
		$this->Connect();
		return pg_escape_literal($this->Connection(), $literal);
	}
	
	public function EscapeBinary(string $binary) {
		$this->Connect();
		return pg_escape_bytea($this->Connection(), $binary);
	}
	
	public function UnescapeBinary(string $string) {
		return pg_unescape_bytea($string);
	}
}

?>
