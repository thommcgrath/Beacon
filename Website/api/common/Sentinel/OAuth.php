<?php

namespace BeaconAPI\Sentinel;

class OAuth implements \JsonSerializable {
	const ProviderNitrado = 'Nitrado';
	
	protected $user_id = null;
	protected $provider = null;
	protected $access_token = null;
	protected $refresh_token = null;
	protected $valid_until = null;
	protected $return_url = null;
	
	public static function RedirectURI(): string {
		return 'https://' . $_SERVER['HTTP_HOST'] . '/oauth/callback.php';
	}
	
	protected static function ClientID(string $provider): string {
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
	
	protected function __construct(string $user_id, string $provider, string $access_token, string $refresh_token, string $valid_until) {
		$this->user_id = $user_id;
		$this->provider = $provider;
		$this->access_token = $access_token;
		$this->refresh_token = $refresh_token;
		$this->valid_until = $valid_until;
	}
	
	public static function Lookup(string $user_id, string $provider): ?OAuth {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT access_token, valid_until AT TIME ZONE \'UTC\' AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $user_id, $provider);
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
			$valid_until = $results->Field('valid_until');
		} catch (\Exception $err) {
			return null;
		}
		
		return new static($user_id, $provider, $access_token, $refresh_token, $valid_until);
	}
	
	public static function Begin(string $user_id, string $provider, string $return_uri): string {
		switch ($provider) {
		case self::ProviderNitrado:
			break;
		default:
			throw new \Exception("Unknown provider $provider.");
		}
		
		$state = \BeaconCommon::GenerateUUID();
		$redirect_uri = 'https://' . $_SERVER['HTTP_HOST'] . '/oauth/callback.php';
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM sentinel.oauth_requests WHERE user_id = $1 OR started < CURRENT_TIMESTAMP - \'6 hours\'::INTERVAL;', $user_id);
		$database->Query('INSERT INTO sentinel.oauth_requests (state, user_id, provider, return_uri) VALUES ($1, $2, $3, $4);', $state, $user_id, $provider, $return_uri);
		$database->Commit();
		
		switch ($provider) {
		case self::ProviderNitrado:
			return 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode(static::RedirectURI()) . '&client_id=' . urlencode(\BeaconCommon::GetGlobal('Nitrado_Client_ID')) . '&response_type=code&scope=service&state=' . urlencode($state);
		}
	}
	
	public static function Complete(string $state, string $code): string {
		$database = \BeaconCommon::Database();
		$requests = $database->Query('SELECT user_id, provider, return_uri FROM sentinel.oauth_requests WHERE state = $1;', $state);
		if ($requests->RecordCount() !== 1) {
			throw new \Exception('Could not find request.');
		}
		
		$user_id = $requests->Field('user_id');
		$provider = $requests->Field('provider');
		$return_uri = $requests->Field('return_uri');
		
		$fields = [
			'grant_type=authorization_code',
			'client_id=' . urlencode(static::ClientID($provider)),
			'client_secret=' . urlencode(static::ClientSecret($provider)),
			'code=' . urlencode($code),
			'redirect_url=' . urlencode(static::RedirectURI())
		];
		
		static::Redeem($user_id, $provider, $fields, $state);
		
		return $return_uri;
	}
	
	public static function RefreshExpiring(): void {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT user_id, provider, access_token, valid_until AT TIME ZONE \'UTC\' AS valid_until, refresh_token FROM sentinel.oauth_tokens WHERE valid_until < CURRENT_TIMESTAMP + \'24 hours\'::INTERVAL;');
		
		while (!$results->EOF()) {
			try {
				$key = \BeaconCommon::GetGlobal('Sentinel OAuth Key');
				$user_id = $results->Field('user_id');
				$provider = $results->Field('provider');
				$access_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('access_token')));
				$refresh_token = \BeaconEncryption::SymmetricDecrypt($key, base64_decode($results->Field('refresh_token')));
				$valid_until = $results->Field('valid_until');
				
				$oauth = new static($user_id, $provider, $access_token, $refresh_token, $valid_until);
				$oauth->Refresh(true);
			} catch (\Exception $err) {
			}
			$results->MoveNext();
		}
	}
	
	protected function UserID(): string {
		return $this->user_id;
	}
	
	protected function Provider(): string {
		return $this->provider;
	}
	
	protected function AccessToken(): string {
		return $this->access_token;
	}
	
	protected function RefreshToken(): string {
		return $this->refresh_token;
	}
	
	protected function ValidUntil(): string {
		return $this->valid_until;
	}
	
	protected function IsExpired(): bool {
		return strtotime($this->valid_until) < time();
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
	
	public function Refresh(bool $force = false): void {
		if ($this->IsExpired() === false && $force === false) {
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
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM sentinel.oauth_tokens WHERE user_id = $1 AND provider = $2;', $this->user_id, $this->provider);
		$database->Commit();
	}
	
	protected static function Redeem(string $user_id, string $provider, array $fields, ?string $state = null) {
		$curl = null;
		switch ($provider) {
		case self::ProviderNitrado:
			$curl = curl_init('https://oauth.nitrado.net/oauth/v2/token');
			break;
		default:
			throw new \Exception("Unknown provider $provider.");
		}
		
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
		if ($state) {
			$database->Query('DELETE FROM sentinel.oauth_requests WHERE state = $1;', $state);
		}
		$database->Query('INSERT INTO sentinel.oauth_tokens (user_id, provider, access_token, valid_until, refresh_token) VALUES ($1, $2, $3, CURRENT_TIMESTAMP + $4::INTERVAL, $5) ON CONFLICT (user_id, provider) DO UPDATE SET access_token = EXCLUDED.access_token, valid_until = EXCLUDED.valid_until, refresh_token = EXCLUDED.refresh_token;', $user_id, $provider, $access_token, "$expires_in seconds", $refresh_token);
		$database->Commit();
	}
}

?>