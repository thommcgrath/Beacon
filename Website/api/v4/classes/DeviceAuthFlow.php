<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class DeviceAuthFlow extends DatabaseObject {
	use AuthFlow;

	protected string $deviceCode;
	protected string $applicationId;
	protected array $scopes;
	protected float $expiration;
	protected float $expiresIn;
	protected ?string $publicKey;
	protected ?string $userId;
	protected ?string $privateKeyEncrypted;

	// Caches
	protected ?User $user = null;
	protected ?Application $application = null;

	public function __construct(BeaconRecordSet $row) {
		$this->deviceCode = $row->Field('device_code');
		$this->applicationId = $row->Field('application_id');
		$this->scopes = explode(' ', $row->Field('scopes'));
		$this->expiration = floatval($row->Field('expiration'));
		$this->expiresIn = floatval($row->Field('expires_in'));
		$this->publicKey = $row->Field('public_key');
		$this->userId = $row->Field('user_id');
		$this->privateKeyEncrypted = $row->Field('private_key_encrypted');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'public',
			table: 'device_auth_flows',
			definitions: [
				new DatabaseObjectProperty('deviceCode', ['primaryKey' => true, 'columnName' => 'device_code']),
				new DatabaseObjectProperty('applicationId', ['columnName' => 'application_id']),
				new DatabaseObjectProperty('scopes'),
				new DatabaseObjectProperty('expiration', ['accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('expiresIn', ['columnName' => 'expires_in', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.expiration - CURRENT_TIMESTAMP)']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('publicKey', ['columnName' => 'public_key']),
				new DatabaseObjectProperty('privateKeyEncrypted', ['columnName' => 'private_key_encrypted'])
			]
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'applicationId');

		if (isset($filters['deviceCode'])) {
			$deviceCodePlaceholder = $parameters->AddValue(static::HashDeviceCode($filters['deviceCode']));
			$parameters->clauses[] = 'device_auth_flows.device_code = $' . $deviceCodePlaceholder;
		}
	}

	public static function Fetch(string $deviceCode): ?static {
		if (BeaconUUID::Validate($deviceCode) === false) {
			$deviceCode = static::HashDeviceCode($deviceCode);
		}
		$flow = parent::Fetch($deviceCode);
		if (is_null($flow) || $flow->IsExpired()) {
			return null;
		}
		return $flow;
	}

	public static function CreateDeviceCode(): string {
		$rawDeviceCode = BeaconCommon::GenerateRandomKey(8, '23456789ABCDEFGHJKLMNPRSTUVWXYZ');
		return substr($rawDeviceCode, 0, 4) . '-' . substr($rawDeviceCode, 4, 4);
	}

	protected static function HashDeviceCode(string $deviceCode): string {
		return BeaconUUID::v5(strtolower($deviceCode), '024273a1-a96d-40ef-ba29-58c7690480dc');
	}

	public static function Create(string $rawDeviceCode, Application $app, array $scopes, ?string $publicKey): static {
		$hashedDeviceCode = static::HashDeviceCode($rawDeviceCode);

		if (in_array(Application::kScopeCommon, $scopes) === false) {
			$scopes[] = Application::kScopeCommon;
		}
		if ($app->HasScopes($scopes) === false) {
			throw new APIException(message: 'Application is not authorized for all requested scopes.', code: 'invalidScope', httpStatus: 400);
		}
		sort($scopes);

		if (in_array(Application::kScopeUsersPrivateKeyRead, $scopes)) {
			if (is_null($publicKey)) {
				throw new APIException(message: 'An RSA public key must be included when using the ' . Application::kScopeUsersPrivateKeyRead . ' scope.', code: 'invalidScope', httpStatus: 400);
			}

			// Do a test encrypt to make sure the key is valid
			try {
				$publicKey = BeaconEncryption::PublicKeyToPEM($publicKey);
				BeaconEncryption::RSAEncrypt($publicKey, 'testing');
			} catch (Exception $err) {
				throw new APIException(message: 'The supplied public key is not valid for encryption.', code: 'invalidPublicKey', httpStatus: 400);
			}
		} else {
			$publicKey = null;
		}

		$scopesString = implode(' ', $scopes);
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.device_auth_flows (device_code, application_id, scopes, public_key) VALUES ($1, $2, $3, $4);", $hashedDeviceCode, $app->ApplicationId(), $scopesString, $publicKey);
		$database->Commit();
		return static::Fetch($hashedDeviceCode);
	}

	public function FlowId(): string {
		return $this->deviceCode;
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

	public function IsExpired(): bool {
		return $this->expiresIn < 0;
	}

	public function ExpiresIn(): float {
		return $this->expiresIn;
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
		return is_null($this->userId) === false;
	}

	public function Authorize(string $deviceId, string $challenge, int $expiration, User $user, ?string $userPassword = null): string {
		if ($this->IsCompleted()) {
			throw new APIException(message: 'This authorization has already been completed. Start a new login process to try again.', code: 'flowCompleted', httpStatus: 400);
		}
		if ($this->IsExpired()) {
			throw new APIException(message: 'This authorization has expired.', code: 'flowExpired', httpStatus: 400);
		}

		$correctChallenge = $this->NewChallenge($deviceId, $user, $expiration);
		if ($expiration < time() || $challenge !== $correctChallenge) {
			throw new APIException(message: 'Authorization could not be completed because a challenge response was not correct. Start a new login process to try again.', code: 'challengeExpired', httpStatus: 400);
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
				throw new APIException(message: 'The provided password is not correct. Please try again with the correct password.', code: 'incorrectUserPassword', httpStatus: 403);
			}
		}
		if (is_null($privateKey) === false) {
			$privateKey = BeaconEncryption::RSAEncryptLargeMessage($this->publicKey, $privateKey);
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("UPDATE public.device_auth_flows SET user_id = $2, private_key_encrypted = $3 WHERE device_code = $1 AND expiration > CURRENT_TIMESTAMP;", $this->deviceCode, $user->UserId(), $privateKey);
		$database->Commit();

		$this->userId = $user->UserId();
		$this->user = $user;
		$this->privateKeyEncrypted = $privateKey;

		return BeaconCommon::AbsoluteUrl('/device?complete&appId=' . urlencode($this->applicationId));
	}

	public function Redeem(): Session {
		if ($this->IsCompleted() === false) {
			throw new APIException(message: 'This authorization is not completed.', code: 'authorizationPending', httpStatus: 412);
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$session = Session::Create($this->User(), $this->Application(), $this->scopes, $this->privateKeyEncrypted);
		$database->Query('DELETE FROM public.device_auth_flows WHERE device_code = $1;', $this->deviceCode);
		$database->Commit();

		return $session;
	}
}

?>
