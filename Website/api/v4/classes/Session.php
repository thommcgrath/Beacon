<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, DateTime, Exception, JsonSerializable;
use Firebase\JWT\{JWT, Key};

class Session extends DatabaseObject implements JsonSerializable {
	private const TokenLength = 32;

	protected string $sessionId = '';
	protected ?string $accessTokenEncrypted = null;
	protected ?string $accessTokenHash = null;
	protected ?string $accessToken = null;
	protected ?string $refreshTokenEncrypted = null;
	protected string $refreshTokenHash = '';
	protected ?string $refreshToken = null;
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
	protected ?string $privateKeyEncrypted = null;

	protected function __construct(?BeaconRecordSet $row = null) {
		if (is_null($row)) {
			return;
		}

		$accessTokenEncrypted = $row->Field('access_token_encrypted');
		if (is_null($accessTokenEncrypted)) {
			$this->accessTokenEncrypted = $accessTokenEncrypted;
			$this->refreshTokenEncrypted = $row->Field('refresh_token_encrypted');
			$this->accessTokenHash = $row->Field('access_token_hash');
		}

		$this->sessionId = $row->Field('session_id');
		$this->refreshTokenHash = $row->Field('refresh_token_hash');
		$this->accessTokenExpiration = filter_var($row->Field('expiration'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? time();
		$this->refreshTokenExpiration = filter_var($row->Field('refresh_token_expiration'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? time();
		$this->userId = $row->Field('user_id');
		$this->remoteIp = $row->Field('remote_ip');
		$this->remoteCountry = $row->Field('remote_country');
		$this->remoteAgent = $row->Field('remote_agent');
		$this->applicationId = $row->Field('application_id');
		$this->applicationName = $row->Field('application_name');
		$this->applicationWebsite = $row->Field('application_website');
		$this->scopes = explode(' ', $row->Field('scopes'));
		$this->privateKeyEncrypted = $row->Field('private_key_encrypted');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'session_tokens', [
			new DatabaseObjectProperty('sessionId', ['primaryKey' => true, 'columnName' => 'session_id']),
			new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => "EXTRACT(EPOCH FROM DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%))::INTEGER"]),
			new DatabaseObjectProperty('refreshToken', ['columnName' => 'refresh_token_hash']),
			new DatabaseObjectProperty('refreshTokenExpiration', ['columnName' => 'refresh_token_expiration', 'accessor' => "EXTRACT(EPOCH FROM DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%))::INTEGER"]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('remoteIp', ['columnName' => 'remote_ip']),
			new DatabaseObjectProperty('remoteCountry', ['columnName' => 'remote_country']),
			new DatabaseObjectProperty('remoteAgent', ['columnName' => 'remote_agent']),
			new DatabaseObjectProperty('applicationId', ['columnName' => 'application_id', 'accessor' => 'applications.application_id']),
			new DatabaseObjectProperty('applicationName', ['columnName' => 'application_name', 'accessor' => 'applications.name']),
			new DatabaseObjectProperty('applicationWebsite', ['columnName' => 'application_website', 'accessor' => 'applications.website']),
			new DatabaseObjectProperty('scopes'),
			new DatabaseObjectProperty('privateKeyEncrypted', ['columnName' => 'private_key_encrypted']),
			new DatabaseObjectProperty('accessToken', ['columnName' => 'access_token_hash']),
			new DatabaseObjectProperty('accessTokenEncrypted', ['columnName' => 'access_token_encrypted']),
			new DatabaseObjectProperty('refreshTokenEncrypted', ['columnName' => 'refresh_token_encrypted']),
		], [
			'LEFT JOIN public.applications ON (session_tokens.application_id = applications.application_id)'
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'accessToken');
		$parameters->AddFromFilter($schema, $filters, 'refreshToken');
		$parameters->AddFromFilter($schema, $filters, 'applicationId');
		$parameters->orderBy = $schema->Accessor('expiration') . ' DESC';
		if ($isNested === false) {
			$parameters->clauses[] = $schema->Comparison('refreshTokenExpiration', '>', 'EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)');
		}
	}

	public function SessionId(): string {
		return $this->sessionId;
	}

	// Alias for legacy code
	public function SessionHash(): string {
		return $this->accessTokenHash ?? hash('sha256', $this->sessionId);
	}

	public function AccessToken(): string {
		$keyList = BeaconCommon::GetGlobal('Authentication Keys');
		$keyIds = array_keys($keyList);
		$keyId = $keyIds[0];
		$primaryKey = $keyList[$keyId];
		$secretKey = $primaryKey['private'];

		$payload = [
			'sub' => $this->userId,
			'iss' => 'https://usebeacon.app',
			'aud' => 'APIv4',
			'iat' => time(),
			'exp' => $this->accessTokenExpiration,
			'jti' => $this->sessionId,
			'app' => [
				'id' => $this->applicationId,
				'name' => $this->applicationName,
				'website' => $this->applicationWebsite,
			],
			'scopes' => $this->scopes,
		];

		$headers = [
			'kid' => $keyId,
		];

		return JWT::encode($payload, $secretKey, 'EdDSA', null, $headers);
	}

	public function AccessTokenHash(): ?string {
		return $this->accessTokenHash;
	}

	public function AccessTokenEncrypted(): ?string {
		return $this->accessTokenEncrypted;
	}

	public function RefreshToken(): ?string {
		return $this->refreshToken;
	}

	public function RefreshTokenHash(): string {
		return $this->refreshTokenHash;
	}

	public function RefreshTokenEncrypted(): ?string {
		return $this->refreshTokenEncrypted;
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
		return (($this->refreshTokenExpiration - time()) <= 864000) || ($this->accessTokenExpiration - time() < 300) || ($this->remoteIp !== BeaconCommon::RemoteAddr()) || ($this->remoteCountry !== BeaconCommon::RemoteCountry());
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

	public function PrivateKeyEncrypted(): ?string {
		return $this->privateKeyEncrypted;
	}

	protected static function PrepareHash(string $token): string {
		return BeaconCommon::Base64UrlEncode(hash('sha3-512', $token, true));
	}

	public static function Create(User $user, Application|string $app, ?array $scopes = null, ?string $privateKey = null): static {
		if (is_string($app)) {
			if (BeaconCommon::IsUUID($app) === false) {
				throw new Exception('Application ID is not a UUID');
			}
			$app = Application::Fetch($app);
			if (is_null($app)) {
				throw new Exception('Unknown application UUID');
			}
		}

		$sessionId = BeaconUUID::v7();
		$schema = static::DatabaseSchema();
		$table = $schema->WriteableTable();
		$refreshToken = BeaconEncryption::GenerateKey(self::TokenLength * 8);
		$refreshTokenHash = static::PrepareHash($refreshToken);
		if (is_null($scopes)) {
			$scopes = $app->Scopes();
		} else if (count($scopes) === 0) {
			throw new Exception('Must request at least one scope');
		}
		sort($scopes);

		$values = [
			$sessionId,
			$refreshTokenHash,
			'15 minutes',
			'30 days',
			$user->UserId(),
			$app->ApplicationId(),
			BeaconCommon::RemoteAddr(),
			BeaconCommon::RemoteCountry(),
			(isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : ''),
			implode(' ', $scopes),
			null
		];

		if (in_array(Application::kScopeUsersPrivateKeyRead, $scopes)) {
			$values[10] = $privateKey;
		}

		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query("INSERT INTO {$table} (session_id, refresh_token_hash, expiration, refresh_token_expiration, user_id, application_id, remote_ip, remote_country, remote_agent, scopes, private_key_encrypted) VALUES ($1, $2, CURRENT_TIMESTAMP(0) + $3::INTERVAL, CURRENT_TIMESTAMP(0) + $4::INTERVAL, $5, $6, $7, $8, $9, $10, $11);", $values);
			$session = static::Fetch($sessionId);
			if (is_null($session)) {
				throw new Exception('Could not retrieve new session');
			}
			$session->refreshToken = BeaconCommon::Base64UrlEncode($refreshToken);
			$database->Commit();
			return $session;
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}

	public static function Fetch(string $token): ?static {
		switch (strlen($token)) {
		case ceil((self::TokenLength / 3) * 4):
			// raw token that is base64-encoded
			$token = BeaconCommon::Base64UrlDecode($token);
			break;
		case self::TokenLength:
			// raw token
			break;
		case 36:
			// uuid
			return parent::Fetch($token);
			break;
		default:
			try {
				$parts = explode('.', $token, 3);
				if (count($parts) !== 3) {
					return null;
				}
				[$headerEncoded, $payloadEncoded, $signatureEncoded] = $parts;
				$header = json_decode(BeaconCommon::Base64UrlDecode($headerEncoded), true);
				$keyId = $header['kid'];

				$keyList = BeaconCommon::GetGlobal('Authentication Keys');
				if (array_key_exists($keyId, $keyList) === false) {
					return self::kUnauthorized;
				}
				$key = $keyList[$keyId];
				$publicKey = $key['public'];
				$decoded = JWT::decode($token, new Key($publicKey, 'EdDSA'));

				$session = new static();
				$session->sessionId = $decoded->jti;
				$session->userId = $decoded->sub;
				$session->accessTokenExpiration = $decoded->exp;
				$session->applicationId = $decoded->app->id;
				$session->scopes = $decoded->scopes;
				return $session;
			} catch (Exception $err) {
				return null;
			}
		}

		$sessions = static::Search(['accessToken|refreshToken' => static::PrepareHash($token)], true);
		if (count($sessions) === 1) {
			$session = $sessions[0];
			$session->Decrypt($token);
			return $session;
		}

		return null;
	}

	protected function Decrypt(string $token): bool {
		if (is_null($this->accessTokenEncrypted)) {
			// Nothing to decrypt
			$providedHash = static::PrepareHash($token);
			if ($this->refreshTokenHash === $providedHash) {
				$this->refreshToken = $token;
				return true;
			}
			return false;
		}

		if (strlen($token) !== self::TokenLength) {
			return false;
		}

		if (empty($this->accessToken) === false && empty($this->refreshToken) === false) {
			return true;
		}

		try {
			$this->accessToken = BeaconCommon::Base64UrlEncode(BeaconEncryption::SymmetricDecrypt($token, BeaconCommon::Base64UrlDecode($this->accessTokenEncrypted)));
			$this->refreshToken = BeaconCommon::Base64UrlEncode($token);
			return true;
		} catch (Exception $err) {
		}

		try {
			$this->refreshToken = BeaconCommon::Base64UrlEncode(BeaconEncryption::SymmetricDecrypt($token, BeaconCommon::Base64UrlDecode($this->refreshTokenEncrypted)));
			$this->accessToken = BeaconCommon::Base64UrlEncode($token);
			return true;
		} catch (Exception $err) {
		}

		return false;
	}

	public function IsDecrypted(): bool {
		return empty($this->accessTokenEncrypted) || (empty($this->accessToken) === false && empty($this->refreshToken) === false);
	}

	public function Renew(bool $force = false): Session {
		if ($this->IsRefreshTokenExpired()) {
			return false;
		}

		if ($force === true || $this->ShouldRenew()) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$newSession = static::Create($this->User(), $this->ApplicationId(), $this->Scopes(), $this->PrivateKeyEncrypted());
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
			'accessToken' => $this->AccessToken(),
			'refreshToken' => $this->refreshToken ?? $this->refreshTokenHash,
			'accessTokenExpiration' => $this->accessTokenExpiration,
			'refreshTokenExpiration' => $this->refreshTokenExpiration,
			'userId' => $this->userId,
			'application' => [
				'id' => $this->applicationId,
				'name' => $this->applicationName,
				'website' => $this->applicationWebsite,
			],
			'scopes' => $this->scopes,
		];
	}

	public function OAuthResponse(): array {
		$accessExpiration = $this->AccessTokenExpiration();
		$refreshExpiration = $this->RefreshTokenExpiration();
		$now = microtime(true);

		return [
			'token_type' => 'Bearer',
			'access_token' => $this->AccessToken(),
			'refresh_token' => $this->refreshToken,
			'access_token_expiration' => $this->accessTokenExpiration,
			'refresh_token_expiration' => $this->refreshTokenExpiration,
			'access_token_expires_in' => $this->accessTokenExpiration - $now,
			'refresh_token_expires_in' => $this->refreshTokenExpiration - $now,
			'scope' => implode(' ', $this->scopes),
			'now' => $now,
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
		$database->Query("DELETE FROM {$table} WHERE {$column} = {$setter};", $this->sessionId);
		$database->Commit();
	}
}

?>
