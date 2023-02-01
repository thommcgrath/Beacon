<?php

namespace BeaconAPI\v4;
use Exception;

class DatabaseSchema {
	protected $schema = 'public';
	protected $table = '';
	protected $writeableTable = '';
	protected $primaryColumn = null;
	protected $columns = [];
	protected $properties = [];
	protected $joins = [];
	
	public function __construct(string $schema, string $table, array $definitions, array $joins = []) {
		$this->schema = $schema;
		$this->table = $table;
		$this->writeableTable = $table;
		foreach ($definitions as $definition) {
			$this->AddColumn($definition);
		}
		$this->joins = $joins;
	}
	
	public function Schema(): string {
		return $this->schema;
	}
	
	public function SetSchema(string $schema): void {
		$this->schema = $schema;
	}
	
	public function Table(): string {
		return $this->table;
	}
	
	public function SetTable(string $table): void {
		$this->table = $table;
	}
	
	public function WriteableTable(): string {
		return $this->schema . '.' . $this->writeableTable;
	}
	
	public function SetWriteableTable(string $table): void {
		$this->writeableTable = $table;
	}
	
	public function PrimaryColumn(): DatabaseObjectProperty {
		return $this->primaryColumn;
	}
	
	public function SetPrimaryColumn(string|DatabaseObjectProperty $column): void {
		$previousKey = $this->primaryColumn;
		if (is_null($previousKey) === false) {
			if (array_key_exists($previousKey->ColumnName(), $this->columns)) {
				unset($this->columns[$previousKey->ColumnName()]);
			}
			if (array_key_exists($previousKey->PropertyName(), $this->properties)) {
				unset($this->columns[$previousKey->PropertyName()]);
			}
		}
		
		$this->AddColumn($column);
	}
	
	public function PrimarySelector(): string {
		return $this->Selector($this->primaryColumn);
	}
	
	public function PrimaryAccessor(): string {
		return $this->Accessor($this->primaryColumn);
	}
	
	public function PrimarySetter(string|int $placeholder): string {
		return $this->Setter($this->primaryColumn, $placeholder);
	}
	
	public function Selector(string|DatabaseObjectProperty $column): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}
		
		return $column->Selector($this->table);
	}
	
	public function Accessor(string|DatabaseObjectProperty $column): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}
		
		return $column->Accessor($this->table);
	}
	
	// This doesn't do much, it's just for API consistency
	public function Setter(string|DatabaseObjectProperty $column, string|int $placeholder): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}
		
		return $column->Setter($placeholder);
	}
	
	public function Comparison(string|DatabaseObjectProperty $column, string $operator, string|int $placeholder): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}
		
		return $column->Accessor($this->table) . ' ' . $operator . ' ' . $column->Setter($placeholder);
	}
	
	public function AddColumn(string|DatabaseObjectProperty $column): void {
		if (is_string($column)) {
			$column = new DatabaseObjectProperty($column);
		}
		
		if (array_key_exists($column->PropertyName(), $this->properties) === false) {
			$this->properties[$column->PropertyName()] = $column;
		}
		if (array_key_exists($column->ColumnName(), $this->columns) === false) {
			$this->columns[$column->ColumnName()] = $column;
		}
		
		if ($column->IsPrimaryKey()) {
			$this->primaryColumn = $column;
		}
	}
	
	public function AddColumns(array $columns): void {
		foreach ($columns as $column) {
			$this->AddColumn($column);
		}	
	}
	
	public function AddJoin(string $join): void {
		if (in_array($join, $this->joins) === false) {
			$this->joins[] = $join;
		}
	}
	
	public function Column(string $columnName): ?DatabaseObjectProperty {
		if ($columnName === 'primaryKey') {
			return $this->primaryColumn;
		}
		if (array_key_exists($columnName, $this->columns)) {
			return $this->columns[$columnName];
		}
		return null;
	}
	
	public function Property(string $propertyName): ?DatabaseObjectProperty {
		if ($propertyName === 'primaryKey') {
			return $this->primaryColumn;
		}
		if (array_key_exists($propertyName, $this->properties)) {
			return $this->properties[$propertyName];
		}
		return null;
	}
	
	public function FromClause(): string {
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], implode(' ', array_merge(["{$this->schema}.{$this->table}"], $this->joins)));
	}
	
	public function SelectColumns(): string {
		$selectors = [];
		foreach ($this->columns as $definition) {
			$selectors[] = $definition->Selector($this->table);
		}
		return implode(', ', $selectors);
	}
	
	public function EditableColumns(int $flags): array {
		$columns = [];
		foreach ($this->columns as $columnName => $definition) {
			if ($definition->IsEditable($flags)) {
				$columns[] = $definition;
			}
		}
		return $columns;
	}
}

?>