<?php
	
namespace BeaconAPI\Ark;

class PresetModifier extends \Ark\GenericObject {
	protected $pattern;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'pattern';
		return $columns;
	}
	
	protected static function TableName() {
		return 'ark.preset_modifiers';
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
