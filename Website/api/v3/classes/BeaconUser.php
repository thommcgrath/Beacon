<?php

class BeaconUser extends \BeaconAPI\User {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['parent_account_id'] = $this->parent_account_id;
		return $json;
	}
}

?>
