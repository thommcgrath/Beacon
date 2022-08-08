<?php

namespace BeaconAPI\Ark;

class Engram extends \Ark\Blueprint {
	protected $entry_string = null;
	protected $required_points = null;
	protected $required_level = null;
	protected $stack_size = null;
	protected $item_id = null;
	protected $recipe = null;
	
	protected static function TableName() {
		return 'engrams';
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'entry_string';
		$columns[] = 'required_points';
		$columns[] = 'required_level';
		$columns[] = 'stack_size';
		$columns[] = 'item_id';
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
		case 'stack_size':
			return $this->stack_size;
		case 'item_id':
			return $this->item_id;
		case 'recipe':
			return $this->recipe;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->entry_string = $row->Field('entry_string');
		$obj->required_points = $row->Field('required_points');
		$obj->required_level = $row->Field('required_level');
		$obj->stack_size = $row->Field('stack_size');
		$obj->item_id = $row->Field('item_id');
		$obj->recipe = is_null($row->Field('recipe')) ? null : json_decode($row->Field('recipe'), true);
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
		return is_null($this->required_points) ? null : intval($this->required_points);
	}
	
	public function RequiredLevel() {
		return is_null($this->required_level) ? null : intval($this->required_level);
	}
	
	public function StackSize() {
		return is_null($this->stack_size) ? null : intval($this->stack_size);
	}
	
	public function ItemID() {
		return is_null($this->item_id) ? null : intval($this->item_id);
	}
	
	public function Recipe() {
		return $this->recipe;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['can_blueprint'] = $this->CanBlueprint();
		$json['entry_string'] = $this->EntryString();
		$json['required_points'] = $this->RequiredPoints();
		$json['required_level'] = $this->RequiredLevel();
		$json['stack_size'] = $this->StackSize();
		$json['item_id'] = $this->ItemID();
		if (is_null($this->recipe) || count($this->recipe) == 0) {
			$json['recipe'] = null;
		} else {
			$json['recipe'] = $this->recipe;
		}
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
		$database = \BeaconCommon::Database();
		$arr = array();
		$results = $database->Query('SELECT creature_id FROM ark.creature_engrams WHERE engram_id = $1;', $this->ObjectID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('creature_id');
			$results->MoveNext();
		}
		$results = $database->Query('SELECT DISTINCT diet_id FROM ark.diet_contents WHERE engram_id = $1;', $this->ObjectID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('diet_id');
			$results->MoveNext();
		}
		return $arr;
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('entry_string', $json)) {
			$value = $json['entry_string'];
			if (is_null($value) || (is_string($value) && substr($value, -2) === '_C')) {
				$this->entry_string = $value;
			} else {
				throw new \Exception('Entry string should end in _C.');
			}
		}
		
		if (array_key_exists('required_points', $json)) {
			$value = $json['required_points'];
			if (is_null($value) || is_int($value)) {
				$this->required_points = $value;
			} else {
				throw new \Exception('Required points should be a whole number.');
			}
		}
		
		if (array_key_exists('required_level', $json)) {
			$value = $json['required_level'];
			if (is_null($value) || is_int($value)) {
				$this->required_level = $value;
			} else {
				throw new \Exception('Required level should be a whole number.');
			}
		}
		
		if (array_key_exists('stack_size', $json)) {
			$value = $json['stack_size'];
			if (is_null($value) || (is_int($value) && $value > 0)) {
				$this->stack_size = $value;
			} else {
				throw new \Exception('Stack size should be a whole number.');
			}
		}
		
		if (array_key_exists('recipe', $json)) {
			$value = $json['recipe'];
			if (is_null($value) || (is_array($value) && \BeaconCommon::IsAssoc($value) === false)) {
				$this->recipe = $value;
			} else {
				throw new \Exception('Recipe should be an array of ingredients.');
			}
		}
	}
}

?>
