<?php

namespace BeaconAPI;

class User implements \JsonSerializable {
	const ARK_FREE = false;
	const ARK2_FREE = false;
	
	protected $banned = false;
	protected $email_id = null;
	protected $enabled = true;
	protected $expiration = '';
	protected $license_hash_members = [];
	protected $license_mask = -1;
	protected $licenses = [];
	protected $licenses_loaded = false;
	protected $parent_account_id = null;
	protected $private_key = null;
	protected $private_key_iterations = null;
	protected $private_key_salt = null;
	protected $public_key = '';
	protected $require_password_change = false;
	protected $signatures = [];
	protected $user_id = '';
	protected $usercloud_key = null;
	protected $usercloud_delete_files = false;
	protected $username = null;
	protected $backup_codes = null;
	protected $backup_codes_added = [];
	protected $backup_codes_removed = [];
	
	private $child_accounts = null;
	private $has_child_accounts = null;
	
	public function __construct($source = null) {
		if ($source instanceof \BeaconRecordSet) {
			$this->user_id = $source->Field('user_id');
			$this->username = $source->Field('username');
			$this->email_id = $source->Field('email_id');
			$this->public_key = $source->Field('public_key');
			$this->private_key = $source->Field('private_key');
			$this->private_key_salt = $source->Field('private_key_salt');
			$this->private_key_iterations = intval($source->Field('private_key_iterations'));
			$this->usercloud_key = $source->Field('usercloud_key');
			$this->banned = $source->Field('banned');
			$this->enabled = $source->Field('enabled');
			$this->require_password_change = $source->Field('require_password_change');
			$this->parent_account_id = $source->Field('parent_account_id');
		} elseif (is_string($source) && \BeaconCommon::IsUUID($source)) {
			$this->user_id = $source;
		} elseif (is_null($source)) {
			$this->user_id = \BeaconCommon::GenerateUUID();
		}
	}
	
	/* !Basic Properties */
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function EmailID() {
		return $this->email_id;
	}
	
	public function SetEmailID(string $email_id) {
		if (\BeaconCommon::IsUUID($email_id)) {
			$this->email_id = $email_id;
			return true;
		}
		return false;
	}
	
	public function SetEmailAddress(string $email) {
		if (self::ValidateEmail($email)) {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
			$database->Commit();
			$this->email_id = $results->Field('email_id');
			return true;
		}
		return false;
	}
	
	public function Suffix() {
		return substr($this->user_id, 0, 8);
	}
	
	public function Username() {
		return $this->username;
	}
	
	public function SetUsername(string $username) {
		$this->username = trim($username);
		return true;
	}
	
	public function PublicKey() {
		return $this->public_key;
	}
	
	public function SetPublicKey(string $public_key) {
		if (is_null($this->public_key) || $public_key !== $this->public_key) {
			$this->public_key = $public_key;
			return true;
		}
		return false;
	}
	
	public function PrivateKey() {
		return $this->private_key;
	}
	
	public function SetPrivateKey(string $encrypted_private_key, string $salt, int $iterations) {
		$this->private_key = $encrypted_private_key;
		$this->private_key_salt = $salt;
		$this->private_key_iterations = $iterations;
		return true;
	}
	
	public function DecryptedPrivateKey(string $password) {
		$hash = \BeaconEncryption::HashFromPassword($password, hex2bin($this->private_key_salt), $this->private_key_iterations);
		try {
			$decrypted = \BeaconEncryption::SymmetricDecrypt($hash, hex2bin($this->private_key));
			if (is_null($decrypted)) {
				return null;
			}
			return $decrypted;
		} catch (\Exception $e) {
			return null;
		}
	}
	
