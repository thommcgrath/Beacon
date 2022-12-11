<?php

namespace BeaconAPI;

abstract class DatabaseObject {
	protected $changed_properties = [];
	
	abstract protected function __construct(\BeaconPostgreSQLRecordSet $row);
	abstract public static function SQLSchemaName(): string;
	abstract public static function SQLTableName(): string;
	abstract public static function SQLColumns(): array;
		
	public static function SQLLongTableName(): string {
		return static::SQLSchemaName() . '.' . static::SQLTableName();
	}
	
	protected static function FromRows(\BeaconPostgreSQLRecordSet $rows): array {
		$objects = [];
		while (!$rows->EOF()) {
			$objects[] = new static($rows);
			$rows->MoveNext();
		}
		return $objects;
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
	}
	
	protected function SetProperty(string $property, mixed $value): void {
		if ($this->$property !== $value) {
			static::ValidateProperty($property, $value);
			$this->$property = $value;
			$this->changed_properties[] = $property;
		}
	}
	
	public function Edit(array $properties): void {
		$whitelist = static::HookGetEditableProperties();
		foreach ($whitelist as $property_name) {
			if (array_key_exists($property_name, $properties)) {
				$this->SetProperty($property_name, $properties[$property_name]);
			}
		}
		
		$this->Save();
	}
	
	public function Save(): void {
		if (count($this->changed_properties) === 0) {
			return;
		}
		
		$placeholder = 1;
		$assignments = [];
		$values = [];
		foreach ($this->changed_properties as $property) {
			static::HookPrepareColumnWrite($property, $placeholder, $assignments, $values);
		}
		$values[] = $this->group_id;
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('UPDATE ' . static::SQLLongTableName() . ' SET ' . implode(', ', $assignments) . ' WHERE group_id = $' . $placeholder++ . ' RETURNING ' . implode(', ', static::SQLColumns()) . ';', $values);
		$database->Commit();
		
		$this->__construct($rows);
		$this->changed_properties = [];
	}
	
	protected static function HookGetEditableProperties(): array {
		return [];
	}
	
	protected static function HookPrepareColumnWrite(string $property, int &$placeholder, array &$assignments, array &$values) {
		$assignments[] = '"' . $property . '" = $' . $placeholder++;
		$values[] = $this->$property;
	}
}

?>