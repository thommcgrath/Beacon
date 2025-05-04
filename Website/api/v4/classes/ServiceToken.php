<?php

namespace BeaconAPI\v4;
use BeaconChannelEvent, BeaconCommon, BeaconEncryption, BeaconPusher, BeaconRabbitMQ, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ServiceToken implements JsonSerializable {
	final const ProviderNitrado = 'Nitrado';
	final const ProviderGameServerApp = 'GameServerApp.com';

	final const TypeOAuth = 'OAuth';
	final const TypeStatic = 'Static';

	final const ExpirationBuffer = 86400;
	private const SelectColumns = 'service_tokens.token_id, service_tokens.user_id, users.username, service_tokens.provider, service_tokens.type, service_tokens.access_token, EXTRACT(EPOCH FROM service_tokens.access_token_expiration) AS access_token_expiration, service_tokens.refresh_token, EXTRACT(EPOCH FROM service_tokens.refresh_token_expiration) AS refresh_token_expiration, service_tokens.provider_specific, service_tokens.encryption_key, service_tokens.automatic, service_tokens.needs_replacing';
	private const FromClause = 'public.service_tokens INNER JOIN public.users ON (service_tokens.user_id = users.user_id)';

	protected string $tokenId;
	protected string $userId;
	protected string $userName;
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
	protected bool $automatic;
	protected bool $needsReplacing;

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
		$this->userName = $row->Field('username') ?? 'Anonymous';
		$this->provider = $row->Field('provider');
		$this->type = $row->Field('type');
		$this->accessTokenEncrypted = $row->Field('access_token');
		$this->refreshTokenEncrypted = $row->Field('refresh_token');
		$this->accessTokenExpiration = is_null($row->Field('access_token_expiration')) ? null : intval($row->Field('access_token_expiration'));
		$this->refreshTokenExpiration = is_null($row->Field('refresh_token_expiration')) ? null : intval($row->Field('refresh_token_expiration'));
		$this->providerSpecific = json_decode($row->Field('provider_specific'), true);
		$this->automatic = $row->Field('automatic');
		$this->needsReplacing = $row->Field('needs_replacing');

		$this->encryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($row->Field('encryption_key')));
		$this->accessToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($this->accessTokenEncrypted));
		if (is_null($this->refreshTokenEncrypted) === false) {
			$this->refreshToken = BeaconEncryption::SymmetricDecrypt($this->encryptionKey, base64_decode($this->refreshTokenEncrypted));
		}
	}

	protected static function OAuthTokenId(string $userId, string $provider, array $providerSpecific): string {
		$uuidParts = [
			$userId,
			$provider
		];
		if ($provider === self::ProviderNitrado) {
			$uuidParts[] = $providerSpecific['user']['id'];
		}
		return BeaconUUID::v5(implode('|', $uuidParts));
	}

	protected static function StaticTokenId(string $userId, string $provider, string $accessToken): string {
		$uuidParts = [
			$userId,
			$provider,
			$accessToken
		];
		return BeaconUUID::v5(implode('|', $uuidParts));
	}

	public static function StoreOAuth(string|User $user, string $provider, string $accessToken, string $refreshToken, int $accessTokenExpiration, int $refreshTokenExpiration, array $providerSpecific, bool $updateExisting = true): ?static {
		$userId = is_string($user) ? $user : $user->UserId();
		$tokenId = static::OAuthTokenId($user, $provider, $providerSpecific);

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
			$database->Query("UPDATE public.service_tokens SET access_token = $2, refresh_token = $3, access_token_expiration = TO_TIMESTAMP($4), refresh_token_expiration = TO_TIMESTAMP($5), provider_specific = $6, needs_replacing = FALSE WHERE token_id = $1;", $tokenId, $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific));
		} else {
			$database->Query("INSERT INTO public.service_tokens (token_id, user_id, provider, type, access_token, refresh_token, access_token_expiration, refresh_token_expiration, provider_specific, encryption_key) VALUES ($1, $2, $3, $4, $5, $6, TO_TIMESTAMP($7), TO_TIMESTAMP($8), $9, $10);", $tokenId, $userId, $provider, 'OAuth', $accessTokenEncrypted, $refreshTokenEncrypted, $accessTokenExpiration, $refreshTokenExpiration, json_encode($providerSpecific), $encryptedEncryptionKey);
		}
		$database->Commit();
		BeaconPusher::SharedInstance()->SendEvents([
			new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($userId), eventName: 'service-tokens-updated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($userId), eventName: 'serviceTokensUpdated', body: null),
		]);

		return static::Fetch($tokenId);
	}

	public static function StoreStatic(string|User $user, string $provider, string $accessToken, array $providerSpecific, bool $updateExisting = true): ?static {
		$userId = is_string($user) ? $user : $user->UserId();
		$tokenId = static::StaticTokenId($user, $provider, $accessToken);

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
			$database->Query("UPDATE public.service_tokens SET access_token = $2, provider_specific = $3, needs_replacing = FALSE WHERE token_id = $1;", $tokenId, $accessTokenEncrypted, json_encode($providerSpecific));
		} else {
			$database->Query("INSERT INTO public.service_tokens (token_id, user_id, provider, type, access_token, provider_specific, encryption_key) VALUES ($1, $2, $3, $4, $5, $6, $7);", $tokenId, $userId, $provider, 'Static', $accessTokenEncrypted, json_encode($providerSpecific), $encryptedEncryptionKey);
		}
		$database->Commit();
		BeaconPusher::SharedInstance()->SendEvents([
			new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($userId), eventName: 'service-tokens-updated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($userId), eventName: 'serviceTokensUpdated', body: null),
		]);

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
		$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM ' . self::FromClause . ' WHERE service_tokens.token_id = $1;', $tokenId);
		if ($rows->RecordCount() !== 1) {
			return null;
		}

		try {
			return new static($rows);
		} catch (Exception $err) {
			return null;
		}
	}

	public static function ResolveAlias(string $oldTokenId): ?string {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT new_service_token_id FROM public.service_token_aliases WHERE old_service_token_id = $1;', $oldTokenId);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('new_service_token_id');
		} else {
			return null;
		}
	}

	public static function Lookup(string $userId, ?string $provider = null, ?string $tokenId = null): array {
		$database = BeaconCommon::Database();
		$placeholder = 2;
		$clauses = ['service_tokens.user_id = $1'];
		$values = [$userId];
		if (is_null($provider) === false) {
			$clauses[] = 'service_tokens.provider = $' . $placeholder++;
			$values[] = $provider;
		}
		if (is_null($tokenId) === false) {
			$tokensSplit = preg_split('/[ ,]/', $tokenId); // Some beta versions of Beacon 2.0.0 used spaces.
			$tokenIds = [];
			foreach ($tokensSplit as $tokenId) {
				if (BeaconUUID::Validate($tokenId)) {
					$tokenIds[] = $tokenId;
				}
			}
			if (count($tokenIds) > 0) {
				$clauses[] = 'service_tokens.token_id = ANY($' . $placeholder++ . ')';
				$values[] = '{' . implode(',', $tokenIds) . '}';
			}
		}

		$rows = $database->Query('SELECT ' . self::SelectColumns . ' FROM ' . self::FromClause . ' WHERE ' . implode(' AND ', $clauses) . ' ORDER BY service_tokens.token_id;', $values);
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
		// Refreshes tokens that are near their refresh token expiration

		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . self::SelectColumns . ' FROM ' . self::FromClause . ' WHERE service_tokens.refresh_token_expiration IS NOT NULL AND service_tokens.refresh_token_expiration < CURRENT_TIMESTAMP + $1::INTERVAL AND service_tokens.refresh_token_expiration > CURRENT_TIMESTAMP AND service_tokens.needs_replacing = FALSE;', self::ExpirationBuffer . ' seconds');

		while (!$results->EOF()) {
			$token = null;
			try {
				$token = new static($results);
			} catch (Exception $err) {
			}
			if (is_null($token) === false) {
				try {
					$token->Refresh(true);
				} catch (Exception $err) {
					$token->MarkNeedsReplacing();
				}
			}
			$results->MoveNext();
		}
	}

	public function MoveToUser(string|User $user): void {
		if ($user instanceof User) {
			$userId = $user->UserId();
		} else {
			$userId = $user;
			$user = User::Fetch($user);
		}
		switch ($this->type) {
		case self::TypeOAuth:
			$newTokenId = static::OAuthTokenId($userId, $this->provider, $this->providerSpecific);
			break;
		case self::TypeStatic:
			$newTokenId = static::StaticTokenId($userId, $this->provider, $this->accessToken);
			break;
		default:
			return;
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('SELECT token_id FROM public.service_tokens WHERE token_id = $1;', $newTokenId);
		if ($rows->RecordCount() === 0) {
			// The new account does not have the token, so we update it
			$database->Query('UPDATE public.service_tokens SET user_id = $2, token_id = $3 WHERE token_id = $1;', $this->tokenId, $userId, $newTokenId);
		} else {
			// The new account already has a token with the same uuid, so we delete this one instead
			$database->Query('DELETE FROM public.service_tokens WHERE token_id = $1;', $this->tokenId);
			$returnValue = false;
		}
		$rows = $database->Query('SELECT old_service_token_id, new_service_token_id FROM public.service_token_aliases WHERE old_service_token_id = $1;', $this->tokenId);
		if ($rows->RecordCount() === 0) {
			// There is no alias from the old id to the new id
			$database->Query('INSERT INTO public.service_token_aliases (old_service_token_id, new_service_token_id) VALUES ($1, $2);', $this->tokenId, $newTokenId);
		} elseif ($rows->Field('new_service_token_id') !== $newTokenId) {
			// There is an alias for the old id, but it puts to the wrong new id, so we update it
			$database->Query('UPDATE public.service_token_aliases SET new_service_token_id = $2 WHERE old_service_token_id = $1;', $this->tokenId, $newTokenId);
		}
		$database->Commit();

		BeaconPusher::SharedInstance()->SendEvents([
			new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($this->userId), eventName: 'service-tokens-updated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($userId), eventName: 'service-tokens-updated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($this->userId), eventName: 'serviceTokensUpdated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($user), eventName: 'serviceTokensUpdated', body: null),
		]);

		$this->tokenId = $newTokenId;
		$this->userId = $userId;
		$this->userName = $user->Username() ?? 'Anonymous';
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

	public function ProvidesServers(): bool {
		return in_array($this->provider, [self::ProviderNitrado, self::ProviderGameServerApp]);
	}

	public function NeedsReplacing(): bool {
		return $this->needsReplacing;
	}

	public function MarkNeedsReplacing(): void {
		if ($this->needsReplacing === true) {
			return;
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE public.service_tokens SET needs_replacing = TRUE WHERE token_id = $1;', $this->tokenId);
		$database->Commit();
		BeaconPusher::SharedInstance()->SendEvents([
			new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($this->userId), eventName: 'service-tokens-updated', body: null),
			new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($this->userId), eventName: 'serviceTokensUpdated', body: null),
		]);

		$this->needsReplacing = true;
	}

	public function JSON(bool $decrypted): array {
		$json = [
			'tokenId' => $this->tokenId,
			'userId' => $this->userId,
			'userName' => $this->userName,
			'provider' => $this->provider,
			'type' => $this->type,
			'accessToken' => $this->AccessToken($decrypted),
			'accessTokenExpiration' => $this->accessTokenExpiration,
			'providerSpecific' => $this->providerSpecific,
			'automatic' => $this->automatic,
			'providesServers' => $this->ProvidesServers(),
			'needsReplacing' => $this->needsReplacing,
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

		$newToken = static::Redeem($this->userId, $this->provider, $fields);
		$this->accessTokenEncrypted = $newToken->accessTokenEncrypted;
		$this->refreshTokenEncrypted = $newToken->refreshTokenEncrypted;
		$this->accessTokenExpiration = $newToken->accessTokenExpiration;
		$this->refreshTokenExpiration = $newToken->refreshTokenExpiration;
		$this->providerSpecific = json_decode(json_encode($newToken->providerSpecific), true);
		$this->encryptionKey = $newToken->encryptionKey;
		$this->accessToken = $newToken->accessToken;
		$this->refreshToken = $newToken->refreshToken;
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

		if ($status === 200 || $status === 204 || $status = 401) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.service_tokens WHERE token_id = $1;', $this->tokenId);
			$database->Commit();
			BeaconPusher::SharedInstance()->SendEvents([
				new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($this->userId), eventName: 'service-tokens-updated', body: null),
				new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($this->userId), eventName: 'serviceTokensUpdated', body: null),
			]);

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
			$refreshTokenExpiration = $accessTokenExpiration + 2592000; // This is a guess, 30 days
			return true;
		}

		return false;
	}
}

?>
