<?php

namespace Ark;

class Creature extends \BeaconAPI\Ark\Creature {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ark/creature/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>