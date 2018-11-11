<?php

class BeaconLootSourceIcon extends BeaconObject {
	private $icon_data;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'icon_data';
		return $columns;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'icon_data':
			return $this->icon_data;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->icon_data = hex2bin($row->Field('icon_data'));
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['icon_data'] = base64_encode($this->icon_data);
		return $json;
	}
}

?>