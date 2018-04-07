<?php

class BeaconCreature extends BeaconBlueprint {
	const TAMING_METHOD_NONE = 'None';
	const TAMING_METHOD_KNOCKOUT = 'Knockout';
	const TAMING_METHOD_PASSIVE = 'Passive';
	const TAMING_METHOD_TRAP = 'Trap';
	
	private $tamable;
	private $taming_diet_id;
	private $taming_method;
	private $tamed_diet_id;
	private $rideable;
	private $carryable;
	private $breedable;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'tamable';
		$columns[] = 'taming_diet';
		$columns[] = 'taming_method';
		$columns[] = 'tamed_diet';
		$columns[] = 'rideable';
		$columns[] = 'carryable';
		$columns[] = 'breedable';
		return $columns;
	}
	
	protected static function TableName() {
		return 'creatures';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'tamable':
			return $this->tamable;
		case 'taming_diet':
			return $this->taming_diet_id;
		case 'taming_method':
			return $this->taming_method;
		case 'tamed_diet':
			return $this->tamed_diet_id;
		case 'rideable':
			return $this->rideable;
		case 'carryable':
			return $this->carryable;
		case 'breedable':
			return $this->breedable;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->tamable = $row->Field('tamable');
		$obj->taming_diet_id = $row->Field('taming_diet');
		$obj->taming_method = $row->Field('taming_method');
		$obj->tamed_diet_id = $row->Field('tamed_diet');
		$obj->rideable = $row->Field('rideable');
		$obj->carryable = $row->Field('carryable');
		$obj->breedable = $row->Field('breedable');
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize(); 
		$json['tamable'] = $this->tamable;
		$json['taming_diet_id'] = $this->taming_diet_id;
		$json['taming_method'] = $this->taming_method;
		$json['tamed_diet'] = $this->tamed_diet_id;
		$json['rideable'] = $this->rideable;
		$json['carryable'] = $this->carryable;
		$json['breedable'] = $this->breedable;
		$json['related_object_ids'] = $this->RelatedObjectIDs();
		return $json;
	}
	
	public function SpawnCode() {
		return 'cheat spawndino "Blueprint\'' . $this->Path() . '\'" 1 1 1 30';
	}
	
	public function Tamable() {
		return $this->tamable;
	}
	
	public function SetTamable(bool $tamable) {
		$this->tamable = $tamable;
	}
	
	public function TamingDietID() {
		return $this->taming_diet_id;
	}
	
	public function SetTamingDietID(string $taming_diet_id) {
		$this->taming_diet_id = $taming_diet_id;
	}
	
	public function TamingDiet() {
		return BeaconDiet::GetByObjectID($this->taming_diet_id);
	}
	
	public function SetTamingDiet(BeaconDiet $taming_diet) {
		$this->taming_diet_id = $taming_diet->ObjectID();
	}
	
	public function TamedDietID() {
		return $this->tamed_diet_id;
	}
	
	public function SetTamedDietID(string $tamed_diet_id) {
		$this->tamed_diet_id = $tamed_diet_id;
	}
	
	public function TamedDiet() {
		return BeaconDiet::GetByObjectID($this->tamed_diet_id);
	}
	
	public function SetTamedDiet(BeaconDiet $tamed_diet) {
		$this->tamed_diet_id = $tamed_diet->ObjectID();
	}
	
	public function TamingMethod() {
		return $this->taming_method;
	}
	
	public function SetTamingMethod(string $taming_method) {
		switch ($taming_method) {
		case self::TAMING_METHOD_NONE:
		case self::TAMING_METHOD_KNOCKOUT:
		case self::TAMING_METHOD_PASSIVE:
		case self::TAMING_METHOD_TRAP:
			$this->taming_method = $taming_method;
		}
	}
	
	public function Rideable() {
		return $this->rideable;
	}
	
	public function SetRideable(bool $rideable) {
		$this->rideable = $rideable;
	}
	
	public function Carryable() {
		return $this->carryable;
	}
	
	public function SetCarryable(bool $carryable) {
		$this->carryable = $carryable;
	}
	
	public function Breedable() {
		return $this->breedable;
	}
	
	public function SetBreedable(bool $breedable) {
		$this->breedable = $breedable;
	}
	
	public function RelatedObjectIDs() {
		$database = BeaconCommon::Database();
		$arr = array();
		$results = $database->Query('SELECT engram_id FROM creature_engrams WHERE creature_id = $1;', $this->ObjectID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('engram_id');
			$results->MoveNext();
		}
		return $arr;
	}
}

?>