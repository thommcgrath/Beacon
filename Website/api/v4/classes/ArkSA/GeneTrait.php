<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime, JsonSerializable;

class GeneTrait extends GenericObject {
	use MutableGenericObject;

	protected string $path;
	protected int $maxAllowed;
	protected string $description;
	protected string $name;

	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);

		$this->path = $row->Field('path');
		$this->maxAllowed = $row->Field('max_allowed');
		$this->description = $row->Field('description');
		$this->name = $row->Field('name');
	}

	protected static function CustomVariablePrefix(): string {
		return 'geneTrait';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('traits');
		$schema->AddColumns([
			new DatabaseObjectProperty('path'),
			new DatabaseObjectProperty('maxAllowed', ['columnName' => 'max_allowed', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('description', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
		return $schema;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);

		$parameters->allowAll = true;
		$parameters->orderBy = 'label';
	}

	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['geneTraitGroup']);
		$json['path'] = $this->path;
		$json['maxAllowed'] = $this->maxAllowed;
		$json['description'] = $this->description;
		$json['name'] = $this->name;
		return $json;
	}
}

?>
