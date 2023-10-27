<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class SpawnPoint extends Blueprint {
	protected ?array $groups;
	protected ?array $limits;
	protected ?array $populations;
	
	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
		
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
	
	protected static function CustomVariablePrefix(): string {
		return 'spawnPoint';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('spawn_points');
		$schema->AddColumns([
			new DatabaseObjectProperty('spawn_sets', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT spawn_point_set_id AS "spawnPointSetId", label, weight, spawn_offset AS "spawnOffset", min_distance_from_players_multiplier AS "minDistanceFromPlayersMultiplier", min_distance_from_structures_multiplier AS "minDistanceFromStructuresMultiplier", min_distance_from_tamed_dinos_multiplier AS "minDistanceFromTamedDinosMultiplier", spread_radius AS "spreadRadius", water_only_minimum_height AS "waterOnlyMinimumHeight", offset_before_multiplier AS "offsetBeforeMultiplier", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT spawn_point_set_entry_id AS "spawnPointSetEntryId", creature_id AS "creatureId", weight, override, min_level_multiplier AS "minLevelMultiplier", max_level_multiplier AS "maxLevelMultiplier", min_level_offset AS "minLevelOffset", max_level_offset AS "maxLevelOffset", spawn_offset AS "spawnOffset", (SELECT array_to_json(array_agg(row_to_json(levels_template))) FROM (SELECT difficulty, min_level AS "minLevel", max_level AS "maxLevel" FROM arksa.spawn_point_set_entry_levels WHERE arksa.spawn_point_set_entry_levels.spawn_point_set_entry_id = arksa.spawn_point_set_entries.spawn_point_set_entry_id) AS levels_template) AS "levelOverrides" FROM arksa.spawn_point_set_entries INNER JOIN arksa.creatures ON (spawn_point_set_entries.creature_id = creatures.object_id) WHERE arksa.spawn_point_set_entries.spawn_point_set_id = arksa.spawn_point_sets.spawn_point_set_id) AS entries_template) AS entries, (SELECT array_to_json(array_agg(row_to_json(replacements_template))) FROM (SELECT target_creature_id AS "creatureId", (SELECT array_to_json(array_agg(row_to_json(choices_template))) FROM (SELECT replacement_creature_id AS "creatureId", weight FROM arksa.spawn_point_set_replacements WHERE target_creature_id = target_creature_id) AS choices_template) AS choices FROM arksa.spawn_point_set_replacements INNER JOIN arksa.creatures AS targets ON (spawn_point_set_replacements.target_creature_id = targets.object_id) WHERE arksa.spawn_point_set_replacements.spawn_point_set_id = arksa.spawn_point_sets.spawn_point_set_id GROUP BY target_creature_id, targets.path, targets.class_string, targets.content_pack_id) AS replacements_template) AS replacements FROM arksa.spawn_point_sets WHERE arksa.spawn_point_sets.spawn_point_id = arksa.spawn_points.object_id) AS sets_template)']),
			new DatabaseObjectProperty('spawn_limits', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(limits_template))) FROM (SELECT spawn_point_limits.creature_id AS "creatureId", spawn_point_limits.max_percentage AS "maxPercentage" FROM arksa.spawn_point_limits INNER JOIN arksa.creatures ON (arksa.spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = spawn_points.object_id) AS limits_template)']),
			new DatabaseObjectProperty('populations', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(pop_template))) FROM (SELECT ark_identifier AS "arkIdentifier", instances_on_map AS "instancesOnMap", max_population AS "maxPopulation" FROM arksa.spawn_point_populations INNER JOIN arksa.maps ON (spawn_point_populations.map_id = maps.map_id) WHERE spawn_point_populations.spawn_point_id = spawn_points.object_id ORDER BY ark_identifier) AS pop_template)'])
		]);
		return $schema;
	}
	
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
		unset($json['spawnPointGroup']);
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
}

?>