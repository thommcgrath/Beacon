<?php

namespace Ark;

class Mod extends \BeaconAPI\Ark\Mod {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('mod/' . $this->workshop_id);
		$json['confirm_url'] = \BeaconAPI::URL('mod/' . $this->workshop_id . '?action=confirm');
		$json['engrams_url'] = \BeaconAPI::URL('engram?mod_id=' . $this->workshop_id);
		return $json;
	}
}

?>
