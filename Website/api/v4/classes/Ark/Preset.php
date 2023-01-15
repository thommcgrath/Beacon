<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\Core;

class Preset extends \BeaconAPI\Ark\Preset {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = Core::URL('template/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>