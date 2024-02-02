<?php

namespace BeaconAPI\v4\Palworld;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconRecordSet;

class ConfigOption extends GenericObject {
	const FILE_SETTINGS_INI = 'PalWorldSettings.ini';

	const TYPE_NUMERIC = 'Numeric';
	const TYPE_TEXT = 'Text';
	const TYPE_ARRAY = 'Array';
	const TYPE_STRUCTURE = 'Structure';
	const TYPE_BOOLEAN = 'Boolean';

	const NITRADO_Format_VALUE  = 'Value';  // In the returned JSON, the value is the raw value after the equal sign.
	const NITRADO_Format_LINE   = 'Line';   // In the returned JSON, the value is the full line or lines.

	const NITRADO_DEPLOY_GUIDED = 'Guided'; // Should only be set during guided deploys
	const NITRADO_DEPLOY_EXPERT = 'Expert'; // Should only be set during expert deploys
	const NITRADO_DEPLOY_BOTH   = 'Both';   // Should be set during any deploy

	protected ?int $nativeEditorVersion;
	protected string $file;
	protected string $header;
	protected ?string $struct;
	protected string $key;
	protected string $valueType;
	protected ?int $maxAllowed;
	protected string $description;
	protected mixed $defaultValue;
	protected ?string $nitradoPath;
	protected ?string $nitradoFormat;
	protected ?string $nitradoDeployStyle;
	protected ?string $uiGroup;
	protected ?array $constraints;
	protected ?string $customSort;

	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);

		$this->nativeEditorVersion = $row->Field('native_editor_version');
		$this->file = $row->Field('file');
		$this->header = $row->Field('header');
		$this->struct = $row->Field('struct');
		$this->key = $row->Field('key');
		$this->valueType = $row->Field('value_type');
		$this->maxAllowed = is_null($row->Field('max_allowed')) ? null : intval($row->Field('max_allowed'));
		$this->description = trim($row->Field('description'));
		$this->defaultValue = $row->Field('default_value');
		$this->nitradoPath = $row->Field('nitrado_path');
		$this->nitradoFormat = $row->Field('nitrado_format');
		$this->nitradoDeployStyle = $row->Field('nitrado_deploy_style');
		$this->uiGroup = $row->Field('ui_group');
		$this->constraints = is_null($row->Field('constraints')) ? null : json_decode($row->Field('constraints'), true);
		$this->customSort = $row->Field('custom_sort');
	}

	protected static function CustomVariablePrefix(): string {
		return 'configOption';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('ini_options');
		$schema->AddColumns([
			new DatabaseObjectProperty('nativeEditorVersion', ['columnName' => 'native_editor_version']),
			new DatabaseObjectProperty('file'),
			new DatabaseObjectProperty('header'),
			new DatabaseObjectProperty('struct'),
			new DatabaseObjectProperty('key'),
			new DatabaseObjectProperty('valueType', ['columnName' => 'value_type']),
			new DatabaseObjectProperty('maxAllowed', ['columnName' => 'max_allowed']),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('defaultValue', ['columnName' => 'default_value']),
			new DatabaseObjectProperty('nitradoPath', ['columnName' => 'nitrado_path']),
			new DatabaseObjectProperty('nitradoFormat', ['columnName' => 'nitrado_format']),
			new DatabaseObjectProperty('nitradoDeployStyle', ['columnName' => 'nitrado_deploy_style']),
			new DatabaseObjectProperty('uiGroup', ['columnName' => 'ui_group']),
			new DatabaseObjectProperty('constraints'),
			new DatabaseObjectProperty('customSort', ['columnName' => 'custom_sort'])
		]);
		return $schema;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);

		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'file');
		$parameters->AddFromFilter($schema, $filters, 'header');
		$parameters->AddFromFilter($schema, $filters, 'struct');
		$parameters->AddFromFilter($schema, $filters, 'key');
	}

	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['configOptionGroup']);
		$json['nativeEditorVersion'] = $this->nativeEditorVersion;
		$json['file'] = $this->file;
		$json['header'] = $this->header;
		$json['struct'] = $this->struct;
		$json['key'] = $this->key;
		$json['valueType'] = $this->valueType;
		$json['maxAllowed'] = $this->maxAllowed;
		$json['description'] = $this->description;
		$json['defaultValue'] = $this->defaultValue;
		if (is_null($this->nitradoPath) == false && is_null($this->nitradoFormat) == false && is_null($this->nitradoDeployStyle) == false) {
			$json['nitradoEquivalent'] = [
				'path' => $this->nitradoPath,
				'format' => $this->nitradoFormat,
				'deployStyle' => $this->nitradoDeployStyle
			];
		}
		$json['uiGroup'] = $this->uiGroup;
		$json['customSort'] = $this->customSort;
		$json['constraints'] = $this->constraints;
		return $json;
	}

	public function NativeEditorInVersion(): ?int {
		return $this->nativeEditorVersion;
	}

	public function ConfigFileName(): string {
		return $this->file;
	}

	public function SectionHeader(): string {
		return $this->header;
	}

	public function StructName(): ?string {
		return $this->struct;
	}

	public function KeyName(): string {
		return $this->key;
	}

	public function ValueType(): string {
		return $this->valueType;
	}

	public function MaxAllowed(): ?int {
		return $this->maxAllowed;
	}

	public function Description(): ?string {
		return $this->description;
	}

	public function DefaultValue(): mixed {
		return $this->defaultValue;
	}

	public function UIGroup(): ?string {
		return $this->uiGroup;
	}

	public function CustomSort(): ?string {
		return $this->customSort;
	}

	public function Constraints(): ?array {
		return $this->constraints;
	}
}

?>