	public function SetDecryptedPrivateKey(string $password, string $private_key) {
		$salt = \BeaconEncryption::GenerateSalt();
		$iterations = 12000;
		$hash = \BeaconEncryption::HashFromPassword($password, $salt, $iterations);
		$encrypted = bin2hex(\BeaconEncryption::SymmetricEncrypt($hash, $private_key, \BeaconAPI::UsesLegacyEncryption()));
		$salt = bin2hex($salt);
		
		// test if the public key needs to be changed
		try {
			$test_value = \BeaconCommon::GenerateUUID();
			$signature = \BeaconEncryption::RSASign($private_key, $test_value);
			$verified = \BeaconEncryption::RSAVerify($this->public_key, $test_value, $signature);
		} catch (\Exception $err) {
			$verified = false;
		}
		if ($verified === false) {
			$new_public_key = \BeaconEncryption::ExtractPublicKey($private_key);
			if (is_null($new_public_key) === false) {
				$this->public_key = $new_public_key;
				$this->SetDecryptedUsercloudKey(self::GenerateUsercloudKey());
			} else {
				return false;
			}
		}
		
		$this->private_key_salt = $salt;
		$this->private_key_iterations = $iterations;
		$this->private_key = $encrypted;
		
		return true;
	}
	
	public function PrivateKeySalt() {
		return $this->private_key_salt;
	}
	
	public function PrivateKeyIterations() {
		return $this->private_key_iterations;
	}
	
	public function IsAnonymous() {
		return empty($this->email_id);
	}
	
	public function OmniVersion() {
		$this->LoadLicenses();
		return $this->license_mask;
	}
	
	// Do not use the method, use Licenses instead
	public function Purchases() {
		return $this->Licenses();
	}
	
	public function Licenses() {
		$this->LoadLicenses();
		return $this->licenses;
	}
	
	public function LicenseInfo(string $product_id) {
		$this->LoadLicenses();
		if (array_key_exists($product_id, $this->licenses)) {
			return $this->licenses[$product_id];
		}
	}
	
	public function IsBanned() {
		return $this->banned;
	}
	
	public function IsEnabled() {
		return $this->enabled;
	}
	
	public function SetIsEnabled(bool $enabled) {
		$this->enabled = $enabled;
		return true;
	}
	
	public function CanSignIn() {
		// Use the methods here so subclasses can override correctly.
		return $this->IsEnabled() === true && $this->RequiresPasswordChange() === false;
	}
	
	/* !Child Accounts */
	
	public function IsChildAccount() {
		return is_null($this->parent_account_id) === false;
	}
	
	public function HasChildAccounts() {
		if (is_null($this->has_child_accounts)) {
 			$database = \BeaconCommon::Database();
 			$results = $database->Query('SELECT COUNT(user_id) AS user_count FROM users WHERE parent_account_id = $1;', $this->user_id);
 			$this->has_child_accounts = intval($results->Field('user_count')) > 0;
 		}
 		return $this->has_child_accounts;
	}
	
	public function ChildAccounts() {
		if (is_null($this->child_accounts)) {
 			$database = \BeaconCommon::Database();
 			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE parent_account_id = $1;', $this->user_id);
 			$this->child_accounts = static::GetFromResults($results);
 			$this->has_child_accounts = count($this->child_accounts) > 0;
 		}
 		return $this->child_accounts;
	}
	
	public function ParentAccountID() {
		return $this->parent_account_id;
	}
	
	public function SetParentAccountID($parent_account_id) {
		$this->parent_account_id = $parent_account_id;
		return true;
	}
	
	public function ParentAccount() {
		if (is_null($this->parent_account_id) === false) {
			return \BeaconUser::GetByUserID($this->parent_account_id);
		}
		return null;
	}
	
	public function TotalChildSeats() {
		if ($this->banned) {
 			return 0;
 		}

  		$database = \BeaconCommon::Database();
 		$results = $database->Query('SELECT SUM(child_seat_count) AS total_seat_count FROM purchased_products WHERE purchaser_email = $1;', $this->email_id);
 		return intval($results->Field('total_seat_count'));
	}
	
	public function UsedChildSeats() {
		$database = \BeaconCommon::Database();
 		$results = $database->Query('SELECT COUNT(users) AS used_seat_count FROM users WHERE parent_account_id = $1 AND enabled = TRUE AND banned = FALSE;', $this->user_id);
 		return intval($results->Field('used_seat_count'));
	}
	
