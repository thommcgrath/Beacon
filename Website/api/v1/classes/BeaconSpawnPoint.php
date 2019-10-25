<?php

class BeaconSpawnPoint extends BeaconBlueprint {
	private $groups = null;
	private $limits = null;
	
	protected static function TableName() {
		return 'spawn_points';
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(groups_template))) FROM (SELECT label, group_id, weight, array_to_json(ARRAY(SELECT creature_id FROM spawn_point_creatures WHERE spawn_point_creatures.group_id = spawn_point_groups.group_id)) AS creatures FROM spawn_point_groups WHERE spawn_point_groups.spawn_point_id = spawn_points.object_id) AS groups_template) AS spawn_groups';
		$columns[] = 'json_object(array(SELECT array[creature_id::text, max_percentage::text] FROM spawn_point_limits WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id)) AS spawn_limits';
		return $columns;
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
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->groups = is_null($row->Field('spawn_groups')) ? null : json_decode($row->Field('spawn_groups'), true);
		$obj->limits = is_null($row->Field('spawn_limits')) ? null : json_decode($row->Field('spawn_limits'), true);
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = BeaconAPI::URL('/spawn_point/' . urlencode($this->ObjectID()));
		$json['spawns'] = $this->groups;
		$json['groups'] = $this->groups;
		$json['limits'] = $this->limits;
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