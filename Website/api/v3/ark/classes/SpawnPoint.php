<?php

namespace Ark;

class SpawnPoint extends \BeaconAPI\Ark\SpawnPoint {
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id, label, weight, spawn_offset, min_distance_from_players_multiplier, min_distance_from_structures_multiplier, min_distance_from_tamed_dinos_multiplier, spread_radius, water_only_minimum_height, offset_before_multiplier, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id, creature_id, weight, override, min_level_multiplier, max_level_multiplier, min_level_offset, max_level_offset, spawn_offset, (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level, max_level FROM ark.spawn_point_set_entry_levels WHERE ark.spawn_point_set_entry_levels.spawn_point_set_entry_id = ark.spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS level_overrides FROM ark.spawn_point_set_entries WHERE ark.spawn_point_set_entries.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT target_creature_id AS creature_id, json_object(array_agg(array[replacement_creature_id::text, weight::text])) AS choices FROM ark.spawn_point_set_replacements WHERE ark.spawn_point_set_replacements.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id GROUP BY target_creature_id) AS replacements_template) AS replacements FROM ark.spawn_point_sets WHERE ark.spawn_point_sets.spawn_point_id = ark.spawn_points.object_id) AS sets_template) AS spawn_sets';
		$columns[] = 'json_object(array(SELECT array[ark.creatures.object_id::text, max_percentage::text] FROM ark.spawn_point_limits INNER JOIN ark.creatures ON (ark.spawn_point_limits.creature_id = ark.creatures.object_id) WHERE ark.spawn_point_limits.spawn_point_id = ark.spawn_points.object_id)) AS spawn_limits';
		return $columns;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		
		if (is_null($row->Field('spawn_sets')) === false) {
			$sets = json_decode($row->Field('spawn_sets'), true);
			for ($i = 0; $i < count($sets); $i++) {
				$replacements = $sets[$i]['replacements'];
				if (is_null($replacements) === false) {
					for ($j = 0; $j < count($replacements); $j++) {
						$choices = $replacements[$j]['choices'];
						foreach ($choices as $creature_id => $weight) {
							$choices[$creature_id] = floatval($weight);
						}
						$replacements[$j]['choices'] = $choices;
					}
					$sets[$i]['replacements'] = $replacements;
				}
			}
			$obj->groups = $sets;
		} else {
			$obj->groups = null;
		}
		
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
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('sets', $json)) {
			$sets = $json['sets'];
			if (is_null($sets) || (is_array($sets) && \BeaconCommon::IsAssoc($sets) === false)) {
				$this->groups = $sets;
			} else {
				throw new \Exception('Sets should be an array of spawn entry sets.');
			}
		}
		
		if (array_key_exists('limits', $json)) {
			$limits = $json['limits'];
			if (is_null($limits) || (is_array($limits) && \BeaconCommon::IsAssoc($limits) === true)) {
				$this->limits = $limits;
			} else {
				throw new \Exception('Limits should be an structure of creature uuid keys and percentage values.'); 
			}
		}
	}
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		
		$this->SaveSets($database);
		$this->SaveLimits($database);
	}
	
	protected function SaveSets(\BeaconDatabase $database) {
		$spawn_point_id = $this->ObjectID();
		$sets_list = [];
		if (is_null($this->groups) === false) {
			foreach ($this->groups as $set) {
				$set_id = $set['spawn_point_set_id'];
				if (\BeaconCommon::IsUUID($set_id)) {
					$sets_list[] = $set_id;
				} else {
					throw new \Exception('Spawn point set id is not a uuid.');
				}
				
				$set['spawn_point_id'] = $spawn_point_id;
				$entries = $set['entries'];
				$replacements = $set['replacements'];
				unset($set['entries'], $set['replacements']);
				
				if (is_null($set['spawn_offset']) === false) {
					$offset = $set['spawn_offset'];
					$set['spawn_offset'] = '(' . $offset['x'] . ',' . $offset['y'] . ',' . $offset['z'] . ')';	
				}
				
				$database->Upsert('spawn_point_sets', $set, ['spawn_point_set_id']);
				
				$this->SaveSetEntries($database, $set['spawn_point_set_id'], $entries);
				$this->SaveSetReplacements($database, $set['spawn_point_set_id'], $replacements);
			}
		}
		if (count($sets_list) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_sets WHERE spawn_point_id = $1 AND spawn_point_set_id NOT IN (\'' . implode('\', \'', $sets_list) . '\');', $spawn_point_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_sets WHERE spawn_point_id = $1;', $spawn_point_id);
		}
	}
	
	protected function SaveSetEntries(\BeaconDatabase $database, string $spawn_point_set_id, $entries) {
		$keep_entries = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$inserted = $database->Upsert('spawn_point_set_entries', [
					'spawn_point_set_entry_id' => $entry['spawn_point_set_entry_id'],
					'spawn_point_set_id' => $spawn_point_set_id,
					'creature_id' => $entry['creature_id'],
					'weight' => $entry['weight'],
					'override' => $entry['override'],
					'min_level_multiplier' => $entry['min_level_multiplier'],
					'max_level_multiplier' => $entry['max_level_multiplier'],
					'min_level_offset' => $entry['min_level_offset'],
					'max_level_offset' => $entry['max_level_offset'],
					'spawn_offset' => (is_null($entry['spawn_offset']) ? null : ('(' . $entry['spawn_offset']['x'] . ',' . $entry['spawn_offset']['y'] . ',' . $entry['spawn_offset']['z'] . ')'))
				], ['spawn_point_set_entry_id']);
				$keep_entries[] = $inserted->Field('spawn_point_set_entry_id');
				
				$this->SaveSetEntryLevels($database, $entry['spawn_point_set_entry_id'], $entry['level_overrides']);
			}
		}
		if (count($keep_entries) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_set_entries WHERE spawn_point_set_id = $1 AND spawn_point_set_entry_id NOT IN (\'' . implode('\', \'', $keep_entries) . '\');', $spawn_point_set_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_set_entries WHERE spawn_point_set_id = $1;', $spawn_point_set_id);
		}
	}
	
	protected function SaveSetEntryLevels(\BeaconDatabase $database, string $spawn_point_set_entry_id, $levels) {
		$keep_levels = [];
		if (is_null($levels) === false) {
			foreach ($levels as $level) {
				$inserted = $database->Upsert('spawn_point_set_entry_levels', [
					'spawn_point_set_entry_id' => $spawn_point_set_entry_id,
					'difficulty' => $level['difficulty'],
					'min_level' => $level['min_level'],
					'max_level' => $level['max_level']
				], ['spawn_point_set_entry_id', 'difficulty']);
				$keep_levels[] = $inserted->Field('spawn_point_set_entry_level_id');
			}
		}
		if (count($keep_levels) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_set_entry_levels WHERE spawn_point_set_entry_id = $1 AND spawn_point_set_entry_level_id NOT IN (\'' . implode('\', \'', $keep_levels) . '\');', $spawn_point_set_entry_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_set_entry_levels WHERE spawn_point_set_entry_id = $1;', $spawn_point_set_entry_id);
		}
	}
	
	protected function SaveSetReplacements(\BeaconDatabase $database, string $spawn_point_set_id, $replacements) {
		$keep_replacements = [];
		if (is_null($replacements) === false) {
			foreach ($replacements as $replacement) {
				$target_creature_id = $replacement['creature_id'];
				$choices = $replacement['choices'];
				foreach ($choices as $replacement_creature_id => $weight) {
					$inserted = $database->Upsert('spawn_point_set_replacements', [
						'spawn_point_set_id' => $spawn_point_set_id,
						'target_creature_id' => $target_creature_id,
						'replacement_creature_id' => $replacement_creature_id,
						'weight' => $weight
					], ['spawn_point_set_id', 'target_creature_id', 'replacement_creature_id']);
					$keep_replacements[] = $inserted->Field('spawn_point_set_replacement_id');
				}
			}
		}
		if (count($keep_replacements) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_set_replacements WHERE spawn_point_set_id = $1 AND spawn_point_set_replacement_id NOT IN (\'' . implode('\', \'', $keep_replacements) . '\');', $spawn_point_set_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_set_replacements WHERE spawn_point_set_id = $1;', $spawn_point_set_id);
		}
	}
	
	protected function SaveLimits(\BeaconDatabase $database) {
		$spawn_point_id = $this->ObjectID();
		$creature_list = [];
		if (is_null($this->limits) === false) {
			foreach ($this->limits as $creature_id => $percentage) {
				if (\BeaconCommon::IsUUID($creature_id)) {
					$creature_list[] = $creature_id;
				} else {
					throw new \Exception('Key for limit is not a uuid.');
				}
				
				$database->Query('INSERT INTO ark.spawn_point_limits (spawn_point_id, creature_id, max_percentage) VALUES ($1, $2, $3) ON CONFLICT (spawn_point_id, creature_id) DO UPDATE SET max_percentage = $3 WHERE spawn_point_limits.max_percentage IS DISTINCT FROM $3;', $spawn_point_id, $creature_id, $percentage);
			}
		}
		if (count($creature_list) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_limits WHERE spawn_point_id = $1 AND creature_id NOT IN (\'' . implode('\', \'', $creature_list) . '\');', $spawn_point_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_limits WHERE spawn_point_id = $1;', $spawn_point_id);
		}
	}
}

?>