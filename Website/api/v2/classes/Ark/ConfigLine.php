<?php

namespace Ark;

class ConfigLine extends \BeaconAPI\Ark\ConfigLine {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ini_option/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>
