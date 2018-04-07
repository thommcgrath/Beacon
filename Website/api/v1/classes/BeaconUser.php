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
			if ($percent > 0.2) {
				return false;
			}
		}
		
		return true;
	}
}

?>