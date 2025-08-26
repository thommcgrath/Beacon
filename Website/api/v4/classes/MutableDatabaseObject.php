<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconDatabase, BeaconUUID, Exception;

trait MutableDatabaseObject {
	protected $changedProperties = [];

	const OperationInsert = 1;
	const OperationUpdate = 2;
	const OperationDelete = 3;

	// Called at the start of Create so that new objects can provide needed values
	protected static function InitializeProperties(array &$properties): void {
		// By default, do nothing
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		// By default, do nothing
		return $value;
	}

	protected static function ValuesEqual(DatabaseObjectProperty $definition, mixed $valueOne, mixed $valueTwo): bool {
		return $valueOne === $valueTwo;
	}

	protected function SetProperty(string|DatabaseObjectProperty $property, mixed $value): void {
		if (is_string($property)) {
			$schema = $this->DatabaseSchema();
			$property = $schema->Property($property);
		}

		$propertyName = $property->PropertyName();
		if (static::ValuesEqual($property, $this->$propertyName, $value) === false) {
			$this->$propertyName = $value;
			$this->changedProperties[] = $propertyName;
		}
	}

	public static function Create(array $properties): DatabaseObject {
		static::InitializeProperties($properties);
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
		$values = [static::PreparePropertyValue($primaryKeyColumn, $primaryKey, [])];
		$placeholders = [$primaryKeyPlaceholder];
		$columns = [$primaryKeyColumn->ColumnName()];
		$placeholder = 2;

		$editableColumns = static::EditableProperties(DatabaseObjectProperty::kEditableAtCreation);
		$upsertAssignments = [];
		$upsertConflicts = [];
		foreach ($editableColumns as $definition) {
			if ($definition->IsPrimaryKey() || $definition->IsSettable() === false) {
				continue;
			}

			if ($definition->UpsertConflict()) {
				$upsertConflicts[] = $definition->ColumnName();
			}

			$propertyName = $definition->PropertyName();
			if (isset($properties[$propertyName]) === false) {
				continue;
			}

			$dependsOn = $definition->DependsOn();
			$otherProperties = [];
			foreach ($dependsOn as $neededPropertyName) {
				if (array_key_exists($neededPropertyName, $properties)) {
					$otherProperties[$neededPropertyName] = $properties[$neededPropertyName];
				}
			}

			$valuePlaceholder = $definition->Setter($placeholder++);
			$value = static::PreparePropertyValue($definition, $properties[$propertyName], $otherProperties);

			$placeholders[] = $valuePlaceholder;
			$columns[] = $definition->ColumnName();
			$values[] = $value;

			if ($definition->UpsertEdit()) {
				$upsertAssignments[] = $definition->ColumnName() . ' = ' . $valuePlaceholder;
			}
		}

		$database = BeaconCommon::Database();
		try {
			$sql = "INSERT INTO " . $schema->WriteableTable() . " (" . implode(', ', $columns) . ") VALUES (" . implode(', ', $placeholders) . ")";
			if (count($upsertConflicts) > 0) {
				$sql .= ' ON CONFLICT (' . implode(', ', $upsertConflicts) . ') DO UPDATE SET ' . implode(', ', $upsertAssignments);
			}
			$sql .= ' RETURNING ' . $primaryKeyColumn->ColumnName() . ';';
			echo $sql;

			$database->BeginTransaction();
			$rows = $database->Query($sql, $values);
			$obj = static::Fetch($rows->Field($primaryKeyColumn->ColumnName()));
			if (is_null($obj)) {
				throw new APIException(message: "{$primaryKey} was inserted into database, but could not be fetched. This is an internal error and will need to be fixed by the developer.", code: 'badInsert', httpStatus: 500);
			}
			$obj->SetProperties($properties); // Gets virtual data into the new object so the next method can function
			$obj->SaveChildObjects($database);
			$database->Commit();
			$obj->HookModified(self::OperationInsert);
			return $obj;
		} catch (Exception $err) {
			$database->Rollback();

			switch ($err->getCode()) {
			case 23502:
				// Not null
				throw new APIException(message: $err->getMessage(), code: 'nullValue', httpStatus: 400);
			case 23503:
				// Foreign key
				throw new APIException(message: $err->getMessage(), code: 'notFound', httpStatus: 400);
			case 23505:
				// Unique violation
				throw new APIException(message: $err->getMessage(), code: 'duplicate', httpStatus: 400);
			default:
				throw $err;
			}
		}
	}

