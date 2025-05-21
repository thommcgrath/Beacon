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
			if (strtolower($operator) === 'in') {
				$values = explode(',', $filters[$propertyName]);
				if (count($values) === 1) {
					$placeholder = $this->AddValue($values[0]);
					$this->clauses[] = $schema->Accessor($property) . ' = $' . $placeholder;
				} elseif (count($values) > 0) {
					$placeholders = [];
					foreach ($values as $value) {
						$placeholders[] = '$' . $this->AddValue($value);
					}
					$this->clauses[] = $schema->Accessor($property) . ' IN (' . implode(', ', $placeholders) . ')';
				}
			} else {
				$value = $filters[$propertyName];
				$this->clauses[] = $schema->Comparison($property, $operator, $this->placeholder++, $value); // $value is byref in case the value needs to be tweaked
				$this->values[] = $value;
			}
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

	public function NextPlaceholder(): int {
		return $this->placeholder++;
	}
}

?>
