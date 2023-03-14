<?php
	
namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, DateTime, Exception;

class Session extends DatabaseObject implements \JsonSerializable {
	protected string $accessTokenHash = '';
	protected string $accessToken = '';
	protected string $refreshTokenHash = '';
	protected string $refreshToken = '';
	protected int $accessTokenExpiration = 0;
	protected int $refreshTokenExpiration = 0;
	protected string $userId = '';
	protected string $remoteIp = '';
	protected string $remoteCountry = '';
	protected string $remoteAgent = '';
	protected string $applicationId = '';
	protected string $applicationName = '';
	protected string $applicationWebsite = '';
	protected array $scopes = [];
	
	protected function __construct(BeaconRecordSet $row) {
		$this->accessTokenHash = $row->Field('access_token_hash');
		$this->refreshTokenHash = $row->Field('refresh_token_hash');
		$this->accessTokenExpiration = filter_var($row->Field('access_token_expiration'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? time();
		$this->refreshTokenExpiration = filter_var($row->Field('refresh_token_expiration'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? time();
		$this->userId = $row->Field('user_id');
		$this->remoteIp = $row->Field('remote_ip');
		$this->remoteCountry = $row->Field('remote_country');
		$this->remoteAgent = $row->Field('remote_agent');
		$this->applicationId = $row->Field('application_id');
		$this->applicationName = $row->Field('application_name');
		$this->applicationWebsite = $row->Field('application_website');
		$this->scopes = explode(' ', $row->Field('scopes'));
		
		if (is_null($row->Field('encrypted_tokens')) === false) {
			try {
				$tokens = json_decode(BeaconEncryption::SymmetricDecrypt(BeaconCommon::GetGlobal('Auth Encryption Key'), base64_decode($row->Field('encrypted_tokens'))), true);
				$this->accessToken = $tokens['access_token'];
				$this->refreshToken = $tokens['refresh_token'];
			} catch (Exception $err) {
			}
		}
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'access_tokens', [
			new DatabaseObjectProperty('accessToken', ['primaryKey' => true, 'columnName' => 'access_token_hash']),
			new DatabaseObjectProperty('refreshToken', ['columnName' => 'refresh_token_hash']),
			new DatabaseObjectProperty('accessTokenExpiration', ['columnName' => 'access_token_expiration', 'accessor' => "EXTRACT(EPOCH FROM DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%))::INTEGER"]),
			new DatabaseObjectProperty('refreshTokenExpiration', ['columnName' => 'refresh_token_expiration', 'accessor' => "EXTRACT(EPOCH FROM DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%))::INTEGER"]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('remoteIp', ['columnName' => 'remote_ip']),
			new DatabaseObjectProperty('remoteCountry', ['columnName' => 'remote_country']),
			new DatabaseObjectProperty('remoteAgent', ['columnName' => 'remote_agent']),
			new DatabaseObjectProperty('applicationId', ['columnName' => 'application_id', 'accessor' => 'applications.application_id']),
			new DatabaseObjectProperty('applicationName', ['columnName' => 'application_name', 'accessor' => 'applications.name']),
			new DatabaseObjectProperty('applicationWebsite', ['columnName' => 'application_website', 'accessor' => 'applications.website']),
			new DatabaseObjectProperty('scopes'),
			new DatabaseObjectProperty('encryptedTokens', ['columnName' => 'encrypted_tokens'])
		], [
			'LEFT JOIN public.applications ON (access_tokens.application_id = applications.application_id)'
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'accessToken');
		$parameters->AddFromFilter($schema, $filters, 'refreshToken');
		$parameters->orderBy = $schema->Accessor('accessTokenExpiration') . ' DESC';
		if ($isNested === false) {
			$parameters->clauses[] = $schema->Comparison('refreshTokenExpiration', '>', 'EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)');
		}
	}
	
	// Alias for legacy code
	public function SessionId(): string {
		return $this->accessToken;
	}
	
	// Alias for legacy code
	public function SessionHash(): string {
		return $this->accessTokenHash;
	}
	
	public function AccessToken(): string {
		return $this->accessToken;
	}
	
	public function AccessTokenHash(): string {
		return $this->accessTokenHash;
	}
	
	public function RefreshToken(): string {
		return $this->refreshToken;
	}
	
	public function RefreshTokenHash(): string {
		return $this->refreshTokenHash;
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function User(): User {
		return User::Fetch($this->userId);
	}
	
	public function AccessTokenExpiration(): int {
		return $this->accessTokenExpiration;
	}
	
	public function IsAccessTokenExpired(): bool {
		return $this->accessTokenExpiration < time();
	}
	
	public function RefreshTokenExpiration(): int {
		return $this->refreshTokenExpiration;
	}
	
	public function IsRefreshTokenExpired(): bool {
		// Should never be true, but this exists for completeness
		return $this->refreshTokenExpiration < time();
	}
	
	public function ShouldRenew(): bool {
		return (($this->refreshTokenExpiration - time()) <= 864000) || ($this->accessTokenExpiration - time() < 300) || ($this->remoteIp !== BeaconCommon::RemoteAddr()) || ($this->remoteCountry !== BeaconCommon::RemoteCountry() || ($this->remoteAgent !== $_SERVER['HTTP_USER_AGENT']));
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
	
	public function Application(): ?Application {
		return Application::Fetch($this->applicationId);
	}
	
	protected static function PrepareHash(string $token, bool $legacy = false): string {
		if ($legacy) {
			return strtolower(hash('sha512', $token, false));
		} else {
			return base64_encode(hash('sha3-512', $token, true));
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
		$accessToken = BeaconCommon::GenerateUUID();
		$accessTokenHash = static::PrepareHash($accessToken);
		$refreshToken = BeaconCommon::GenerateUUID();
		$refreshTokenHash = static::PrepareHash($refreshToken);
		if (is_null($scopes)) {
			$scopes = $app->Scopes();
		} else if (count($scopes) === 0) {
			throw new Exception('Must request at least one scope');
		}
		sort($scopes);
		$encryptedTokens = base64_encode(BeaconEncryption::SymmetricEncrypt(BeaconCommon::GetGlobal('Auth Encryption Key'), json_encode([
			'access_token' => $accessToken,
			'refresh_token' => $refreshToken
		])));
			
		$values = [
			$accessTokenHash,
			$refreshTokenHash,
			'1 hour',
			'30 days',
			$user->UserId(),
			$app->ApplicationId(),
			BeaconCommon::RemoteAddr(),
			BeaconCommon::RemoteCountry(),
			(isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : ''),
			implode(' ', $scopes),
			$encryptedTokens
		];
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query("INSERT INTO {$table} (access_token_hash, refresh_token_hash, access_token_expiration, refresh_token_expiration, user_id, application_id, remote_ip, remote_country, remote_agent, scopes, encrypted_tokens) VALUES ($1, $2, CURRENT_TIMESTAMP(0) + $3::INTERVAL, CURRENT_TIMESTAMP(0) + $4::INTERVAL, $5, $6, $7, $8, $9, $10, $11);", $values);
			$session = static::Fetch($accessToken);
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
	
	public static function Fetch(string $token): ?static {
		$hashes = [];
		if (BeaconCommon::IsUUID($token)) {
			$hashes[] = static::PrepareHash($token, false);
			$hashes[] = static::PrepareHash($token, true);
		} else {
			$hashes[] = $token;
		}
		
		foreach ($hashes as $hash) {
			$sessions = static::Search(['accessToken|refreshToken' => $hash], true);
			if (count($sessions) === 1) {
				$session = $sessions[0];
				if (BeaconCommon::IsUUID($token)) {
					if ($session->accessTokenHash === $hash) {
						$session->accessToken = $token;
					}
					if ($session->refreshTokenHash === $hash) {
						$session->refreshToken = $token;
					}
				}
				return $session;
			}
		}
		
		return null;
	}
	
	public function Renew(bool $force = false): Session {
		if ($force === true || $this->ShouldRenew()) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$newSession = static::Create($this->User(), $this->Application(), $this->Scopes());
			$this->Delete();
			$database->Commit();
			
			return $newSession;
		} else {
			return $this;
		}
	}
	
	public function Scopes(): array {
		return $this->scopes;
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
			'accessToken' => $this->accessToken,
			'refreshToken' => $this->refreshToken,
			'accessTokenExpiration' => date('Y-m-d H:i:sO', $this->accessTokenExpiration),
			'refreshTokenExpiration' => date('Y-m-d H:i:sO', $this->refreshTokenExpiration),
			'userId' => $this->userId,
			'application' => [
				'id' => $this->applicationId,
				'name' => $this->applicationName,
				'website' => $this->applicationWebsite
			],
			'scopes' => $this->scopes
		];
	}
	
	public function OAuthResponse(): array {
		$accessExpiration = $this->AccessTokenExpiration();
		$refreshExpiration = $this->RefreshTokenExpiration();
		
		return [
			'token_type' => 'Bearer',
			'access_token' => $this->accessToken,
			'refresh_token' => $this->refreshToken,
			'access_token_expiration' => date('Y-m-d H:i:sO', $this->accessTokenExpiration),
			'refresh_token_expiration' => date('Y-m-d H:i:sO', $this->refreshTokenExpiration),
			'expires_in' => $this->accessTokenExpiration - time(),
			'refresh_expires_in' => $this->refreshTokenExpiration - time(),
			'scope' => implode(' ', $this->scopes)
		];
	}
	
	public static function Cleanup(): void {
		$schema = static::DatabaseSchema();
		$table = $schema->WriteableTable();
		$column = $schema->Property('refreshTokenExpiration')->ColumnName();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM {$table} WHERE {$column} < CURRENT_TIMESTAMP;");
		$database->Commit();
	}
	
	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$table = $schema->WriteableTable();
		$column = $schema->PrimaryColumn()->ColumnName();
		$setter = $schema->PrimarySetter('$1');
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM {$table} WHERE {$column} = {$setter};", $this->AccessTokenHash());
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
