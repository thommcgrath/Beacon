<?php

class BeaconUser implements JsonSerializable {
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
	
	public function __construct($source = null) {
		if ($source instanceof BeaconRecordSet) {
			$this->user_id = $source->Field('user_id');
			$this->username = $source->Field('username');
			$this->email_id = $source->Field('email_id');
			$this->public_key = $source->Field('public_key');
			$this->private_key = $source->Field('private_key');
			$this->private_key_salt = $source->Field('private_key_salt');
			$this->private_key_iterations = intval($source->Field('private_key_iterations'));
			
			if (self::OmniFree) {
				$this->purchased_omni_version = 1;
			} else {
				$database = BeaconCommon::Database();
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
		} elseif (is_null($source)) {
			$this->user_id = BeaconCommon::GenerateUUID();
		}
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function Suffix() {
		return substr($this->user_id, 0, 8);
	}
	
	public function LoginKey() {
		return $this->username;
	}
	
	public function Username() {
		return $this->username;
	}
	
	public function SetUsername(string $username) {
		$this->username = trim($username);
	}
	
	public function PublicKey() {
		return $this->public_key;
	}
	
	public function PrivateKey() {
		return $this->private_key;
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
	
	public function jsonSerialize() {
		$arr = array(
			'user_id' => $this->user_id,
			'login_key' => $this->username,
			'username' => $this->username,
			'public_key' => $this->public_key,
			'private_key' => $this->private_key,
			'private_key_salt' => $this->private_key_salt,
			'private_key_iterations' => $this->private_key_iterations,
			'signatures' => $this->signatures,
			'omni_version' => $this->purchased_omni_version
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
		if (openssl_sign(implode(' ', $fields), $signature, BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			$this->signatures['1'] = bin2hex($signature);
		}
	}
	
	public function TestPassword(string $password) {
		$hash = BeaconEncryption::HashFromPassword($password, hex2bin($this->private_key_salt), $this->private_key_iterations);
		try {
			BeaconEncryption::BlowfishDecrypt($hash, hex2bin($this->private_key));
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	public function ReplacePassword(string $password, string $private_key) {
		if (empty($this->email_id)) {
			return false;
		}
		
		unset($this->private_key);
		return $this->AddAuthentication($this->username, $this->email_id, $password, $private_key);
	}
	
	public function AddAuthentication(string $username, string $email, string $password, string $private_key) {
		if (empty($this->private_key) == false) {
			return false;
		}
		
		try {
			if (BeaconCommon::IsUUID($email)) {
				$email_id = $email;
			} else {
				$database = BeaconCommon::Database();
				$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
				$email_id = $results->Field('email_id');
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
			
			$salt = BeaconEncryption::GenerateSalt();
			$iterations = 12000;
			$hash = BeaconEncryption::HashFromPassword($password, $salt, $iterations);
			$encrypted_private_key = bin2hex(BeaconEncryption::BlowfishEncrypt($hash, $private_key));
			$salt = bin2hex($salt);
			
			$this->username = $username;
			$this->email_id = $email_id;
			$this->private_key_salt = $salt;
			$this->private_key_iterations = $iterations;
			$this->private_key = $encrypted_private_key;
			
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	public function ChangePassword(string $old_password, string $new_password) {
		try {
			$old_hash = BeaconEncryption::HashFromPassword($old_password, hex2bin($this->private_key_salt), $this->private_key_iterations);
			$private_key = BeaconEncryption::BlowfishDecrypt($old_hash, hex2bin($this->private_key));
			$salt = BeaconEncryption::GenerateSalt();
			$iterations = 12000;
			$new_hash = BeaconEncryption::HashFromPassword($new_password, $salt, $iterations);
			$encrypted_private_key = bin2hex(BeaconEncryption::BlowfishEncrypt($new_hash, $private_key));
			$salt = bin2hex($salt);
			unset($private_key, $old_hash);
			
			$this->private_key_salt = $salt;
			$this->private_key_iterations = $iterations;
			$this->private_key = $encrypted_private_key;
			
			$changes['private_key'] = $this->private_key;
			$changes['private_key_salt'] = $this->private_key_salt;
			$changes['private_key_iterations'] = $this->private_key_iterations;
			
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	public function MergeUsers(... $user_ids) {
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			foreach ($user_ids as $user_id) {
				$database->Query('UPDATE sessions SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE documents SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE mods SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('UPDATE oauth_tokens SET user_id = $2 WHERE user_id = $1;', $user_id, $this->user_id);
				$database->Query('DELETE FROM users WHERE user_id = $1;', $user_id);
			}
			$database->Commit();
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
	
	public function SetPublicKey(string $public_key) {
		$this->public_key = $public_key;
	}
	
	public function Commit() {
		$original_user = BeaconUser::GetByUserID($this->user_id);
		$changes = array();
		$database = BeaconCommon::Database();
		
		if (is_null($original_user)) {
			$changes['user_id'] = $this->user_id;
			$changes['username'] = $this->username;
			$changes['email_id'] = $this->email_id;
			$changes['public_key'] = $this->public_key;
			$changes['private_key'] = $this->private_key;
			$changes['private_key_salt'] = $this->private_key_salt;
			$changes['private_key_iterations'] = $this->private_key_iterations;
			try {
				$database->Insert('users', $changes);
			} catch (Exception $e) {
				return false;
			}
		} else {
			$keys = array('username', 'email_id', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations');
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
				$database->Commit();
			} catch (Exception $e) {
				return false;
			}
		}
		
		return true;
	}
	
	public function CheckSignature(string $data, string $signature) {
		return BeaconEncryption::RSAVerify($this->public_key, $data, $signature);
	}
	
	private static function SQLColumns() {
		return array('user_id', 'email_id', 'username', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations');
	}
	
	public static function GetByEmail(string $email) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE email_id IS NOT NULL AND email_id = uuid_for_email($1);', $email);
		$users = static::GetFromResults($results);
		if (count($users) == 1) {
			return $users[0];
		}
	}
	
	public static function GetByUserID(string $user_id) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE user_id = ANY($1);', '{' . $user_id . '}');
		$users = static::GetFromResults($results);
		if (count($users) == 1) {
			return $users[0];
		}
	}
	
	protected static function GetFromResults(BeaconRecordSet $results) {
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
}

?>
