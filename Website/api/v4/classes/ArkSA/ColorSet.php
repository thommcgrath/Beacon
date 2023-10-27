<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime, JsonSerializable;

class ColorSet extends DatabaseObject implements JsonSerializable {
	protected string $colorSetId;
	protected string $label;
	protected string $classString;
	protected int $lastUpdate;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->colorSetId = $row->Field('color_set_id');
		$this->label = $row->Field('label');
		$this->classString = $row->Field('class_string');
		$this->lastUpdate = round($row->Field('last_update'));
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('arksa', 'color_sets', [
			New DatabaseObjectProperty('colorSetId', ['primaryKey' => true, 'columnName' => 'color_set_id']),
			New DatabaseObjectProperty('label'),
			New DatabaseObjectProperty('classString', ['columnName' => 'class_string']),
			New DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = 'label';
		$parameters->AddFromFilter($schema, $filters, 'classString');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		}
		
		$colors = static::Search(['classString' => $uuid], true);
		if (count($colors) === 1) {
			return $colors[0];
		}
		
		return null;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'colorSetId' => $this->colorSetId,
			'label' => $this->label,
			'classString' => $this->classString,
			'lastUpdate' => $this->lastUpdate
		];
	}
	
	public function ColorSetId(): string {
		return $this->colorSetId;
	}
	
	public function Label(): string {
		return $this->label;
	}
	
	public function ClassString(): string {
		return $this->classString;
	}
}

?>
