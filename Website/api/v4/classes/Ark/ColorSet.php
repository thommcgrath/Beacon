<?php

namespace BeaconAPI\v4\Ark;
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
		return new DatabaseSchema('ark', 'color_sets', [
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
	
	/*protected static function SQLColumns() {
		return [
			'ark.color_sets.colorSetId',
			'ark.color_sets.label',
			'ark.color_sets.classString'
		];
	}
	
	public static function GetAll(DateTime $updated_since = null) {
		$database = BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets ORDER BY label;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets WHERE last_update > $1 ORDER BY label;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForUUID(string $uuid) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets WHERE colorSetId = $1 ORDER BY label;', $uuid);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = new static();
		$obj->colorSetId = $row->Field('colorSetId');
		$obj->label = $row->Field('label');
		$obj->classString = $row->Field('classString');
		return $obj;
	}*/
	
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
