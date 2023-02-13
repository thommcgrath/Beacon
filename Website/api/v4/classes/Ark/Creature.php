<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class Creature extends Blueprint {
	protected $incubationTime = null;
	protected $matureTime = null;
	protected $stats = null;
	protected $usedStats = 0;
	protected $minMatingInterval = null;
	protected $maxMatingInterval = null;
	
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
	
	/*protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'tamable';
		$columns[] = 'taming_diet';
		$columns[] = 'taming_method';
		$columns[] = 'tamed_diet';
		$columns[] = 'rideable';
		$columns[] = 'carryable';
		$columns[] = 'breedable';
		$columns[] = 'EXTRACT(epoch FROM incubationTime) AS incubationTime';
		$columns[] = 'EXTRACT(epoch FROM matureTime) AS matureTime';
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(template))) FROM (SELECT stat_index, base_value, per_level_wild_multiplier, per_level_tamed_multiplier, add_multiplier, affinity_multiplier FROM ark.creature_stats WHERE creature_stats.creature_id = creatures.object_id ORDER BY stat_index) AS template) AS stats';
		$columns[] = 'EXTRACT(epoch FROM minMatingInterval) AS minMatingInterval';
		$columns[] = 'EXTRACT(epoch FROM maxMatingInterval) AS maxMatingInterval';
		$columns[] = 'usedStats';
		return $columns;
	}
	
	protected static function TableName() {
		return 'creatures';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'tamable':
			return $this->tamable;
		case 'taming_diet':
			return $this->taming_diet_id;
		case 'taming_method':
			return $this->taming_method;
		case 'tamed_diet':
			return $this->tamed_diet_id;
		case 'rideable':
			return $this->rideable;
		case 'carryable':
			return $this->carryable;
		case 'breedable':
			return $this->breedable;
		case 'incubationTime':
			return $this->incubationTime;
		case 'matureTime':
			return $this->matureTime;
		case 'stats':
			return $this->stats;
		case 'minMatingInterval':
			return $this->minMatingInterval;
		case 'maxMatingInterval':
			return $this->maxMatingInterval;
		case 'usedStats':
			return $this->usedStats;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('tamable', $json)) {
			if (is_bool($json['tamable'])) {
				$this->tamable = $json['tamable'];
			} else {
				throw new \Exception('Tamable must be a boolean');
			}
		} elseif (array_key_exists('tameable', $json)) {
			if (is_bool($json['tameable'])) {
				$this->tamable = $json['tameable'];
			} else {
				throw new \Exception('Tameable must be a boolean');
			}
		}
		if (array_key_exists('taming_diet', $json)) {
			$diet_id = $json['taming_diet'];
			if (is_null($diet_id) || \BeaconCommon::IsUUID($diet_id)) {
				$this->taming_diet_id = $diet_id;
			} else {
				throw new \Exception('Taming diet must be null or v4 UUID');
			}
		}
		if (array_key_exists('taming_method', $json)) {
			$method = $json['taming_method'];
			if ($method === self::TAMING_METHOD_NONE || $method === self::TAMING_METHOD_KNOCKOUT || $method === self::TAMING_METHOD_PASSIVE || $method === self::TAMING_METHOD_TRAP) {
				$this->taming_method = $method;
			} else {
				throw new \Exception('Taming method must be one of ' . \BeaconCommon::ArrayToEnglish(array(self::TAMING_METHOD_NONE, self::TAMING_METHOD_KNOCKOUT, self::TAMING_METHOD_PASSIVE, self::TAMING_METHOD_TRAP), 'or'));
			}
		}
		if (array_key_exists('rideable', $json)) {
			if (is_bool($json['rideable'])) {
				$this->rideable = $json['rideable'];
			} else {
				throw new \Exception('Rideable must be a boolean');
			}
		}
		if (array_key_exists('carryable', $json)) {
			if (is_bool($json['carryable'])) {
				$this->carryable = $json['carryable'];
			} else {
				throw new \Exception('Carryable must be a boolean');
			}
		}
		if (array_key_exists('breedable', $json)) {
			if (is_bool($json['breedable'])) {
				$this->breedable = $json['breedable'];
			} else {
				throw new \Exception('Breedable must be a boolean');
			}
		}
		if (array_key_exists('incubationTime', $json)) {
			$value = $json['incubationTime'];
			if (is_null($value) || is_numeric($value)) {
				$this->incubationTime = $value;
			} else {
				throw new \Exception('Incubation time must be a number of seconds.');
			}
		}
		if (array_key_exists('matureTime', $json)) {
			$value = $json['matureTime'];
			if (is_null($value) || is_numeric($value)) {
				$this->matureTime = $value;
			} else {
				throw new \Exception('Mature time must be a number of seconds.');
			}
		}
		if (array_key_exists('stats', $json)) {
			if (is_null($json['stats']) || (is_array($json['stats']) && \BeaconCommon::IsAssoc($json['stats']) === false)) {
				$this->stats = $json['stats'];
			} else {
				throw new \Exception('Stats must be a structure.');
			}
		}
		if (array_key_exists('minMatingInterval', $json)) {
			$value = $json['minMatingInterval'];
			if (is_null($value) || is_numeric($value)) {
				$this->minMatingInterval = $value;
			} else {
				throw new \Exception('Min mating interval time must be a number of seconds.');
			}
		}
		if (array_key_exists('maxMatingInterval', $json)) {
			$value = $json['maxMatingInterval'];
			if (is_null($value) || is_numeric($value)) {
				$this->maxMatingInterval = $value;
			} else {
				throw new \Exception('Max mating interval time must be a number of seconds.');
			}
		}
		if (array_key_exists('usedStats', $json)) {
			$value = $json['usedStats'];
			if (is_null($value) || is_numeric($value)) {
				$this->usedStats = $value;
			} else {
				throw new \Exception('Used stats should be an bit mask.');
			}
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->tamable = $row->Field('tamable');
		$obj->taming_diet_id = $row->Field('taming_diet');
		$obj->taming_method = $row->Field('taming_method');
		$obj->tamed_diet_id = $row->Field('tamed_diet');
		$obj->rideable = $row->Field('rideable');
		$obj->carryable = $row->Field('carryable');
		$obj->breedable = $row->Field('breedable');
		$obj->incubationTime = is_null($row->Field('incubationTime')) ? null : intval($row->Field('incubationTime'));
		$obj->matureTime = is_null($row->Field('matureTime')) ? null : intval($row->Field('matureTime'));
		$obj->stats = is_null($row->Field('stats')) ? null : json_decode($row->Field('stats'), true);
		$obj->minMatingInterval = is_null($row->Field('minMatingInterval')) ? null : intval($row->Field('minMatingInterval'));
		$obj->maxMatingInterval = is_null($row->Field('maxMatingInterval')) ? null : intval($row->Field('maxMatingInterval'));
		$obj->usedStats = is_null($row->Field('usedStats')) ? null : intval($row->Field('usedStats'));
		return $obj;
	}*/
	
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
		return 'cheat spawndino ' . $this->classString . ' 1 1 1 30';
	}
	
	public function RelatedObjectIDs(): array {
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
