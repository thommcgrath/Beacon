<?php

abstract class BeaconMaps {
	public static function All() {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT bit_or(mask) AS combined_mask FROM maps;');
		return $results->Field('combined_mask');
	}
	
	public static function Masks(int $mask = 0) {
		$database = BeaconCommon::Database();
		if ($mask > 0) {
			$results = $database->Query('SELECT label, mask FROM maps WHERE (mask & $1) = mask ORDER BY official DESC, sort;', $mask);
		} else {
			$results = $database->Query('SELECT label, mask FROM maps ORDER BY official DESC, sort;');
		}
		$masks = [];
		while (!$results->EOF()) {
			$masks[$results->Field('mask')] = $results->Field('label');
			$results->MoveNext();
		}
		return $masks;
	}
	
	public static function Names(int $mask = 0) {
		return array_values(static::Masks($mask));
	}
	
	public static function MaskForName(string $name) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT mask FROM maps WHERE label = $1;', $name);
		if ($results->RecordCount() == 1) {
			return $results->Field('mask');
		}
		return 0;
	}
}

?>
