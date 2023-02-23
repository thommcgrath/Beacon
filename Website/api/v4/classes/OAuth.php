<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, Exception, JsonSerializable;

class OAuth implements JsonSerializable {
	const ProviderNitrado = 'Nitrado';
	const ExpirationBuffer = 86400;
	
	protected $userId = null;
	protected $provider = null;
	protected $accessToken = null;
	protected $refreshToken = null;
	protected $validUntil = null;
	protected $returnUrl = null;
	
	public static function RedirectURI(): string {
		return 'https://' . BeaconCommon::APIDomain() . '/oauth/callback.php';
	}
	
	public static function ProviderEndpoint(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/token';
		default:
			throw new Exception("Unknown provider {$provider}.");
		}
	}
	
	public static function ClientID(string $provider): string {
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
	
	protected function __construct(string $userId, string $provider, string $accessToken, string $refreshToken, int $validUntil) {
		$this->userId = $userId;
		$this->provider = $provider;
		$this->accessToken = $accessToken;
		$this->refreshToken = $refreshToken;
		$this->validUntil = $validUntil;
	}
	
	public static function Lookup(string $userId, string $provider): ?OAuth {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT access_token, EXTRACT(EPOCH FROM valid_until) AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $userId, $provider);
		if ($results->RecordCount() !== 1) {
			return null;
		}
		
		$accessToken = null;
		$refreshToken = null;
		$validUntil = null;
		
		try {
			$key = BeaconCommon::GetGlobal('Sentinel OAuth Key');
			$accessToken = BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('access_token')));
			$refreshToken = BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('refresh_token')));
			$validUntil = intval($results->Field('valid_until'));
		} catch (Exception $err) {
			return null;
		}
		
		return new static($userId, $provider, $accessToken, $refreshToken, $validUntil);
	}
	
	public static function Begin(string $provider, string $state): string {
		switch ($provider) {
		case self::ProviderNitrado:
			break;
		default:
			throw new Exception("Unknown provider $provider.");
		}
		
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode(static::RedirectURI()) . '&client_id=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_ID')) . '&response_type=code&scope=service&state=' . urlencode($state);
		}
	}
	
	public static function Complete(string $userId, string $provider, string $code): OAuth {
		$fields = [
			'grant_type=authorization_code',
			'client_id=' . urlencode(static::ClientID($provider)),
			'client_secret=' . urlencode(static::ClientSecret($provider)),
			'code=' . urlencode($code)
		];
		
		static::Redeem($userId, $provider, $fields);
		
		return static::Lookup($userId, $provider);
	}
	
	public static function RefreshExpiring(): void {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT user_id, provider, access_token, EXTRACT(EPOCH FROM valid_until) AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE valid_until < CURRENT_TIMESTAMP + $1::INTERVAL;', "${self::ExpirationBuffer} seconds");
		
		while (!$results->EOF()) {
			try {
				$key = BeaconCommon::GetGlobal('Sentinel OAuth Key');
				$userId = $results->Field('user_id');
				$provider = $results->Field('provider');
				$accessToken = BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('access_token')));
				$refreshToken = BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('refresh_token')));
				$validUntil = intval($results->Field('valid_until'));
				
				$oauth = new static($userId, $provider, $accessToken, $refreshToken, $validUntil);
				$oauth->Refresh(true);
			} catch (Exception $err) {
			}
			$results->MoveNext();
		}
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function Provider(): string {
		return $this->provider;
	}
	
	public function AccessToken(): string {
		return $this->accessToken;
	}
	
	public function RefreshToken(): string {
		return $this->refreshToken;
	}
	
	public function ValidUntil(): int {
		return $this->validUntil;
	}
	
	public function IsExpiring(): bool {
		return $this->validUntil < time() + self::ExpirationBuffer;
	}
	
	public function IsExpired(): bool {
		return $this->validUntil < time();
	}
	
	public function jsonSerialize(): mixed {
		return [
			'userId' => $this->userId,
			'provider' => $this->provider,
			'accessToken' => $this->accessToken,
			'refreshToken' => $this->refreshToken,
			'validUntil' => $this->validUntil,
			'expired' => $this->IsExpired()
		];
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
			throw new Exception("Unknown provider ${this->provider}");
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
			'redirect_url=' . urlencode(static::RedirectURI())
		];
		
		static::Redeem($this->userId, $this->provider, $fields);
	}
	
	public function Delete(): void {
		$curl = curl_init(static::ProviderEndpoint($this->provider));
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $this->accessToken
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status === 204) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $this->userId, $this->provider);
			$database->Commit();
		}
	}
	
	protected static function Redeem(string $userId, string $provider, array $fields) {
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
		$key = BeaconCommon::GetGlobal('Sentinel OAuth Key');
		$accessToken = base64_encode(BeaconEncryption::SymmetricEncrypt($key, $response['access_token'], false));
		$refreshToken = base64_encode(BeaconEncryption::SymmetricEncrypt($key, $response['refresh_token'], false));
		$expiresIn = $response['expires_in'];
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.oauth_tokens (user_id, provider, access_token, valid_until, refresh_token) VALUES ($1, $2, $3, CURRENT_TIMESTAMP(0) + $4::INTERVAL, $5) ON CONFLICT (user_id, provider) DO UPDATE SET access_token = EXCLUDED.access_token, valid_until = EXCLUDED.valid_until, refresh_token = EXCLUDED.refresh_token;', $userId, $provider, $accessToken, "$expiresIn seconds", $refreshToken);
		$database->Commit();
	}
}

?>