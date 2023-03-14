<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet;

class Map extends DatabaseObject implements \JsonSerializable {
	protected $mapId = null;
	protected $contentPackId = null;
	protected $label = null;
	protected $arkIdentifier = null;
	protected $difficultyScale = null;
	protected $isOfficial = null;
	protected $mask = null;
	protected $sortOrder = null;
	protected $lastUpdate = null;
	
	public function __construct(BeaconRecordSet $row) {
		$this->mapId = $row->Field('map_id');
		$this->contentPackId = $row->Field('mod_id');
		$this->label = $row->Field('label');
		$this->arkIdentifier = $row->Field('ark_identifier');
		$this->difficultyScale = filter_var($row->Field('difficulty_scale'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 4.0;
		$this->isOfficial = filter_var($row->Field('official'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE) ?? false;
		$this->mask = filter_var($row->Field('mask'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 0;
		$this->sortOrder = filter_var($row->Field('sort'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 999;
		$this->lastUpdate = $row->Field('last_update');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'maps', [
			new DatabaseObjectProperty('mapId', ['primaryKey' => true, 'columnName' => 'map_id']),
			new DatabaseObjectProperty('contentPackId', ['columnName' => 'mod_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('arkIdentifier', ['columnName' => 'ark_identifier']),
			new DatabaseObjectProperty('difficultyScale', ['columnName' => 'difficulty_scale']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'official']),
			new DatabaseObjectProperty('mask'),
			new DatabaseObjectProperty('sortOrder', ['columnName' => 'sort']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update'])
		]);	
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = $schema->Accessor('isOfficial') . ' DESC, ' . $schema->Accessor('sortOrder') . ', ' . $schema->Accessor('label');
		$parameters->AddFromFilter($schema, $filters, 'arkIdentifier');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		
		if (isset($filters['mask'])) {
			$maskProperty = $schema->Property('mask');
			$parameters->clauses[] = '(' . $schema->Setter($maskProperty, $parameters->placeholder++) . ' & ' . $schema->Accessor($maskProperty) . ') = ' . $schema->Accessor($maskProperty);
			$parameters->values[] = $filters['mask'];
		}
		
		if (isset($filters['contentPackId'])) {
			if (BeaconCommon::IsUUID($filters['contentPackId']) === true) {
				$parameters->clauses[] = $schema->Comparison('contentPackId', '=', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('contentPackSteamId', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['contentPackId'];
		}
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		}
		
		$results = static::Search(['arkIdentifier' => $uuid], true);
		if (count($results) === 1) {
			return $results[0];
		}
		
		return null;
	}
	
	public function Label(): string {
		return $this->label;
	}
	
	public function MapId(): string {
		return $this->map_id;
	}
	
	public function Identifier(): string {
		return $this->ark_identifier;
	}
	
	public function DifficultyScale(): float {
		return $this->difficulty_scale;
	}
	
	public function IsOfficial(): bool {
		return $this->is_official;
	}
	
	public function Mask(): int {
		return $this->mask;
	}
	
	public function SortOrder(): int {
		return $this->sort;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'mapId' => $this->mapId,
			'contentPackId' => $this->contentPackId,
			'label' => $this->label,
			'arkIdentifier' => $this->arkIdentifier,
			'difficultyScale' => $this->difficultyScale,
			'isOfficial' => $this->isOfficial,
			'mask' => $this->mask,
			'sortOrder' => $this->sortOrder,
			'lastUpdate' => $this->lastUpdate
		];
	}
	
	/*protected static function SQLColumns() {
		return ['maps.map_id', 'maps.mod_id', 'maps.label', 'maps.ark_identifier', 'maps.difficulty_scale', 'maps.official', 'maps.mask', 'maps.sort'];
	}
	
	public static function GetAll(\DateTime $since = null) {
		if (is_null($since)) {
			$since = new \DateTime('2000-01-01');
		}
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.maps INNER JOIN ark.mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND maps.last_update > $1 ORDER BY maps.official DESC, maps.sort;', $since->format('Y-m-d H:i:sO'));
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}
	
	public static function GetForMapID(string $map_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.maps INNER JOIN ark.mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND maps.map_id = $1 ORDER BY maps.official DESC, maps.sort;', $map_id);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;	
	}
	
	public static function GetForMask(int $mask) {
		if ($mask === 0) {
			return static::GetAll();
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.maps INNER JOIN ark.mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND (maps.mask & $1) = maps.mask ORDER BY maps.official DESC, maps.sort;', $mask);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}
	
	public static function GetNamed(string $name) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.maps INNER JOIN ark.mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND maps.label = $1 OR maps.ark_identifier = $1 ORDER BY maps.official DESC, maps.sort;', $name);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}*/
	
	public static function CombinedMask(array $maps): int {
		$combined = 0;
		foreach ($maps as $map) {
			$combined = ($combined | $map->Mask());
		}
		return $combined;
	}
	
	public static function Names(array $maps): string {
		$names = [];
		foreach ($maps as $map) {
			$names[] = $map->Label();
		}
		return BeaconCommon::ArrayToEnglish($names);
	}
}

?>
