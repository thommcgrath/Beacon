<?php

namespace BeaconAPI\v4;

class DatabaseObjectProperty {
	const kEditableNever = 0;
	const kEditableAtCreation = 1;
	const kEditableLater = 2;
	const kEditableAlways = self::kEditableAtCreation | self::kEditableLater;

	protected string $propertyName;
	protected string $columnName;
	protected ?string $alias = null;
	protected ?string $accessor = null;
	protected ?string $setter = null;
	protected int $editable = self::kEditableAtCreation;
	protected bool $primaryKey = false;
	protected bool $required = true;
	protected array $dependsOn = [];

	public function __construct(string $propertyName, array $options = []) {
		$this->propertyName = $propertyName;
		if (isset($options['columnName'])) {
			$this->columnName = $options['columnName'];
		} else {
			$this->columnName = $propertyName;
		}

		if (isset($options['accessor'])) {
			$this->accessor = $options['accessor'];
		}

		if (isset($options['setter'])) {
			$this->setter = $options['setter'];
		}

		if (isset($options['editable'])) {
			$this->editable = $options['editable'] & self::kEditableAlways;
		}

		if (isset($options['primaryKey'])) {
			$this->primaryKey = $options['primaryKey'];
		}

		if (isset($options['alias'])) {
			$this->alias = $options['alias'];
		}

		if (isset($options['required'])) {
			$this->required = $options['required'];
		} elseif ($this->editable === self::kEditableNever) {
			$this->required = false;
		}

		if (isset($options['dependsOn'])) {
			$this->dependsOn = $options['dependsOn'];
		}
	}

	public function PropertyName(): string {
		return $this->propertyName;
	}

	public function ColumnName(): string {
		return $this->columnName;
	}

	public function Alias(): ?string {
		return $this->alias;
	}

	public function Selector(string $table): string {
		$selector = $this->Accessor($table);
		if (is_null($this->accessor) === false) {
			if (is_null($this->alias) === false) {
				$selector .= " AS {$this->alias}";
			} else {
				$selector .= " AS {$this->columnName}";
			}
		} else if (is_null($this->alias) === false) {
			$selector .= " AS {$this->alias}";
		}
		return $selector;
	}

	public function Accessor(string $table): string {
		if (is_null($this->accessor)) {
			return "{$table}.{$this->columnName}";
		} else {
			return str_replace(['%%TABLE%%', '%%COLUMN%%'], [$table, $this->columnName], $this->accessor);
		}
	}

	public function Setter(string|int $placeholder): string {
		if (is_int($placeholder)) {
			$placeholder = '$' . $placeholder;
		}
		if (is_null($this->setter)) {
			return $placeholder;
		} else {
			return str_replace('%%PLACEHOLDER%%', $placeholder, $this->setter);
		}
	}

	public function IsEditable(int $flags): bool {
		return ($this->editable & $flags) === $flags;
	}

	public function IsPrimaryKey(): bool {
		return $this->primaryKey;
	}

	public function IsSettable(): bool {
		return is_null($this->accessor) || is_null($this->setter) === false;
	}

	public function IsRequired(): bool {
		return $this->required;
	}

	public function DependsOn(): array {
		return $this->dependsOn;
	}
}

?>
