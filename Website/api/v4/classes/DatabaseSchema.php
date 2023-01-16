<?php

namespace BeaconAPI\v4;

class DatabaseSchema {
	protected $schema = 'public';
	protected $table = '';
	protected $primaryColumn = null;
	protected $columns = [];
	protected $properties = [];
	protected $joins = [];
	
	public function __construct(string $schema, string $table, array $definitions, array $joins = []) {
		$this->schema = $schema;
		$this->table = $table;
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
	
	public function Table(bool $full = false): string {
		if ($full) {
			return $this->schema . '.' . $this->table;
		} else {
			return $this->table;
		}
	}
	
	public function SetTable(string $table): void {
		$this->table = $table;
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
	
	public function PrimaryKey(bool $full = false): string {
		if ($full) {
			return $this->primaryColumn->Accessor($this->table);
		} else {
			return $this->primaryColumn->ColumnName();
		}
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
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], implode(' ', array_merge([$this->Table(true)], $this->joins)));
	}
	
	public function SelectColumns(): string {
		$selectors = [];
		foreach ($this->columns as $definition) {
			$selectors[] = $definition->Accessor($this->table);
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