<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Map extends DatabaseObject implements JsonSerializable {
	protected string $mapId;
	protected string $contentPackId;
	protected string $label;
	protected string $worldName;
	protected string $arkIdentifier; // Deprecated, needed by Beacon 2.0.0 through 2.3.0 inclusive
	protected float $difficultyScale;
	protected bool $isOfficial;
	protected string $type;
	protected int $mask;
	protected int $sortOrder;
	protected int $engramGroups;
	protected int $lastUpdate;
	protected float $cycleScaleMultiplier;
	protected float $dayScaleMultiplier;
	protected float $nightScaleMultiplier;
	protected int $dayStartTime;
	protected int $dayEndTime;

	public function __construct(BeaconRecordSet $row) {
		$this->mapId = $row->Field('map_id');
		$this->contentPackId = $row->Field('content_pack_id');
		$this->label = $row->Field('label');
		$this->worldName = $row->Field('world_name');
		$this->arkIdentifier = $row->Field('ark_identifier');
		$this->difficultyScale = filter_var($row->Field('difficulty_scale'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 4.0;
		$this->isOfficial = filter_var($row->Field('official'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE) ?? false;
		$this->type = $row->Field('type');
		$this->mask = filter_var($row->Field('mask'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 0;
		$this->sortOrder = filter_var($row->Field('sort'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 999;
		$this->engramGroups = filter_var($row->Field('engram_groups'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 10;
		$this->lastUpdate = round($row->Field('last_update'));
		$this->cycleScaleMultiplier = filter_var($row->Field('cycle_scale_multiplier'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 1.0;
		$this->dayScaleMultiplier = filter_var($row->Field('day_scale_multiplier'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 1.0;
		$this->nightScaleMultiplier = filter_var($row->Field('night_scale_multiplier'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 1.0;
		$this->dayStartTime = filter_var($row->Field('day_start_time'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 18900;
		$this->dayEndTime = filter_var($row->Field('day_end_time'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 73400;
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('arksa', 'maps', [
			new DatabaseObjectProperty('mapId', ['primaryKey' => true, 'columnName' => 'map_id']),
			new DatabaseObjectProperty('contentPackId', ['columnName' => 'content_pack_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('worldName', ['columnName' => 'world_name']),
			new DatabaseObjectProperty('arkIdentifier', ['columnName' => 'ark_identifier']),
			new DatabaseObjectProperty('difficultyScale', ['columnName' => 'difficulty_scale']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'official']),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('mask'),
			new DatabaseObjectProperty('sortOrder', ['columnName' => 'sort']),
			new DatabaseObjectProperty('engramGroups', ['columnName' => 'engram_groups']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('cycleScaleMultiplier', ['columnName' => 'cycle_scale_multiplier']),
			new DatabaseObjectProperty('dayScaleMultiplier', ['columnName' => 'day_scale_multiplier']),
			new DatabaseObjectProperty('nightScaleMultiplier', ['columnName' => 'night_scale_multiplier']),
			new DatabaseObjectProperty('dayStartTime', ['columnName' => 'day_start_time']),
			new DatabaseObjectProperty('dayEndTime', ['columnName' => 'day_end_time']),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = $schema->Accessor('isOfficial') . ' DESC, ' . $schema->Accessor('sortOrder') . ', ' . $schema->Accessor('label');
		$parameters->AddFromFilter($schema, $filters, 'arkIdentifier');
		$parameters->AddFromFilter($schema, $filters, 'worldName');
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

		$results = static::Search(['worldName' => $uuid], true);
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

	public function WorldName(): string {
		return $this->world_name;
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

	public function Type(): string {
		return $this->type;
	}

	public function Mask(): int {
		return $this->mask;
	}

	public function SortOrder(): int {
		return $this->sort;
	}

	public function EngramGroups(): int {
		return $this->engramGroups;
	}

	public function CycleScaleMultiplier(): float {
		return $this->cycleScaleMultiplier;
	}

	public function DayScaleMultiplier(): float {
		return $this->dayScaleMultiplier;
	}

	public function NightScaleMultiplier(): float {
		return $this->nightScaleMultiplier;
	}

	public function DayStartTime(): int {
		return $this->dayStartTime;
	}

	public function DayEndTime(): int {
		return $this->dayEndTime;
	}

	public function jsonSerialize(): mixed {
		return [
			'mapId' => $this->mapId,
			'contentPackId' => $this->contentPackId,
			'label' => $this->label,
			'worldName' => $this->worldName,
			'arkIdentifier' => $this->arkIdentifier,
			'difficultyScale' => $this->difficultyScale,
			'isOfficial' => $this->isOfficial,
			'type' => $this->type,
			'mask' => $this->mask,
			'sortOrder' => $this->sortOrder,
			'engramGroups' => $this->engramGroups,
			'lastUpdate' => $this->lastUpdate,
			'cycleScaleMultiplier' => $this->cycleScaleMultiplier,
			'dayScaleMultiplier' => $this->dayScaleMultiplier,
			'nightScaleMultiplier' => $this->nightScaleMultiplier,
			'dayStartTime' => $this->dayStartTime,
			'dayEndTime' => $this->dayEndTime,
		];
	}

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
