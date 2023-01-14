<?php

namespace BeaconAPI;

class DatabaseSchema {
	protected $schema = 'public';
	protected $table = '';
	protected $primaryKey = '';
	protected $nativeColumns = [];
	protected $joins = [];
	protected $importedColumns = [];
	
	public function __construct(string $schema, string $table, string $primaryKey, array $nativeColumns, array $joins = [], array $importedColumns = []) {
		$this->schema = $schema;
		$this->table = $table;
		$this->primaryKey = $primaryKey;
		if (in_array($primaryKey, $nativeColumns)) {
			$this->nativeColumns = $nativeColumns;
		} else {
			$this->nativeColumns = array_merge([$primaryKey], $nativeColumns);
		}
		$this->joins = $joins;
		$this->importedColumns = $importedColumns;
	}
	
	public function schema(): string {
		return $this->schema;
	}
	
	public function setSchema(string $schema): void {
		$this->schema = $schema;
	}
	
	public function table(bool $full = false): string {
		if ($full) {
			return $this->schema . '.' . $this->table;
		} else {
			return $this->table;
		}
	}
	
	public function setTable(string $table): void {
		$this->table = $table;
	}
	
	public function primaryKey(bool $full = false): string {
		if ($full) {
			return $this->table . '.' . $this->primaryKey;
		} else {
			return $this->primaryKey;
		}
	}
	
	public function setPrimaryKey(string $primaryKey): void {
		$this->primaryKey = $primaryKey;
	}
	
	public function addColumn(string $column): void {
		if (in_array($column, $this->nativeColumns) === false) {
			$this->nativeColumns[] = $column;
		}
	}
	
	public function addJoin(string $join): void {
		if (in_array($join, $this->joins) === false) {
			$this->joins[] = $join;
		}
	}
	
	public function importColumn(string $column): void {
		if (in_array($column, $this->importedColumns) === false) {
			$this->importedColumns[] = $column;
		}
	}
	
	public function fromClause(): string {
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], implode(' ', array_merge([$this->table(true)], $this->joins)));
	}
	
	public function selectColumns(): string {
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], implode(', ', array_merge($this->nativeColumns, $this->importedColumns)));
	}
	
	public function nativeColumns(): array {
		return $this->nativeColumns;
	}
}

?>