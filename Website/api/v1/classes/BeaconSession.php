<?php

class BeaconSession implements JsonSerializable {
	const COOKIE_NAME = 'BeaconAuth';
	
	protected $session_id = '';
	protected $user_id = '';
	protected $valid_until = '';
	
	public function SessionID() {
		return $this->session_id;
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function User() {
		$users = BeaconUser::GetByUserID($this->user_id);
		if (count($users) === 1) {
			return $users[0];
		}
	}
	
	public function Expiration() {
		return new DateTime($this->valid_until);
	}
	
	public function Delete() {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM sessions WHERE session_id = encode(digest($1, 'sha512'), 'hex'));", $this->session_id);
		$database->Commit();
	}
	
	public static function Create(string $user_id) {
		$session_id = BeaconCommon::GenerateUUID();
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO sessions (session_id, user_id, valid_until) VALUES (encode(digest($1, 'sha512'), 'hex'), $2, CURRENT_TIMESTAMP(0) + '30d');", $session_id, $user_id);
		$database->Commit();
		
		return static::GetBySessionID($session_id);
	}
	
	public static function GetBySessionID(string $session_id) {
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT $1::text AS session_id, user_id, valid_until FROM sessions WHERE session_id = encode(digest($1, 'sha512'), 'hex') AND valid_until >= CURRENT_TIMESTAMP(0);", $session_id);
		if ($results->RecordCount() === 1) {
			return self::GetFromResult($results);
		} else {
			return null;
		}
	}
	
	public function jsonSerialize() {
		return array(
			'session_id' => $this->session_id,
			'user_id' => $this->user_id,
			'valid_until' => $this->valid_until
		);
	}
	
	public function SendCookie() {
		setcookie(self::COOKIE_NAME, $this->session_id, $this->Expiration()->getTimestamp(), '/', 'beaconapp.cc', true, true);
	}
	
	public static function GetFromCookie() {
		if (isset($_COOKIE[self::COOKIE_NAME])) {
			return self::GetBySessionID($_COOKIE[self::COOKIE_NAME]);
		}
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$session = new static();
		$session->session_id = $results->Field('session_id');
		$session->user_id = $results->Field('user_id');
		$session->valid_until = $results->Field('valid_until');
		return $session;
	}
	
	protected static function GetFromResults(BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$sessions = array();
		while (!$results->EOF()) {
			$session = self::GetFromResult($results);
			if ($session !== null) {
				$sessions[] = $session;
			}
			$results->MoveNext();
		}
		return $sessions;
	}
}