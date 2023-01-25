<?php
	
namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime, Exception;

class Session extends DatabaseObject implements \JsonSerializable {
	use DatabaseCommonWriterObject;
	
	const COOKIE_NAME = 'beacon_auth';
	
	protected $session_hash = '';
	protected $session_id = '';
	protected $user_id = '';
	protected $valid_until = '';
	protected $remote_ip = null;
	protected $remote_country = null;
	protected $remote_agent = null;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->session_hash = $row->Field('session_id');
		$this->user_id = $row->Field('user_id');
		$this->valid_until = $row->Field('valid_until');
		$this->remote_ip = $row->Field('remote_ip');
		$this->remote_country = $row->Field('remote_country');
		$this->remote_agent = $row->Field('remote_agent');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'sessions', [
			new DatabaseObjectProperty('session_id', ['primaryKey' => true]),
			new DatabaseObjectProperty('user_id'),
			new DatabaseObjectProperty('valid_until', ['accessor' => "date_trunc('second', sessions.valid_until)", 'setter' => 'to_timestamp(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('remote_ip'),
			new DatabaseObjectProperty('remote_country'),
			new DatabaseObjectProperty('remote_agent')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'user_id');
		$parameters->AddFromFilter($schema, $filters, 'session_id');
		$parameters->orderBy = 'valid_until DESC';
	}
	
	public function SessionId(): string {
		return $this->session_id;
	}
	
	public function SessionHash(): string {
		return $this->session_hash;
	}
	
	public function UserId(): string {
		return $this->user_id;
	}
	
	public function User(): User {
		return User::Fetch($this->user_id);
	}
	
	public function Expiration(): DateTime {
		return new DateTime($this->valid_until);
	}
	
	public function ShouldRenew(): bool {
		return (($this->Expiration()->getTimestamp() - time()) <= 864000) || ($this->remote_ip !== BeaconCommon::RemoteAddr()) || ($this->remote_country !== BeaconCommon::RemoteCountry() || ($this->remote_agent !== $_SERVER['HTTP_USER_AGENT']));
	}
	
	public function Renew(bool $force = false): void {
		if ($force === true || $this->ShouldRenew()) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$results = $database->Query("UPDATE sessions SET valid_until = CURRENT_TIMESTAMP + '30 days'::INTERVAL, remote_ip = $2, remote_country = $3, remote_agent = $4 WHERE session_id = $1 RETURNING date_trunc('second', valid_until) AS valid_until, remote_ip, remote_country, remote_agent;", $this->session_hash, BeaconCommon::RemoteAddr(), BeaconCommon::RemoteCountry(), $_SERVER['HTTP_USER_AGENT']);
			$database->Commit();
			
			$this->valid_until = $results->Field('valid_until');
			$this->remote_ip = $results->Field('remote_ip');
			$this->remote_country = $results->Field('remote_country');
			$this->remote_agent = $results->Field('remote_agent');
		}
	}
			
	
	public function RemoteAddr(): ?string {
		return $this->remote_ip;
	}
	
	public function RemoteCountry(): ?string {
		return $this->remote_country;
	}
	
	public function RemoteAgent(): ?string {
		return $this->remote_agent;
	}
	
	public static function CreateForUser(User $user, ?string $verification_code): ?static {
		if ($user->Is2FAProtected() && (is_null($verification_code) || $user->Verify2FACode($verification_code) === false)) {
			return null;
		}
		
		$session_id = BeaconCommon::GenerateUUID();
		$properties = [
			'session_id' => strtolower(hash('sha512', $session_id)),
			'user_id' => $user->UserId(),
			'valid_until' => time() + 2592000,
			'remote_ip' => BeaconCommon::RemoteAddr(),
			'remote_country' => BeaconCommon::RemoteCountry(),
			'remote_agent' => isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : ''
		];
		
		try {
			$session = static::Create($properties);
			$session->session_id = $session_id;
		} catch (Exception $err) {
			return null;
		}
		
		return $session;
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM sessions WHERE session_id = $1;", $this->session_hash);
		$database->Commit();
	}
	
	public static function Fetch(string $session_id): ?static {
		if (BeaconCommon::IsUUID($session_id)) {
			$session = parent::Fetch(strtolower(hash('sha512', $session_id)));
			if (is_null($session) === false) {
				$session->session_id = $session_id;
				return $session;
			}
			return null;
		}
		
		$sessions = static::Search(['session_id' => $session_id], true);
		if (count($sessions) === 1) {
			return $sessions[0];
		}
		
		return null;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'session_id' => $this->session_id,
			'user_id' => $this->user_id,
			'valid_until' => $this->valid_until
		];
	}
	
	public function SendCookie(bool $temporary = false): void {
		setcookie(self::COOKIE_NAME, $this->session_id, [
			'expires' => ($temporary ? 0 : $this->Expiration()->getTimestamp()),
			'path' => '/account',
			'domain' =>'',
			'secure' => true,
			'httponly' =>true,
			'samesite' => 'Strict'
		]);
	}
	
	public static function RemoveCookie(): void {
		setcookie(self::COOKIE_NAME, '', [
			'expires' => 0,
			'path' => '/account',
			'domain' => '',
			'secure' => true,
			'httponly' =>true,
			'samesite' => 'Strict'
		]);
	}
	
	public static function GetFromCookie(): ?static {
		if (isset($_COOKIE[self::COOKIE_NAME])) {
			return self::Fetch($_COOKIE[self::COOKIE_NAME]);
		}
		return null;
	}
	
	public static function Cleanup(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM sessions WHERE valid_until < CURRENT_TIMESTAMP;');
		$database->Commit();
	}
	
	/* ! Deprecated Methods */
	
	public static function GetBySessionId(string $session_id): ?static {
		return static::Fetch($session_id);
	}
	
	public static function GetBySessionHash(string $session_hash): ?static {
		return static::Fetch($session_hash);
	}
	
	public static function GetForUserID(string $user_id): array {
		return static::Search(['user_id' => $user_id], true);
	}
	
	public static function GetForUser(User $user): array {
		if (is_null($user)) {
			return [];
		}
		
		return static::Search(['user_id' => $user->UserId()], true);
	}
}

?>
