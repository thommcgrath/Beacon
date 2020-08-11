<?php

class BeaconSpawnPoint extends BeaconAPI\SpawnPoint {
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT label, spawn_point_set_id AS group_id, weight, array_to_json(ARRAY(SELECT creatures.path FROM (SELECT DISTINCT spawn_point_set_entries.creature_id FROM spawn_point_set_entries WHERE spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id) AS entry_creatures INNER JOIN creatures ON (entry_creatures.creature_id = creatures.object_id))) AS creatures FROM spawn_point_sets WHERE spawn_point_sets.spawn_point_id = spawn_points.object_id) AS sets_template) AS spawn_groups';
		$columns[] = 'json_object(array(SELECT array[creatures.path, max_percentage::text] FROM spawn_point_limits INNER JOIN creatures ON (spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id)) AS spawn_limits';
		return $columns;
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
		if (is_null($this->groups) || count($this->groups) == 0) {
			$json['spawns'] = null;
			$json['groups'] = null;
		} else {
			$json['spawns'] = $this->groups;
			$json['groups'] = $this->groups;
		}
		if (is_null($this->limits) || count($this->limits) == 0) {
			$json['limits'] = null;
		} else {
			$json['limits'] = $this->limits;
		}
		return $json;
	}
}

?>