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
	
	public function AddFromFilter(DatabaseSchema $schema, array $filters, string|DatabaseObjectProperty $property): void {
		if (is_string($property)) {
			$property = $schema->Property($property);
		}
		if (is_null($property)) {
			return;
		}
		
		$propertyName = $property->PropertyName();
		if (isset($filters[$propertyName])) {
			$table = $schema->Table();
			$this->clauses[] = $schema->Accessor($property) . ' = ' . $schema->Setter($property, '$' . $this->placeholder++);
			$this->values[] = $filters[$propertyName];
		}
	}
}

?>
