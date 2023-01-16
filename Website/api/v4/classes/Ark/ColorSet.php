<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime;

class ColorSet extends DatabaseObject implements \JsonSerializable {
	protected $color_set_id;
	protected $label;
	protected $class_string;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->color_set_id = $row->Field('color_set_id');
		$this->label = $row->Field('label');
		$this->class_string = $row->Field('class_string');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'color_sets', [
			New DatabaseObjectProperty('color_set_id', ['primaryKey' => true]),
			New DatabaseObjectProperty('label'),
			New DatabaseObjectProperty('class_string')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$parameters->allowAll = true;
		$parameters->orderBy = 'label';
	}
	
	protected static function SQLColumns() {
		return [
			'ark.color_sets.color_set_id',
			'ark.color_sets.label',
			'ark.color_sets.class_string'
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
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.color_sets WHERE color_set_id = $1 ORDER BY label;', $uuid);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = new static();
		$obj->color_set_id = $row->Field('color_set_id');
		$obj->label = $row->Field('label');
		$obj->class_string = $row->Field('class_string');
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'color_set_id' => $this->color_set_id,
			'label' => $this->label,
			'class_string' => $this->class_string
		];
	}
	
	public function ColorSetId(): string {
		return $this->color_set_id;
	}
	
	public function Label(): string {
		return $this->label;
	}
	
	public function ClassString(): string {
		return $this->class_string;
	}
}

?>
