<?php

class BeaconUser extends BeaconAPI\User {
	public function Email() {
		return $this->email_id;
	}
	
	public function LoginKey() {
		return $this->username;
	}
	
	public function jsonSerialize(): mixed {
		$arr = parent::jsonSerialize();
		$arr['login_key'] = $this->username;
		return $arr;
	}
	
	public function IsEnabled() {
		// Child accounts cannot sign in with the v1 API.
		if ($this->IsChildAccount()) {
			return false;
		}
		return parent::IsEnabled();
	}
}

?>
