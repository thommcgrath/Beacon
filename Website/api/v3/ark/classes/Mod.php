<?php

namespace Ark;

class Mod extends \BeaconAPI\Ark\Mod {
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ark/mod/' . $this->workshop_id);
		$json['confirm_url'] = \BeaconAPI::URL('ark/mod/' . $this->workshop_id . '?action=confirm');
		$json['engrams_url'] = \BeaconAPI::URL('ark/engram?mod_id=' . $this->workshop_id);
		return $json;
	}
}

?>
