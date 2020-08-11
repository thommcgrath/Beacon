<?php

class BeaconSpawnPoint extends BeaconAPI\SpawnPoint {
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id, label, weight, spawn_offset, min_distance_from_players_multiplier, min_distance_from_structures_multiplier, min_distance_from_tamed_dinos_multiplier, spread_radius, water_only_minimum_height, offset_before_multiplier, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id, creature_id, weight, override, min_level_multiplier, max_level_multiplier, min_level_offset, max_level_offset, spawn_offset, (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level, max_level FROM spawn_point_set_entry_levels WHERE spawn_point_set_entry_levels.spawn_point_set_entry_id = spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS level_overrides FROM spawn_point_set_entries WHERE spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT spawn_point_set_replacement_id, target_creature_id, replacement_creature_id FROM spawn_point_set_replacements WHERE spawn_point_set_replacements.spawn_point_set_id = spawn_point_sets.spawn_point_set_id) AS replacements_template) AS replacements FROM spawn_point_sets WHERE spawn_point_sets.spawn_point_id = spawn_points.object_id) AS sets_template) AS spawn_sets';
		$columns[] = 'json_object(array(SELECT array[creatures.object_id::text, max_percentage::text] FROM spawn_point_limits INNER JOIN creatures ON (spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id)) AS spawn_limits';
		return $columns;
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->groups = is_null($row->Field('spawn_sets')) ? null : json_decode($row->Field('spawn_sets'), true);
		
		if (is_null($row->Field('spawn_limits'))) {
			$obj->limits = null;
		} else {
			$decoded = json_decode($row->Field('spawn_limits'), true);
			$obj->limits = [];
			foreach ($decoded as $creature_id => $weight) {
				$obj->limits[$creature_id] = floatval($weight);
			}
		}
		
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		if (is_null($this->groups) || count($this->groups) == 0) {
			$json['sets'] = null;
		} else {
			$json['sets'] = $this->groups;
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