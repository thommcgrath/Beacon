<?php

namespace BeaconAPI\v4;

class BeaconUser extends \BeaconAPI\User {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['parent_account_id'] = $this->parent_account_id;
		return $json;
	}
}

?>
