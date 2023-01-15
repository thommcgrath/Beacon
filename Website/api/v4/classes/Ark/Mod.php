<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\Core;

class Mod extends \BeaconAPI\Ark\Mod {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = Core::URL('ark/mods/' . $this->mod_id);
		$json['confirm_url'] = Core::URL('ark/mods/' . $this->mod_id . '/checkConfirmation');
		$json['engrams_url'] = Core::URL('ark/mods/' . $this->mod_id . '/engrams');
		return $json;
	}
}

?>
