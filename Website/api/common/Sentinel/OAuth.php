<?php

namespace BeaconAPI\Sentinel;

class OAuth implements \JsonSerializable {
	const ProviderNitrado = 'Nitrado';
	const ExpirationBuffer = 86400;
	
	protected $user_id = null;
	protected $provider = null;
	protected $access_token = null;
	protected $refresh_token = null;
	protected $valid_until = null;
	protected $return_url = null;
	
	public static function RedirectURI(): string {
		return 'https://' . \BeaconCommon::APIDomain() . '/oauth/callback.php';
	}
	
	public static function ProviderEndpoint(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/token';
		default:
			throw new \Exception("Unknown provider $provider.");
		}
	}
	
	public static function ClientID(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return \BeaconCommon::GetGlobal('Nitrado_Client_ID');
		default:
			throw new \Exception("Unknown provider $provider.");
		}
	}
	
	protected static function ClientSecret(string $provider): string {
		switch ($provider) {
		case self::ProviderNitrado:
			return \BeaconCommon::GetGlobal('Nitrado_Client_Secret');
		default:
			throw new \Exception("Unknown provider $provider.");
		}
	}
	
	protected function __construct(string $user_id, string $provider, string $access_token, string $refresh_token, int $valid_until) {
		$this->user_id = $user_id;
		$this->provider = $provider;
		$this->access_token = $access_token;
		$this->refresh_token = $refresh_token;
		$this->valid_until = $valid_until;
	}
	
	public static function Lookup(string $user_id, string $provider): ?OAuth {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT access_token, EXTRACT(EPOCH FROM valid_until) AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $user_id, $provider);
		if ($results->RecordCount() !== 1) {
			return null;
		}
		
		$access_token = null;
		$refresh_token = null;
		$valid_until = null;
		
		try {
			$key = \BeaconCommon::GetGlobal('Sentinel OAuth Key');
			$access_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('access_token')));
			$refresh_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('refresh_token')));
			$valid_until = intval($results->Field('valid_until'));
		} catch (\Exception $err) {
			return null;
		}
		
		return new static($user_id, $provider, $access_token, $refresh_token, $valid_until);
	}
	
	public static function Begin(string $provider, string $state): string {
		switch ($provider) {
		case self::ProviderNitrado:
			break;
		default:
			throw new \Exception("Unknown provider $provider.");
		}
		
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode(static::RedirectURI()) . '&client_id=' . urlencode(\BeaconCommon::GetGlobal('Nitrado_Client_ID')) . '&response_type=code&scope=service&state=' . urlencode($state);
		}
	}
	
	public static function Complete(string $user_id, string $provider, string $code): OAuth {
		$fields = [
			'grant_type=authorization_code',
			'client_id=' . urlencode(static::ClientID($provider)),
			'client_secret=' . urlencode(static::ClientSecret($provider)),
			'code=' . urlencode($code)
		];
		
		static::Redeem($user_id, $provider, $fields);
		
		return static::Lookup($user_id, $provider);
	}
	
	public static function RefreshExpiring(): void {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT user_id, provider, access_token, EXTRACT(EPOCH FROM valid_until) AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE valid_until < CURRENT_TIMESTAMP + $1::INTERVAL;', "${self::ExpirationBuffer} seconds");
		
		while (!$results->EOF()) {
			try {
				$key = \BeaconCommon::GetGlobal('Sentinel OAuth Key');
				$user_id = $results->Field('user_id');
				$provider = $results->Field('provider');
				$access_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('access_token')));
				$refresh_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('refresh_token')));
				$valid_until = intval($results->Field('valid_until'));
				
				$oauth = new static($user_id, $provider, $access_token, $refresh_token, $valid_until);
				$oauth->Refresh(true);
			} catch (\Exception $err) {
			}
			$results->MoveNext();
		}
	}
	
	public function UserID(): string {
		return $this->user_id;
	}
	
	public function Provider(): string {
		return $this->provider;
	}
	
	public function AccessToken(): string {
		return $this->access_token;
	}
	
	public function RefreshToken(): string {
		return $this->refresh_token;
	}
	
	public function ValidUntil(): int {
		return $this->valid_until;
	}
	
	public function IsExpiring(): bool {
		return $this->valid_until < time() + self::ExpirationBuffer;
	}
	
	public function IsExpired(): bool {
		return $this->valid_until < time();
	}
	
	public function jsonSerialize(): mixed {
		return [
			'user_id' => $this->user_id,
			'provider' => $this->provider,
			'access_token' => $this->access_token,
			'refresh_token' => $this->refresh_token,
			'valid_until' => $this->valid_until,
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
			} catch (\Exception $err) {
				return false;
			}
		}
		
		$endpoint = '';
		switch ($this->provider) {
		case self::ProviderNitrado:
			$endpoint = 'https://oauth.nitrado.net/token';
			break;
		default:
			throw new \Exception("Unknown provider ${this->provider}");
		}
		
		$curl = curl_init($endpoint);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $this->access_token
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
			'refresh_token=' . urlencode($this->refresh_token),
			'redirect_url=' . urlencode(static::RedirectURI())
		];
		
		static::Redeem($this->user_id, $this->provider, $fields);
	}
	
	public function Delete(): void {
		$curl = curl_init(static::ProviderEndpoint($this->provider));
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $this->access_token
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status === 204) {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $this->user_id, $this->provider);
			$database->Commit();
		}
	}
	
	protected static function Redeem(string $user_id, string $provider, array $fields) {
		$curl = curl_init(static::ProviderEndpoint($provider));
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, implode('&', $fields));
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status !== 200) {
			throw new \Exception('Invalid authorization code.');
		}
		
		$response = json_decode($response, true);
		$key = \BeaconCommon::GetGlobal('Sentinel OAuth Key');
		$access_token = base64_encode(\BeaconEncryption::SymmetricEncrypt($key, $response['access_token'], false));
		$refresh_token = base64_encode(\BeaconEncryption::SymmetricEncrypt($key, $response['refresh_token'], false));
		$expires_in = $response['expires_in'];
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.oauth_tokens (user_id, provider, access_token, valid_until, refresh_token) VALUES ($1, $2, $3, CURRENT_TIMESTAMP(0) + $4::INTERVAL, $5) ON CONFLICT (user_id, provider) DO UPDATE SET access_token = EXCLUDED.access_token, valid_until = EXCLUDED.valid_until, refresh_token = EXCLUDED.refresh_token;', $user_id, $provider, $access_token, "$expires_in seconds", $refresh_token);
		$database->Commit();
	}
}

?>