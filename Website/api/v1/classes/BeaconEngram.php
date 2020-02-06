<?php

class BeaconEngram extends BeaconBlueprint {
	protected $entry_string = null;
	protected $required_points = null;
	protected $required_level = null;
	
	protected static function TableName() {
		return 'engrams';
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'entry_string';
		$columns[] = 'required_points';
		$columns[] = 'required_level';
		return $columns;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'entry_string':
			return $this->entry_string;
		case 'required_points':
			return $this->required_points;
		case 'required_level':
			return $this->required_level;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->entry_string = $row->Field('entry_string');
		$obj->required_points = intval($row->Field('required_points'));
		$obj->required_level = intval($row->Field('required_level'));
		return $obj;
	}
	
	public function SpawnCode() {
		return 'cheat giveitem "Blueprint\'' . $this->Path() . '\'" 1 0 false';
	}
	
	public function UnlockCode() {
		if (is_null($this->entry_string)) {
			return null;
		}
		
		return 'cheat unlockengram "Blueprint\'' . $this->Path() . '\'"';
	}
	
	public function EntryString() {
		return $this->entry_string;
	}
	
	public function RequiredPoints() {
		return $this->required_points;
	}
	
	public function RequiredLevel() {
		return $this->required_level;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['can_blueprint'] = $this->CanBlueprint();
		$json['resource_url'] = BeaconAPI::URL('/engram/' . urlencode($this->ObjectID()));
		$json['entry_string'] = $this->EntryString();
		$json['required_points'] = $this->RequiredPoints();
		$json['required_level'] = $this->RequiredLevel();
		
		// legacy support
		$json['mod_id'] = $this->ModID();
		$json['mod_name'] = $this->ModName();
		$json['uid'] = $this->Hash();
		$json['class'] = $json['class_string'];
		
		return $json;
	}
	
	public function CanBlueprint() {
		return $this->IsTagged('blueprintable');
	}
	
	public function SetCanBlueprint(bool $can_blueprint) {
		if ($can_blueprint) {
			$this->AddTag('blueprintable');
		} else {
			$this->RemoveTag('blueprintable');
		}
	}
	
	public function Harvestable() {
		return $this->IsTagged('harvestable');
	}
	
	public function SetHarvestable(bool $harvestable) {
		if ($harvestable) {
			$this->AddTag('harvestable');
		} else {
			$this->RemoveTag('harvestable');
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