<?php

class BeaconUser implements JsonSerializable {
	protected $user_id = '';
	protected $login_key = null;
	protected $public_key = '';
	protected $private_key = null;
	protected $private_key_salt = null;
	protected $private_key_iterations = null;
	protected $patreon_user_id = null;
	protected $is_patreon_supporter = false;
	
	public function __construct($source = null) {
		if ($source instanceof BeaconRecordSet) {
			$this->user_id = $source->Field('user_id');
			$this->login_key = $source->Field('login_key');
			$this->public_key = $source->Field('public_key');
			$this->private_key = $source->Field('private_key');
			$this->private_key_salt = $source->Field('private_key_salt');
			$this->private_key_iterations = intval($source->Field('private_key_iterations'));
			$this->patreon_user_id = $source->Field('patreon_id') !== null ? intval($source->Field('patreon_id')) : null;
			$this->is_patreon_supporter = $source->Field('is_patreon_supporter');
		} elseif (is_null($source)) {
			$this->user_id = BeaconCommon::GenerateUUID();
		}
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function LoginKey() {
		return $this->login_key;
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
	
	public function IsPatreonLinked() {
		return $this->patreon_user_id !== null;
	}
	
	public function IsPatreonSupporter() {
		return $this->is_patreon_supporter;
	}
	
	public function IsAnonymous() {
		return empty($this->login_key);
	}
	
	public function Validation() {
		$time = floor(time() / 604800);
		$key = strtolower($this->user_id) . ' ' . $time . ' ' . ($this->patreon_user_id !== null ? $this->patreon_user_id : '' ) . ' ' . ($this->is_patreon_supporter ? 1 : 0);
		$signature = '';
		if (openssl_sign($key, $signature, BeaconCommon::GetGlobal('Beacon_Private_Key'))) {
			return bin2hex($signature);
		}
	}
	
	public function jsonSerialize() {
		return array(
			'user_id' => $this->user_id,
			'login_key' => $this->login_key,
			'public_key' => $this->public_key,
			'private_key' => $this->private_key,
			'private_key_salt' => $this->private_key_salt,
			'private_key_iterations' => $this->private_key_iterations,
			'patreon_user_id' => $this->patreon_user_id,
			'is_patreon_supporter' => $this->is_patreon_supporter,
			'validation' => $this->Validation()
		);
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
		if (empty($this->login_key)) {
			return false;
		}
		
		unset($this->private_key);
		return $this->AddAuthentication($this->login_key, $password, $private_key);
	}
	
	public function AddAuthentication(string $login_key, string $password, string $private_key) {
		if (empty($this->private_key) == false) {
			return false;
		}
		
		try {
			$salt = BeaconEncryption::GenerateSalt();
			$iterations = 12000;
			$hash = BeaconEncryption::HashFromPassword($password, $salt, $iterations);
			$encrypted_private_key = bin2hex(BeaconEncryption::BlowfishEncrypt($hash, $private_key));
			$salt = bin2hex($salt);
			
			$this->login_key = $login_key;
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
			$changes['login_key'] = $this->login_key;
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
			$keys = array('login_key', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations');
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
					$database->Query('DELETE FROM email_verification WHERE email = $1;', $this->login_key);
					$database->Query('DELETE FROM sessions WHERE user_id = $1;', $this->user_id);
				}
				$database->Commit();
			} catch (Exception $e) {
				return false;
			}
		}
		
		return true;
	}
		
	
	private static function SQLColumns() {
		return array('user_id', 'login_key', 'public_key', 'private_key', 'private_key_salt', 'private_key_iterations', 'patreon_id', 'is_patreon_supporter');
	}
	
	public static function GetByEmail(string $email) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM users WHERE login_key = $1;', $email);
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
	
	public static function ValidateLoginKey(string $login_key) {
		return filter_var($login_key, FILTER_VALIDATE_EMAIL);
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