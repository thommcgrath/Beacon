<?php

abstract class BeaconMaps {
	public static function All() {
		$maps = BeaconMap::GetAll();
		return BeaconMap::CombinedMask($maps);
	}
	
	public static function Masks(int $mask = 0) {
		$maps = BeaconMap::GetForMask($mask);
		$masks = [];
		foreach ($maps as $map) {
			$masks[$map->Mask()] = $map->Name();
		}
		return $masks;
	}
	
	public static function Names(int $mask = 0) {
		$maps = BeaconMap::GetForMask($mask);
		$names = [];
		foreach ($maps as $map) {
			$names[] = $map->Name();
		}
		return $names;
	}
	
	public static function MaskForName(string $name) {
		$maps = BeaconMap::GetNamed($name);
		if (count($maps) === 1) {
			return $maps[0]->Mask();
		}
		return 0;
	}
}

?>
