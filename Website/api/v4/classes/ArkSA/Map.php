<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Map extends DatabaseObject implements JsonSerializable {
	protected string $mapId;
	protected string $contentPackId;
	protected string $label;
	protected string $arkIdentifier;
	protected float $difficultyScale;
	protected bool $isOfficial;
	protected string $type;
	protected int $mask;
	protected int $sortOrder;
	protected int $engramGroups;
	protected int $lastUpdate;

	public function __construct(BeaconRecordSet $row) {
		$this->mapId = $row->Field('map_id');
		$this->contentPackId = $row->Field('content_pack_id');
		$this->label = $row->Field('label');
		$this->arkIdentifier = $row->Field('ark_identifier');
		$this->difficultyScale = filter_var($row->Field('difficulty_scale'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 4.0;
		$this->isOfficial = filter_var($row->Field('official'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE) ?? false;
		$this->type = $row->Field('type');
		$this->mask = filter_var($row->Field('mask'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 0;
		$this->sortOrder = filter_var($row->Field('sort'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 999;
		$this->engramGroups = filter_var($row->Field('engram_groups'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 10;
		$this->lastUpdate = round($row->Field('last_update'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('arksa', 'maps', [
			new DatabaseObjectProperty('mapId', ['primaryKey' => true, 'columnName' => 'map_id']),
			new DatabaseObjectProperty('contentPackId', ['columnName' => 'content_pack_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('arkIdentifier', ['columnName' => 'ark_identifier']),
			new DatabaseObjectProperty('difficultyScale', ['columnName' => 'difficulty_scale']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'official']),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('mask'),
			new DatabaseObjectProperty('sortOrder', ['columnName' => 'sort']),
			new DatabaseObjectProperty('engramGroups', ['columnName' => 'engram_groups']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)'])
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

	public function jsonSerialize(): mixed {
		return [
			'mapId' => $this->mapId,
			'contentPackId' => $this->contentPackId,
			'label' => $this->label,
			'arkIdentifier' => $this->arkIdentifier,
			'difficultyScale' => $this->difficultyScale,
			'isOfficial' => $this->isOfficial,
			'type' => $this->type,
			'mask' => $this->mask,
			'sortOrder' => $this->sortOrder,
			'engramGroups' => $this->engramGroups,
			'lastUpdate' => $this->lastUpdate,
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
