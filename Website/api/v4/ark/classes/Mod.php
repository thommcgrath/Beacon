<?php

namespace Ark;

class Mod extends \BeaconAPI\Ark\Mod {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ark/mods/' . $this->mod_id);
		$json['confirm_url'] = \BeaconAPI::URL('ark/mods/' . $this->mod_id . '/checkConfirmation');
		$json['engrams_url'] = \BeaconAPI::URL('ark/mods/' . $this->mod_id . '/engrams');
		return $json;
	}
}

?>
