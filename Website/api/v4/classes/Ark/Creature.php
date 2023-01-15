<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\Core;

class Creature extends \BeaconAPI\Ark\Creature {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = Core::URL('ark/creature/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>
