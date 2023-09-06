<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ServiceToken implements JsonSerializable {
	final const ProviderNitrado = 'Nitrado';
	final const ProviderGameServerApp = 'GameServerApp.com';

	final const TypeOAuth = 'OAuth';
	final const TypeStatic = 'Static';

	final const ExpirationBuffer = 86400;
	private const SelectColumns = 'token_id, user_id, provider, type, access_token, EXTRACT(EPOCH FROM access_token_expiration) AS access_token_expiration, refresh_token, EXTRACT(EPOCH FROM refresh_token_expiration) AS refresh_token_expiration, provider_specific, encryption_key';

	protected string $tokenId;
	protected string $userId;
	protected string $provider;
	protected string $type;
	protected string $accessToken;
	protected ?string $refreshToken;
	protected string $accessTokenEncrypted;
	protected ?string $refreshTokenEncrypted;
	protected ?int $accessTokenExpiration;
	protected ?int $refreshTokenExpiration;
	protected string $encryptionKey;
	protected array $providerSpecific;

	public static function RedirectURI(string $provider): string {
		return 'https://' . BeaconCommon::Domain() . '/account/oauth/v4/redeem/' . strtolower($provider);
	}

	public static function CleanupProvider(string $provider): string {
		switch (strtolower($provider)) {
		case strtolower(self::ProviderNitrado):
			return self::ProviderNitrado;
		case strtolower(self::ProviderGameServerApp):
			return self::ProviderGameServerApp;
		}
		return $provider;
	}

	public static function ProviderEndpoint(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/token';
		default:
			throw new Exception("Unknown endpoint for provider {$provider}.");
		}
	}

	public static function ClientId(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return BeaconCommon::GetGlobal('Nitrado_Client_ID');
		default:
			throw new Exception("Unknown client id for provider {$provider}.");
		}
	}

	protected static function ClientSecret(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return BeaconCommon::GetGlobal('Nitrado_Client_Secret');
		default:
			throw new Exception("Unknown client secret for provider {$provider}.");
		}
	}

	protected function __construct(BeaconRecordSet $row) {
		$this->tokenId = $row->Field('token_id');
		$this->userId = $row->Field('user_id');
		$this->provider = $row->Field('provider');
		$this->type = $row->Field('type');
		$this->accessTokenEncrypted = $row->Field('access_token');
		$this->refreshTokenEncrypted = $row->Field('refresh_token');
		$this->accessTokenExpiration = is_null($row->Field('access_token_expiration')) ? null : intval($row->Field('access_token_expiration'));
		$this->refreshTokenExpiration = is_null($row->Field('refresh_token_expiration')) ? null : intval($row->Field('refresh_token_expiration'));
		$this->providerSpecific = json_decode($row->Field('provider_specific'), true);

		$this->encryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($row->Field('encryption_key')));
		$this->accessToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($this->accessTokenEncrypted));
		if (is_null($this->refreshTokenEncrypted) === false) {
			$this->refreshToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($this->refreshTokenEncrypted));
		}
	}

	public static function StoreOAuth(string|User $user, string $provider, string $accessToken, string $refreshToken, int $accessTokenExpiration, int $refreshTokenExpiration, array $providerSpecific, bool $updateExisting = true): ?static {
		$userId = is_string($user) ? $user : $user->UserId();
		$uuidParts = [
			$userId,
			$provider
		];
		if ($provider === self::ProviderNitrado) {
			$uuidParts[] = $providerSpecific['user']['id'];
		}
		$tokenId = BeaconUUID::v5(implode('|', $uuidParts));

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT encryption_key FROM public.service_tokens WHERE token_id = $1;', $tokenId);
		$isUpdate = ($rows->RecordCount() === 1);
		if ($isUpdate && $updateExisting === false) {
			return static::Fetch($tokenId);
		}
		if ($isUpdate) {
			$encryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($rows->Field('encryption_key')));
		} else {
			$encryptionKey = BeaconEncryption::GenerateKey(256);
			$encryptedEncryptionKey = base64_encode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $encryptionKey));
		}
		$accessTokenEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt($encryptionKey, $accessToken, false));
		$refreshTokenEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt($encryptionKey, $refreshToken, false));

		$database->BeginTransaction();
		if ($isUpdate) {
			$database->Query("UPDATE public.service_tokens SET access_token = $2, refresh_token = $3, access_token_expiration = TO_TIMESTAMP($4), refresh_token_expiration = TO_TIMESTAMP($5), provider_specific = $6 WHERE token_id = $1;", $tokenId, $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific));
		} else {
			$database->Query("INSERT INTO public.service_tokens (token_id, user_id, provider, type, access_token, refresh_token, access_token_expiration, refresh_token_expiration, provider_specific, encryption_key) VALUES ($1, $2, $3, $4, $5, $6, TO_TIMESTAMP($7), TO_TIMESTAMP($8), $9, $10);", $tokenId, $userId, $provider, 'OAuth', $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific), $encryptedEncryptionKey);
		}
		$database->Commit();

		return static::Fetch($tokenId);
	}

	public static function StoreStatic(string|User $user, string $provider, string $accessToken, array $providerSpecific, bool $updateExisting = true): ?static {
		$userId = is_string($user) ? $user : $user->UserId();
		$uuidParts = [
			$userId,
			$provider,
			$accessToken
		];
		$tokenId = BeaconUUID::v5(implode('|', $uuidParts));

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT encryption_key FROM public.service_tokens WHERE token_id = $1;', $tokenId);
		$isUpdate = ($rows->RecordCount() === 1);
		if ($isUpdate && $updateExisting === false) {
			return static::Fetch($tokenId);
		}
		if ($isUpdate) {
			$encryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($rows->Field('encryption_key')));
		} else {
			$encryptionKey = BeaconEncryption::GenerateKey(256);
			$encryptedEncryptionKey = base64_encode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $encryptionKey));
		}
		$accessTokenEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt($encryptionKey, $accessToken, false));

		$database->BeginTransaction();
		if ($isUpdate) {
			$database->Query("UPDATE public.service_tokens SET access_token = $2, provider_specific = $3 WHERE token_id = $1;", $tokenId, $accessTokenEncrypted, json_encode($providerSpecific));
		} else {
			$database->Query("INSERT INTO public.service_tokens (token_id, user_id, provider, type, access_token, provider_specific, encryption_key) VALUES ($1, $2, $3, $4, $5, $6, $7);", $tokenId, $userId, $provider, 'Static', $accessTokenEncrypted, json_encode($providerSpecific), $encryptedEncryptionKey);
		}
		$database->Commit();

		return static::Fetch($tokenId);
	}

	public static function ImportOAuth(string|User $user, string $provider, string $accessToken, string $refreshToken): ?static {
		$userId = is_string($user) ? $user : $user->UserId();

		$accessTokenExpiration = time();
		$refreshTokenExpiration = time();
		$providerSpecific = [];
		if (static::UpdateOAuthProperties($provider, $accessToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific)) {
			return static::StoreOAuth($userId, $provider, $accessToken, $refreshToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific, false);
		} else {
			$fields = [
				'grant_type' => 'refresh_token',
				'client_id' => static::ClientID($provider),
				'refresh_token' => $refreshToken,
				'redirect_url' => static::RedirectURI($provider),
			];

			return static::Redeem($userId, $provider, $fields, false);
		}
	}

	public static function Fetch(string $tokenId): ?static {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.service_tokens WHERE token_id = $1;', $tokenId);
		if ($rows->RecordCount() !== 1) {
			return null;
		}

		try {
			return new static($rows);
		} catch (Exception $err) {
			return null;
		}
	}

	public static function Lookup(string $userId, ?string $provider = null): array {
		$database = BeaconCommon::Database();
		if (is_null($provider)) {
			$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.service_tokens WHERE user_id = $1;', $userId);
		} else {
			$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.service_tokens WHERE user_id = $1 AND provider = $2;', $userId, $provider);
		}
		$tokens = [];
		while (!$rows->EOF()) {
			try {
				$tokens[] = new static($rows);
			} catch (Exception $err) {
			}
			$rows->MoveNext();
		}
		return $tokens;
	}

	public static function Begin(string $provider, string $state): string {
		switch ($provider) {
		case self::ProviderNitrado:
			break;
		default:
			throw new Exception("Unknown provider $provider.");
		}

		$clientId = static::ClientId($provider);

		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode(static::RedirectURI($provider)) . '&client_id=' . urlencode($clientId) . '&response_type=code&scope=service&state=' . urlencode($state);
		}
	}

	public static function Complete(string $userId, string $provider, string $code): ?static {
		$fields = [
			'grant_type' => 'authorization_code',
			'client_id' => static::ClientId($provider),
			'client_secret' => static::ClientSecret($provider),
			'code' => $code,
		];

		return static::Redeem($userId, $provider, $fields);
	}

	public static function RefreshExpiring(): void {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.service_tokens WHERE access_token_expiration IS NOT NULL AND access_token_expiration < CURRENT_TIMESTAMP + $1::INTERVAL;', self::ExpirationBuffer . ' seconds');

		while (!$results->EOF()) {
			try {
				$token = new static($results);
				$token->Refresh(true);
			} catch (Exception $err) {
			}
			$results->MoveNext();
		}
	}

	public function TokenId(): string {
		return $this->tokenId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Provider(): string {
		return $this->provider;
	}

	public function Type(): string {
		return $this->type;
	}

	public function AccessToken(bool $decrypted = false): string {
		return $decrypted ? $this->accessToken : $this->accessTokenEncrypted;
	}

	public function RefreshToken(bool $decrypted = false): ?string {
		return $decrypted ? $this->refreshToken : $this->refreshTokenEncrypted;
	}

	public function AccessTokenExpiration(): ?int {
		return $this->accessTokenExpiration;
	}

	public function RefreshTokenExpiration(): ?int {
		return $this->refreshTokenExpiration;
	}

	public function IsExpiring(): bool {
		if (is_null($this->accessTokenExpiration)) {
			return false;
		}

		return $this->accessTokenExpiration < time() + self::ExpirationBuffer;
	}

	public function IsExpired(): bool {
		if (is_null($this->accessTokenExpiration)) {
			return false;
		}

		return $this->accessTokenExpiration < time();
	}

	public function ProviderSpecific(): array {
		return $this->providerSpecific;
	}

	public function JSON(bool $decrypted): array {
		$json = [
			'tokenId' => $this->tokenId,
			'userId' => $this->userId,
			'provider' => $this->provider,
			'type' => $this->type,
			'accessToken' => $this->AccessToken($decrypted),
			'accessTokenExpiration' => $this->accessTokenExpiration,
			'providerSpecific' => $this->providerSpecific
		];
		if ($decrypted) {
			$json['encryptionKey'] = base64_encode($this->encryptionKey);
		}
		return $json;
	}

	public function jsonSerialize(): mixed {
		return $this->JSON(false);
	}

	public function Test(bool $autorefresh = true): bool {
		if ($autorefresh) {
			try {
				if ($this->IsExpiring()) {
					$this->Refresh(true);
					return true; // No need to make another request, we know the redeem worked.
				}
			} catch (Exception $err) {
				return false;
			}
		}

		$endpoint = '';
		switch ($this->provider) {
		case self::ProviderNitrado:
			$endpoint = 'https://oauth.nitrado.net/token';
			break;
		default:
			return true;
		}

		$curl = curl_init($endpoint);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $this->accessToken
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		return $status === 200;
	}

	public function Refresh(bool $force = false): void {
		if ($force === false && $this->IsExpiring() === false) {
			return;
		}

		$fields = [
			'grant_type' => 'refresh_token',
			'client_id' => static::ClientID($this->provider),
			'refresh_token' => $this->refreshToken,
			'redirect_url' => static::RedirectURI($this->provider),
		];

		static::Redeem($this->userId, $this->provider, $fields);
	}

	public function Delete(): bool {
		$status = 0;
		if ($this->type === static::TypeOAuth) {
			$curl = curl_init(static::ProviderEndpoint($this->provider));
			curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
			curl_setopt($curl, CURLOPT_HTTPHEADER, [
				'Authorization: Bearer ' . $this->accessToken
			]);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			$response = curl_exec($curl);
			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			curl_close($curl);
		} else {
			$status = 200;
		}

		if ($status === 200 || $status === 204) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.service_tokens WHERE token_id = $1;', $this->tokenId);
			$database->Commit();
			return true;
		}

		return false;
	}

	protected static function Redeem(string $userId, string $provider, array $fields, bool $updateExisting = true): ?static {
		$curl = curl_init(static::ProviderEndpoint($provider));
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($fields));
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if ($status !== 200) {
			throw new Exception('Invalid authorization code.');
		}

		$response = json_decode($response, true);
		$accessToken = $response['access_token'];
		$refreshToken = $response['refresh_token'];
		$accessTokenExpiration = time();
		$refreshTokenExpiration = time();
		$providerSpecific = [];

		if (static::UpdateOAuthProperties($provider, $accessToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific) === false) {
			throw new Exception('Invalid access token or provider.');
		}

		return static::StoreOAuth($userId, $provider, $accessToken, $refreshToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific, $updateExisting);
	}

	protected static function UpdateOAuthProperties(string $provider, string $accessToken, int &$accessTokenExpiration, int &$refreshTokenExpiration, array &$providerSpecific): bool {
		switch ($provider) {
		case self::ProviderNitrado:
			$curl = curl_init('https://api.nitrado.net/token');
			curl_setopt($curl, CURLOPT_HTTPHEADER, [
				'Authorization: Bearer ' . $accessToken,
			]);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			$response = curl_exec($curl);
			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			curl_close($curl);

			if ($status !== 200) {
				return false;
			}

			$response = json_decode($response, true);
			$providerSpecific['user'] = $response['data']['token']['user'];
			$accessTokenExpiration = $response['data']['token']['expires_at'];
			$refreshTokenExpiration = $accessTokenExpiration + 2592000; // This is a guess
			return true;
		}

		return false;
	}
}

?>
