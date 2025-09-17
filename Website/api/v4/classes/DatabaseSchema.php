<?php

namespace BeaconAPI\v4;
use Exception;

class DatabaseSchema {
	protected string $schema = 'public';
	protected string $table = '';
	protected string $writeableTable = '';
	protected ?DatabaseObjectProperty $primaryColumn = null;
	protected array $columns = [];
	protected array $properties = [];
	protected array $joins = [];
	protected array $conditions = [];
	protected bool|array $distinct = false;

	public function __construct(string $schema, string $table, array $definitions, array $joins = [], bool|string|array $distinct = false, array $conditions = []) {
		$this->schema = $schema;
		$this->table = $table;
		$this->writeableTable = $table;
		foreach ($definitions as $definition) {
			$this->AddColumn($definition);
		}
		$this->joins = $joins;
		$this->conditions = $conditions;
		$this->SetDistinct($distinct);
	}

	public function ReplaceLookups(string $source): string {
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], $source);
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

	public function SetTable(string $table, bool $updateWriteable = true): void {
		$this->table = $table;
		if ($updateWriteable) {
			$this->writeableTable = $table;
		}
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

	public function Distinct(): bool|array {
		return $this->distinct;
	}

	public function UsesDistinct(): bool {
		return $this->distinct !== false;
	}

	public function UsesDistinctOn(): bool {
		return is_array($this->distinct);
	}

	public function SetDistinct(bool|string|array $distinct): void {
		if (is_array($distinct)) {
			if (count($distinct) === 0) {
				$distinct = false;
			} else {
				foreach ($distinct as $column) {
					if (is_string($column) === false) {
						throw new Exception('Distinct array members must be strings');
					}
				}
			}
		} elseif (is_string($distinct)) {
			$distinct = [$distinct];
		}
		$this->distinct = $distinct;
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

	public function Comparison(string|DatabaseObjectProperty $column, string $operator, string|int $placeholder, mixed &$value = null): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}

		if (is_int($placeholder)) {
			$placeholder = '$' . $placeholder;
		}

		if ($operator === 'ILIKE') {
			$value = '%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $value ?? '') . '%';
			return $column->Accessor($this->table) . ' ILIKE ' . $placeholder;
		} elseif ($operator === 'LIKE') {
			$value = '%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $value ?? '') . '%';
			return $column->Accessor($this->table) . ' LIKE ' . $placeholder;
		} elseif ($operator === 'SEARCH') {
			return 'public.websearch(' . $column->Accessor($this->table) . ', ' . $placeholder . ')';
		} else {
			return $column->Accessor($this->table) . ' ' . $operator . ' ' . $placeholder;
		}
	}

	public function AddColumn(string|DatabaseObjectProperty $column): void {
		if (is_string($column)) {
			$column = new DatabaseObjectProperty($column);
		}

		$this->properties[$column->PropertyName()] = $column;
		$this->columns[$column->ColumnName()] = $column;

		if ($column->IsPrimaryKey()) {
			$this->primaryColumn = $column;
		}
	}

	public function AddColumns(array $columns): void {
		foreach ($columns as $column) {
			$this->AddColumn($column);
		}
	}

	public function AddJoin(string $join, ?string $key = null): void {
		if (is_null($key)) {
			if (in_array($join, $this->joins) === false) {
				$this->joins[] = $join;
			}
		} else {
			$this->joins[$key] = $join;
		}
	}

	public function RemoveJoin(string $join): void {
		if (array_key_exists($join, $this->joins)) {
			unset($this->joins[$join]);
		} else {
			$keys = array_keys($this->joins, $join, true);
			foreach ($keys as $key) {
				unset($this->joins[$key]);
			}
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

	public function HasProperty(string $propertyName): bool {
		if ($propertyName === 'primaryKey') {
			return true;
		}
		return array_key_exists($propertyName, $this->properties);
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
		return $this->ReplaceLookups(implode(' ', array_merge(["{$this->schema}.{$this->table}"], array_values($this->joins))));
	}

	public function WhereClause(): string {
		return $this->ReplaceLookups(implode(' AND ', [
			$this->PrimaryAccessor() . ' = ' . $this->PrimarySetter('$1'),
			...$this->conditions,
		]));
	}

	public function SelectColumns(): string {
		$selectors = [];
		foreach ($this->columns as $definition) {
			$selectors[] = $definition->Selector($this->table);
		}
		return implode(', ', $selectors);
	}

	public function DistinctClause(string|null $orderBy = null): string|null {
		if (is_bool($this->distinct)) {
			if ($this->distinct === true) {
				return 'DISTINCT';
			}
			return null;
		}
		if (is_array($this->distinct) === false) {
			return null;
		}

		$members = [];
		if (is_null($orderBy) === false) {
			$orderByParts = explode(',', $orderBy);
			foreach ($orderByParts as $orderByPart) {
				if (str_contains($orderByPart, ' ')) {
					$chunks = explode(' ', $orderByPart);
					$lastChunk = strtoupper($chunks[count($chunks) - 1]);
					if ($lastChunk === 'DESC' || $lastChunk === 'ASC') {
						array_pop($chunks);
					}
					$members[] = implode(' ', $chunks);
				} else {
					$members[] = $orderByPart;
				}
			}
		}

		foreach ($this->distinct as $column) {
			$column = str_replace('%%TABLE%%', $this->table, $column);
			if (in_array($column, $members) === false) {
				$members[] = $column;
			}
		}
		return 'DISTINCT ON (' . implode(', ', $members) . ')';
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

	public function RequiredColumns(): array {
		$columns = [];
		foreach ($this->columns as $columnName => $definition) {
			if ($definition->IsRequired()) {
				$columns[] = $definition;
			}
		}
		return $columns;
	}

	public function Properties(): array {
		$columns = [];
		foreach ($this->columns as $columnName => $definition) {
			$columns[] = $definition;
		}
		return $columns;
	}

	public function AddCondition(string $condition): void {
		if (in_array($condition, $this->conditions) === false) {
			$this->conditions[] = $condition;
		}
	}

	public function GetConditions(): array {
		return $this->conditions;
	}
}

?>
