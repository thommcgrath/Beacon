<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception;

abstract class DatabaseObject {
	const kPermissionCreate = 1;
	const kPermissionRead = 2;
	const kPermissionUpdate = 4;
	const kPermissionDelete = 8;
	const kPermissionAll = self::kPermissionCreate | self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete;
	
	protected $changed_properties = [];
	protected static $schema = null;
	
	abstract protected function __construct(BeaconRecordSet $row);
	abstract public static function BuildDatabaseSchema(): DatabaseSchema;
	abstract protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void;
		
	public static function DatabaseSchema(): DatabaseSchema {
		if (is_null(static::$schema)) {
			static::$schema = static::BuildDatabaseSchema();
		}
		return static::$schema;
	}
	
	protected static function FromRows(BeaconRecordSet $rows): array {
		$objects = [];
		while (!$rows->EOF()) {
			$objects[] = new static($rows);
			$rows->MoveNext();
		}
		return $objects;
	}
	
	public static function Fetch(string $uuid): ?DatabaseObject {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryKey(true) . ' = $1;', $uuid);
		if (is_null($rows) && $rows->RecordCount() !== 1) {
			return null;
		}
		return new static($rows);
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
	}
	
	protected static function PreparePropertyValue(string $propertyName, DatabaseObjectProperty $definition, mixed $value, string &$setter): mixed {
		// By default, do nothing
		return $value;
	}
	
	// Need a way to check incoming array data for permission
	
	static function CheckClassPermission(User $user, int $desiredPermissions): bool {
		return false;
	}
	
	function CheckPermission(User $user, int $desiredPermissions): bool {
		if (static::CheckClassPermission($user, $desiredPermissions) === false) {
			return false;
		}
		
		return false;	
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
		if (isset($properties[$primaryKeyName]) && BeaconCommon::IsUUID($properties[$primaryKeyName])) {
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
				echo "Skipping {$definition->PropertyName()}...\n";
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
			$database->Query("INSERT INTO " . $schema->Table(true) . " (" . implode(', ', $columns) . ") VALUES (" . implode(', ', $placeholders) . ");", $values);
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
			$assignments[] = $definition->Setter('$' . $placeholder++);
			$values[] = $this->$propertyName;
		}
		$values[] = $uuid;
		
		$database->BeginTransaction();
		try {
			$database->Query('UPDATE ' . $schema->Table(true) . ' SET ' . implode(', ', $assignments) . ' WHERE ' . $schema->PrimaryKey(true) . ' = $' . $placeholder++ . ';', $values);
			$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryKey(true) . ' = $1;', $uuid);
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
	
	public function UUID(): string {
		$primary_key = static::DatabaseSchema()->primaryKey(false);
		return $this->$primary_key;
	}
	
	public static function Search(array $filters = [], bool $legacyMode = false): array {
		$schema = static::DatabaseSchema();
		$params = new DatabaseSearchParameters();
		if (isset($filters['pageSize'])) {
			$params->pageSize = intval($filters['pageSize']);
			$params->pageNum = 1;
		}
		if (isset($filters['page'])) {
			$params->pageNum = intval($filters['page']);
		}
		$params->orderBy = $schema->PrimaryKey(true);
		
		static::BuildSearchParameters($params, $filters);
			
		$params->pageNum = max($params->pageNum, 1);
		$params->pageSize = min($params->pageSize, 250);
		
		if (count($params->clauses) === 0 && $params->allowAll !== true) {
			if ($legacyMode) {
				return [];
			} else {
				return [
					'totalResults' => 0,
					'pageSize' => $params->pageSize,
					'pages' => 0,
					'page' => $params->pageNum,
					'results' => []
				];
			}
		}
		
		$totalRowCount = 0;
		$primaryKey = $schema->PrimaryKey(true);
		$from = $schema->FromClause();
		$database = BeaconCommon::Database();
			
		if ($legacyMode === false) {
			$sql = "SELECT COUNT({$primaryKey}) AS num_results FROM {$from}";
			if (count($params->clauses) > 0) {
				$sql .= " WHERE " . implode(' AND ', $params->clauses);
			}
			$sql .= ';';
			//echo "{$sql}\n";
			$totalRows = $database->Query($sql, $params->values);
			$totalRowCount = intval($totalRows->Field('num_results'));
		}
		
		$sql = "SELECT " . $schema->SelectColumns() . " FROM {$from}";
		if (count($params->clauses) > 0) {
			$sql .= ' WHERE ' . implode(' AND ', $params->clauses);
		}
		if (is_null($params->orderBy) === false) {
			$sql .= " ORDER BY {$params->orderBy}";
		}
		if ($legacyMode === false) {
			$sql .= ' OFFSET $' . $params->placeholder++ . ' LIMIT $' . $params->placeholder++;
			$params->values[] = ($params->pageNum - 1) * $params->pageSize;
			$params->values[] = $params->pageSize;
		}
		
		//echo "{$sql}\n";
		$rows = $database->Query($sql, $params->values);
		$members = static::FromRows($rows);
		
		if ($legacyMode) {
			return $members;
		} else {
			return [
				'totalResults' => $totalRowCount,
				'pageSize' => $params->pageSize,
				'pages' => ceil($totalRowCount / $params->pageSize),
				'page' => $params->pageNum,
				'results' => $members
			];
		}
	}
}

?>