	public function RemainingChildSeats() {
		return $this->TotalChildSeats() - $this->UsedChildSeats();
	}
	
	public function CanAddChildAccount() {
		return $this->RemainingChildSeats() > 0;
	}
	
	/* !Two Factor Authentication */
	
	public function Is2FAProtected(): bool {
		return Authenticator::UserIDHasAuthenticators($this->user_id);
	}
	
	// $code may be a TOTP, backup code, or trusted device id
	public function Verify2FACode(string $code, bool $verifyOnly = false): bool {
		$authenticators = Authenticator::GetForUserID($this->user_id);
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
		if (\BeaconCommon::IsUUID($code) === true) {
			return $this->IsDeviceTrusted($code);
		}
		
		// Finally, try backup codes
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT * FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->user_id, $code);
		if ($rows->RecordCount() === 1) {
			if ($verifyOnly === false) {
				$database->BeginTransaction();
				$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->user_id, $code);
				$backup_codes_removed[] = $code;
				$new_code = \BeaconCommon::GenerateRandomKey(6);
				$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $this->user_id, $new_code);
				$backup_codes_added[] = $new_code;
				$database->Commit();
				if (is_null($this->backup_codes) === false) {
					$this->backup_codes = null;
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
		while (count($this->backup_codes) < 10) {
			$code = \BeaconCommon::GenerateRandomKey(6);
			$this->backup_codes[] = $code;
			$this->backup_codes_added[] = $code;
			$changed = true;
		}
		
		if ($changed && $commit) {
			$this->Commit();
			return false;
		}
		
		return $changed;
	}
	
	public function Get2FABackupCodes(): array {
		if (is_null($this->backup_codes)) {
			$this->backup_codes = [];
			$database = \BeaconCommon::Database();
			$rows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1;', $this->user_id);
			while (!$rows->EOF()) {
				$this->backup_codes[] = $rows->Field('code');
				$rows->MoveNext();
			}
		}
		return $this->backup_codes;
	}
	
	public function Clear2FABackupCodes(bool $commit = false): void {
		$codes = $this->Get2FABackupCodes();
		foreach ($codes as $code) {
			$this->backup_codes_removed[] = $code;
		}
		$this->backup_codes = [];
		
		if ($commit) {
			$this->Commit();
		}
	}
	
	/* !Cloud Files */
	
	public function CloudUserID() {
		if (is_null($this->parent_account_id)) {
			return $this->user_id;
		} else {
			return $this->parent_account_id;
		}
	}
	
	public function UsercloudKey() {
		return $this->usercloud_key;
	}
	
	public function SetUsercloudKey(string $key, bool $delete_files = true): bool {
		$this->usercloud_key = $key;
		$this->usercloud_delete_files = $delete_files;
		
		$children = $this->ChildAccounts();
		foreach ($children as $child) {
			$child->SetUsercloudKey($key);
		}
		
		return true;
	}
	
	public function DecryptedUsercloudKey(string $private_key) {
		try {
			return \BeaconEncryption::RSADecrypt($private_key, hex2bin($this->usercloud_key));
		} catch (\Exception $err) {
			return null;
		}
	}
	
	public function SetDecryptedUsercloudKey(string $key, bool $delete_files = true): bool {
		try {
			$this->usercloud_key = bin2hex(\BeaconEncryption::RSAEncrypt($this->public_key, $key));
			$this->usercloud_delete_files = $delete_files;
			
			$children = $this->ChildAccounts();
			foreach ($children as $child) {
				$child->SetDecryptedUsercloudKey($key);
			}
			
			return true;
		} catch (\Exception $err) {
			return false;
		}
	}
	
	public static function GenerateUsercloudKey() {
		return random_bytes(128);
	}
	
	public function HasFiles() {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT COUNT(remote_path) AS num_files FROM usercloud WHERE remote_path LIKE $1 AND size_in_bytes > 0 AND deleted = FALSE;', '/' . $this->UserID() . '/%');
		return $results->Field('num_files') > 0;
	}
	
