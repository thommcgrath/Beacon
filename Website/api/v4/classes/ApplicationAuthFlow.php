<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime, Exception, JsonSerializable;

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
			new DatabaseObjectProperty('codeVerifierMethod', ['columnName' => 'verifier_hash_algorithm'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
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
	
	public static function Create(Application $app, array $scopes, string $callback, string $state, string $codeVerifierHash, string $codeVerifierMethod): static {
		if ($app->CallbackAllowed($callback) === false) {
			throw new Exception('Redirect uri is not whitelisted');
		}
		
		if (in_array(Application::kScopeCommon, $scopes) === false) {
			$scopes[] = Application::kScopeCommon;
		}
		if ($app->HasScopes($scopes) === false) {
			throw new Exception('Application is not authorized for all requested scopes');
		}
		sort($scopes);
		
		if ($codeVerifierMethod !== 'S256') {
			throw new Exception('Unsupported code verifier has method');
		}
		if (strlen($codeVerifierHash) !== 43) {
			throw new Exception('Verifier hash should be 43 base64url characters.');
		}
		
		$flowId = BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.application_auth_flows (flow_id, application_id, scopes, callback, state, verifier_hash, verifier_hash_algorithm) VALUES ($1, $2, $3, $4, $5, $6, $7);", $flowId, $app->ApplicationId(), implode(' ', $scopes), $callback, $state, $codeVerifierHash, $codeVerifierMethod);
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
		$challengeSecret = $this->Application()->Secret();
		$challengeRaw = $deviceId . $expiration . $challengeSecret . $this->flowId . $user->UserId();
		return base64_encode(hash('sha3-512', $challengeRaw, true));
	}
	
	public function Authorize(string $deviceId, string $challenge, int $expiration, User $user): string {
		if ($this->IsCompleted()) {
			throw new Error('Authorization has already been completed');
		}
		
		$correctChallenge = $this->NewChallenge($deviceId, $user, $expiration);
		if ($expiration < time() || $challenge !== $correctChallenge) {
			throw new Error('Incorrect challenge');
		}
		
		$code = BeaconCommon::GenerateUUID();
		$codeHash = static::PrepareCodeHash($this->applicationId, $this->Application()->Secret(), $this->callback, $code);
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM public.application_auth_flows WHERE expiration < CURRENT_TIMESTAMP;");
		$database->Query("UPDATE public.application_auth_flows SET code_hash = $2, user_id = $3, expiration = CURRENT_TIMESTAMP(0) + '5 minutes'::INTERVAL WHERE flow_id = $1 AND expiration > CURRENT_TIMESTAMP AND code_hash IS NULL;", $this->flowId, $codeHash, $user->UserId());
		$database->Commit();
		
		$this->codeHash = $codeHash;
		$this->userId = $user->UserId();
		$this->user = $user;
		
		return $this->callback . (str_contains($this->callback, '?') ? '&' : '?') . http_build_query([
			'code' => $code,
			'state' => $this->state
		]);
	}
	
	public static function Redeem(string $applicationId, ?string $applicationSecret, string $redirectUri, string $code, string $codeVerifier): Session {
		if (is_null($applicationSecret)) {
			$app = Application::Fetch($applicationId);
			if (!$app) {
				throw new Exception('Invalid client');
			}
			$applicationSecret = $app->Secret();
		}
		
		$codeHash = static::PrepareCodeHash($applicationId, $applicationSecret, $redirectUri, $code);
		$flows = static::Search(['codeHash' => $codeHash], true);
		if (count($flows) !== 1) {
			throw new Exception('Authorization flow not found');
		}
		$flow = $flows[0];
		
		if ($flow->CheckCodeVerifier($codeVerifier) !== true) {
			throw new Exception('Invalid code verifier');
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$session = Session::Create($flow->User(), $flow->Application(), $flow->scopes);
		$database->Query("DELETE FROM public.application_auth_flows WHERE flow_id = $1 OR expiration < CURRENT_TIMESTAMP;", $flow->FlowId());
		$database->Commit();
		return $session;
	}
	
	protected static function PrepareCodeHash(string $applicationId, string $applicationSecret, string $redirectUri, string $code): string {
		return base64_encode(hash('sha3-512', "{$applicationId}.{$applicationSecret}.{$redirectUri}.{$code}", true));
	}
	
	protected function CheckCodeVerifier(string $codeVerifier): bool {
		switch ($this->codeVerifierMethod) {
		case 'S256':
			$base64 = base64_encode(hash('sha256', $codeVerifier, true));
			if ($base64 === false) {
				return false;
			}
			return $this->codeVerifierHash === str_replace(['+', '/', '='], ['-', '_', ''], $base64);
			break;
		default:
			return false;
		}
	}
}

?>
