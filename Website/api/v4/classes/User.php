<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconEmail, BeaconEncryption, BeaconRecordSet, BeaconShop, Exception;

class User implements \JsonSerializable {
	const ARK_FREE = false;
	const ARK2_FREE = false;
	
	protected $banned = false;
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
	protected $signatures = [];
	protected $userId = '';
	protected $cloudKey = null;
	protected $deleteCloudFiles = false;
	protected $username = null;
	protected $backupCodes = null;
	protected $backupCodesAdded = [];
	protected $backupCodesRemoved = [];
	
	public function __construct($source = null) {
		if ($source instanceof BeaconRecordSet) {
			$this->userId = $source->Field('user_id');
			$this->username = $source->Field('username');
			$this->emailId = $source->Field('email_id');
			$this->publicKey = $source->Field('public_key');
			$this->privateKey = $source->Field('private_key');
			$this->privateKeySalt = $source->Field('private_key_salt');
			$this->privateKeyIterations = intval($source->Field('private_key_iterations'));
			$this->cloudKey = $source->Field('usercloud_key');
			$this->banned = $source->Field('banned');
			$this->enabled = $source->Field('enabled');
			$this->requirePasswordChange = $source->Field('require_password_change');
		} elseif (is_string($source) && BeaconCommon::IsUUID($source)) {
			$this->userId = $source;
		} elseif (is_null($source)) {
			$this->userId = BeaconCommon::GenerateUUID();
		}
	}
	
	/* !Basic Properties */
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function EmailId(): string {
		return $this->emailId;
	}
	
	public function SetEmailId(string $emailId): bool {
		if (BeaconCommon::IsUUID($emailId)) {
			$this->emailId = $emailId;
			return true;
		}
		return false;
	}
	
