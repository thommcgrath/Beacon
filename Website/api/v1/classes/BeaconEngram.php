<?php

class BeaconEngram extends BeaconAPI\Engram {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		
		// legacy support
		$json['mod_id'] = $this->ModID();
		$json['mod_name'] = $this->ModName();
		$json['uid'] = $this->Hash();
		$json['class'] = $json['class_string'];
		
		return $json;
	}
}

?>
