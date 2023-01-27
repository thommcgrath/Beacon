<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class SpawnPoint extends Blueprint {
	protected $groups = null;
	protected $limits = null;
	protected $populations = null;
	
	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
		$this->objectGroup = 'spawnPoints';
		
		if (is_null($row->Field('spawn_sets')) === false) {
			$this->groups = json_decode($row->Field('spawn_sets'), true);
		} else {
			$this->groups = null;
		}
		
		if (is_null($row->Field('spawn_limits'))) {
			$this->limits = null;
		} else {
			$this->limits = json_decode($row->Field('spawn_limits'), true);
		}
		
		if (is_null($row->Field('populations'))) {
			$this->populations = null;
		} else {
			$decoded = json_decode($row->Field('populations'), true);
			$this->populations = [];
			foreach ($decoded as $popdata) {
				$this->populations[$popdata['arkIdentifier']] = [
					'instances' => $popdata['instancesOnMap'],
					'targetPopulation' => $popdata['maxPopulation']
				];
			}
		}
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('spawn_points');
		$schema->AddColumns([
			new DatabaseObjectProperty('spawn_sets', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id AS "spawnPointSetId", label, weight, spawn_offset AS "spawnOffset", min_distance_from_players_multiplier AS "minDistanceFromPlayersMultiplier", min_distance_from_structures_multiplier AS "minDistanceFromStructuresMultiplier", min_distance_from_tamed_dinos_multiplier AS "minDistanceFromTamedDinosMultiplier", spread_radius AS "spreadRadius", water_only_minimum_height AS "waterOnlyMinimumHeight", offset_before_multiplier AS "offsetBeforeMultiplier", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id AS "spawnPointSetEntryId", creature_id AS "creatureId", weight, override, min_level_multiplier AS "minLevelMultiplier", max_level_multiplier AS "maxLevelMultiplier", min_level_offset AS "minLevelOffset", max_level_offset AS "maxLevelOffset", spawn_offset AS "spawnOffset", (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level AS "minLevel", max_level AS "maxLevel" FROM ark.spawn_point_set_entry_levels WHERE ark.spawn_point_set_entry_levels.spawn_point_set_entry_id = ark.spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS "levelOverrides" FROM ark.spawn_point_set_entries INNER JOIN ark.creatures ON (spawn_point_set_entries.creature_id = creatures.object_id) WHERE ark.spawn_point_set_entries.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT target_creature_id AS "creatureId", (SELECT array_to_json(array_agg(row_to_json(choices_template))) FROM (SELECT replacement_creature_id AS "creatureId", weight FROM ark.spawn_point_set_replacements WHERE target_creature_id = target_creature_id) AS choices_template) AS choices FROM ark.spawn_point_set_replacements INNER JOIN ark.creatures AS targets ON (spawn_point_set_replacements.target_creature_id = targets.object_id) WHERE ark.spawn_point_set_replacements.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id GROUP BY target_creature_id, targets.path, targets.class_string, targets.mod_id) AS replacements_template) AS replacements FROM ark.spawn_point_sets WHERE ark.spawn_point_sets.spawn_point_id = ark.spawn_points.object_id) AS sets_template)']),
			new DatabaseObjectProperty('spawn_limits', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(limits_template))) FROM (SELECT spawn_point_limits.creature_id AS "creatureId", spawn_point_limits.max_percentage AS "maxPercentage" FROM ark.spawn_point_limits INNER JOIN ark.creatures ON (ark.spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id) AS limits_template)']),
			new DatabaseObjectProperty('populations', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(pop_template))) FROM (SELECT ark_identifier AS "arkIdentifier", instances_on_map AS "instancesOnMap", max_population AS "maxPopulation" FROM ark.spawn_point_populations INNER JOIN ark.maps ON (spawn_point_populations.map_id = maps.map_id) WHERE spawn_point_populations.spawn_point_id = spawn_points.object_id ORDER BY ark_identifier) AS pop_template)'])
		]);
		return $schema;
	}
	
	/*protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id, label, weight, spawn_offset, min_distance_from_players_multiplier, min_distance_from_structures_multiplier, min_distance_from_tamed_dinos_multiplier, spread_radius, water_only_minimum_height, offset_before_multiplier, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id, creature_id, creatures.path, creatures.class_string, creatures.mod_id, weight, override, min_level_multiplier, max_level_multiplier, min_level_offset, max_level_offset, spawn_offset, (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level, max_level FROM ark.spawn_point_set_entry_levels WHERE ark.spawn_point_set_entry_levels.spawn_point_set_entry_id = ark.spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS level_overrides FROM ark.spawn_point_set_entries INNER JOIN ark.creatures ON (spawn_point_set_entries.creature_id = creatures.object_id) WHERE ark.spawn_point_set_entries.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT target_creature_id AS creature_id, targets.path, targets.class_string, targets.mod_id, (SELECT array_to_json(array_agg(row_to_json(choices_template))) FROM (SELECT object_id, path, class_string, mod_id, weight FROM ark.spawn_point_set_replacements INNER JOIN ark.creatures ON (spawn_point_set_replacements.replacement_creature_id = creatures.object_id) WHERE target_creature_id = target_creature_id) AS choices_template) AS choices FROM ark.spawn_point_set_replacements INNER JOIN ark.creatures AS targets ON (spawn_point_set_replacements.target_creature_id = targets.object_id) WHERE ark.spawn_point_set_replacements.spawn_point_set_id = ark.spawn_point_sets.spawn_point_set_id GROUP BY target_creature_id, targets.path, targets.class_string, targets.mod_id) AS replacements_template) AS replacements FROM ark.spawn_point_sets WHERE ark.spawn_point_sets.spawn_point_id = ark.spawn_points.object_id) AS sets_template) AS spawn_sets';
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(limits_template))) FROM (SELECT spawn_point_limits.creature_id, spawn_point_limits.max_percentage, creatures.path, creatures.class_string, creatures.mod_id FROM ark.spawn_point_limits INNER JOIN ark.creatures ON (ark.spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id) AS limits_template) AS spawn_limits';
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(pop_template))) FROM (SELECT ark_identifier, instances_on_map, max_population FROM ark.spawn_point_populations INNER JOIN ark.maps ON (spawn_point_populations.map_id = maps.map_id) WHERE spawn_point_populations.spawn_point_id = spawn_points.object_id ORDER BY ark_identifier) AS pop_template) AS populations';
		return $columns;
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		
		if (is_null($row->Field('spawn_sets')) === false) {
			$sets = json_decode($row->Field('spawn_sets'), true);
			for ($i = 0; $i < count($sets); $i++) {
				$entries = $sets[$i]['entries'];
				if (is_null($entries) === false) {
					for ($entry_idx = 0; $entry_idx < count($entries); $entry_idx++) {
						$entry = $entries[$entry_idx];
						$entry['creature'] = [
							'Schema' => 'Beacon.BlueprintReference',
							'Version' => 1,
							'Kind' => 'Creature',
							'UUID' => $entry['creature_id'],
							'Path' => $entry['path'],
							'Class' => $entry['class_string'],
							'ModUUID' => $entry['mod_id']
						];
						unset($entry['creature_id'], $entry['path'], $entry['class_string'], $entry['mod_id']);
						$entries[$entry_idx] = $entry;
					}
					$sets[$i]['entries'] = $entries;
				}
				
				$replacements = $sets[$i]['replacements'];
				if (is_null($replacements) === false) {
					for ($j = 0; $j < count($replacements); $j++) {
						$replacement = $replacements[$j];
						
						$choices = $replacements[$j]['choices'];
						for ($choice_idx = 0; $choice_idx < count($choices); $choice_idx++) {
							$choice = $choices[$choice_idx];
							$choices[$choice_idx] = [
								'creature' => [
									'Schema' => 'Beacon.BlueprintReference',
									'Version' => 1,
									'Kind' => 'Creature',
									'UUID' => $choice['object_id'],
									'Path' => $choice['path'],
									'Class' => $choice['class_string'],
									'ModUUID' => $choice['mod_id']
								],
								'weight' => $choice['weight']
							];
						}
						$replacements[$j] = [
							'creature' => [
								'Schema' => 'Beacon.BlueprintReference',
								'Version' => 1,
								'Kind' => 'Creature',
								'UUID' => $replacement['creature_id'],
								'Path' => $replacement['path'],
								'Class' => $replacement['class_string'],
								'ModUUID' => $replacement['mod_id']
							],
							'choices' => $choices
						];
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
			foreach ($decoded as $limit) {
				$obj->limits[] = [
					'creature' => [
						'Schema' => 'Beacon.BlueprintReference',
						'Version' => 1,
						'Kind' => 'Creature',
						'UUID' => $limit['creature_id'],
						'Path' => $limit['path'],
						'ClassString' => $limit['class_string'],
						'ModUUID' => $limit['mod_id']
					],
					'max_percent' => $limit['max_percentage']
				];
			}
		}
		
		if (is_null($row->Field('populations'))) {
			$obj->populations = null;
		} else {
			$decoded = json_decode($row->Field('populations'), true);
			$obj->populations = [];
			foreach ($decoded as $popdata) {
				$obj->populations[$popdata['ark_identifier']] = [
					'instances' => $popdata['instances_on_map'],
					'target_population' => $popdata['max_population']
				];
			}
		}
		
		return $obj;
	}*/
	
	public function Populations(): array {
		return $this->populations ?? [];
	}
	
	public function Spawns(): array {
		return $this->groups ?? [];
	}
	
	public function Limits(): array {
		return $this->limits ?? [];
	}
	
	public function jsonSerialize(): mixed {
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
		if (is_null($this->populations) || count($this->populations) == 0) {
			$json['populations'] = null;
		} else {
			$json['populations'] = $this->populations;
		}
		return $json;
	}
	
	/*public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('sets', $json)) {
			$sets = $json['sets'];
			if (is_null($sets) || (is_array($sets) && BeaconCommon::IsAssoc($sets) === false)) {
				$this->groups = $sets;
			} else {
				throw new Exception('Sets should be an array of spawn entry sets.');
			}
		}
		
		if (array_key_exists('limits', $json)) {
			$limits = $json['limits'];
			if (is_null($limits) || (is_array($limits) && BeaconCommon::IsAssoc($limits) === false)) {
				$this->limits = $limits;
			} else {
				throw new Exception('Limits should be an array of structures.'); 
			}
		}
	}
	
	protected function SaveChildrenHook(BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		
		$this->SaveSets($database);
		$this->SaveLimits($database);
	}
	
	protected function SaveSets(BeaconDatabase $database) {
		$spawn_point_id = $this->ObjectID();
		$sets_list = [];
		if (is_null($this->groups) === false) {
			foreach ($this->groups as $set) {
				$set_id = $set['spawn_point_set_id'];
				if (BeaconCommon::IsUUID($set_id)) {
					$sets_list[] = $set_id;
				} else {
					throw new Exception('Spawn point set id is not a uuid.');
				}
				
				$set['spawn_point_id'] = $spawn_point_id;
				$entries = $set['entries'];
				$replacements = $set['replacements'];
				unset($set['entries'], $set['replacements']);
				
				if (is_null($set['spawn_offset']) === false) {
					$offset = $set['spawn_offset'];
					$set['spawn_offset'] = '(' . $offset['x'] . ',' . $offset['y'] . ',' . $offset['z'] . ')';	
				}
				
				$database->Upsert('ark.spawn_point_sets', $set, ['spawn_point_set_id']);
				
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
	
	protected function SaveSetEntries(BeaconDatabase $database, string $spawn_point_set_id, $entries) {
		$keep_entries = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$inserted = $database->Upsert('ark.spawn_point_set_entries', [
					'spawn_point_set_entry_id' => $entry['spawn_point_set_entry_id'],
					'spawn_point_set_id' => $spawn_point_set_id,
					'creature_id' => $entry['creature']['UUID'],
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
	
	protected function SaveSetEntryLevels(BeaconDatabase $database, string $spawn_point_set_entry_id, $levels) {
		$keep_levels = [];
		if (is_null($levels) === false) {
			foreach ($levels as $level) {
				$inserted = $database->Upsert('ark.spawn_point_set_entry_levels', [
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
	
	protected function SaveSetReplacements(BeaconDatabase $database, string $spawn_point_set_id, $replacements) {
		$keep_replacements = [];
		if (is_null($replacements) === false) {
			foreach ($replacements as $replacement) {
				$target_creature_id = $replacement['creature']['UUID'];
				foreach ($replacement['choices'] as $choice) {
					$inserted = $database->Upsert('ark.spawn_point_set_replacements', [
						'spawn_point_set_id' => $spawn_point_set_id,
						'target_creature_id' => $target_creature_id,
						'replacement_creature_id' => $choice['creature']['UUID'],
						'weight' => $choice['weight']
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
	
	protected function SaveLimits(BeaconDatabase $database) {
		$spawn_point_id = $this->ObjectID();
		$creature_list = [];
		if (is_null($this->limits) === false) {
			foreach ($this->limits as $limit) {
				$creature_id = $limit['creature']['UUID'];
				$percentage = $limit['max_percent'];
				if (BeaconCommon::IsUUID($creature_id)) {
					$creature_list[] = $creature_id;
				} else {
					throw new Exception('Key for limit is not a uuid.');
				}
				
				$database->Query('INSERT INTO ark.spawn_point_limits (spawn_point_id, creature_id, max_percentage) VALUES ($1, $2, $3) ON CONFLICT (spawn_point_id, creature_id) DO UPDATE SET max_percentage = $3 WHERE spawn_point_limits.max_percentage IS DISTINCT FROM $3;', $spawn_point_id, $creature_id, $percentage);
			}
		}
		if (count($creature_list) > 0) {
			$database->Query('DELETE FROM ark.spawn_point_limits WHERE spawn_point_id = $1 AND creature_id NOT IN (\'' . implode('\', \'', $creature_list) . '\');', $spawn_point_id);
		} else {
			$database->Query('DELETE FROM ark.spawn_point_limits WHERE spawn_point_id = $1;', $spawn_point_id);
		}
	}*/
}

?>