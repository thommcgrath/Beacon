<?php

namespace Ark;

abstract class Maps {
	public static function All() {
		$maps = Map::GetAll();
		return Map::CombinedMask($maps);
	}
	
	public static function Masks(int $mask = 0) {
		$maps = Map::GetForMask($mask);
		$masks = [];
		foreach ($maps as $map) {
			$masks[$map->Mask()] = $map->Name();
		}
		return $masks;
	}
	
	public static function Names(int $mask = 0) {
		$maps = Map::GetForMask($mask);
		$names = [];
		foreach ($maps as $map) {
			$names[] = $map->Name();
		}
		return $names;
	}
	
	public static function MaskForName(string $name) {
		$maps = Map::GetNamed($name);
		if (count($maps) === 1) {
			return $maps[0]->Mask();
		}
		return 0;
	}
}

?>
