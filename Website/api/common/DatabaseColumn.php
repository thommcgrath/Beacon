<?php

namespace BeaconAPI;

class DatabaseColumn {
	public $table = '';
	public $column = '';
	public $accessor = '';
	public $setter = '';
	
	public function __construct(string $table, string $column) {
		$this->table = $table;
		$this->column = $column;
		$this->accessor = '%%TABLENAME%%.' . $column;
		$this->setter = $column . ' = %%PLACEHOLDER%%';
	}
	
	public function RenderAccessor(string $alias = ''): string {
		$table = empty($alias) ? $this->table : $alias;
		return str_replace('%%TABLENAME%%', $table, $this->accessor);
	}
	
	public function RenderSetter(string $placeholder): string {
		return str_replace('%%PLACEHOLDER%%', $placeholder, $this->setter);
	}
	
	public static function RenderAccessors(array $columns, string $alias = ''): string {
		$accessors = [];
		foreach ($columns as $column) {
			$accessors[] = $column->RenderAccessor($alias);
		}
		return implode(', ', $accessors);
	}
}

?>