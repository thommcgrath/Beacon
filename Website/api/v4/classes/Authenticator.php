<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception;

class Authenticator extends DatabaseObject implements \JsonSerializable {
	use DatabaseCommonWriterObject;
	
	const TYPE_TOTP = 'TOTP';
	
	protected $authenticatorId;
	protected $userId;
	protected $type;
	protected $nickname;
	protected $dateAdded;
	protected $metadata;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->authenticatorId = $row->Field('authenticator_id');
		$this->userId = $row->Field('user_id');
		$this->type = $row->Field('type');
		$this->nickname = $row->Field('nickname');
		$this->dateAdded = intval($row->Field('date_added'));
		$this->metadata = json_decode($row->Field('metadata'), true);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'user_authenticators', [
			new DatabaseObjectProperty('authenticatorId', ['primaryKey' => true, 'columnName' => 'authenticator_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('nickname', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('dateAdded', ['columnName' => 'date_added', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('metadata')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		
		if (isset($filters['userId']) === false) {
			throw new Exception('Must include userId filter');
		}
		
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'type');
	}
	
	/*public static function Create(string $authenticator_id, string $user_id, string $type, string $nickname, array $metadata): Authenticator {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (authenticator_id, user_id, type, nickname, date_added, metadata) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, $5);', $authenticator_id, $user_id, $type, $nickname, json_encode($metadata));
		$database->Commit();
		return static::GetByAuthenticatorID($authenticator_id);
	}*/
	
	public static function UserHasAuthenticators(User $user, ?string $type = null): bool {
		return static::UserIdHasAuthenticators($user->UserId(), $type);
	}
	
	public static function UserIdHasAuthenticators(string $userId, ?string $type = null): bool {
		$filters = [
			'userId' => $userId,
			'pageSize' => 1
		];
		if (is_null($type) === false) {
			$filters['type'] = $type;
		}
		
		$authenticators = static::Search($filters);
		return $authenticators['totalResults'] > 0;
	}
	
	public function AuthenticatorId(): string {
		return $this->authenticatorId;
	}
	
	public function UserId(): string {
		return $this->userId;
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
		return $this->dateAdded;
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
			'authenticatorId' => $this->authenticatorId,
			'type' => $this->type,
			'nickname' => $this->nickname,
			'dateAdded' => $this->dateAdded,
			'metadata' => $this->metadata
		];
	}
}

?>