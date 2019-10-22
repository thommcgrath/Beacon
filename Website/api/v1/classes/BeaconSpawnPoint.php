<?php

class BeaconSpawnPoint extends BeaconBlueprint {
	private $groups = null;
	
	protected static function TableName() {
		return 'spawn_points';
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(groups_template))) FROM (SELECT label, group_id, weight, (SELECT array_to_json(array_agg(row_to_json(creatures_template))) FROM (SELECT creature_id, max_percentage FROM spawn_point_creatures WHERE spawn_point_creatures.group_id = spawn_point_groups.group_id) AS creatures_template) AS creatures FROM spawn_point_groups WHERE spawn_point_groups.spawn_point_id = spawn_points.object_id) AS groups_template) AS spawn_groups';
		return $columns;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'spawn_groups':
			return $this->groups;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->groups = is_null($row->Field('spawn_groups')) ? null : json_decode($row->Field('spawn_groups'), true);
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = BeaconAPI::URL('/spawn_point/' . urlencode($this->ObjectID()));
		$json['spawns'] = $this->groups;
		return $json;
	}
	
	public function Spawns() {
		return $this->groups;
	}
}

?>