	public function HasEncryptedFiles() {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT COUNT(remote_path) AS num_files FROM usercloud WHERE remote_path LIKE $1 AND size_in_bytes > 0 AND deleted = FALSE AND header IS NOT NULL;', '/' . $this->UserID() . '/%');
		return $results->Field('num_files') > 0;
	}
	
	/* !Passwords & Authentication */
	
	public function RequiresPasswordChange() {
		return $this->require_password_change;
	}
	
	public function SetRequiresPasswordChange(bool $required) {
		$this->require_password_change = $required;
		return true;
	}
	
	public function TestPassword(string $password) {
		$decrypted = $this->DecryptedPrivateKey($password);
		if (is_null($decrypted)) {
			return false;
		}
		
		if (\BeaconAPI::UsesLegacyEncryption() === false && strtolower(substr($decrypted, 0, 4)) === '8a01') {
			$this->SetDecryptedPrivateKey($password, $decrypted, \BeaconAPI::UsesLegacyEncryption());
		}
		
		return true;
	}
	
	public function ReplacePassword(string $password, string $private_key, string $usercloud_key) {
		if (empty($this->email_id)) {
			return false;
		}
		
		if (is_null($usercloud_key)) {
			$usercloud_key = static::GenerateUsercloudKey();
		}
		
		if ($this->SetDecryptedPrivateKey($password, $private_key)) {
			$this->SetDecryptedUsercloudKey($usercloud_key);
			$this->SetRequiresPasswordChange(false);
			
			$children = $this->ChildAccounts();
			foreach ($children as $child) {
				$child_password = \BeaconCommon::GenerateUUID();
				if ($child->ReplacePassword($child_password, $private_key, $usercloud_key)) {
					$child->SetRequiresPasswordChange(true);
				}
			}
			
			return true;
		} else {
			return false;
		}
	}
	
	public function AddAuthentication(string $username, string $email, string $password, string $private_key) {
		if (empty($this->private_key) == false) {
			return false;
		}
		
		try {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			if (\BeaconCommon::IsUUID($email)) {
				$email_id = $email;
			} else {
				$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
				$email_id = $results->Field('email_id');
			}
			
			if (empty($username)) {
				if (empty($this->username)) {
					$database = \BeaconCommon::Database();
					$results = $database->Query('SELECT generate_username() AS username;');
					$username = $results->Field('username');
				} else {
					$username = $this->username;
				}
			}
			
			$this->SetDecryptedPrivateKey($password, $private_key);
			$this->SetDecryptedUsercloudKey(static::GenerateUsercloudKey());
			$this->SetRequiresPasswordChange(false);
			$database->Commit();
			
			$this->username = $username;
			$this->email_id = $email_id;
			
			return true;
		} catch (\Exception $e) {
			return false;
		}
	}
	
	public function ChangePassword(string $old_password, string $new_password, bool $regenerate_private_key = false): bool {
		try {
			$private_key = $this->DecryptedPrivateKey($old_password);
			if (is_null($private_key)) {
				return false;
			}
			
			if ($regenerate_private_key) {
				$usercloud_key = $this->DecryptedUsercloudKey($private_key);
				if (is_null($usercloud_key)) {
					return false;
				}
				
				$public_key = null;
				$private_key = null;
				\BeaconEncryption::GenerateKeyPair($public_key, $private_key);
					
				$this->SetPublicKey($public_key);
				$this->SetDecryptedUsercloudKey($usercloud_key, false);
			}
			$this->SetDecryptedPrivateKey($new_password, $private_key);
			$this->SetRequiresPasswordChange(false);
			return true;
		} catch (\Exception $e) {
			return false;
		}
	}
	
	/* !User Lookup */
	
