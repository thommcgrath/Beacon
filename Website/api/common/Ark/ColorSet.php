<?php

namespace BeaconAPI\Ark;

class ColorSet implements \JsonSerializable {
	protected $color_set_id;
	protected $label;
	protected $class_string;
	
	protected static function SQLColumns() {
		return [
			'ark.color_sets.color_set_id',
			'ark.color_sets.label',
			'ark.color_sets.class_string'
		];
	}
	
	public static function GetAll(\DateTime $updated_since = null) {
		$database = \BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets ORDER BY label;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets WHERE last_update > $1 ORDER BY label;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForUUID(string $uuid) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets WHERE color_set_id = $1 ORDER BY label;', $uuid);
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
		$obj->color_set_id = $row->Field('color_set_id');
		$obj->label = $row->Field('label');
		$obj->class_string = $row->Field('class_string');
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'color_set_id' => $this->color_set_id,
			'label' => $this->label,
			'class_string' => $this->class_string
		];
	}
	
	public function Label() {
		return $this->label;
	}
	
	public function UUID() {
		return $this->color_set_id;
	}
	
	public function ClassString() {
		return $this->class_string;
	}
}

?>
