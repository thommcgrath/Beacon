<?php

class BeaconUser extends BeaconAPI\User {
	public function Email() {
		return $this->email_id;
	}
	
	public function LoginKey() {
		return $this->username;
	}
	
	public function jsonSerialize() {
		$arr = parent::jsonSerialize();
		$arr['login_key'] = $this->username;
		return $arr;
	}
}

?>
