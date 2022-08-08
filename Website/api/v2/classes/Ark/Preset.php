<?php

namespace Ark;

class Preset extends \BeaconAPI\Ark\Preset {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('preset/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>