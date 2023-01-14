<?php

namespace BeaconAPI;

abstract class DatabaseObject {
	protected $changed_properties = [];
	protected static $schema = null;
	
	abstract protected function __construct(\BeaconPostgreSQLRecordSet $row);
	abstract public static function BuildDatabaseSchema(): DatabaseSchema;
	/*abstract public static function SQLSchemaName(): string;
	abstract public static function SQLTableName(): string;
	abstract public static function SQLPrimaryKey(): string;
	abstract public static function SQLColumns(): array;*/
	abstract protected static function BuildSearchParameters(\BeaconAPI\DatabaseSearchParameters $parameters, array $filters): void;
		
	public static function DatabaseSchema(): DatabaseSchema {
		if (is_null(static::$schema)) {
			static::$schema = static::BuildDatabaseSchema();
		}
		return static::$schema;
	}
		
	/*public static function SQLLongTableName(): string {
		return static::SQLSchemaName() . '.' . static::SQLTableName();
	}
	
	public static function SQLSortColumn(): string {
		return static::SQLPrimaryKey();
	}
	
	public static function SQLJoins(): array {
		return [];
	}
	
	public static function SQLFromClause(string $alias): array {
		$from = static::SQLLongTableName();
		if (empty($alias) === false) {
			$from .= ' AS ' . $alias;
		}
		
		$joins = static::SQLJoins();
		foreach ($joins as $join) {
			// no function yet
		}
		
		return $from;
	}*/
	
	protected static function FromRows(\BeaconPostgreSQLRecordSet $rows): array {
		$objects = [];
		while (!$rows->EOF()) {
			$objects[] = new static($rows);
			$rows->MoveNext();
		}
		return $objects;
	}
	
	public static function Fetch(string $uuid): ?DatabaseObject {
		$schema = static::DatabaseSchema();
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . $schema->selectColumns() . ' FROM ' . $schema->fromClause() . ' WHERE ' . $schema->primaryKey(true) . ' = $1;', $uuid);
		if (is_null($rows) && $rows->RecordCount() !== 1) {
			return null;
		}
		return new static($rows);
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
			$this->HookPrepareColumnWrite($property, $placeholder, $assignments, $values);
		}
		$values[] = $this->UUID();
		
		$schema = static::DatabaseSchema();
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE ' . $schema->table(true) . ' SET ' . implode(', ', $assignments) . ' WHERE ' . $schema->primaryKey(true) . ' = $' . $placeholder++ . ';', $values);
		$rows = $database->Query('SELECT ' . $schema->selectColumns() . ' FROM ' . $schema->fromClause() . ' WHERE ' . $schema->primaryKey(true) . ' = $1;', $this->UUID());
		$database->Commit();
		
		$this->__construct($rows);
		$this->changed_properties = [];
	}
	
	protected static function HookGetEditableProperties(): array {
		return [];
	}
	
	protected function HookPrepareColumnWrite(string $property, int &$placeholder, array &$assignments, array &$values): void {
		$assignments[] = '"' . $property . '" = $' . $placeholder++;
		$values[] = $this->$property;
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
		$params->orderBy = $schema->primaryKey(true);
		
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
		$primaryKey = $schema->primaryKey(true);
		$from = $schema->fromClause();
		$database = \BeaconCommon::Database();
			
		if ($legacyMode === false) {
			$sql = "SELECT COUNT({$primaryKey}) AS num_results FROM {$from}";
			if (count($params->clauses) > 0) {
				$sql .= " WHERE " . implode(' AND ', $params->clauses);
			}
			$sql .= ';';
			//echo "$sql\n";
			$totalRows = $database->Query($sql, $params->values);
			$totalRowCount = intval($totalRows->Field('num_results'));
		}
		
		$sql = "SELECT " . $schema->selectColumns() . " FROM {$from}";
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
		//echo "$sql\n";
		
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