	public static function GetByEmail(string $email) {
		// When doing a SELECT with uuid_for_email(email, create), you must wrap it in its own SELECT statement.
		// This is because the function is VOLATILE and will be executed for every row in the user table unless
		// treated as a subquery. Or omit the second parameter, which is a STABLE function and performs fine.
		// The second parameter should only be used when updating the email row is desired.
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
		if ($results->RecordCount() !== 1 || is_null($results->Field('email_id'))) {
			return null;
		}
		$email_id = $results->Field('email_id');
		
		$results = $database->Query('SELECT email_needs_update($1::UUID) AS update_needed;', $email_id);
		if ($results->RecordCount() !== 1 || is_null($results->Field('update_needed'))) {
			return null;
		}
		if ($results->Field('update_needed')) {
			$database->BeginTransaction();
			$database->Query('SELECT uuid_for_email($1, TRUE);', $email);
			$database->Commit();
		}
		
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE email_id = $1;', $email_id);
		$users = static::GetFromResults($results);
		if (count($users) !== 1) {
			return null;
		}
		return $users[0];
	}
	
	public static function GetByEmailID(string $email_id) {
			$database = \BeaconCommon::Database();
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE email_id = ANY($1);', '{' . $email_id . '}');
			$users = static::GetFromResults($results);
			if (count($users) == 1) {
				return $users[0];
			}
		}
	
	public static function GetByUserID(string $user_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE user_id = ANY($1);', '{' . $user_id . '}');
		$users = static::GetFromResults($results);
		if (count($users) == 1) {
			return $users[0];
		}
	}
	
	public static function GetByExtendedUsername(string $username) {
		$display_name = substr($username, 0, -9);
		$suffix = strtolower(substr($username, -8));
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE username = $1 AND SUBSTRING(LOWER(user_id::TEXT) FROM 1 FOR 8) = $2;', $display_name, $suffix);
		$users = static::GetFromResults($results);
		if (count($users) == 1) {
			return $users[0];
		}
	}
	
	protected static function GetFromResults(\BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$users = array();
		while (!$results->EOF()) {
			$user = new static($results);
			$users[] = $user;
			$results->MoveNext();
		}
		return $users;
	}
	
	/* !Validation */
	
	public static function ValidateEmail(string $email) {
		return filter_var($email, FILTER_VALIDATE_EMAIL);
	}
	
	public static function ValidatePassword(string $password) {
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
	
	public static function IsExtendedUsername(string $username) {
		return preg_match('/#[a-fA-F0-9]{8}$/', $username) === 1;
	}
	
	/* !Everything Else */
	
	public function MergeUsers(... $user_ids) {
		$database = \BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			foreach ($user_ids as $user_id) {
				$database->Query('UPDATE sessions SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE projects SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE guest_projects SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE ark.mods SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE oauth_tokens SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('DELETE FROM users WHERE user_id = $1;', $user_id);
			}
			$database->Commit();
			return true;
		} catch (\Exception $e) {
			return false;
		}
	}
	
	public function Commit() {
		$original_user = \BeaconUser::GetByUserID($this->user_id);
		$changes = [];
		$database = \BeaconCommon::Database();
		
		if (is_null($original_user)) {
			$changes['user_id'] = $this->user_id;
			$changes['username'] = $this->username;
			$changes['email_id'] = $this->email_id;
			$changes['public_key'] = $this->public_key;
			$changes['private_key'] = $this->private_key;
			$changes['private_key_salt'] = $this->private_key_salt;
			$changes['private_key_iterations'] = $this->private_key_iterations;
			$changes['usercloud_key'] = $this->usercloud_key;
			$changes['enabled'] = $this->enabled;
			$changes['require_password_change'] = $this->require_password_change;
			$changes['parent_account_id'] = $this->parent_account_id;
			try {
				$database->Insert('users', $changes);
				if (is_null($this->backup_codes) === false) {
					foreach ($this->backup_codes as $code) {
						$database->Insert('public.user_backup_codes', ['user_id' => $this->user_id, 'code' => $code]);
					}
				}
			} catch (\Exception $e) {
				return false;
			}
		} else {
			$keys = ['username', 'email_id', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations', 'usercloud_key', 'enabled', 'require_password_change', 'parent_account_id'];
			foreach ($keys as $key) {
				if ($this->$key !== $original_user->$key) {
					$changes[$key] = $this->$key;
				}
			}
			if (count($changes) === 0 && count($this->backup_codes_added) === 0 && count($this->backup_codes_removed) === 0) {
				return true;
			}
			try {
				$database->BeginTransaction();
				
				if (count($changes) > 0) {
					$database->Update('users', $changes, ['user_id' => $this->user_id]);
					if (array_key_exists('private_key', $changes)) {
						$database->Query('DELETE FROM email_verification WHERE email_id = $1;', $this->email_id);
					}
					
					if ($this->IsChildAccount() === false && array_key_exists('usercloud_key', $changes) && $this->usercloud_delete_files === true) {
						// The cloud key has been changed, so we need to cleanup the cloud files
						$cloud_files = \BeaconCloudStorage::ListFiles('/' . $this->UserID() . '/');
						foreach ($cloud_files as $file) {
							if ($file['deleted'] === false && is_null($file['header']) === false) {
								\BeaconCloudStorage::DeleteFile($file['path']);
							}
						}
					}
				}
				
				foreach ($this->backup_codes_removed as $code) {
					$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $this->user_id, $code);
				}
				
				foreach ($this->backup_codes_added as $code) {
					$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $this->user_id, $code);
				}
				
				$database->Commit();
			} catch (\Exception $e) {
				return false;
			}
		}
		$this->usercloud_delete_files = false;
		$this->backup_codes_added = [];
		$this->backup_codes_removed = [];
		
		return true;
	}
	