	protected function PropertiesForValidation(): array {
		return $this->jsonSerialize();
	}

	public function SetProperties(array $properties): void {
		$whitelist = static::EditableProperties(DatabaseObjectProperty::kEditableLater);
		foreach ($whitelist as $definition) {
			$propertyName = $definition->PropertyName();
			if (array_key_exists($propertyName, $properties)) {
				$this->SetProperty($propertyName, $properties[$propertyName]);
			}
		}
	}

	public function Edit(array $properties, bool $restoreDefaults = false): void {
		$this->SetProperties($properties);
		$this->Save($restoreDefaults);
	}

	public function Save(bool $restoreDefaults = false): void {
		if ($this->HasPendingChanges() === false && $restoreDefaults === false) {
			return;
		}

		static::Validate($this->PropertiesForValidation());

		$schema = static::DatabaseSchema();
		$placeholder = 1;
		$assignments = [];
		$values = [];
		$primaryKey = $this->PrimaryKey();
		foreach ($this->changedProperties as $propertyName) {
			$definition = $schema->Property($propertyName);
			if ($definition->IsSettable() === false) {
				continue;
			}

			$dependsOn = $definition->DependsOn();
			$otherProperties = [];
			foreach ($dependsOn as $neededPropertyName) {
				$otherProperties[$neededPropertyName] = $this->$neededPropertyName;
			}

			$assignments[] = $definition->ColumnName() . ' = ' . $definition->Setter('$' . $placeholder++);
			$values[] = static::PreparePropertyValue($definition, $this->$propertyName, $otherProperties);
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
			if (count($assignments) > 0) {
				$primaryKeyColumn = $schema->PrimaryColumn();
				$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET ' . implode(', ', $assignments) . ' WHERE ' . $primaryKeyColumn->ColumnName() . ' = ' . $schema->PrimarySetter($placeholder++) . ';', $values);
				$from = $schema->FromClause();
				$columns = $schema->SelectColumns();
				$selectValues = [$primaryKey];
				if (str_contains($from, '%%USER_ID%%') || str_contains($columns, '%%USER_ID%%')) {
					$selectValues[] = Core::UserId();
					$from = str_replace('%%USER_ID%%', '$2', $from);
					$columns = str_replace('%%USER_ID%%', '$2', $columns);
				}
				$rows = $database->Query('SELECT ' . $columns . ' FROM ' . $from . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter(1) . ';', $selectValues);
			}
			$this->SaveChildObjects($database);
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
		$this->HookModified(self::OperationUpdate);
	}

	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$this->HookModified(self::OperationDelete); // Fire before actually performing any work so the hook still knows what is going on
		$database->Query('DELETE FROM ' . $schema->WriteableTable() . ' WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->PrimaryKey());
		$database->Commit();
	}

	protected static function EditableProperties(int $flags): array {
		return static::DatabaseSchema()->EditableColumns($flags);
	}

	protected function HasPendingChanges(): bool {
		return count($this->changedProperties) > 0;
	}

	protected function SaveChildObjects(BeaconDatabase $database): void {
	}

	protected function CleanupChildObjects(): void {
	}

	protected static function Validate(array $properties): void {
		$requiredProperties = static::DatabaseSchema()->RequiredColumns();
		$missingProperties = [];
		foreach ($requiredProperties as $definition) {
			//echo "`" . $definition->PropertyName() . "`";
			if (array_key_exists($definition->PropertyName(), $properties) === false) {
				$missingProperties[] = $definition->PropertyName();
			}
		}
		sort($missingProperties);
		if (count($missingProperties) > 1) {
			throw new APIException(message: 'Missing properties ' . BeaconCommon::ArrayToEnglish($missingProperties) . '.', code: 'missingProperties');
		} elseif (count($missingProperties) === 1) {
			throw new APIException(message: 'Missing property ' . $missingProperties[0] . '.', code: 'missingProperties');
		}
	}

	protected function HookModified(int $operation): void {

	}
}

?>
