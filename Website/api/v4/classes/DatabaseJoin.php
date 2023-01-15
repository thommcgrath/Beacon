<?php

namespace BeaconAPI\v4;

class DatabaseJoin {
	const OPTION_ALIAS = 'alias';
	const OPTION_LEFT = 'left';
	
	public $left_column = null;
	public $right_column = null;
	public $imported_columns = [];
	public $left = false;
	public $alias = '';
	
	public function __construct(string $left_column, string $right_column, array $imported_columns, array $options = []) {
		$this->left_column = $left_column;
		$this->right_column = $right_column;
		$this->imported_columns = $imported_columns;
		$this->left = isset($options[self::OPTION_LEFT]) ? filter_var($options[self::OPTION_LEFT], FILTER_VALIDATE_BOOL) : false;
		$this->alias = isset($options[self::OPTION_ALIAS]) ? $options[self::OPTION_ALIAS] : '';
	}
	
	public function Render() {
		$table = $right_column->table;
		if (empty($this->alias) === false) {
			$table .= ' AS ' . $this->alias;
		}
		return ($this->left ? ' LEFT JOIN ' : ' INNER JOIN ') . $table . ' ON (' . $left_column->RenderAccessor() . ' = ' . $right_column->RenderAccessor($alias) . ')';
	}
}

?>
