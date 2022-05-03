<?php

namespace Ark;

class Preset extends \BeaconAPI\Ark\Preset {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('template/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>