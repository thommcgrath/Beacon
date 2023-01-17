<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet;

class Authenticator extends DatabaseObject implements \JsonSerializable {
	const TYPE_TOTP = 'TOTP';
	
	protected $authenticator_id;
	protected $user_id;
	protected $type;
	protected $nickname;
	protected $date_added;
	protected $metadata;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->authenticator_id = $row->Field('authenticator_id');
		$this->user_id = $row->Field('user_id');
		$this->type = $row->Field('type');
		$this->nickname = $row->Field('nickname');
		$this->date_added = intval($row->Field('date_added'));
		$this->metadata = json_decode($row->Field('metadata'), true);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'user_authenticators', [
			new DatabaseObjectProperty('authenticator_id', ['primaryKey' => true]),
			new DatabaseObjectProperty('user_id'),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('nickname', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('date_added', ['accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.date_added)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('metadata')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		
		if (isset($filters['user_id']) === false) {
			throw new Exception('Must include user_id filter');
		}
		
		$parameters->AddFromFilter($schema, $filters, 'user_id');
		$parameters->AddFromFilter($schema, $filters, 'type');
	}
	
	public static function SQLSchemaName(): string {
		return 'public';
	}
	
	public static function SQLTableName(): string {
		return 'user_authenticators';
	}
	
	public static function SQLPrimaryKey(): string {
		return 'authenticator_id';
	}
	
	public static function SQLColumns(): array {
		$table = static::SQLTableName();
		return [
			"$table.authenticator_id",
			"$table.user_id",
			"$table.type",
			"$table.nickname",
			"EXTRACT(EPOCH FROM $table.date_added) AS date_added",
			"$table.metadata"
		];
	}
	
	/*public static function Create(string $authenticator_id, string $user_id, string $type, string $nickname, array $metadata): Authenticator {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (authenticator_id, user_id, type, nickname, date_added, metadata) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, $5);', $authenticator_id, $user_id, $type, $nickname, json_encode($metadata));
		$database->Commit();
		return static::GetByAuthenticatorID($authenticator_id);
	}*/
	
	public static function GetForUser(User $user, ?string $type = null): array {
		return static::GetForUserID($user->UserID(), $type);
	}
	
	public static function GetForUserID(string $user_id, ?string $type = null): array {
		$table = static::SQLTableName();
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE ' . $table . '.user_id = $1';
		$values = [$user_id];
		if (is_null($type) === false) {
			$sql .= ' AND ' . $table . '.type = $2';
			$values[] = $type;
		}
		$sql .= ' ORDER BY ' . $table . '.date_added DESC;';
		$database = BeaconCommon::Database();
		$rows = $database->Query($sql, $values);
		$authenticators = [];
		while (!$rows->EOF()) {
			$authenticators[] = new static($rows);
			$rows->MoveNext();
		}
		return $authenticators;
	}
	
	public static function UserHasAuthenticators(User $user, ?string $type = null): bool {
		return static::UserIDHasAuthenticators($user->UserID(), $type);
	}
	
	public static function UserIDHasAuthenticators(string $user_id, ?string $type = null): bool {
		$table = static::SQLTableName();
		$sql = 'SELECT COUNT(' . $table . '.authenticator_id) AS num_authenticators FROM ' . static::SQLLongTableName() . ' WHERE ' . $table . '.user_id = $1';
		$values = [$user_id];
		if (is_null($type) === false) {
			$sql .= ' AND ' . $table . '.type = $2';
			$values[] = $type;
		}
		$database = BeaconCommon::Database();
		$rows = $database->Query($sql, $values);
		return $rows->Field('num_authenticators') > 0;
	}
	
	public static function GetByAuthenticatorID(string $authenticator_id): ?Authenticator {
		$database = BeaconCommon::Database();
		$table = static::SQLTableName();
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE ' . $table . '.authenticator_id = $1;';
		$rows = $database->Query($sql, $authenticator_id);
		if ($rows->RecordCount() === 1) {
			return new static($rows);
		}
	}
	
	public function AuthenticatorID(): string {
		return $this->authenticator_id;
	}
	
	public function UserID(): string {
		return $this->user_id;
	}
	
	public function Type(): string {
		return $this->type;
	}
	
	public function Nickname(): string {
		return $this->nickname;
	}
	
	public function SetNickname(string $nickname): void {
		$this->SetProperty('nickname', $nickname);
	}
	
	public function DateAdded(): int {
		return $this->date_added;
	}
	
	public function Metadata(): array {
		return $this->metadata;
	}
	
	public function TestCode(string $code): bool {
		switch ($this->type) {
		case self::TYPE_TOTP:
			if (strlen($code) !== 6) {
				return false;
			}
			
			$secret = $this->metadata['secret'];
			$decoded = BeaconCommon::Base32Decode($secret);
			$now = time();
			$future = $now + 30;
			$past = $now - 30;
			return ($code === static::GenerateTOTP($now, $decoded) || $code === static::GenerateTOTP($past, $decoded) || $code === static::GenerateTOTP($future, $decoded));
		}
		
		return false;
	}
	
	protected static function GenerateTOTP(int $timestamp, string $decoded_secret): string {
		$timestamp = floor($timestamp / 30);
		$binary = pack('N*', 0) . pack('N*', $timestamp);
		$hash = hash_hmac('sha1', $binary, $decoded_secret, true);
		$offset = ord($hash[19]) & 0xf;
		$code = (((ord($hash[$offset]) & 0x7f) << 24) | ((ord($hash[$offset + 1]) & 0xff) << 16) | ((ord($hash[$offset + 2]) & 0xff) << 8) | (ord($hash[$offset + 3]) & 0xff)) % pow(10, 6);
		return str_pad($code, 6, '0', STR_PAD_LEFT);
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::SQLLongTableName() . ' WHERE ' . static::SQLTableName() . '.authenticator_id = $1;', $this->authenticator_id);
		$database->Commit();
	}
	
	public function jsonSerialize(): mixed {
		// We don't need the user id since users should not be able to query other user's authenticators
		return [
			'authenticator_id' => $this->authenticator_id,
			'type' => $this->type,
			'nickname' => $this->nickname,
			'date_added' => $this->date_added,
			'metadata' => $this->metadata
		];
	}
}

?>