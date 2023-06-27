<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, DateTime, Exception, JsonSerializable;

class ApplicationAuthFlow extends DatabaseObject {
	protected $flowId = null;
	protected $applicationId = null;
	protected $application = null;
	protected $scopes = [];
	protected $callback = null;
	protected $state = null;
	protected $codeHash = null;
	protected $userId = null;
	protected $user = null;
	protected $expired = null;
	protected $codeVerifierHash = null;
	protected $codeVerifierMethod = null;
	protected $publicKey = null;
	protected $privateKeyEncrypted = null;
	
	public function __construct(BeaconRecordSet $row) {
		$this->flowId = $row->Field('flow_id');
		$this->applicationId = $row->Field('application_id');
		$this->scopes = explode(' ', $row->Field('scopes'));
		$this->callback = $row->Field('callback');
		$this->state = $row->Field('state');
		$this->codeHash = $row->Field('code_hash');
		$this->userId = $row->Field('user_id');
		$this->expired = $row->Field('expiration');
		$this->codeVerifierHash = $row->Field('verifier_hash');
		$this->codeVerifierMethod = $row->Field('verifier_hash_algorithm');
		$this->publicKey = $row->Field('public_key');
		$this->privateKeyEncrypted = $row->Field('private_key_encrypted');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'application_auth_flows', [
			new DatabaseObjectProperty('flowId', ['primaryKey' => true, 'columnName' => 'flow_id']),
			new DatabaseObjectProperty('applicationId', ['columnName' => 'application_id']),
			new DatabaseObjectProperty('scopes'),
			new DatabaseObjectProperty('callback'),
			new DatabaseObjectProperty('state'),
			new DatabaseObjectProperty('codeHash', ['columnName' => 'code_hash']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('expired', ['columnName' => 'expiration', 'accessor' => "(%%TABLE%%.%%COLUMN%% < CURRENT_TIMESTAMP)::BOOLEAN"]),
			new DatabaseObjectProperty('codeVerifierHash', ['columnName' => 'verifier_hash']),
			new DatabaseObjectProperty('codeVerifierMethod', ['columnName' => 'verifier_hash_algorithm']),
			new DatabaseObjectProperty('publicKey', ['columnName' => 'public_key']),
			new DatabaseObjectProperty('privateKeyEncrypted', ['columnName' => 'private_key_encrypted'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'applicationId');
		$parameters->AddFromFilter($schema, $filters, 'codeHash');
	}
	
	public static function Fetch(string $uuid): ?static {
		$flow = parent::Fetch($uuid);
		if (is_null($flow) || $flow->expired) {
			return null;
		}
		return $flow;
	}
	
	public static function Create(Application $app, array $scopes, string $callback, string $state, ?string $codeVerifierHash, ?string $codeVerifierMethod, ?string $publicKey): static {
		if ($app->CallbackAllowed($callback) === false) {
			throw new Exception('Redirect uri is not whitelisted.');
		}
		
		if (in_array(Application::kScopeCommon, $scopes) === false) {
			$scopes[] = Application::kScopeCommon;
		}
		if ($app->HasScopes($scopes) === false) {
			throw new Exception('Application is not authorized for all requested scopes.');
		}
		sort($scopes);
		
		if (is_null($codeVerifierHash) === false || is_null($codeVerifierMethod) === false) {
			if (is_null($codeVerifierMethod) || $codeVerifierMethod !== 'S256') {
				throw new Exception('Unsupported code verifier has method.');
			}
			if (is_null($codeVerifierHash) || strlen($codeVerifierHash) !== 43) {
				throw new Exception('Verifier hash should be 43 base64url characters.');
			}
		}
		
		if (in_array(Application::kScopeUsersPrivateKeyRead, $scopes)) {
			if (is_null($publicKey)) {
				throw new Exception('An RSA public key must be included when using the ' . Application::kScopeUsersPrivateKeyRead . ' scope.');
			}
			
			// Do a test encrypt to make sure the key is valid
			try {
				$publicKey = BeaconEncryption::PublicKeyToPEM($publicKey);
				BeaconEncryption::RSAEncrypt($publicKey, 'testing');
			} catch (Exception $err) {
				throw new Exception('The supplied public key is not valid for encryption.');
			}
		} else {
			$publicKey = null;
		}
		
		$flowId = BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.application_auth_flows (flow_id, application_id, scopes, callback, state, verifier_hash, verifier_hash_algorithm, public_key) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);", $flowId, $app->ApplicationId(), implode(' ', $scopes), $callback, $state, $codeVerifierHash, $codeVerifierMethod, $publicKey);
		$database->Commit();
		return static::Fetch($flowId);
	}
	
	public function FlowId(): string {
		return $this->flowId;
	}
	
	public function ApplicationId(): string {
		return $this->applicationId;
	}
	
	public function Application(): Application {
		if (is_null($this->application)) {
			$this->application = Application::Fetch($this->applicationId);
		}
		return $this->application;
	}
	
	public function Scopes(): array {
		return $this->scopes;
	}
	
	public function HasScope(string $scope): bool {
		return in_array($scope, $this->scopes);	
	}
	
	public function Callback(): string {
		return $this->callback;
	}
	
	public function State(): string {
		return $this->state;
	}
	
	public function CodeHash(): ?string {
		return $this->codeHash;
	}
	
	public function UserId(): ?string {
		return $this->userId;
	}
	
	public function User(): ?User {
		if (is_null($this->user)) {
			$this->user = User::Fetch($this->userId);
		}
		return $this->user;
	}
	
	public function IsCompleted(): bool {
		return is_null($this->codeHash) === false && is_null($this->userId) === false;
	}
	
	public function NewChallenge(string $deviceId, User $user, int $expiration): string {
		$challengeSecret = $this->Application()->Secret() ?? '';
		$challengeRaw = $deviceId . $expiration . $challengeSecret . $this->flowId . $user->UserId();
		return BeaconCommon::Base64UrlEncode(hash('sha3-512', $challengeRaw, true));
	}
	
	public function Authorize(string $deviceId, string $challenge, int $expiration, User $user, ?string $userPassword = null): string {
		if ($this->IsCompleted()) {
			throw new Exception('This authorization has already been completed. Start a new login process to try again.');
		}
		
		$correctChallenge = $this->NewChallenge($deviceId, $user, $expiration);
		if ($expiration < time() || $challenge !== $correctChallenge) {
			throw new Exception('Authorization could not be completed because a challenge response was not correct. Start a new login process to try again.');
		}
		
		$privateKey = null;
		if ($this->HasScope(Application::kScopeUsersPrivateKeyRead)) {
			try {
				if (is_string($userPassword)) {
					$privateKey = $user->DecryptPrivateKey($userPassword);
				}
			} catch (Exception $err) {
			}
			if (is_null($privateKey)) {
				throw new Exception('The provided password is not correct. Please try again with the correct password.');
			}
		}
		
		$code = BeaconEncryption::GenerateKey(256);
		if (is_null($privateKey) === false) {
			$privateKey = BeaconEncryption::RSAEncryptLargeMessage($this->publicKey, $privateKey);
		}
		$codeHash = static::PrepareCodeHash($this->applicationId, $this->Application()->Secret(), $this->callback, $code);
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("UPDATE public.application_auth_flows SET code_hash = $2, user_id = $3, expiration = CURRENT_TIMESTAMP(0) + '5 minutes'::INTERVAL, private_key_encrypted = $4 WHERE flow_id = $1 AND expiration > CURRENT_TIMESTAMP AND code_hash IS NULL;", $this->flowId, $codeHash, $user->UserId(), $privateKey);
		$database->Commit();
		
		$this->codeHash = $codeHash;
		$this->userId = $user->UserId();
		$this->user = $user;
		
		return $this->callback . (str_contains($this->callback, '?') ? '&' : '?') . http_build_query([
			'code' => BeaconCommon::Base64UrlEncode($code),
			'state' => $this->state
		]);
	}
	
	public static function Redeem(string $applicationId, ?string $applicationSecret, string $redirectUri, string $code, string $codeVerifier): Session {
		$app = Application::Fetch($applicationId);
		if (is_null($app)) {
			throw new Exception('Invalid client id.');
		}
		if (is_null($applicationSecret) && $app->IsConfidential()) {
			throw new Exception('Invalid client secret.');
		} else if (is_null($applicationSecret) === false && $app->IsConfidential() === false) {
			// Ignore a secret if provided
			$applicationSecret = null;
		}
		
		$codeHash = static::PrepareCodeHash($applicationId, $applicationSecret, $redirectUri, BeaconCommon::Base64UrlDecode($code));
		$flows = static::Search(['codeHash' => $codeHash], true);
		if (count($flows) !== 1) {
			throw new Exception('Authorization flow not found.');
		}
		$flow = $flows[0];
		
		if ($flow->CheckCodeVerifier($codeVerifier) !== true) {
			throw new Exception('Invalid code verifier.');
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$session = Session::Create($flow->User(), $flow->Application(), $flow->scopes, $flow->privateKeyEncrypted);
		$database->Query("DELETE FROM public.application_auth_flows WHERE flow_id = $1;", $flow->FlowId());
		$database->Commit();
		return $session;
	}
	
	protected static function PrepareCodeHash(string $applicationId, ?string $applicationSecret, string $redirectUri, string $code): string {
		if (is_null($applicationSecret) === false) {
			$applicationId = "{$applicationId}.{$applicationSecret}";
		}
		return BeaconCommon::Base64UrlEncode(hash('sha3-512', "{$applicationId}.{$redirectUri}.{$code}", true));
	}
	
	protected function CheckCodeVerifier(string $codeVerifier): bool {
		switch ($this->codeVerifierMethod) {
		case 'S256':
			return $this->codeVerifierHash === BeaconCommon::Base64UrlEncode(hash('sha256', $codeVerifier, true));
			break;
		default:
			return false;
		}
	}
}

?>
