<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class Creature extends Blueprint {
	protected ?int $incubationTime;
	protected ?int $matureTime;
	protected ?array $stats;
	protected ?int $usedStats;
	protected ?int $minMatingInterval;
	protected ?int $maxMatingInterval;
	
	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
			
		$this->incubationTime = filter_var($row->Field('incubation_time'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->matureTime = filter_var($row->Field('mature_time'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->stats = is_null($row->Field('stats')) ? null : json_decode($row->Field('stats'), true);
		$this->minMatingInterval = filter_var($row->Field('mating_interval_min'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->maxMatingInterval = filter_var($row->Field('mating_interval_max'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->usedStats = filter_var($row->Field('used_stats'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
	}
	
	protected static function CustomVariablePrefix(): string {
		return 'creature';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('creatures');
		$schema->AddColumns([
			new DatabaseObjectProperty('incubationTime', ['columnName' => 'incubation_time', 'accessor' => 'ROUND(EXTRACT(epoch FROM %%TABLE%%.%%COLUMN%%))']),
			new DatabaseObjectProperty('mature_time', ['columnName' => 'mature_time', 'accessor' => 'ROUND(EXTRACT(epoch FROM %%TABLE%%.%%COLUMN%%))']),
			new DatabaseObjectProperty('stats', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(template))) FROM (SELECT stat_index AS "statIndex", base_value AS "baseValue", per_level_wild_multiplier AS "perLevelWildMultiplier", per_level_tamed_multiplier AS "perLevelTamedMultiplier", add_multiplier AS "addMultiplier", affinity_multiplier AS "affinityMultiplier" FROM ark.creature_stats WHERE creature_stats.creature_id = creatures.object_id ORDER BY stat_index) AS template)']),
			new DatabaseObjectProperty('minMatingInterval', ['columnName' => 'mating_interval_min', 'accessor' => 'ROUND(EXTRACT(epoch FROM %%TABLE%%.%%COLUMN%%))']),
			new DatabaseObjectProperty('maxMatingInterval', ['columnName' => 'mating_interval_max', 'accessor' => 'ROUND(EXTRACT(epoch FROM %%TABLE%%.%%COLUMN%%))']),
			new DatabaseObjectProperty('usedStats', ['columnName' => 'used_stats'])
		]);
		return $schema;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['creatureGroup']);
		$json['incubationTime'] = $this->incubationTime;
		$json['matureTime'] = $this->matureTime;
		$json['stats'] = $this->stats;
		$json['usedStats'] = $this->usedStats;
		$json['minMatingInterval'] = $this->minMatingInterval;
		$json['maxMatingInterval'] = $this->maxMatingInterval;
		$json['relatedObjectIds'] = $this->RelatedObjectIDs();
		return $json;
	}
	
	public function SpawnCode(): string {
		return 'cheat summon ' . $this->classString;
	}
	
	public function RelatedObjectIds(): array {
		$database = BeaconCommon::Database();
		$arr = [];
		$results = $database->Query('SELECT engram_id FROM ark.creature_engrams WHERE creature_id = $1;', $this->UUID());
		while (!$results->EOF()) {
			$arr[] = $results->Field('engram_id');
			$results->MoveNext();
		}
		return $arr;
	}
	
	public function IncubationTimeSeconds(): ?int {
		return $this->incubationTime;
	}
	
	public function MatureTimeSeconds(): ?int {
		return $this->matureTime;
	}
	
	public function MinMatingIntervalSeconds(): ?int {
		return $this->minMatingInterval;
	}
	
	public function MaxMatingIntervalSeconds(): ?int {
		return $this->maxMatingInterval;
	}
	
	public function UsedStats(): ?int {
		return $this->usedStats;
	}
	
	/*protected function SaveChildrenHook(\BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		$object_id = $this->ObjectID();
		
		if (is_null($this->stats)) {
			$database->Query('DELETE FROM ark.creature_stats WHERE creature_id = $1;', $object_id);
			return;
		}
		
		$indexes = [];
		foreach ($this->stats as $stat) {
			$index = intval($stat['stat_index']);
			$indexes[] = $index;
			$database->Query('INSERT INTO ark.creature_stats (creature_id, stat_index, base_value, per_level_wild_multiplier, per_level_tamed_multiplier, add_multiplier, affinity_multiplier) VALUES ($1, $2, $3, $4, $5, $6, $7) ON CONFLICT (creature_id, stat_index) DO UPDATE SET base_value = $3, per_level_wild_multiplier = $4, per_level_tamed_multiplier = $5, add_multiplier = $6, affinity_multiplier = $7 WHERE creature_stats.base_value IS DISTINCT FROM $3 OR creature_stats.per_level_wild_multiplier IS DISTINCT FROM $4 OR creature_stats.per_level_tamed_multiplier IS DISTINCT FROM $5 OR creature_stats.add_multiplier IS DISTINCT FROM $7 OR creature_stats.affinity_multiplier IS DISTINCT FROM $7;', $object_id, $index, $stat['base_value'], $stat['per_level_wild_multiplier'], $stat['per_level_tamed_multiplier'], $stat['add_multiplier'], $stat['affinity_multiplier']);
		}
		$database->Query('DELETE FROM ark.creature_stats WHERE creature_id = $1 AND stat_index NOT IN (' . implode(',', $indexes) . ');', $object_id);
	}*/
}

?>