	public function CheckSignature(string $data, string $signature) {
		return \BeaconEncryption::RSAVerify($this->public_key, $data, $signature);
	}
	
	protected static function SQLColumns() {
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
			'users.require_password_change',
			'users.parent_account_id'
		];
	}
	
	public function jsonSerialize(): mixed {
		$arr = [
			'user_id' => $this->user_id,
			'username' => $this->username,
			'public_key' => $this->public_key,
			'private_key' => $this->private_key,
			'private_key_salt' => $this->private_key_salt,
			'private_key_iterations' => $this->private_key_iterations,
			'banned' => $this->banned,
			'signatures' => $this->signatures,
			'licenses' => $this->licenses,
			'omni_version' => $this->license_mask,
			'usercloud_key' => $this->usercloud_key
		];
		if (empty($this->expiration) === false) {
			$arr['expiration'] = $this->expiration;
		}
		return $arr;
	}
	
	public function LoadLicenses() {
		if ($this->licenses_loaded === true) {
			return;
		}
		
		$database = \BeaconCommon::Database();
		$purchases = [];
		$hash_members = [];
		$combined_flags = 0;
		
		$free_licenses = [];
		if (self::ARK_FREE) {
			$arkProductId = \BeaconShop::GetProductByTag('USD', 'Ark', 'Base');
			if ($arkProductId) {
				$free_licenses[] = $arkProductId;
			}
		}
		if (self::ARK2_FREE) {
			$ark2ProductId = \BeaconShop::GetProductByTag('USD', 'Ark2', 'Base');
			if ($ark2ProductId) {
				$free_licenses[] = $ark2ProductId;
			}
		}
		if (count($free_licenses) > 0) {
			$expires = (floor(time() / 604800) * 604800) + 1209600;
			$this->expiration = date('Y-m-d H:i:sO', $expires);
		}
		foreach ($free_licenses as $product_id) {
			$results = $database->Query('SELECT product_id, flags FROM products WHERE product_id = $1;', $product_id);
			if ($results->RecordCount() === 1) {
				$purchase = [
					'product_id' => $results->Field('product_id'),
					'flags' => intval($results->Field('flags'))
				];
				$combined_flags = $combined_flags | $purchase['flags'];
				$hash_data = strtolower($purchase['product_id']) . ':' . strval($purchase['flags']);
				$purchases[] = $purchase;
				$hash_members[] = $hash_data;
			}
		}
		
		$results = $database->Query('SELECT licenses.product_id, EXTRACT(epoch FROM licenses.expiration) AS expiration, products.flags FROM public.licenses INNER JOIN public.products ON (licenses.product_id = products.product_id) INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 ORDER BY licenses.product_id;', $this->email_id);
		while ($results->EOF() === false) {
			$purchase = [
				'product_id' => $results->Field('product_id'),
				'flags' => intval($results->Field('flags'))
			];
			$combined_flags = $combined_flags | $purchase['flags'];
			$hash_data = strtolower($purchase['product_id']) . ':' . strval($purchase['flags']);
			
			$expires = $results->Field('expiration');
			if (is_null($expires) === false) {
				$purchase['expires_epoch'] = intval($expires);
				$expires_str = date('Y-m-d H:i:sO', $purchase['expires_epoch']);
				$purchase['expires'] = $expires_str;
				$hash_data .= ':' . $expires_str;
			}
			$purchases[] = $purchase;
			$hash_members[] = $hash_data;
			$results->MoveNext();
		}
		$this->licenses = $purchases;
		$this->license_hash_members = $hash_members;
		$this->licenses_loaded = true;
		$this->license_mask = $combined_flags;
	}
	
	// Don't use this method, use LoadLicenses or PrepareSignatures
	public function Prepare(string $hardware_id) {
		$this->PrepareSignatures($hardware_id);
	}
	
	public function PrepareSignatures(string $hardware_id) {
		if (count($this->signatures) !== 0) {
			return;
		}
		
		$this->LoadLicenses();
		
		$user_id = strtolower($this->UserID());
		// signature v1
		$fields = [$hardware_id, $user_id, strval($this->license_mask)];
		if (empty($this->expiration) === false) {
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, \BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['1'] = bin2hex($signature);
		}
		
		// signature v2
		$fields = [$hardware_id, $user_id, strval($this->license_mask), ($this->banned ? 'Banned' : 'Clean')];
		if (empty($this->expiration) === false) {
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, \BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['2'] = bin2hex($signature);
		}
		
		// signature v3
		$fields = [$hardware_id, $user_id, implode(';', $this->license_hash_members), ($this->banned ? 'Banned' : 'Clean')];
		if (empty($this->expiration) === false) {
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, \BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['3'] = bin2hex($signature);
		}
	}
	
	public function Delete() {
		$database = \BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query('DELETE FROM users WHERE user_id = $1;', $this->user_id);
			$database->Commit();
			return true;
		} catch (\Exception $err) {
			$database->Rollback();
			return false;
		}
	}
	
	/* ! Trusted Devices */
	
	public function TrustDevice(string $device_id): void {
		$database = \BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($device_id);
		$database->BeginTransaction();
		$database->Query('INSERT INTO public.trusted_devices (device_id_hash, user_id) VALUES ($1, $2) ON CONFLICT (device_id_hash) DO NOTHING;', $device_hash, $this->UserID());
		$database->Commit();
	}
	
	public function UntrustDevice(string $device_id): void {
		$database = \BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($device_id);
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.trusted_devices WHERE device_id_hash = $1 AND user_id = $2;', $device_hash, $this->UserID());
		$database->Commit();
	}
	
	public function UntrustAllDevices(): void {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.trusted_devices WHERE user_id = $1;', $this->UserID());
		$database->Commit();
	}
	
	public function IsDeviceTrusted(string $device_id): bool {
		$database = \BeaconCommon::Database();
		$device_hash = $this->PrepareDeviceHash($device_id);
		$rows = $database->Query('SELECT device_id_hash FROM public.trusted_devices WHERE device_id_hash = $1 AND user_id = $2;', $device_hash, $this->UserID());
		return $rows->RecordCount() === 1;
	}
	
	protected function PrepareDeviceHash(string $device_id): string {
		return base64_encode(hash('sha3-512', strtolower($device_id) . strtolower($this->user_id), true));
	}
}

?>