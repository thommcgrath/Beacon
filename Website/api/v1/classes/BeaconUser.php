<?php

class BeaconUser implements JsonSerializable {
	protected $user_id = '';
	protected $login_key = '';
	protected $public_key = '';
	protected $private_key = '';
	protected $private_key_salt = '';
	protected $private_key_iterations = 0;
	protected $patreon_user_id = null;
	protected $is_patreon_supporter = false;
	
	private function ConsumeRecordSet(BeaconRecordSet $results) {
		$this->user_id = $results->Field('user_id');
		$this->login_key = $results->Field('login_key');
		$this->public_key = $results->Field('public_key');
		$this->private_key = $results->Field('private_key');
		$this->private_key_salt = $results->Field('private_key_salt');
		$this->private_key_iterations = intval($results->Field('private_key_iterations'));
		$this->patreon_user_id = $results->Field('patreon_id') !== null ? intval($results->Field('patreon_id')) : null;
		$this->is_patreon_supporter = $results->Field('is_patreon_supporter');
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function PublicKey() {
		return $this->public_key;
	}
	
	public function IsPatreonLinked() {
		return $this->patreon_user_id !== null;
	}
	
	public function IsPatreonSupporter() {
		return $this->is_patreon_supporter;
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
	
	public function SetupAuthentication(string $username, string $password, string $pem_private_key) {
		$iterations = 12000;
		$salt = BeaconEncryption::GenerateSalt();
		$hash = BeaconEncryption::HashFromPassword($password, $salt, $iterations);
		$encrypted_private_key = BeaconEncryption::BlowfishEncrypt($hash, $pem_private_key);
		
		$private_key = openssl_pkey_get_private($pem_private_key);
		$pem_public_key = openssl_pkey_get_details($private_key)['key'];
		unset($private_key, $pem_private_key);
		
		if (empty($this->user_id)) {
			$this->user_id = BeaconCommon::GenerateUUID();
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$results = $database->Query('SELECT user_id FROM users WHERE user_id = $1;', $this->user_id);
		if ($results->RecordCount() == 0) {
			$results = $database->Query('INSERT INTO users (user_id, login_key, public_key, private_key, private_key_salt, private_key_iterations) VALUES ($1, $2, $3, $4, $5, $6) RETURNING ' . implode(', ', static::SQLColumns()) . ';', $this->user_id, $username, $pem_public_key, bin2hex($encrypted_private_key), bin2hex($salt), $iterations);
		} else {
			$results = $database->Query('UPDATE users SET login_key = $2, public_key = $3, private_key = $4, private_key_salt = $5, private_key_iterations = $6 WHERE user_id = $1 RETURNING ' . implode(', ', static::SQLColumns()) . ';', $this->user_id, $username, $pem_public_key, bin2hex($encrypted_private_key), bin2hex($salt), $iterations);
		}
		$database->Commit();
		
		$this->ConsumeRecordSet($results);
	}
	
	public static function MergeUsers(BeaconUser $retain_user, $claim_users) {
		$user_ids = array();
		if (!is_array($claim_users)) {
			$claim_users = array($claim_users);
		}
		foreach ($claim_users as $user) {
			if (BeaconCommon::IsUUID($user)) {
				$user_ids[] = $user;
			} elseif ($user instanceof self) {
				$user_ids[] = $user->UserID();
			}
		}
		
		if (count($user_ids) == 0) {
			return false;
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT user_id FROM users WHERE login_key IS NULL AND user_id = ANY($1);', '{' . implode(',', $user_ids) . '}');
		if ($results->RecordCount() == 0) {
			return false;
		}
		
		// rebuild $user_ids with the results to ensure we're working with only valid values
		$user_ids = array();
		while (!$results->EOF()) {
			$user_ids[] = $results->Field('user_id');
			$results->MoveNext();
		}
		
		$users = '{' . implode(',', $user_ids) . '}';
		try {
			$database->BeginTransaction();
			$database->Query('UPDATE documents SET user_id = $1 WHERE user_id = ANY($2);', $retain_user->UserID(), $users);
			$database->Query('UPDATE mods SET user_id = $1 WHERE user_id = ANY($2);', $retain_user->UserID(), $users);
			$database->Query('UPDATE sessions SET user_id = $1 WHERE user_id = ANY($2);', $retain_user->UserID(), $users);
			$database->Query('DELETE FROM users WHERE user_id = ANY($1);', $users);
			$database->Commit();
			return true;
		} catch (Exception $e) {
			return false;
		}
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
			$user = new static();
			$user->ConsumeRecordSet($results);
			$users[] = $user;
			$results->MoveNext();
		}
		return $users;
	}
	
	public static function ValidatePassword(string $password) {
		$passlen = strlen($password);
		
		if ($passlen < 8) {
			return false;
		}
		
		$chars = count_chars($password);
		foreach ($chars as $char => $count) {
			$percent = $count / $passlen;
			if ($percent > 0.2) {
				return false;
			}
		}
		
		return true;
	}
}

?>