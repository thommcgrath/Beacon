<?php
	
namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime, Exception;

class Session extends DatabaseObject implements \JsonSerializable {
	const COOKIE_NAME = 'beacon_auth';
	
	protected $sessionHash = '';
	protected $sessionId = '';
	protected $userId = '';
	protected $validUntil = '';
	protected $remoteIp = null;
	protected $remoteCountry = null;
	protected $remoteAgent = null;
	protected $applicationId = '';
	protected $applicationName = '';
	protected $applicationWebsite = '';
	protected $scopes = [];
	
	protected function __construct(BeaconRecordSet $row) {
		$this->sessionHash = $row->Field('session_id');
		$this->userId = $row->Field('user_id');
		$this->validUntil = $row->Field('valid_until');
		$this->remoteIp = $row->Field('remote_ip');
		$this->remoteCountry = $row->Field('remote_country');
		$this->remoteAgent = $row->Field('remote_agent');
		$this->applicationId = $row->Field('application_id');
		$this->applicationName = $row->Field('application_name');
		$this->applicationWebsite = $row->Field('application_website');
		$this->scopes = explode(' ', $row->Field('scopes'));
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'sessions', [
			new DatabaseObjectProperty('sessionId', ['primaryKey' => true, 'columnName' => 'session_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('validUntil', ['columnName' => 'valid_until', 'accessor' => "DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%)"]),
			new DatabaseObjectProperty('remoteIp', ['columnName' => 'remote_ip']),
			new DatabaseObjectProperty('remoteCountry', ['columnName' => 'remote_country']),
			new DatabaseObjectProperty('remoteAgent', ['columnName' => 'remote_agent']),
			new DatabaseObjectProperty('applicationId', ['columnName' => 'application_id', 'accessor' => 'applications.application_id']),
			new DatabaseObjectProperty('applicationName', ['columnName' => 'application_name', 'accessor' => 'applications.name']),
			new DatabaseObjectProperty('applicationWebsite', ['columnName' => 'application_website', 'accessor' => 'applications.website']),
			new DatabaseObjectProperty('scopes')
		], [
			'INNER JOIN public.applications ON (sessions.application_id = applications.application_id)'
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'sessionId');
		$parameters->orderBy = $schema->Accessor('validUntil') . ' DESC';
	}
	
	public function SessionId(): string {
		return $this->sessionId;
	}
	
	public function SessionHash(): string {
		return $this->sessionHash;
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function User(): User {
		return User::Fetch($this->userId);
	}
	
	public function Expiration(): DateTime {
		return new DateTime($this->validUntil);
	}
	
	public function ShouldRenew(): bool {
		return (($this->Expiration()->getTimestamp() - time()) <= 864000) || ($this->remoteIp !== BeaconCommon::RemoteAddr()) || ($this->remoteCountry !== BeaconCommon::RemoteCountry() || ($this->remoteAgent !== $_SERVER['HTTP_USER_AGENT']));
	}
	
	public function RemoteAddr(): ?string {
		return $this->remoteIp;
	}
	
	public function RemoteCountry(): ?string {
		return $this->remoteCountry;
	}
	
	public function RemoteAgent(): ?string {
		return $this->remoteAgent;
	}
	
	public function ApplicationId(): ?string {
		return $this->applicationId;
	}
	
	protected static function PrepareHash(string $sessionId, bool $legacy = false): string {
		if ($legacy) {
			return strtolower(hash('sha512', $sessionId, false));
		} else {
			return base64_encode(hash('sha3-512', $sessionId, true));
		}
	}
	
	public static function Create(User $user, Application|string $app, ?array $scopes = null): static {
		if (is_string($app)) {
			if (BeaconCommon::IsUUID($app) === false) {
				throw new Exception('Application ID is not a UUID');
			}
			$app = Application::Fetch($app);
			if (is_null($app)) {
				throw new Exception('Unknown application UUID');
			}
		}
		
		$schema = static::DatabaseSchema();
		$table = $schema->WriteableTable();
		$sessionId = BeaconCommon::GenerateUUID();
		$sessionHash = static::PrepareHash($sessionId);
		if (is_null($scopes)) {
			$scopes = $app->Scopes();
		} else if (count($scopes) === 0) {
			throw new Exception('Must request at least one scope');
		}
		sort($scopes);
			
		$values = [
			$sessionHash,
			$user->UserId(),
			'2592000 seconds',
			BeaconCommon::RemoteAddr(),
			BeaconCommon::RemoteCountry(),
			(isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : ''),
			$app->ApplicationId(),
			implode(' ', $scopes)
		];
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query("INSERT INTO {$table} (session_id, user_id, valid_until, remote_ip, remote_country, remote_agent, application_id, scopes) VALUES ($1, $2, CURRENT_TIMESTAMP(0) + $3::INTERVAL, $4, $5, $6, $7, $8);", $values);
			$session = static::Fetch($sessionId);
			if (is_null($session)) {
				throw new Exception('Could not retrieve new session');
			}
			$database->Commit();
			return $session;
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}
	
	public static function Fetch(string $sessionId): ?static {
		if (BeaconCommon::IsUUID($sessionId)) {
			$session = parent::Fetch(static::PrepareHash($sessionId), false) ?? parent::Fetch(static::PrepareHash($sessionId, true));
			if (is_null($session) === false) {
				$session->sessionId = $sessionId;
				return $session;
			}
			return null;
		}
		
		// This one searches for the hashed version
		$sessions = static::Search(['sessionId' => $sessionId], true);
		if (count($sessions) === 1) {
			return $sessions[0];
		}
		
		return null;
	}
	
	public function Renew(bool $force = false): void {
		if ($force === true || $this->ShouldRenew()) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$results = $database->Query("UPDATE sessions SET valid_until = CURRENT_TIMESTAMP(0) + '30 days'::INTERVAL, remote_ip = $2, remote_country = $3, remote_agent = $4 WHERE session_id = $1 RETURNING date_trunc('second', valid_until) AS valid_until, remote_ip, remote_country, remote_agent;", $this->sessionHash, BeaconCommon::RemoteAddr(), BeaconCommon::RemoteCountry(), $_SERVER['HTTP_USER_AGENT']);
			$database->Commit();
			
			$this->validUntil = $results->Field('valid_until');
			$this->remoteIp = $results->Field('remote_ip');
			$this->remoteCountry = $results->Field('remote_country');
			$this->remoteAgent = $results->Field('remote_agent');
		}
	}
	
	public function HasScope(string $scope): bool {
		return in_array($scope, $this->scopes);
	}
	
	public function HasScopes(array $scopes): bool {
		foreach ($scopes as $scope) {
			if ($this->HasScope($scope) === false) {
				return false;
			}
		}
		return true;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'sessionId' => $this->sessionId,
			'userId' => $this->userId,
			'validUntil' => $this->validUntil,
			'application' => [
				'id' => $this->applicationId,
				'name' => $this->applicationName,
				'website' => $this->applicationWebsite
			],
			'scopes' => $this->scopes
		];
	}
	
	public function SendCookie(bool $temporary = false): void {
		setcookie(self::COOKIE_NAME, $this->sessionId, [
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
	
	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . $schema->WriteableTable() . ' WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->SessionHash());
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
		return static::Search(['userId' => $user_id], true);
	}
	
	public static function GetForUser(User $user): array {
		if (is_null($user)) {
			return [];
		}
		
		return static::Search(['userId' => $user->UserId()], true);
	}
}

?>
