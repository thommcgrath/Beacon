<?php

namespace BeaconAPI;

class User implements \JsonSerializable {
	const OmniFree = false;
	
	protected $user_id = '';
	protected $username = null;
	protected $email_id = null;
	protected $public_key = '';
	protected $private_key = null;
	protected $private_key_salt = null;
	protected $private_key_iterations = null;
	protected $signatures = array();
	protected $purchased_omni_version = 0;
	protected $expiration = '';
	protected $usercloud_key = null;
	protected $banned = false;
	protected $enabled = true;
	protected $require_password_change = false;
	protected $parent_account_id = false;
	
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
			
			if (self::OmniFree) {
				$this->purchased_omni_version = 1;
			} else {
				$database = \BeaconCommon::Database();
				$purchases = $database->Query('SELECT * FROM purchased_products WHERE purchaser_email = $1;', $this->email_id);
				while (!$purchases->EOF()) {
					$omni_version = 0;
					$product_id = $purchases->Field('product_id');
					switch ($product_id) {
					case '972f9fc5-ad64-4f9c-940d-47062e705cc5':
						$omni_version = 1;
						break;
					}
					$this->purchased_omni_version = max($this->purchased_omni_version, $omni_version);
					$purchases->MoveNext();
				}
			}
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
			$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
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
		return $this->purchased_omni_version;
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
	
	/* !Child Accounts */
	
	public function IsChildAccount() {
		return is_null($this->parent_account_id) === false;
	}
	
	public function HasChildAccounts() {
		return false;
	}
	
	public function ChildAccounts() {
		return [];
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
		return 0;
	}
	
	public function UsedChildSeats() {
		return 0;
	}
	
	public function RemainingChildSeats() {
		return $this->TotalChildSeats() - $this->UsedChildSeats();
	}
	
	public function CanAddChildAccount() {
		return $this->RemainingChildSeats() > 0;
	}
	
	/* !Two Factor Authentication */
	
	public function IsVerified() {
		return true;
	}
	
	public function Is2FAProtected() {
		return false;
	}
	
	public function Set2FAKey($key) {
		return false;
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
	
	public function SetUsercloudKey(string $key) {
		$this->usercloud_key = $key;
		
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
	
	public function SetDecryptedUsercloudKey(string $key) {
		try {
			$this->usercloud_key = bin2hex(\BeaconEncryption::RSAEncrypt($this->public_key, $key));
			
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
	
	public function ReplacePassword(string $password, string $private_key, string $usercloud_key, array &$child_account_passwords) {
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
				$temp = [];
				if ($child->ReplacePassword($child_password, $private_key, $usercloud_key, $temp)) {
					$child->SetRequiresPasswordChange(true);
					$child_account_passwords[$child->UserID()] = $child_password;
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
			if (\BeaconCommon::IsUUID($email)) {
				$email_id = $email;
			} else {
				$database = \BeaconCommon::Database();
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
			
			$this->username = $username;
			$this->email_id = $email_id;
			
			return true;
		} catch (\Exception $e) {
			return false;
		}
	}
	
	public function ChangePassword(string $old_password, string $new_password) {
		try {
			$private_key = $this->DecryptedPrivateKey($old_password);
			if (is_null($private_key)) {
				return false;
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
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE email_id IS NOT NULL AND email_id = (SELECT uuid_for_email($1, FALSE));', $email);
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
		
		if ($passlen < 8) {
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
				$database->Query('UPDATE documents SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE guest_documents SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE mods SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
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
		$changes = array();
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
			} catch (\Exception $e) {
				return false;
			}
		} else {
			$keys = array('username', 'email_id', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations', 'usercloud_key', 'enabled', 'require_password_change', 'parent_account_id');
			foreach ($keys as $key) {
				if ($this->$key !== $original_user->$key) {
					$changes[$key] = $this->$key;
				}
			}
			if (count($changes) == 0) {
				return true;
			}
			try {
				$database->BeginTransaction();
				$database->Update('users', $changes, array('user_id' => $this->user_id));
				if (array_key_exists('private_key', $changes)) {
					$database->Query('DELETE FROM email_verification WHERE email_id = $1;', $this->email_id);
					$database->Query('DELETE FROM sessions WHERE user_id = $1;', $this->user_id);
				}
				
				if ($this->IsChildAccount() === false && array_key_exists('usercloud_key', $changes)) {
					// The cloud key has been changed, so we need to cleanup the cloud files
					$cloud_files = \BeaconCloudStorage::ListFiles('/' . $this->UserID() . '/');
					foreach ($cloud_files as $file) {
						if ($file['deleted'] === false && is_null($file['header']) === false) {
							\BeaconCloudStorage::DeleteFile($file['path']);
						}
					}
				}
				
				$database->Commit();
			} catch (\Exception $e) {
				return false;
			}
		}
		
		return true;
	}
	
	public function CheckSignature(string $data, string $signature) {
		return \BeaconEncryption::RSAVerify($this->public_key, $data, $signature);
	}
	
	protected static function SQLColumns() {
		return array('user_id', 'email_id', 'username', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations', 'usercloud_key', 'banned', 'enabled', 'require_password_change', 'parent_account_id');
	}
	
	public function jsonSerialize() {
		$arr = array(
			'user_id' => $this->user_id,
			'username' => $this->username,
			'public_key' => $this->public_key,
			'private_key' => $this->private_key,
			'private_key_salt' => $this->private_key_salt,
			'private_key_iterations' => $this->private_key_iterations,
			'banned' => $this->banned,
			'signatures' => $this->signatures,
			'omni_version' => $this->purchased_omni_version,
			'usercloud_key' => $this->usercloud_key
		);
		if (!empty($this->expiration)) {
			$arr['expiration'] = $this->expiration;
		}
		return $arr;
	}
	
	public function PrepareSignatures(string $hardware_id) {
		// version 1
		$fields = array($hardware_id, strtolower($this->UserID()), strval($this->purchased_omni_version));
		if (self::OmniFree) {
			$expires = (floor(time() / 604800) * 604800) + 2592000;
			$this->expiration = date('Y-m-d H:i:sO', $expires);
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, \BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['1'] = bin2hex($signature);
		}
		
		// version 2
		$fields = array($hardware_id, strtolower($this->UserID()), strval($this->purchased_omni_version), ($this->banned ? 'Banned' : 'Clean'));
		if (self::OmniFree) {
			$expires = (floor(time() / 604800) * 604800) + 2592000;
			$this->expiration = date('Y-m-d H:i:sO', $expires);
			$fields[] = $this->expiration;
		}
		$signature = '';
		if (openssl_sign(implode(' ', $fields), $signature, \BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['2'] = bin2hex($signature);
		}
	}
}

?>