<?php

namespace BeaconAPI\Ark;

class SpawnPoint extends \Ark\Blueprint {
	protected $groups = null;
	protected $limits = null;
	
	protected static function TableName() {
		return 'ark.spawn_points';
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
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('/spawn_point/' . urlencode($this->ObjectID()));
		return $json;
	}
	
	public function Spawns() {
		return $this->groups;
	}
	
	public function Limits() {
		return $this->limits;
	}
}

?>