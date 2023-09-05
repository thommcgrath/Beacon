<?php

namespace BeaconAPI\v4\SDTD;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconRecordSet;

class ConfigOption extends GenericObject {
	use MutableGenericObject;
	
	const FILE_SERVERCONFIG_XML = 'serverconfig.xml';
	
	const TYPE_NUMERIC = 'Numeric';
	const TYPE_TEXT = 'Text';
	const TYPE_BOOLEAN = 'Boolean';
	
	protected string $file;
	protected string $key;
	protected string $valueType;
	protected ?int $maxAllowed;
	protected string $description;
	protected mixed $defaultValue;
	protected ?string $uiGroup;
	protected ?array $constraints;
	protected ?string $customSort;
	protected ?int $nativeEditorVersion;
	protected ?int $minGameVersion;
	protected ?int $maxGameVersion;
	
	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
			
		$this->file = $row->Field('file');
		$this->key = $row->Field('key');
		$this->valueType = $row->Field('value_type');
		$this->maxAllowed = is_null($row->Field('max_allowed')) ? null : intval($row->Field('max_allowed'));
		$this->description = trim($row->Field('description'));
		$this->defaultValue = $row->Field('default_value');
		$this->uiGroup = $row->Field('ui_group');
		$this->constraints = is_null($row->Field('constraints')) ? null : json_decode($row->Field('constraints'), true);
		$this->customSort = $row->Field('custom_sort');
		$this->nativeEditorVersion = $row->Field('native_editor_version');
		$this->minGameVersion = $row->Field('min_game_version');
		$this->maxGameVersion = $row->Field('max_game_version');
	}
	
	protected static function CustomVariablePrefix(): string {
		return 'configOption';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('config_options');
		$schema->AddColumns([
			new DatabaseObjectProperty('file'),
			new DatabaseObjectProperty('key'),
			new DatabaseObjectProperty('valueType', ['columnName' => 'value_type']),
			new DatabaseObjectProperty('maxAllowed', ['columnName' => 'max_allowed']),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('defaultValue', ['columnName' => 'default_value']),
			new DatabaseObjectProperty('uiGroup', ['columnName' => 'ui_group']),
			new DatabaseObjectProperty('constraints'),
			new DatabaseObjectProperty('customSort', ['columnName' => 'custom_sort']),
			new DatabaseObjectProperty('nativeEditorVersion', ['columnName' => 'native_editor_version']),
			new DatabaseObjectProperty('minGameVersion', ['columnName' => 'min_game_version', 'accessor' => 'CASE WHEN LOWER_INC(supported_versions) THEN LOWER(supported_versions) ELSE LOWER(supported_versions) + 1 END']),
			new DatabaseObjectProperty('maxGameVersion', ['columnName' => 'max_game_version', 'accessor' => 'CASE WHEN UPPER_INC(supported_versions) THEN UPPER(supported_versions) ELSE UPPER(supported_versions) - 1 END']),
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);
			
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'file');
		$parameters->AddFromFilter($schema, $filters, 'key');
		
		if (isset($filters['gameVersion'])) {
			$parameters->clauses[] = 'config_options.supported_versions @> $' . $parameters->placeholder++ . '::INTEGER';
			$parameters->values[] = $filters['gameVersion'];
		}
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['configOptionGroup']);
		$json['file'] = $this->file;
		$json['key'] = $this->key;
		$json['valueType'] = $this->valueType;
		$json['maxAllowed'] = $this->maxAllowed;
		$json['description'] = $this->description;
		$json['defaultValue'] = $this->defaultValue;
		$json['uiGroup'] = $this->uiGroup;
		$json['customSort'] = $this->customSort;
		$json['constraints'] = $this->constraints;
		$json['nativeEditorVersion'] = $this->nativeEditorVersion;
		$json['minGameVersion'] = $this->minGameVersion;
		$json['maxGameVersion'] = $this->maxGameVersion;
		return $json;
	}
	
	public function ConfigFileName(): string {
		return $this->file;
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
	
	public function NativeEditorVersion(): ?int {
		return $this->nativeEditorVersion;
	}
	
	public function MinGameVersion(): ?int {
		return $this->minGameVersion;
	}
	
	public function MaxGameVersion(): ?int {
		return $this->maxGameVersion;
	}
}

?>
