<?php

namespace BeaconAPI\Ark;

class Color implements \JsonSerializable {
	protected $color_id;
	protected $color_name;
	protected $color_code;
	
	protected static function SQLColumns() {
		return [
			'colors.color_id',
			'colors.color_name',
			'colors.color_code'
		];
	}
	
	public static function GetAll(\DateTime $updated_since = null) {
		$database = \BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM colors ORDER BY color_id;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM colors WHERE last_update > $1 ORDER BY color_id;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForID(int $id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM colors WHERE color_id = $1 ORDER BY color_id;', $id);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRows(\BeaconRecordSet $results) {
		if (($results === null) || ($results->RecordCount() == 0)) {
			return array();
		}
		
		$objects = array();
		while (!$results->EOF()) {
			$object = static::FromRow($results);
			if ($object !== null) {
				$objects[] = $object;
			}
			$results->MoveNext();
		}
		return $objects;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = new static();
		$obj->color_id = $row->Field('color_id');
		$obj->color_name = $row->Field('color_name');
		$obj->color_code = $row->Field('color_code');
		return $obj;
	}
	
	public function jsonSerialize() {
		return [
			'color_id' => $this->color_id,
			'label' => $this->color_name,
			'hex' => $this->color_code
		];
	}
	
	public function Label() {
		return $this->color_name;
	}
	
	public function ID() {
		return $this->color_id;
	}
	
	public function ColorHex() {
		return $this->color_code;
	}
}

?>
