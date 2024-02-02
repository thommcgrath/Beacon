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

	public function AddFromFilter(DatabaseSchema $schema, array $filters, string|DatabaseObjectProperty $property, string $operator = '='): void {
		if (is_string($property)) {
			$property = $schema->Property($property);
		}
		if (is_null($property)) {
			return;
		}

		$propertyName = $property->PropertyName();
		if (isset($filters[$propertyName])) {
			$this->clauses[] = $schema->Comparison($property, $operator, $this->placeholder++);
			$this->values[] = $filters[$propertyName];
		}
	}

	public function AddValue(mixed $value): int {
		$idx = array_search($value, $this->values);
		if ($idx !== false) {
			return $idx;
		}
		$this->values[] = $value;
		$placeholder = $this->placeholder++;
		return $placeholder;
	}
}

?>
