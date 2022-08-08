<?php

namespace Ark;

class Preset extends \BeaconAPI\Ark\Preset {
	public function Contents(bool $legacy_style = true) {
		$contents = parent::Contents(false);
		if ($legacy_style === false) {
			return $contents;
		}
		
		$json = json_decode($contents, true);
		if (isset($json['Version']) == false || intval($json['Version']) < 2) {
			// already legacy
			return $contents;
		}
		
		$modifiers = $json['Modifiers'];
		
		$legacy_modifiers = array();
		if (array_key_exists('e350c14c-a3a1-493a-bd5c-b34a530e45cb', $modifiers)) {
			$legacy_modifiers['Standard'] = $modifiers['e350c14c-a3a1-493a-bd5c-b34a530e45cb'];
		} else {
			$legacy_modifiers['Standard'] = array(
				'Quality' => 0,
				'Quantity' => 1.0
			);
		}
		if (array_key_exists('13299620-1aaa-43a7-9c44-42fc409ea7a1', $modifiers)) {
			$legacy_modifiers['Bonus'] = $modifiers['13299620-1aaa-43a7-9c44-42fc409ea7a1'];
		} else {
			$legacy_modifiers['Bonus'] = array(
				'Quality' => 3,
				'Quantity' => 2.0
			);
		}
		if (array_key_exists('22b6ba8a-dacb-4bda-945a-26b95d0ad0db', $modifiers)) {
			$legacy_modifiers['Cave'] = $modifiers['22b6ba8a-dacb-4bda-945a-26b95d0ad0db'];
		} else {
			$legacy_modifiers['Cave'] = array(
				'Quality' => 6,
				'Quantity' => 1.0
			);
		}
		if (array_key_exists('4ae8364b-4890-4a53-9d24-204ab5f00411', $modifiers)) {
			$legacy_modifiers['Sea'] = $modifiers['4ae8364b-4890-4a53-9d24-204ab5f00411'];
		} else {
			$legacy_modifiers['Sea'] = array(
				'Quality' => 6,
				'Quantity' => 1.0
			);
		}
		
		$json['Modifiers'] = $legacy_modifiers;
		unset($json['Modifier Definitions']);
		unset($json['Version']);
		
		return json_encode($json);
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('preset/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>