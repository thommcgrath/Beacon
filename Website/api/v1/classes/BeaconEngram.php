<?php

class BeaconEngram extends BeaconBlueprint {
	protected static function TableName() {
		return 'engrams';
	}
	
	public function SpawnCode() {
		return 'cheat giveitem "Blueprint\'' . $this->Path() . '\'" 1 0 false';
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['can_blueprint'] = $this->CanBlueprint();
		$json['resource_url'] = BeaconAPI::URL('/engram/' . urlencode($this->ObjectID()));
		
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