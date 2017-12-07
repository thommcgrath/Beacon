<?php

class BeaconUser implements JsonSerializable {
	protected $user_id = '';
	protected $public_key = '';
	protected $patreon_user_id = null;
	protected $is_patreon_supporter = false;
	
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
			'public_key' => $this->public_key,
			'patreon_user_id' => $this->patreon_user_id,
			'is_patreon_supporter' => $this->is_patreon_supporter,
			'validation' => $this->Validation()
		);
	}
	
	public static function GetByUserID(string $user_id) {
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT user_id, public_key, patreon_id, is_patreon_supporter FROM users WHERE user_id = ANY($1);", '{' . $user_id . '}');
		return self::GetFromResults($results);
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$user = new static();
		$user->user_id = $results->Field('user_id');
		$user->public_key = $results->Field('public_key');
		$user->patreon_user_id = $results->Field('patreon_id') !== null ? intval($results->Field('patreon_id')) : null;
		$user->is_patreon_supporter = $results->Field('is_patreon_supporter');
		return $user;
	}
	
	protected static function GetFromResults(BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$users = array();
		while (!$results->EOF()) {
			$user = self::GetFromResult($results);
			if ($user !== null) {
				$users[] = $user;
			}
			$results->MoveNext();
		}
		return $users;
	}
}

?>