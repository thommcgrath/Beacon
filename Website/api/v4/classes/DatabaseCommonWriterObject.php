<?php

namespace BeaconAPI\v4;
use BeaconCommon, Exception;

trait DatabaseCommonWriterObject {
	protected $changed_properties = [];
	
	protected static function ValidateProperty(string $property, mixed $value): void {
	}
	
	protected static function PreparePropertyValue(string $propertyName, DatabaseObjectProperty $definition, mixed $value, string &$setter): mixed {
		// By default, do nothing
		return $value;
	}
	
	protected function SetProperty(string $property, mixed $value): void {
		if ($this->$property !== $value) {
			static::ValidateProperty($property, $value);
			$this->$property = $value;
			$this->changed_properties[] = $property;
		}
	}
	
	public static function Create(array $properties): DatabaseObject {
		$schema = static::DatabaseSchema();
		$primaryKeyColumn = $schema->PrimaryColumn();
		$primaryKeyName = $primaryKeyColumn->PropertyName();
		if (isset($properties[$primaryKeyName])) {
			$primaryKey = $properties[$primaryKeyName];
		} else {
			$primaryKey = BeaconCommon::GenerateUUID();
		}
		
		$primaryKeyPlaceholder = $primaryKeyColumn->Setter('$1');
		$values = [static::PreparePropertyValue($primaryKeyName, $primaryKeyColumn, $primaryKey, $primaryKeyPlaceholder)];
		$placeholders = [$primaryKeyPlaceholder];
		$columns = [$primaryKeyColumn->ColumnName()];
		$placeholder = 2;
		
		$editableColumns = static::EditableProperties(DatabaseObjectProperty::kEditableAtCreation);
		foreach ($editableColumns as $definition) {
			if ($definition->IsPrimaryKey() || $definition->IsSettable() === false) {
				continue;
			}
			
			$propertyName = $definition->PropertyName();
			if (isset($properties[$propertyName]) === false) {
				continue;
			}
			
			$valuePlaceholder = $definition->Setter('$' . $placeholder++);
			$value = static::PreparePropertyValue($propertyName, $definition, $properties[$propertyName], $valuePlaceholder);
			
			$placeholders[] = $valuePlaceholder;
			$columns[] = $definition->ColumnName();
			$values[] = $value;
		}
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Query("INSERT INTO " . $schema->WriteableTable() . " (" . implode(', ', $columns) . ") VALUES (" . implode(', ', $placeholders) . ");", $values);
			$obj = static::Fetch($primaryKey);
			if (is_null($obj)) {
				throw new Exception("No object inserted into database.");
			}
			$database->Commit();
			return $obj;
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}
	
	public function Edit(array $properties): void {
		$whitelist = static::EditableProperties(DatabaseObjectProperty::kEditableLater);
		foreach ($whitelist as $definition) {
			$propertyName = $definition->PropertyName();
			if (array_key_exists($propertyName, $properties)) {
				$this->SetProperty($propertyName, $properties[$propertyName]);
			}
		}
		$this->Save();
	}
	
	public function Save(): void {
		$database = BeaconCommon::Database();
			
		if (count($this->changed_properties) === 0) {
			try {
				$database->BeginTransaction();
				$this->SaveChildObjects();
				$database->Commit();
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
			return;
		}
		
		$schema = static::DatabaseSchema();
		$placeholder = 1;
		$assignments = [];
		$values = [];
		$uuid = $this->UUID();
		foreach ($this->changed_properties as $propertyName) {
			$definition = $schema->Property($propertyName);
			$assignments[] = $definition->ColumnName() . ' = ' . $definition->Setter('$' . $placeholder++);
			$values[] = $this->$propertyName;
		}
		$values[] = $uuid;
		
		$database->BeginTransaction();
		try {
			$primaryKeyColumn = $schema->PrimaryColumn();
			$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET ' . implode(', ', $assignments) . ' WHERE ' . $primaryKeyColumn->ColumnName() . ' = ' . $schema->PrimarySetter('$' . $placeholder++) . ';', $values);
			$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ';', $uuid);
			$this->SaveChildObjects();
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
		
		$this->__construct($rows);
		$this->changed_properties = [];
	}
	
	protected static function EditableProperties(int $flags): array {
		return static::DatabaseSchema()->EditableColumns($flags);
	}
	
	protected function SaveChildObjects(): void {
	}	
}

?>