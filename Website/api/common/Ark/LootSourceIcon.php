<?php

namespace BeaconAPI\Ark;

class LootSourceIcon extends \Ark\GenericObject {
	private $icon_data;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'icon_data';
		return $columns;
	}
	
	protected static function TableName() {
		return 'loot_source_icons';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'icon_data':
			return $this->icon_data;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->icon_data = $row->Field('icon_data');
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['icon_data'] = base64_encode($this->icon_data);
		return $json;
	}
	
	public function IconData(bool $base64 = true) {
		if ($base64) {
			return base64_encode($this->icon_data);
		} else {
			return $this->icon_data;
		}
	}
}

?>
