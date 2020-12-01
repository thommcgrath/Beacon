<?php
	
namespace BeaconAPI;

class PresetModifier extends \BeaconObject {
	protected $pattern;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'pattern';
		return $columns;
	}
	
	protected static function TableName() {
		return 'preset_modifiers';
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->pattern = $row->Field('pattern');
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['pattern'] = $this->pattern;
		return $json;
	}
	
	public function Pattern() {
		return $this->pattern;
	}
}

?>