	public function SetEmailAddress(string $email): bool {
		if (BeaconEmail::IsEmailValid($email)) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
			$database->Commit();
			$this->emailId = $results->Field('email_id');
			return true;
		}
		return false;
	}
	
	public function Suffix(): string {
		return substr($this->userId, 0, 8);
	}
	
	public function Username(bool $with_suffix = false): string {
		$name = $this->username;
		if ($with_suffix) {
			$name .= '#' . $this->Suffix();
		}
		return $name;
	}
	
	public function SetUsername(string $username): bool {
		$this->username = trim($username);
		return true;
	}
	
	public function PublicKey(): string {
		return $this->publicKey;
	}
	
	public function SetPublicKey(string $public_key): bool {
		if (is_null($this->publicKey) || $public_key !== $this->publicKey) {
			$this->publicKey = $public_key;
			return true;
		}
		return false;
	}
	
	public function PrivateKey(): ?stirng {
		return $this->privateKey;
	}
	
	public function SetPrivateKey(string $encrypted_private_key, string $salt, int $iterations): bool {
		$this->privateKey = $encrypted_private_key;
		$this->privateKeySalt = $salt;
		$this->privateKeyIterations = $iterations;
		return true;
	}
	
	public function DecryptedPrivateKey(string $password): ?string {
		$hash = BeaconEncryption::HashFromPassword($password, hex2bin($this->privateKeySalt), $this->privateKeyIterations);
		try {
			$decrypted = BeaconEncryption::SymmetricDecrypt($hash, hex2bin($this->privateKey));
			if (is_null($decrypted)) {
				return null;
			}
			return $decrypted;
		} catch (Exception $e) {
			return null;
		}
	}
	
	public function SetDecryptedPrivateKey(string $password, string $privateKey): bool {
		$salt = BeaconEncryption::GenerateSalt();
		$iterations = 12000;
		$hash = BeaconEncryption::HashFromPassword($password, $salt, $iterations);
		$encrypted = bin2hex(BeaconEncryption::SymmetricEncrypt($hash, $privateKey, false));
		$salt = bin2hex($salt);
		
		// test if the public key needs to be changed
		try {
			$testValue = BeaconCommon::GenerateUUID();
			$signature = BeaconEncryption::RSASign($privateKey, $testValue);
			$verified = BeaconEncryption::RSAVerify($this->publicKey, $testValue, $signature);
		} catch (Exception $err) {
			$verified = false;
		}
		if ($verified === false) {
			$newPublicKey = BeaconEncryption::ExtractPublicKey($privateKey);
			if (is_null($newPublicKey) === false) {
				$this->publicKey = $newPublicKey;
				$this->SetDecryptedCloudKey(self::GenerateCloudKey());
			} else {
				return false;
			}
		}
		
		$this->privateKeySalt = $salt;
		$this->privateKeyIterations = $iterations;
		$this->privateKey = $encrypted;
		
		return true;
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
	
	public function LicenseInfo(string $productId): array {
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
	
	public function SetIsEnabled(bool $enabled): bool {
		$this->enabled = $enabled;
		return true;
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
	
	public function CloudUserId() {
		return $this->userId;
	}
	
	public function CloudKey() {
		return $this->cloudKey;
	}
	
	public function SetCloudKey(string $key, bool $delete_files = true): bool {
		$this->cloudKey = $key;
		$this->deleteCloudFiles = $delete_files;
		return true;
	}
	
	public function DecryptedCloudKey(string $privateKey): ?string {
		try {
			return BeaconEncryption::RSADecrypt($privateKey, hex2bin($this->cloudKey));
		} catch (Exception $err) {
			return null;
		}
	}
	
	public function SetDecryptedCloudKey(string $key, bool $delete_files = true): bool {
		try {
			$this->cloudKey = bin2hex(BeaconEncryption::RSAEncrypt($this->publicKey, $key));
			$this->deleteCloudFiles = $delete_files;
			return true;
		} catch (Exception $err) {
			return false;
		}
	}
	
	public static function GenerateCloudKey(): string {
		return random_bytes(128);
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
	
	public function SetRequiresPasswordChange(bool $required): bool {
		$this->requirePasswordChange = $required;
		return true;
	}
	
	public function TestPassword(string $password): bool {
		$decrypted = $this->DecryptedPrivateKey($password);
		if (is_null($decrypted)) {
			return false;
		}
		
		if (Core::UsesLegacyEncryption() === false && strtolower(substr($decrypted, 0, 4)) === '8a01') {
			$this->SetDecryptedPrivateKey($password, $decrypted, Core::UsesLegacyEncryption());
		}
		
		return true;
	}
	
	public function ReplacePassword(string $password, string $privateKey, ?string $cloudKey): bool {
		if (empty($this->emailId)) {
			return false;
		}
		
		if (is_null($cloudKey)) {
			$cloudKey = static::GenerateCloudKey();
		}
		
		if ($this->SetDecryptedPrivateKey($password, $privateKey)) {
			$this->SetDecryptedCloudKey($cloudKey);
			$this->SetRequiresPasswordChange(false);
			return true;
		} else {
			return false;
		}
	}
	
	public function AddAuthentication(string $username, string $email, string $password, string $privateKey): bool {
		if (empty($this->privateKey) == false) {
			return false;
		}
		
		try {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			if (BeaconCommon::IsUUID($email)) {
				$emailId = $email;
			} else {
				$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
				$emailId = $results->Field('email_id');
			}
			
			if (empty($username)) {
				if (empty($this->username)) {
					$database = BeaconCommon::Database();
					$results = $database->Query('SELECT generate_username() AS username;');
					$username = $results->Field('username');
				} else {
					$username = $this->username;
				}
			}
			
			$this->SetDecryptedPrivateKey($password, $privateKey);
			$this->SetDecryptedCloudKey(static::GenerateCloudKey());
			$this->SetRequiresPasswordChange(false);
			$database->Commit();
			
			$this->username = $username;
			$this->emailId = $emailId;
			
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	public function ChangePassword(string $oldPassword, string $newPassword, bool $regeneratePrivateKey = false): bool {
		try {
			$privateKey = $this->DecryptedPrivateKey($oldPassword);
			if (is_null($privateKey)) {
				return false;
			}
			
			if ($regeneratePrivateKey) {
				$cloudKey = $this->DecryptedCloudKey($privateKey);
				if (is_null($cloudKey)) {
					return false;
				}
				
				$publicKey = null;
				$privateKey = null;
				BeaconEncryption::GenerateKeyPair($publicKey, $privateKey);
					
				$this->SetPublicKey($publicKey);
				$this->SetDecryptedCloudKey($cloudKey, false);
			}
			$this->SetDecryptedPrivateKey($newPassword, $privateKey);
			$this->SetRequiresPasswordChange(false);
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	/* !User Lookup */
	
	public static function Fetch(string $userId): ?static {
		$database = BeaconCommon::Database();
		if (BeaconCommon::IsUUID($userId)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE user_id = $1 OR email_id = $1;', $userId);
		} else if (BeaconEmail::IsEmailValid($userId)) {
			// When doing a SELECT with uuid_for_email(email, create), you must wrap it in its own SELECT statement.
			// This is because the function is VOLATILE and will be executed for every row in the user table unless
			// treated as a subquery. Or omit the second parameter, which is a STABLE function and performs fine.
			// The second parameter should only be used when updating the email row is desired.
			
			$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $userId);
			if ($results->RecordCount() !== 1 || is_null($results->Field('email_id'))) {
				return null;
			}
			$emailId = $results->Field('email_id');
			
			$results = $database->Query('SELECT email_needs_update($1::UUID) AS update_needed;', $emailId);
			if ($results->RecordCount() !== 1 || is_null($results->Field('update_needed'))) {
				return null;
			}
			if ($results->Field('update_needed')) {
				$database->BeginTransaction();
				$database->Query('SELECT uuid_for_email($1, TRUE);', $email);
				$database->Commit();
			}
			
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE email_id = $1;', $emailId);
		} else if (static::IsExtendedUsername($userId)) {
			$displayName = substr($userId, 0, -9);
			$suffix = strtolower(substr($userId, -8));
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE username = $1 AND SUBSTRING(LOWER(user_id::TEXT) FROM 1 FOR 8) = $2;', $displayName, $suffix);
		} else {
			return null;
		}
		if ($results->RecordCount() === 1) {
			return new static($results);
		}
		return null;
	}
	
	/* !Validation */
	
	public static function ValidatePassword(string $password): bool {
		$passlen = strlen($password);
		
		if ($passlen < 8 || $passlen > 256) {
			return false;
		}
		
		$chars = count_chars($password);
		foreach ($chars as $char => $count) {
			$percent = $count / $passlen;
			if ($percent > 0.3) {
				return false;
			}
		}
		
		return true;
	}
	
	public static function IsExtendedUsername(string $username): bool {
		return preg_match('/#[a-fA-F0-9]{8}$/', $username) === 1;
	}
	
	/* !Everything Else */
	
	public function Commit(): bool {
		$original_user = static::Fetch($this->userId);
		$changes = [];
		$database = BeaconCommon::Database();
		
		if (is_null($original_user)) {
			$changes['user_id'] = $this->userId;
			$changes['username'] = $this->username;
			$changes['email_id'] = $this->emailId;
			$changes['public_key'] = $this->publicKey;
			$changes['private_key'] = $this->privateKey;
			$changes['private_key_salt'] = $this->privateKeySalt;
			$changes['private_key_iterations'] = $this->privateKeyIterations;
			$changes['usercloud_key'] = $this->cloudKey;
			$changes['enabled'] = $this->enabled;
			$changes['require_password_change'] = $this->requirePasswordChange;
			try {
				$database->Insert('users', $changes);
				if (is_null($this->backupCodes) === false) {
					foreach ($this->backupCodes as $code) {
						$database->Insert('public.user_backup_codes', ['user_id' => $this->userId, 'code' => $code]);
					}
				}
			} catch (Exception $e) {
				return false;
			}
		} else {
			$keys = ['username', 'email_id', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations', 'usercloud_key', 'enabled', 'require_password_change'];
			foreach ($keys as $key) {
				if ($this->$key !== $original_user->$key) {
					$changes[$key] = $this->$key;
				}
			}
			if (count($changes) === 0 && count($this->backupCodesAdded) === 0 && count($this->backupCodesRemoved) === 0) {
				return true;
			}
			try {
				$database->BeginTransaction();
				
				if (count($changes) > 0) {
					$database->Update('users', $changes, ['user_id' => $this->userId]);
					if (array_key_exists('private_key', $changes)) {
						$database->Query('DELETE FROM email_verification WHERE email_id = $1;', $this->emailId);
					}
					
					if (array_key_exists('usercloud_key', $changes) && $this->deleteCloudFiles === true) {
						// The cloud key has been changed, so we need to cleanup the cloud files
						$cloud_files = BeaconCloudStorage::ListFiles('/' . $this->UserID() . '/');
						foreach ($cloud_files as $file) {
							if ($file['deleted'] === false && is_null($file['header']) === false) {
								BeaconCloudStorage::DeleteFile($file['path']);
							}
						}
					}
				}
				
				foreach ($this->backupCodesRemoved as $code) {
					$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->userId, $code);
				}
				
				foreach ($this->backupCodesAdded as $code) {
					$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $this->userId, $code);
				}
				
				$database->Commit();
			} catch (Exception $e) {
				return false;
			}
		}
		$this->deleteCloudFiles = false;
		$this->backupCodesAdded = [];
		$this->backupCodesRemoved = [];
		
		return true;
	}
	
	public function CheckSignature(string $data, string $signature): bool {
		return BeaconEncryption::RSAVerify($this->publicKey, $data, $signature);
	}
	
	protected static function SQLColumns(): array {
		return [
			'users.user_id',
			'users.email_id',
			'users.username',
			'users.public_key',
			'users.private_key',
			'users.private_key_salt',
			'users.private_key_iterations',
			'users.usercloud_key',
			'users.banned',
			'users.enabled',
			'users.require_password_change'
		];
	}
	
	public function jsonSerialize(): mixed {
		$arr = [
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->Username(true),
			'publicKey' => $this->publicKey,
			'privateKey' => $this->privateKey,
			'privateKeySalt' => $this->privateKeySalt,
			'privateKeyIterations' => $this->privateKeyIterations,
			'banned' => $this->banned,
			'signatures' => $this->signatures,
			'licenses' => $this->licenses,
			'cloudKey' => $this->cloudKey
		];
		if (empty($this->expiration) === false) {
			$arr['expiration'] = $this->expiration;
		}
		return $arr;
	}
	
	public function LoadLicenses(): void {
		if ($this->licensesLoaded === true) {
			return;
		}
		
		$this->licenses = License::Search(['userId' => $this->userId], true);
		$this->licensesLoaded = true;
	}
	
	public function PrepareSignatures(string $deviceId): void {
		if (count($this->signatures) !== 0) {
			return;
		}
		
		$this->LoadLicenses();
		
		$userId = strtolower($this->UserID());
		
		// signature v3
		$licenseHashMembers = [];
		foreach ($this->licenses as $license) {
			$licenseHashMembers[] = $license->HashBits(3);	
		}
		$fields = [$deviceId, $userId, implode(';', $licenseHashMembers), ($this->banned ? 'Banned' : 'Clean')];
		if (empty($this->expiration) === false) {
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['3'] = bin2hex($signature);
		}
	}
	
	public function Delete(): bool {
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query('DELETE FROM users WHERE user_id = $1;', $this->userId);
			$database->Commit();
			return true;
		} catch (Exception $err) {
			$database->Rollback();
			return false;
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