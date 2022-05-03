<?php

namespace BeaconAPI\Ark;

class SpawnPoint extends \Ark\Blueprint {
	protected $groups = null;
	protected $limits = null;
	
	protected static function TableName() {
		return 'spawn_points';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'spawn_groups':
			return $this->groups;
		case 'spawn_limits':
			return $this->limits;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	public function Spawns() {
		return $this->groups;
	}
	
	public function Limits() {
		return $this->limits;
	}
}

?>