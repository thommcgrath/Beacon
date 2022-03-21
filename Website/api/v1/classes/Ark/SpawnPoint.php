<?php

namespace Ark;

class SpawnPoint extends \BeaconAPI\Ark\SpawnPoint {
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT label, spawn_point_set_id AS group_id, weight, array_to_json(ARRAY(SELECT creatures.path FROM (SELECT DISTINCT spawn_point_set_entries.creature_id FROM ark.spawn_point_set_entries WHERE ark.spawn_point_set_entries.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id) AS entry_creatures INNER JOIN ark.creatures ON (entry_creatures.creature_id = ark.creatures.object_id))) AS creatures FROM ark.spawn_point_sets WHERE ark.spawn_point_sets.spawn_point_id = ark.spawn_points.object_id) AS sets_template) AS spawn_groups';
		$columns[] = 'json_object(array(SELECT array[ark.creatures.path, max_percentage::text] FROM ark.spawn_point_limits INNER JOIN ark.creatures ON (ark.spawn_point_limits.creature_id = ark.creatures.object_id) WHERE ark.spawn_point_limits.spawn_point_id = ark.spawn_points.object_id)) AS spawn_limits';
		return $columns;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
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
		$json['resource_url'] = \BeaconAPI::URL('spawn_point/' . urlencode($this->ObjectID()));
		return $json;
	}
}

?>