<?php
	
namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime, Exception;

class Session implements \JsonSerializable {
	const COOKIE_NAME = 'beacon_auth';
	
	protected $session_hash = '';
	protected $session_id = '';
	protected $user_id = '';
	protected $valid_until = '';
	protected $remote_ip = null;
	protected $remote_country = null;
	protected $remote_agent = null;
	
	public function SessionID(): string {
		return $this->session_id;
	}
	
	public function SessionHash(): string {
		return $this->session_hash;
	}
	
	public function UserID(): string {
		return $this->user_id;
	}
	
	public function User(): User {
		return User::GetByUserID($this->user_id);
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
			$results = $database->Query('UPDATE sessions SET valid_until = CURRENT_TIMESTAMP + \'30 days\'::INTERVAL, remote_ip = $2, remote_country = $3, remote_agent = $4 WHERE session_id = $1 RETURNING date_trunc(\'second\', valid_until) AS valid_until, remote_ip, remote_country, remote_agent;', $this->session_hash, BeaconCommon::RemoteAddr(), BeaconCommon::RemoteCountry(), $_SERVER['HTTP_USER_AGENT']);
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
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM sessions WHERE session_id = $1;", $this->session_hash);
		$database->Commit();
	}
	
	public static function Create(User $user, ?string $verification_code = null): ?Session {
		if ($user->Is2FAProtected() && (is_null($verification_code) || $user->Verify2FACode($verification_code) === false)) {
			return null;
		}
		
		$session_id = BeaconCommon::GenerateUUID();
		$remote_ip = BeaconCommon::RemoteAddr();
		$remote_country = BeaconCommon::RemoteCountry();
		$remote_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$database->Query("INSERT INTO sessions (session_id, user_id, valid_until, remote_ip, remote_country, remote_agent) VALUES (encode(digest($1, 'sha512'), 'hex'), $2, CURRENT_TIMESTAMP + '30d', $3, $4, $5);", $session_id, $user->UserID(), $remote_ip, $remote_country, $remote_agent);
			$database->Commit();
		} catch (Exception $err) {
			return null;
		}
		
		return static::GetBySessionID($session_id);
	}
	
	public static function GetBySessionID(string $session_id): ?Session {
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT $1::text AS session_id, " . implode(', ', static::SQLColumns()) . " FROM " . static::SQLTable() . " WHERE sessions.session_id = encode(digest($1, 'sha512'), 'hex') AND sessions.valid_until >= CURRENT_TIMESTAMP;", $session_id);
		if ($results->RecordCount() === 1) {
			return self::GetFromResult($results);
		} else {
			return null;
		}
	}
	
	public static function GetBySessionHash(string $session_hash): ?Session {
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT '' AS session_id, " . implode(', ', static::SQLColumns()) . " FROM " . static::SQLTable() . " WHERE sessions.session_id = $1 AND sessions.valid_until >= CURRENT_TIMESTAMP;", $session_hash);
		if ($results->RecordCount() === 1) {
			return self::GetFromResult($results);
		} else {
			return null;
		}
	}
	
	public static function GetForUserID(string $user_id): array {
		try {
			$database = BeaconCommon::Database();
			$results = $database->Query('SELECT \'\' AS session_id, ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLTable() . ' WHERE sessions.user_id = $1 AND sessions.valid_until >= CURRENT_TIMESTAMP ORDER BY valid_until DESC;', $user_id);
			return static::GetFromResults($results);
		} catch (Exception $err) {
			return [];
		}
	}
	
	public static function GetForUser(User $user): array {
		if (is_null($user)) {
			return [];
		}
		
		return static::GetForUserID($user->UserID());
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
	
	public static function GetFromCookie(): ?Session {
		if (isset($_COOKIE[self::COOKIE_NAME])) {
			return self::GetBySessionID($_COOKIE[self::COOKIE_NAME]);
		}
		return null;
	}
	
	protected static function SQLColumns(): array {
		return [
			'sessions.session_id AS session_hash',
			'sessions.user_id',
			'date_trunc(\'second\', sessions.valid_until) AS valid_until',
			'sessions.remote_ip',
			'sessions.remote_country',
			'sessions.remote_agent'
		];	
	}
	
	protected static function SQLTable(): string {
		return 'sessions';
	}
	
	protected static function GetFromResult(BeaconRecordSet $results): Session {
		$session = new static();
		$session->session_hash = $results->Field('session_hash');
		$session->session_id = $results->Field('session_id');
		$session->user_id = $results->Field('user_id');
		$session->valid_until = $results->Field('valid_until');
		$session->remote_ip = $results->Field('remote_ip');
		$session->remote_country = $results->Field('remote_country');
		$session->remote_agent = $results->Field('remote_agent');
		return $session;
	}
	
	protected static function GetFromResults(BeaconRecordSet $results): array {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$sessions = array();
		while (!$results->EOF()) {
			$session = self::GetFromResult($results);
			if ($session !== null) {
				$sessions[] = $session;
			}
			$results->MoveNext();
		}
		return $sessions;
	}
	
	public static function Cleanup(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM sessions WHERE valid_until < CURRENT_TIMESTAMP;');
		$database->Commit();
	}
}

?>
