<?php

abstract class BeaconDatabase {
	const CONNECTION_READONLY = 'readonly';
	const CONNECTION_WRITABLE = 'writable';
	const CONNECTION_VALID_MODES = [self::CONNECTION_READONLY, self::CONNECTION_WRITABLE];
	
	private string $mode = self::CONNECTION_WRITABLE;
	private mixed $connection = null;
	
	private array $settings = [];
	private array $connections = [];
	
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
	
	public function __construct(string $default_mode, \BeaconDatabaseSettings $write_settings, ?\BeaconDatabaseSettings $read_settings) {
		if (in_array($default_mode, self::CONNECTION_VALID_MODES) === false) {
			throw new \Exception('Default mode is not a valid connection mode.');
		}
		if (is_null($write_settings)) {
			throw new \Exception('Write settings must not be null.');
		}
		
		$this->settings = [
			self::CONNECTION_WRITABLE => $write_settings
		];
		$this->connections = [
			self::CONNECTION_WRITABLE => null
		];
		
		if (is_null($read_settings) === false) {
			$this->settings[self::CONNECTION_READONLY] = $read_settings;
			$this->connections[self::CONNECTION_READONLY] = null;
		} else {
			$default_mode = self::CONNECTION_WRITABLE;
		}
		
		$this->mode = $default_mode;
	}
	
	public static function Create(string $host, int $port, string $databasename, string $username, string $password) {
		return new static(self::CONNECTION_WRITABLE, new \BeaconDatabaseSettings($host, $post, $databasename, $username, $password));
	}
	
	public function ConnectionMode(): string {
		return $this->mode;
	}
	
	public function SetConnectionMode(string $mode): bool {
		if (array_key_exists($mode, $this->settings) === false || $this->InTransaction()) {
			return false;
		}
			
		$this->mode = $mode;
		$this->connection = $this->connections[$mode];
		return true;
	}
	
	public function Settings(): ?BeaconDatabaseSettings {
		// if we have settings for the current mode, return then
		return $this->settings[$this->mode];
	}
	
	protected function Connection(): mixed {
		return $this->connections[$this->mode];
	}
	
	protected function SetConnection(mixed $connection): bool {
		if ($this->InTransaction()) {
			return false;
		}
		
		$this->connections[$this->mode] = $connection;
		return true;
	}
	
	public function DatabaseName(): string {
		return $this->Settings()->DatabaseName();
	}
}

?>
