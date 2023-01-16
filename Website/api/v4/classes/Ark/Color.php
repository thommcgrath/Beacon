<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime;

class Color extends DatabaseObject implements \JsonSerializable {
	protected $color_id;
	protected $name;
	protected $code;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->color_id = intval($row->Field('color_id'));
		$this->name = $row->Field('color_name');
		$this->code = $row->Field('color_code');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'colors', [
			New DatabaseObjectProperty('color_id', ['primaryKey' => true]),
			New DatabaseObjectProperty('name', ['columnName' => 'color_name']),
			New DatabaseObjectProperty('code', ['columnName' => 'color_code'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$parameters->allowAll = true;
		
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'code');
	}
	
	protected static function SQLColumns() {
		return [
			'ark.colors.color_id',
			'ark.colors.color_name',
			'ark.colors.color_code'
		];
	}
	
	public static function GetAll(DateTime $updated_since = null) {
		$database = BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.colors ORDER BY color_id;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.colors WHERE last_update > $1 ORDER BY color_id;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForID(int $id) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.colors WHERE color_id = $1 ORDER BY color_id;', $id);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = new static();
		$obj->color_id = $row->Field('color_id');
		$obj->color_name = $row->Field('color_name');
		$obj->color_code = $row->Field('color_code');
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'color_id' => $this->color_id,
			'label' => $this->name,
			'hex' => $this->code
		];
	}
	
	public function ColorId(): int {
		return $this->color_id;
	}
	
	public function Label(): string {
		return $this->color_name;
	}
	
	public function Hex(): string {
		return $this->color_code;
	}
}

?>
