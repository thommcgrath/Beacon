<?php

class BeaconEngram extends BeaconBlueprint {
	private $can_blueprint = false;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'can_blueprint';
		return $columns;
	}
	
	protected static function TableName() {
		return 'engrams';
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->can_blueprint = $row->Field('can_blueprint');
		return $obj;
	}
	
	public function SpawnCode() {
		return 'cheat giveitem "Blueprint\'' . $this->Path() . '\'" 1 0 false';
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['can_blueprint'] = $this->can_blueprint;
		$json['resource_url'] = BeaconAPI::URL('/engram.php/' . urlencode($this->ObjectID()));
		
		// legacy support
		$json['mod_id'] = $this->ModID();
		$json['mod_name'] = $this->ModName();
		$json['uid'] = $this->Hash();
		$json['class'] = $json['class_string'];
		
		return $json;
	}
	
	public function CanBlueprint() {
		return $this->can_blueprint;
	}
	
	public function SetCanBlueprint(bool $can_blueprint) {
		$this->can_blueprint = $can_blueprint;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'can_blueprint':
			return $this->can_blueprint;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	public function RelatedObjectIDs() {
		$database = BeaconCommon::Database();
		$arr = array();
		$results = $database->Query('SELECT creature_id FROM creature_engrams WHERE engram_id = $1;', $this->ObjectID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('creature_id');
			$results->MoveNext();
		}
		$results = $database->Query('SELECT DISTINCT diet_id FROM diet_contents WHERE engram_id = $1;', $this->ObjectID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('diet_id');
			$results->MoveNext();
		}
		return $arr;
	}
}

?>