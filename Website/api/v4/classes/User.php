<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconEmail, BeaconEncryption, BeaconRecordSet, BeaconShop, Exception, JsonSerializable;

class User extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Edit as protected MutableDatabaseObjectEdit;
		Validate as protected MutableDatabaseObjectValidate;
		HasPendingChanges as protected MutableDatabaseObjectHasPendingChanges;
		SaveChildObjects as protected MutableDatabaseObjectSaveChildObjects;
		CleanupChildObjects as protected MutableDatabaseObjectCleanupChildObjects;
	}

	protected $backupCodes = null;
	protected $backupCodesAdded = [];
	protected $backupCodesRemoved = [];
	protected $banned = false;
	protected $cloudKey = null;
	protected $deleteCloudFiles = false;
	protected $emailId = null;
	protected $enabled = true;
	protected $expiration = '';
	protected $licenses = [];
	protected $licensesLoaded = false;
	protected $privateKey = null;
	protected $privateKeyIterations = null;
	protected $privateKeySalt = null;
	protected $publicKey = '';
	protected $requirePasswordChange = false;
	protected ?array $signature = null;
	protected $userId = '';
	protected $username = null;

	public function __construct(BeaconRecordSet $row) {
		$this->backupCodes = null;
		$this->backupCodesAdded = [];
		$this->backupCodesRemoved = [];
		$this->banned = filter_var($row->Field('banned'), FILTER_VALIDATE_BOOL);
		$this->cloudKey = $row->Field('usercloud_key');
		$this->deleteCloudFiles = false;
		$this->emailId = $row->Field('email_id');
		$this->enabled = filter_var($row->Field('enabled'), FILTER_VALIDATE_BOOL);
		$this->expiration = '';
		$this->licenses = [];
		$this->licensesLoaded = false;
		$this->privateKey = $row->Field('private_key');
		$this->privateKeyIterations = filter_var($row->Field('private_key_iterations'), FILTER_VALIDATE_INT);
		$this->privateKeySalt = $row->Field('private_key_salt');
		$this->publicKey = $row->Field('public_key');
		$this->requirePasswordChange = filter_var($row->Field('require_password_change'), FILTER_VALIDATE_BOOL);
		$this->signature = null;
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username') ?? 'Anonymous';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'users', [
			new DatabaseObjectProperty('userId', ['primaryKey' => true, 'columnName' => 'user_id']),
			new DatabaseObjectProperty('emailId', ['columnName' => 'email_id', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('username', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('publicKey', ['columnName' => 'public_key', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('privateKey', ['columnName' => 'private_key', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('privateKeySalt', ['columnName' => 'private_key_salt', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('privateKeyIterations', ['columnName' => 'private_key_iterations', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('cloudKey', ['columnName' => 'usercloud_key', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('banned'),
			new DatabaseObjectProperty('enabled'),
			new DatabaseObjectProperty('requirePasswordChange', ['columnName' => 'require_password_change'])
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'emailId');

		if (isset($filters['userId|emailId']) || isset($filters['emailId|userId'])) {
			$parameters->clauses[] = '(' . $schema->Comparison('userId', '=', $parameters->placeholder) . ' OR ' . $schema->Comparison('emailId', '=', $parameters->placeholder++) . ')';
			$parameters->values[] = $filters['userId|emailId'] ?? $filters['emailId|userId'];
		}

		if (isset($filters['email']) && BeaconEmail::IsEmailValid($filters['email'])) {
			$parameters->clauses[] = $schema->Comparison('emailId', '=', '(SELECT uuid_for_email($' . $parameters->placeholder++ . '))');
			$parameters->values[] = $filters['email'];
		}

		if (isset($filters['username'])) {
			$username = strtok($filters['username'], '#');
			$suffix = strtok('#');

			$parameters->clauses[] = $schema->Comparison('username', '=', $parameters->placeholder++);
			$parameters->values[] = $username;

			if ($suffix !== false) {
				$parameters->clauses[] = 'SUBSTRING(LOWER(' . $schema->Accessor('userId') . '::TEXT) FROM 1 FOR 8) = $' . $parameters->placeholder++;
				$parameters->values[] = $suffix;
			}
		}
	}

	public static function Create(array $properties): static {
		if (BeaconCommon::HasAllKeys($properties, 'publicKey', 'cloudKey') === false) {
			throw new Exception('Missing required properties.');
		}
		$publicKey = BeaconEncryption::PublicKeyToPem($properties['publicKey']);
		$cloudKey = $properties['cloudKey'];
		if (BeaconCommon::IsHex($cloudKey) === false) {
			throw new Exception('Cloud key should be hex-encoded.');
		}

		$userId = $properties['userId'] ?? BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();

		if (BeaconCommon::HasAnyKeys($properties, 'email', 'username', 'privateKey', 'privateKeySalt', 'privateKeyIterations') === false) {
			// Anonymous
			$database->BeginTransaction();
			$database->Query("INSERT INTO public.users (user_id, public_key, usercloud_key) VALUES ($1, $2, $3);", $userId, $publicKey, $cloudKey);
			$database->Commit();
			return static::Fetch($userId);
		}

		if (BeaconCommon::HasAllKeys($properties, 'email', 'username', 'privateKey', 'privateKeySalt', 'privateKeyIterations') === false) {
			throw new Exception('Missing required properties.');
		}

		$username = $properties['username'];
		if (static::ValidateUsername($username) === false) {
			throw new Exception('Username must not contain a # character.');
		}

		$email = strtolower($properties['email']);
		if (BeaconEmail::IsEmailValid($email) === false) {
			throw new Exception('Email address is not valid.');
		}

		$privateKey = $properties['privateKey'];
		if (BeaconEncryption::IsEncrypted(hex2bin($privateKey)) === false) {
			throw new Exception('Private key is not encrypted.');
		}

		$privateKeySalt = $properties['privateKeySalt'];
		$privateKeyIterations = filter_var($properties['privateKeyIterations'], FILTER_VALIDATE_INT);
		if ($privateKeyIterations === false) {
			throw new Exception('Property privateKeyIterations should be a number');
		}

		$database->BeginTransaction();
		$database->Query("INSERT INTO public.users (user_id, public_key, usercloud_key, email_id, username, private_key, private_key_salt, private_key_iterations) VALUES ($1, $2, $3, uuid_for_email($4, TRUE), $5, $6, $7, $8);", $userId, $publicKey, $cloudKey, $email, $username, $privateKey, $privateKeySalt, $privateKeyIterations);
		$database->Commit();

		return static::Fetch($userId);
	}

	public function Edit(array $properties, bool $restoreDefaults = false): void {
		if (empty($properties['email']) === false) {
			$email = $properties['email'];
			if (BeaconEmail::IsEmailValid($email) === false) {
				throw new Exception('Email address is not valid.');
			}

			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$rows = $database->Query("SELECT uuid_for_email($1, TRUE) AS email_id;", $email);
			$database->Commit();

			$properties['emailId'] = $rows->Field('email_id');
		}

		static::MutableDatabaseObjectEdit($properties, $restoreDefaults);
	}

	protected function PropertiesForValidation(): array {
		return [
			'banned' => $this->banned,
			'cloudKey' => $this->cloudKey,
			'emailId' => $this->emailId,
			'enabled' => $this->enabled,
			'privateKey' => $this->privateKey,
			'privateKeyIterations' => $this->privateKeyIterations,
			'privateKeySalt' => $this->privateKeySalt,
			'publicKey' => $this->publicKey,
			'requirePasswordChange' => $this->requirePasswordChange,
			'userId' => $this->userId,
			'username' => $this->username,
		];
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (static::ValidateUsername($properties['username']) === false) {
			throw new Exception('Invalid username.');
		}
	}

	/* !Basic Properties */

	public function UserId(): string {
		return $this->userId;
	}

	public function PusherChannelName(): string {
		return 'user-' . strtolower(str_replace('-', '', $this->userId));
	}

	public function EmailId(): ?string {
		return $this->emailId;
	}

	public function SetEmailId(string $emailId): void {
		$this->SetProperty('emailId', $emailId);
	}

	public function SetEmailAddress(string $email): void {
		if (BeaconEmail::IsEmailValid($email) === false) {
			throw new Exception('Invalid email address.');
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
		$database->Commit();

		$this->SetEmailId($rows->Field('email_id'));
	}

	public function Suffix(): string {
		return substr($this->userId, 0, 8);
	}

	public function Username(bool $with_suffix = false): ?string {
		$name = $this->username;
		if ($with_suffix && is_string($name)) {
			$name .= '#' . $this->Suffix();
		}
		return $name;
	}

	public function SetUsername(string $username): void {
		$username = trim($username);
		if (static::ValidateUsername($username) === false) {
			throw new Exception('Invalid username.');
		}

		$this->SetProperty('username', $username);
	}

	public function PublicKey(): string {
		return $this->publicKey;
	}

	public function PrivateKey(): ?string {
		return $this->privateKey;
	}

	public function PrivateKeySalt(): ?string {
		return $this->privateKeySalt;
	}

	public function PrivateKeyIterations(): ?int {
		return $this->privateKeyIterations;
	}

	public function IsAnonymous(): bool {
		return empty($this->emailId);
	}

	public function Licenses(): array {
		$this->LoadLicenses();
		return $this->licenses;
	}

	public function LicenseForProductId(string $productId): array {
		$this->LoadLicenses();
		if (array_key_exists($productId, $this->licenses)) {
			return $this->licenses[$productId];
		}
	}

	public function IsBanned(): bool {
		return $this->banned;
	}

	public function IsEnabled(): bool {
		return $this->enabled;
	}

	public function IsCurator(): bool {
		$this->LoadLicenses();
		foreach ($this->licenses as $license) {
			if (($license->ProductFlags() & 8) === 8) {
				return true;
			}
		}
		return false;
	}

	public function CanSignIn(): bool {
		// Use the methods here so subclasses can override correctly.
		return $this->IsEnabled() === true && $this->RequiresPasswordChange() === false;
	}

	/* !Two Factor Authentication */

	public function Is2FAProtected(): bool {
		return Authenticator::UserIdHasAuthenticators($this->userId);
	}

	// $code may be a TOTP, backup code, or trusted device id
	public function Verify2FACode(string $code, bool $verifyOnly = false): bool {
		$authenticators = Authenticator::Search(['userId' => $this->userId], true);
		if (count($authenticators) === 0) {
			// If there are no authenticators, the account is not 2FA protected
			return false;
		}

		// Try regular authenticators first
		foreach ($authenticators as $authenticator) {
			if ($authenticator->TestCode($code)) {
				return true;
			}
		}

		// If it's a UUID, it's obviously not a backup code
		if (BeaconCommon::IsUUID($code) === true) {
			return $this->IsDeviceTrusted($code);
		}

		// Finally, try backup codes
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT * FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->userId, $code);
		if ($rows->RecordCount() === 1) {
			if ($verifyOnly === false) {
				$database->BeginTransaction();
				$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->userId, $code);
				$backupCodesRemoved[] = $code;
				$newCode = BeaconCommon::GenerateRandomKey(6);
				$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $this->userId, $newCode);
				$backupCodesAdded[] = $newCode;
				$database->Commit();
				if (is_null($this->backupCodes) === false) {
					$this->backupCodes = null;
					$this->Get2FABackupCodes(); // refreshes the cache
				}
			}
			return true;
		}

		return false;
	}

	// Returns true when there are changes that need to be committed
	public function Create2FABackupCodes(bool $commit = false): bool {
		// Cache the current codes
		$this->Get2FABackupCodes();

		$changed = false;
		while (count($this->backupCodes) < 10) {
			$code = BeaconCommon::GenerateRandomKey(6);
			$this->backupCodes[] = $code;
			$this->backupCodesAdded[] = $code;
			$changed = true;
		}

		if ($changed && $commit) {
			$this->Commit();
			return false;
		}

		return $changed;
	}

	public function Get2FABackupCodes(): array {
		if (is_null($this->backupCodes)) {
			$this->backupCodes = [];
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1;', $this->userId);
			while (!$rows->EOF()) {
				$this->backupCodes[] = $rows->Field('code');
				$rows->MoveNext();
			}
		}
		return $this->backupCodes;
	}

	public function Clear2FABackupCodes(bool $commit = false): void {
		$codes = $this->Get2FABackupCodes();
		foreach ($codes as $code) {
			$this->backupCodesRemoved[] = $code;
		}
		$this->backupCodes = [];

		if ($commit) {
			$this->Commit();
		}
	}

	/* !Cloud Files */

	public function CloudKey() {
		return $this->cloudKey;
	}

	public static function GenerateCloudKey(): string {
		return random_bytes(32);
	}

	public function HasFiles(): bool {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT COUNT(remote_path) AS num_files FROM usercloud WHERE remote_path LIKE $1 AND size_in_bytes > 0 AND deleted = FALSE;', '/' . $this->UserID() . '/%');
		return $results->Field('num_files') > 0;
	}

	public function HasEncryptedFiles(): bool {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT COUNT(remote_path) AS num_files FROM usercloud WHERE remote_path LIKE $1 AND size_in_bytes > 0 AND deleted = FALSE AND header IS NOT NULL;', '/' . $this->UserID() . '/%');
		return $results->Field('num_files') > 0;
	}

	/* !Passwords & Authentication */

	public function RequiresPasswordChange(): bool {
		return $this->requirePasswordChange;
	}

	public function DecryptPrivateKey(string $password): string {
		$privateKeySalt = hex2bin($this->privateKeySalt);
		$privateKeyIterations = $this->privateKeyIterations;
		$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
		try {
			$privateKeyPem = BeaconEncryption::SymmetricDecrypt($privateKeySecret, hex2bin($this->privateKey));

			if (strtolower(substr($privateKeyPem, 0, 4)) === '8a01') {
				$privateKeySalt = BeaconEncryption::GenerateSalt();
				$privateKeyIterations = rand(100000, 111111);
				$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
				$encryptedPrivateKey = BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false);

				$changes = [
					'privateKey' => bin2hex($encryptedPrivateKey),
					'privateKeySalt' => bin2hex($privateKeySalt),
					'privateKeyIterations' => $privateKeyIterations
				];

				$this->Edit($changes);
			}

			return $privateKeyPem;
		} catch (Exception $err) {
			throw new Exception('Incorrect password');
		}
	}

	public function TestPassword(string $password): bool {
		try {
			$this->DecryptPrivateKey($password);
			return true;
		} catch (Exception $err) {
			return false;
		}
	}

	/* !User Lookup */

	public static function Fetch(string $userId): ?static {
		$filters = [];
		$email = null;
		if (BeaconCommon::IsUUID($userId)) {
			$filters['userId|emailId'] = $userId;
		} else if (static::IsExtendedUsername($userId)) {
			$filters['username'] = $userId;
		} else {
			$filters['email'] = $userId;
			$email = $userId;
		}

		$users = static::Search($filters, true);
		if (count($users) !== 1) {
			return null;
		}

		$user = $users[0];
		if (is_null($email) === false) {
			$database = BeaconCommon::Database();
			$rows = $database->Query("SELECT email_needs_update($1::UUID) AS update_needed;", $user->EmailId());
			if (filter_var($rows->Field('update_needed'), FILTER_VALIDATE_BOOL)) {
				$database->BeginTransaction();
				$database->Query("SELECT uuid_for_email($1, TRUE);", $email);
				$database->Commit();
			}
		}

		return $user;
	}

	/* !Validation */

	public static function ValidateUsername(string $username): bool {
		return str_contains($username, '#') === false && strlen($username) < 64;
	}

	public static function ValidatePassword(string $password): bool {
		return mb_strlen($password) >= 8;
	}

	public static function IsExtendedUsername(string $username): bool {
		return preg_match('/#[a-fA-F0-9]{8}$/', $username) === 1;
	}

	/* !Everything Else */

	protected function HasPendingChanges(): bool {
		return static::MutableDatabaseObjectHasPendingChanges() || count($this->backupCodesAdded) > 0 || count($this->backupCodesRemoved) > 0;
	}

	protected function SaveChildObjects(): void {
		static::MutableDatabaseObjectSaveChildObjects();

		foreach ($this->backupCodesRemoved as $code) {
			$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->userId, $code);
		}

		foreach ($this->backupCodesAdded as $code) {
			$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $this->userId, $code);
		}
	}

	protected function CleanupChildObjects(): void {
		static::MutableDatabaseObjectCleanupChildObjects();

		$this->backupCodesAdded = [];
		$this->backupCodesRemoved = [];
	}

	public function CheckSignature(string $data, string $signature): bool {
		return BeaconEncryption::RSAVerify($this->publicKey, $data, $signature);
	}

	public function jsonSerialize(): mixed {
		$json = [
			'userId' => $this->userId,
			'username' => $this->Username(false),
			'usernameFull' => $this->Username(true),
			'isAnonymous' => $this->IsAnonymous(),
			'publicKey' => $this->publicKey,
			'banned' => $this->banned,
			'signature' => $this->signature,
			'licenses' => $this->licenses,
		];
		if (empty($this->expiration) === false) {
			$json['expiration'] = $this->expiration;
		}
		return $json;
	}

	public function LoadLicenses(): void {
		if ($this->licensesLoaded === true) {
			return;
		}

		$this->licenses = License::Search(['userId' => $this->userId], true);
		$this->licensesLoaded = true;
	}

	public function PrepareSignatures(string $deviceId): void {
		if (is_null($this->signature) === false) {
			return;
		}

		$this->LoadLicenses();

		$userId = strtolower($this->UserID());
		$fieldNames = ['deviceId', 'userId', 'licenses', 'banned'];
		$fieldValues = [$deviceId, $userId, $this->licenses, $this->banned];
		if (empty($this->expiration) === false) {
			$fieldNames[] = 'expiration';
			$fieldValues[] = $this->expiration;
		}
		$stringToSign = json_encode($fieldValues);

		if (openssl_sign($stringToSign, $signature, BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signature = [
				'fields' => $fieldNames,
				'signed' => BeaconCommon::Base64UrlEncode($signature),
			];
		}
	}

	/* ! Trusted Devices */

	public function TrustDevice(string $deviceId): void {
		$database = BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($deviceId);
		$database->BeginTransaction();
		$database->Query('INSERT INTO public.trusted_devices (device_id_hash, user_id) VALUES ($1, $2) ON CONFLICT (device_id_hash) DO NOTHING;', $device_hash, $this->UserID());
		$database->Commit();
	}

	public function UntrustDevice(string $deviceId): void {
		$database = BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($deviceId);
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.trusted_devices WHERE device_id_hash = $1 AND user_id = $2;', $device_hash, $this->UserID());
		$database->Commit();
	}

	public function UntrustAllDevices(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.trusted_devices WHERE user_id = $1;', $this->UserID());
		$database->Commit();
	}

	public function IsDeviceTrusted(string $deviceId): bool {
		$database = BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($deviceId);
		$rows = $database->Query('SELECT device_id_hash FROM public.trusted_devices WHERE device_id_hash = $1 AND user_id = $2;', $device_hash, $this->UserId());
		return $rows->RecordCount() === 1;
	}

	protected function PrepareDeviceHash(string $deviceId): string {
		return base64_encode(hash('sha3-512', strtolower($deviceId) . strtolower($this->userId), true));
	}
}

?>
