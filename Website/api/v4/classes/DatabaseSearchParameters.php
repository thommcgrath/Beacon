<?php

namespace BeaconAPI\v4;

class DatabaseSearchParameters {
	public $clauses = [];
	public $values = [];
	public $placeholder = 1;
	public $allowAll = false;
	public $pageSize = 250;
	public $pageNum = 1;
	public $orderBy = null;
	
	public function AddFromFilter(DatabaseSchema $schema, array $filters, string $propertyName): void {
		if (isset($filters[$propertyName])) {
			$definition = $schema->Property($propertyName);
			if (is_null($definition)) {
				return;
			}
			$table = $schema->Table();
			$this->clauses[] = $definition->Accessor($table) . ' = ' . $definition->Setter('$' . $this->placeholder++);
			$this->values[] = $filters[$propertyName];
		}
	}
}

?>
