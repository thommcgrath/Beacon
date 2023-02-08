<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception;

abstract class DatabaseObject {
	const kPermissionCreate = 1;
	const kPermissionRead = 2;
	const kPermissionUpdate = 4;
	const kPermissionDelete = 8;
	const kPermissionAll = self::kPermissionCreate | self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete;
	
	protected static $schema = [];
	
	abstract protected function __construct(BeaconRecordSet $row);
	abstract public static function BuildDatabaseSchema(): DatabaseSchema;
	abstract protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void;
		
	public static function DatabaseSchema(): DatabaseSchema {
		$calledClass = get_called_class();
		if (array_key_exists($calledClass, static::$schema) === false) {
			static::$schema[$calledClass] = static::BuildDatabaseSchema();
		}
		return static::$schema[$calledClass];
	}
	
	// Seems odd, but allows subclasses to implement as a factory
	protected static function NewInstance(BeaconRecordSet $rows): DatabaseObject {
		return new static($rows);
	}
	
	protected static function FromRows(BeaconRecordSet $rows): array {
		$objects = [];
		while (!$rows->EOF()) {
			$objects[] = static::NewInstance($rows);
			$rows->MoveNext();
		}
		return $objects;
	}
	
	public static function Exists(string $uuid): bool {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM ' . $schema->Schema() . '.' . $schema->Table() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ');', $uuid);
		return $rows->Field('exists');
	}
	
	public static function Fetch(string $uuid): ?static {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ';', $uuid);
		if (is_null($rows) || $rows->RecordCount() !== 1) {
			return null;
		}
		return static::NewInstance($rows);
	}
	
	// Need a way to check incoming array data for permission
	
	public static function CheckClassPermission(?User $user, array $members, int $desiredPermissions): bool {
		return $desiredPermissions === static::kPermissionRead;
	}
	
	public function PrimaryKey(): string {
		$primaryKey = static::DatabaseSchema()->PrimaryColumn()->PropertyName();
		return $this->$primaryKey;
	}
	
	// Deprecated
	public function UUID(): string {
		$primary_key = static::DatabaseSchema()->PrimaryColumn()->PropertyName();
		return $this->$primary_key;
	}
	
	public static function Search(array $filters = [], bool $legacyMode = false): array {
		$schema = static::DatabaseSchema();
		$params = new DatabaseSearchParameters();
		if (isset($filters['pageSize'])) {
			$pageSize = filter_var($filters['pageSize'], FILTER_VALIDATE_INT);
			if ($pageSize !== false) {
				$params->pageSize = $pageSize;
			}
		}
		if (isset($filters['page'])) {
			$page = filter_var($filters['page'], FILTER_VALIDATE_INT);
			if ($page !== false) {
				$params->pageNum = $page;
			}
		}
		
		$minVersionProperty = $schema->Property('minVersion');
		if (is_null($minVersionProperty) === false) {
			$minVersion = false;
			if (isset($filters['minVersion'])) {
				$minVersion = filter_var($filters['minVersion'], FILTER_VALIDATE_INT);
			}
			if ($minVersion !== false && $minVersion > 0) {
				$params->clauses[] = $schema->Accessor($minVersionProperty) . ' <= ' . $schema->Setter($minVersionProperty, '$' . $params->placeholder++);
				$params->values[] = $filters['minVersion'];
			}
		}
		
		static::BuildSearchParameters($params, $filters);
			
		$params->pageNum = max($params->pageNum, 1);
		$params->pageSize = min($params->pageSize, 250);
		
		if ($legacyMode) {
			$emptyReturn = [];
		} else {
			$emptyReturn = [
				'totalResults' => 0,
				'pageSize' => $params->pageSize,
				'pages' => 0,
				'page' => $params->pageNum,
				'results' => []
			];
		}
		
		if (count($params->clauses) === 0 && $params->allowAll !== true) {
			return $emptyReturn;
		}
		
		$totalRowCount = 0;
		$primaryKey = $schema->PrimarySelector();
		$from = $schema->FromClause();
		$database = BeaconCommon::Database();
			
		if ($legacyMode === false) {
			$sql = "SELECT COUNT({$primaryKey}) AS num_results FROM {$from}";
			if (count($params->clauses) > 0) {
				$sql .= " WHERE " . implode(' AND ', $params->clauses);
			}
			$sql .= ';';
			//echo "{$sql}\n";
			//print_r($params->values);
			$totalRows = $database->Query($sql, $params->values);
			$totalRowCount = intval($totalRows->Field('num_results'));
			
			if ($totalRowCount === 0) {
				return $emptyReturn;
			}
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
	
	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . $schema->WriteableTable() . ' WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->UUID());
		$database->Commit();
	}
	
	public function HasProperty(string $propertyName): bool {
		$schema = static::DatabaseSchema();
		$property = $schema->Property($propertyName);
		return is_null($property) === false;
	}
}

?>