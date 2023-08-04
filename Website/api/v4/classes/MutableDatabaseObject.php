<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconUUID, Exception;

trait MutableDatabaseObject {
	protected $changedProperties = [];
	
	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value): mixed {
		// By default, do nothing
		return $value;
	}
	
	protected function SetProperty(string|DatabaseObjectProperty $property, mixed $value): void {
		if (is_string($property)) {
			$schema = $this->DatabaseSchema();
			$property = $schema->Property($property);
		}
		
		$propertyName = $property->PropertyName();
		if ($this->$propertyName !== $value) {
			$this->$propertyName = $value;
			$this->changedProperties[] = $propertyName;
		}
	}
	
	public static function Create(array $properties): DatabaseObject {
		static::Validate($properties);
		
		$schema = static::DatabaseSchema();
		$primaryKeyColumn = $schema->PrimaryColumn();
		$primaryKeyName = $primaryKeyColumn->PropertyName();
		if (isset($properties[$primaryKeyName])) {
			$primaryKey = $properties[$primaryKeyName];
		} else {
			$primaryKey = BeaconUUID::v4();
		}
		
		$primaryKeyPlaceholder = $primaryKeyColumn->Setter(1);
		$values = [static::PreparePropertyValue($primaryKeyColumn, $primaryKey)];
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
			
			$valuePlaceholder = $definition->Setter($placeholder++);
			$value = static::PreparePropertyValue($definition, $properties[$propertyName]);
			
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
	
	public function Edit(array $properties, bool $restoreDefaults = false): void {
		$whitelist = static::EditableProperties(DatabaseObjectProperty::kEditableLater);
		foreach ($whitelist as $definition) {
			$propertyName = $definition->PropertyName();
			if (array_key_exists($propertyName, $properties)) {
				$this->SetProperty($propertyName, $properties[$propertyName]);
			}
		}
		$this->Save($restoreDefaults);
	}
	
	public function Save(bool $restoreDefaults = false): void {
		if ($this->HasPendingChanges() === false && $restoreDefaults === false) {
			return;
		}
		
		static::Validate($this->jsonSerialize());
		
		$schema = static::DatabaseSchema();
		$placeholder = 1;
		$assignments = [];
		$values = [];
		$primaryKey = $this->PrimaryKey();
		foreach ($this->changedProperties as $propertyName) {
			$definition = $schema->Property($propertyName);
			$assignments[] = $definition->ColumnName() . ' = ' . $definition->Setter('$' . $placeholder++);
			$values[] = static::PreparePropertyValue($definition, $this->$propertyName);
		}
		$values[] = $primaryKey;
		
		if ($restoreDefaults) {
			$whitelist = static::EditableProperties(DatabaseObjectProperty::kEditableLater);
			foreach ($whitelist as $definition) {
				if (in_array($definition->PropertyName(), $this->changedProperties)) {
					continue;
				}
				
				$assignments[] = $definition->ColumnName() . ' = DEFAULT';
			}
		}
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$rows = null;
			if (count($this->changedProperties) > 0) {
				$primaryKeyColumn = $schema->PrimaryColumn();
				$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET ' . implode(', ', $assignments) . ' WHERE ' . $primaryKeyColumn->ColumnName() . ' = ' . $schema->PrimarySetter($placeholder++) . ';', $values);
				$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter(1) . ';', $primaryKey);
			}
			$this->SaveChildObjects();
			$database->Commit();
			
			if (is_null($rows) === false) {
				$this->__construct($rows);
				$this->changedProperties = [];
			}
			
			$this->CleanupChildObjects();
		} catch (Exception $err) {
			if ($database->InTransaction()) {
				$database->Rollback();
			}
			throw $err;
		}
	}
	
	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . $schema->WriteableTable() . ' WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->PrimaryKey());
		$database->Commit();
	}
	
	protected static function EditableProperties(int $flags): array {
		return static::DatabaseSchema()->EditableColumns($flags);
	}
	
	protected function HasPendingChanges(): bool {
		return count($this->changedProperties) > 0;
	}
	
	protected function SaveChildObjects(): void {
	}
	
	protected function CleanupChildObjects(): void {
	}
	
	protected static function Validate(array $properties): void {
		$requiredProperties = static::DatabaseSchema()->RequiredColumns();
		$missingProperties = [];
		foreach ($requiredProperties as $definition) {
			if (array_key_exists($definition->PropertyName(), $properties) === false) {
				$missingProperties[] = $definition->PropertyName();
			}
		}
		sort($missingProperties);
		if (count($missingProperties) > 1) {
			throw new Exception('Missing properties ' . BeaconCommon::ArrayToEnglish($missingProperties) . '.');
		} elseif (count($missingProperties) === 1) {
			throw new Exception('Missing property ' . $missingProperties[0] . '.');
		}
	}
}

?>