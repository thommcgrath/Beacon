<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class SpawnPoint extends MutableBlueprint {
	protected ?array $sets;
	protected ?array $limits;
	protected ?array $populations;

	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);

		if (is_null($row->Field('sets')) === false) {
			$this->sets = json_decode($row->Field('sets'), true);
		} else {
			$this->sets = null;
		}

		if (is_null($row->Field('limits'))) {
			$this->limits = null;
		} else {
			$this->limits = json_decode($row->Field('limits'), true);
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

	protected static function CustomVariablePrefix(): string {
		return 'spawnPoint';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('spawn_points');
		$schema->AddColumns([
			new DatabaseObjectProperty('sets', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id AS "spawnPointSetId", label, weight, spawn_offset AS "spawnOffset", min_distance_from_players_multiplier AS "minDistanceFromPlayersMultiplier", min_distance_from_structures_multiplier AS "minDistanceFromStructuresMultiplier", min_distance_from_tamed_dinos_multiplier AS "minDistanceFromTamedDinosMultiplier", spread_radius AS "spreadRadius", water_only_minimum_height AS "waterOnlyMinimumHeight", offset_before_multiplier AS "offsetBeforeMultiplier", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id AS "spawnPointSetEntryId", creature_id AS "creatureId", weight, override, min_level_multiplier AS "minLevelMultiplier", max_level_multiplier AS "maxLevelMultiplier", min_level_offset AS "minLevelOffset", max_level_offset AS "maxLevelOffset", spawn_offset AS "spawnOffset", (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level AS "minLevel", max_level AS "maxLevel" FROM arksa.spawn_point_set_entry_levels WHERE arksa.spawn_point_set_entry_levels.spawn_point_set_entry_id = arksa.spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS "levelOverrides" FROM arksa.spawn_point_set_entries INNER JOIN arksa.creatures ON (spawn_point_set_entries.creature_id = creatures.object_id) WHERE arksa.spawn_point_set_entries.spawn_point_set_id = arksa.spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT target_creature_id AS "creatureId", (SELECT array_to_json(array_agg(row_to_json(choices_template))) FROM (SELECT replacement_creature_id AS "creatureId", weight FROM arksa.spawn_point_set_replacements WHERE target_creature_id = target_creature_id AND spawn_point_set_replacements.spawn_point_set_id = spawn_point_sets.spawn_point_set_id) AS choices_template) AS choices FROM arksa.spawn_point_set_replacements INNER JOIN arksa.creatures AS targets ON (spawn_point_set_replacements.target_creature_id = targets.object_id) WHERE spawn_point_set_replacements.spawn_point_set_id = spawn_point_sets.spawn_point_set_id GROUP BY target_creature_id, targets.path, targets.class_string, targets.content_pack_id) AS replacements_template) AS replacements FROM arksa.spawn_point_sets WHERE arksa.spawn_point_sets.spawn_point_id = arksa.spawn_points.object_id) AS sets_template)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('limits', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(limits_template))) FROM (SELECT spawn_point_limits.creature_id AS "creatureId", spawn_point_limits.max_percentage AS "maxPercentage" FROM arksa.spawn_point_limits INNER JOIN arksa.creatures ON (arksa.spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id) AS limits_template)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('populations', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(pop_template))) FROM (SELECT ark_identifier AS "arkIdentifier", instances_on_map AS "instancesOnMap", max_population AS "maxPopulation" FROM arksa.spawn_point_populations INNER JOIN arksa.maps ON (spawn_point_populations.map_id = maps.map_id) WHERE spawn_point_populations.spawn_point_id = spawn_points.object_id ORDER BY ark_identifier) AS pop_template)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever])
		]);
		return $schema;
	}

	public function Populations(): array {
		return $this->populations ?? [];
	}

	public function Spawns(): array {
		return $this->sets ?? [];
	}

	public function Limits(): array {
		return $this->limits ?? [];
	}

	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['spawnPointGroup']);
		if (is_null($this->sets) || count($this->sets) == 0) {
			$json['sets'] = null;
		} else {
			$json['sets'] = $this->sets;
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

	protected function SaveChildObjects(BeaconDatabase $database): void {
		parent::SaveChildObjects($database);
		$this->SaveSets($database);
		$this->SaveLimits($database);
	}

	protected function SaveSets(BeaconDatabase $database) {
		$spawnPointId = $this->ObjectID();
		$setsList = [];
		if (is_null($this->sets) === false) {
			foreach ($this->sets as $set) {
				$spawnPointSetId = $set['spawnPointSetId'];
				if (BeaconCommon::IsUUID($spawnPointSetId)) {
					$setsList[] = $spawnPointSetId;
				} else {
					throw new Exception('Spawn point set id is not a uuid.');
				}

				$columnMap = [
					'label' => 'label',
					'weight' => 'weight',
					'minDistanceFromPlayersMultiplier' => 'min_distance_from_players_multiplier',
					'minDistanceFromStructuresMultiplier' => 'min_distance_from_structures_multiplier',
					'minDistanceFromTamedDinosMultiplier' => 'min_distance_from_tamed_dinos_multiplier',
					'spreadRadius' => 'spread_radius',
					'waterOnlyMinimumHeight' => 'water_only_minimum_height',
					'offsetBeforeMultiplier' => 'offset_before_multiplier',
				];
				$columns = [
					'spawn_point_set_id' => $spawnPointSetId,
					'spawn_point_id' => $spawnPointId,
				];
				foreach ($columnMap as $propertyName => $columnName) {
					if (array_key_exists($propertyName, $set)) {
						$columns[$columnName] = $set[$propertyName];
					}
				}
				if (array_key_exists('spawnOffset', $set)) {
					if (is_null($set['spawnOffset']) === false) {
						$offset = $set['spawnOffset'];
						$columns['spawn_offset'] = '(' . $offset['x'] . ',' . $offset['y'] . ',' . $offset['z'] . ')';
					} else {
						$columns['spawn_offset'] = null;
					}
				}

				$database->Upsert('arksa.spawn_point_sets', $columns, ['spawn_point_set_id']);

				$this->SaveSetEntries($database, $spawnPointSetId, $set['entries']);
				$this->SaveSetReplacements($database, $spawnPointSetId, $set['replacements']);
			}
		}
		if (count($setsList) > 0) {
			$database->Query('DELETE FROM arksa.spawn_point_sets WHERE spawn_point_id = $1 AND spawn_point_set_id NOT IN (\'' . implode('\', \'', $setsList) . '\');', $spawnPointId);
		} else {
			$database->Query('DELETE FROM arksa.spawn_point_sets WHERE spawn_point_id = $1;', $spawnPointId);
		}
	}

	protected function SaveSetEntries(BeaconDatabase $database, string $spawnPointSetId, ?array $entries) {
		$keepEntries = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$inserted = $database->Upsert('arksa.spawn_point_set_entries', [
					'spawn_point_set_entry_id' => $entry['spawnPointSetEntryId'],
					'spawn_point_set_id' => $spawnPointSetId,
					'creature_id' => $entry['creatureId'],
					'weight' => $entry['weight'],
					'override' => $entry['override'],
					'min_level_multiplier' => $entry['minLevelMultiplier'],
					'max_level_multiplier' => $entry['maxLevelMultiplier'],
					'min_level_offset' => $entry['minLevelOffset'],
					'max_level_offset' => $entry['maxLevelOffset'],
					'spawn_offset' => (is_null($entry['spawnOffset']) ? null : ('(' . $entry['spawnOffset']['x'] . ',' . $entry['spawnOffset']['y'] . ',' . $entry['spawnOffset']['z'] . ')'))
				], ['spawn_point_set_entry_id']);
				$keepEntries[] = $inserted->Field('spawn_point_set_entry_id');

				$this->SaveSetEntryLevels($database, $entry['spawnPointSetEntryId'], $entry['levelOverrides']);
			}
		}
		if (count($keepEntries) > 0) {
			$database->Query('DELETE FROM arksa.spawn_point_set_entries WHERE spawn_point_set_id = $1 AND spawn_point_set_entry_id NOT IN (\'' . implode('\', \'', $keepEntries) . '\');', $spawnPointSetId);
		} else {
			$database->Query('DELETE FROM arksa.spawn_point_set_entries WHERE spawn_point_set_id = $1;', $spawnPointSetId);
		}
	}

	protected function SaveSetEntryLevels(BeaconDatabase $database, string $spawnPointSetEntryId, ?array $levels) {
		$keepLevels = [];
		if (is_null($levels) === false) {
			foreach ($levels as $level) {
				$inserted = $database->Upsert('arksa.spawn_point_set_entry_levels', [
					'spawn_point_set_entry_id' => $spawnPointSetEntryId,
					'difficulty' => $level['difficulty'],
					'min_level' => $level['minLevel'],
					'max_level' => $level['maxLevel']
				], ['spawn_point_set_entry_id', 'difficulty']);
				$keepLevels[] = $inserted->Field('spawn_point_set_entry_level_id');
			}
		}
		if (count($keepLevels) > 0) {
			$database->Query('DELETE FROM arksa.spawn_point_set_entry_levels WHERE spawn_point_set_entry_id = $1 AND spawn_point_set_entry_level_id NOT IN (\'' . implode('\', \'', $keepLevels) . '\');', $spawnPointSetEntryId);
		} else {
			$database->Query('DELETE FROM arksa.spawn_point_set_entry_levels WHERE spawn_point_set_entry_id = $1;', $spawnPointSetEntryId);
		}
	}

	protected function SaveSetReplacements(BeaconDatabase $database, string $spawnPointSetId, ?array $replacements) {
		$keepReplacements = [];
		if (is_null($replacements) === false) {
			foreach ($replacements as $replacement) {
				$targetCreatureId = $replacement['creatureId'];
				foreach ($replacement['choices'] as $choice) {
					$inserted = $database->Upsert('arksa.spawn_point_set_replacements', [
						'spawn_point_set_id' => $spawnPointSetId,
						'target_creature_id' => $targetCreatureId,
						'replacement_creature_id' => $choice['creatureId'],
						'weight' => $choice['weight']
					], ['spawn_point_set_id', 'target_creature_id', 'replacement_creature_id']);
					$keepReplacements[] = $inserted->Field('spawn_point_set_replacement_id');
				}
			}
		}
		if (count($keepReplacements) > 0) {
			$database->Query('DELETE FROM arksa.spawn_point_set_replacements WHERE spawn_point_set_id = $1 AND spawn_point_set_replacement_id NOT IN (\'' . implode('\', \'', $keepReplacements) . '\');', $spawnPointSetId);
		} else {
			$database->Query('DELETE FROM arksa.spawn_point_set_replacements WHERE spawn_point_set_id = $1;', $spawnPointSetId);
		}
	}

	protected function SaveLimits(BeaconDatabase $database) {
		$spawnPointId = $this->ObjectID();
		$creatureList = [];
		if (is_null($this->limits) === false) {
			foreach ($this->limits as $limit) {
				$creatureId = $limit['creatureId'];
				$percentage = $limit['maxPercentage'];
				if (BeaconCommon::IsUUID($creatureId)) {
					$creatureList[] = $creatureId;
				} else {
					throw new Exception('Key for limit is not a uuid.');
				}

				$database->Query('INSERT INTO arksa.spawn_point_limits (spawn_point_id, creature_id, max_percentage) VALUES ($1, $2, $3) ON CONFLICT (spawn_point_id, creature_id) DO UPDATE SET max_percentage = $3 WHERE spawn_point_limits.max_percentage IS DISTINCT FROM $3;', $spawnPointId, $creatureId, $percentage);
			}
		}
		if (count($creatureList) > 0) {
			$database->Query('DELETE FROM arksa.spawn_point_limits WHERE spawn_point_id = $1 AND creature_id NOT IN (\'' . implode('\', \'', $creatureList) . '\');', $spawnPointId);
		} else {
			$database->Query('DELETE FROM arksa.spawn_point_limits WHERE spawn_point_id = $1;', $spawnPointId);
		}
	}
}

?>
