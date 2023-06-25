<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class OAuth implements JsonSerializable {
	final const ProviderNitrado = 'Nitrado';
	final const ExpirationBuffer = 86400;
	private const SelectColumns = 'oauth_token_id, user_id, provider, access_token, EXTRACT(EPOCH FROM access_token_expiration) AS access_token_expiration, refresh_token, EXTRACT(EPOCH FROM refresh_token_expiration) AS refresh_token_expiration, provider_specific, encryption_key';
	
	protected string $tokenId;
	protected string $userId;
	protected string $provider;
	protected string $accessToken;
	protected string $refreshToken;
	protected string $accessTokenEncrypted;
	protected string $refreshTokenEncrypted;
	protected int $accessTokenExpiration;
	protected int $refreshTokenExpiration;
	protected string $encryptionKey;
	protected array $providerSpecific;
	
	public static function RedirectURI(string $provider): string {
		return 'https://' . BeaconCommon::Domain() . '/account/oauth/v4/redeem/' . strtolower($provider);
	}
	
	public static function CleanupProvider(string $provider): string {
		switch (strtolower($provider)) {
		case strtolower(self::ProviderNitrado):
			return self::ProviderNitrado;
		}
		return $provider;	
	}
	
	public static function ProviderEndpoint(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/token';
		default:
			throw new Exception("Unknown provider {$provider}.");
		}
	}
	
	public static function ClientId(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return BeaconCommon::GetGlobal('Nitrado_Client_ID');
		default:
			throw new Exception("Unknown provider {$provider}.");
		}
	}
	
	protected static function ClientSecret(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return BeaconCommon::GetGlobal('Nitrado_Client_Secret');
		default:
			throw new Exception("Unknown provider {$provider}.");
		}
	}
	
	protected function __construct(BeaconRecordSet $row) {
		$this->tokenId = $row->Field('oauth_token_id');
		$this->userId = $row->Field('user_id');
		$this->provider = $row->Field('provider');
		$this->accessTokenEncrypted = $row->Field('access_token');
		$this->refreshTokenEncrypted = $row->Field('refresh_token');
		$this->accessTokenExpiration = intval($row->Field('access_token_expiration'));
		$this->refreshTokenExpiration = intval($row->Field('refresh_token_expiration'));
		$this->providerSpecific = json_decode($row->Field('provider_specific'), true);
		
		$this->encryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($row->Field('encryption_key')));
		$this->accessToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($row->Field('access_token')));
		$this->refreshToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($row->Field('refresh_token')));
	}
	
	public static function Store(string|User $user, string $provider, string $accessToken, string $refreshToken, int $accessTokenExpiration, int $refreshTokenExpiration, array $providerSpecific): ?static {
		if (is_string($user)) {
			$user = User::Fetch($user);
			if (is_null($user)) {
				throw new Exception('Could not find user');
			}
		}
		
		$uuidParts = [
			$user->UserId(),
			$provider
		];
		if ($provider === self::ProviderNitrado) {
			$uuidParts[] = $providerSpecific['user']['id'];
		}
		$accessTokenId = BeaconUUID::v5(implode('|', $uuidParts));
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT encryption_key FROM public.oauth_tokens WHERE oauth_token_id = $1;', $accessTokenId);
		$isUpdate = ($rows->RecordCount() === 1);
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
			$database->Query("UPDATE public.oauth_tokens SET access_token = $2, refresh_token = $3, access_token_expiration = TO_TIMESTAMP($4), refresh_token_expiration = TO_TIMESTAMP($5), provider_specific = $6 WHERE oauth_token_id = $1;", $accessTokenId, $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific));
		} else {
			$database->Query("INSERT INTO public.oauth_tokens (oauth_token_id, user_id, provider, access_token, refresh_token, access_token_expiration, refresh_token_expiration, provider_specific, encryption_key) VALUES ($1, $2, $3, $4, $5, TO_TIMESTAMP($6), TO_TIMESTAMP($7), $8, $9);", $accessTokenId, $user->UserId(), $provider, $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific), $encryptedEncryptionKey);
		}
		$database->Commit();
		
		return static::Fetch($accessTokenId);
	}
	
	public static function Fetch(string $tokenId): ?static {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.oauth_tokens WHERE oauth_token_id = $1;', $tokenId);
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
			$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.oauth_tokens WHERE user_id = $1;', $userId);
		} else {
			$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.oauth_tokens WHERE user_id = $1 AND provider = $2;', $userId, $provider);
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
			'grant_type=authorization_code',
			'client_id=' . urlencode(static::ClientId($provider)),
			'client_secret=' . urlencode(static::ClientSecret($provider)),
			'code=' . urlencode($code)
		];
		
		return static::Redeem($userId, $provider, $fields);
	}
	
	public static function RefreshExpiring(): void {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . self::SelectColumns . ' FROM public.oauth_tokens WHERE access_token_expiration < CURRENT_TIMESTAMP + $1::INTERVAL;', self::ExpirationBuffer . ' seconds');
		
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
	
	public function AccessToken(bool $decrypted = false): string {
		return $decrypted ? $this->accessToken : $this->accessTokenEncrypted;
	}
	
	public function RefreshToken(bool $decrypted = false): string {
		return $decrypted ? $this->refreshToken : $this->refreshTokenEncrypted;
	}
	
	public function AccessTokenExpiration(): int {
		return $this->accessTokenExpiration;
	}
	
	public function RefreshTokenExpiration(): int {
		return $this->refreshTokenExpiration;
	}
	
	public function IsExpiring(): bool {
		return $this->accessTokenExpiration < time() + self::ExpirationBuffer;
	}
	
	public function IsExpired(): bool {
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
			'accessToken' => $this->AccessToken($decrypted),
			'refreshToken' => $this->RefreshToken($decrypted),
			'accessTokenExpiration' => $this->accessTokenExpiration,
			'refreshTokenExpiration' => $this->refreshTokenExpiration,
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
			throw new Exception("Unknown provider {$this->provider}");
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
			'grant_type=refresh_token',
			'client_id=' . urlencode(static::ClientID($this->provider)),
			'refresh_token=' . urlencode($this->refreshToken),
			'redirect_url=' . urlencode(static::RedirectURI($this->provider))
		];
		
		static::Redeem($this->userId, $this->provider, $fields);
	}
	
	public function Delete(): bool {
		$curl = curl_init(static::ProviderEndpoint($this->provider));
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $this->accessToken
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status === 200 || $status === 204) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.oauth_tokens WHERE oauth_token_id = $1;', $this->tokenId);
			$database->Commit();
			return true;
		}
		
		return false;
	}
	
	protected static function Redeem(string $userId, string $provider, array $fields): ?static {
		$curl = curl_init(static::ProviderEndpoint($provider));
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, implode('&', $fields));
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
		if ($provider === self::ProviderNitrado) {
			$curl = curl_init('https://api.nitrado.net/token');
			curl_setopt($curl, CURLOPT_HTTPHEADER, [
			  'Authorization: Bearer ' . $accessToken,
			]);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			$response = curl_exec($curl);
			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			curl_close($curl);
			
			if ($status !== 200) {
				throw new Exception('Invalid access token.');
			}
			
			$response = json_decode($response, true);
			$providerSpecific['user'] = $response['data']['token']['user'];
			$accessTokenExpiration = $response['data']['token']['expires_at'];
			$refreshTokenExpiration = $accessTokenExpiration + 2592000; // This is a guess
		}
		
		return static::Store($userId, $provider, $accessToken, $refreshToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific);
	}
}

?>