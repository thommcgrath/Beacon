<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconRecordSet;

class ConfigOption extends GenericObject {
	const FILE_GAME_INI = 'Game.ini';
	const FILE_GAMEUSERSETTINGS_INI = 'GameUserSettings.ini';
	const FILE_COMMANDLINE_FLAG = 'CommandLineFlag'; // A flag has no equals sign, its presence means true.
	const FILE_COMMANDLINE_OPTION = 'CommandLineOption'; // An option, on the other hand, has a value assigned with an equals sign.
	
	const TYPE_NUMERIC = 'Numeric';
	const TYPE_TEXT = 'Text';
	const TYPE_ARRAY = 'Array';
	const TYPE_STRUCTURE = 'Structure';
	const TYPE_BOOLEAN = 'Boolean';
	
	const nitradoFormat_VALUE  = 'Value';  // In the returned JSON, the value is the raw value after the equal sign.
	const nitradoFormat_LINE   = 'Line';   // In the returned JSON, the value is the full line or lines.
	
	const NITRADO_DEPLOY_GUIDED = 'Guided'; // Should only be set during guided deploys
	const NITRADO_DEPLOY_EXPERT = 'Expert'; // Should only be set during expert deploys
	const NITRADO_DEPLOY_BOTH   = 'Both';   // Should be set during any deploy
	
	protected $nativeEditorVersion = null;
	protected $file = '';
	protected $header = '';
	protected $key = '';
	protected $valueType = '';
	protected $maxAllowed = null;
	protected $description = '';
	protected $defaultValue = '';
	protected $nitradoPath = null;
	protected $nitradoFormat = null;
	protected $nitradoDeployStyle = null;
	protected $uiGroup = null;
	protected $constraints = null;
	protected $customSort = null;
	protected $gsaPlaceholder = null;
	protected $uwpChanges = null;
	
	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
			
		$this->nativeEditorVersion = $row->Field('native_editor_version');
		$this->file = $row->Field('file');
		$this->header = $row->Field('header');
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
		$this->gsaPlaceholder = $row->Field('gsa_placeholder');
		$this->uwpChanges = is_null($row->Field('uwp_changes')) ? null : json_decode($row->Field('uwp_changes'), true);
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
			new DatabaseObjectProperty('customSort', ['columnName' => 'custom_sort']),
			new DatabaseObjectProperty('gsaPlaceholder', ['columnName' => 'gsa_placeholder']),
			new DatabaseObjectProperty('uwpChanges', ['columnName' => 'uwp_changes'])
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		parent::BuildSearchParameters($parameters, $filters);
			
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'file');
		$parameters->AddFromFilter($schema, $filters, 'header');
		$parameters->AddFromFilter($schema, $filters, 'key');
	}
	
	/*protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'nativeEditorVersion';
		$columns[] = 'file';
		$columns[] = 'header';
		$columns[] = 'key';
		$columns[] = 'valueType';
		$columns[] = 'maxAllowed';
		$columns[] = 'description';
		$columns[] = 'defaultValue';
		$columns[] = 'nitradoPath';
		$columns[] = 'nitradoFormat';
		$columns[] = 'nitradoDeployStyle';
		$columns[] = 'uiGroup';
		$columns[] = 'constraints';
		$columns[] = 'customSort';
		$columns[] = 'gsaPlaceholder';
		return $columns;
	}
	
	protected static function TableName() {
		return 'ini_options';
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->nativeEditorVersion = $row->Field('nativeEditorVersion');
		$obj->file = $row->Field('file');
		$obj->header = $row->Field('header');
		$obj->key = $row->Field('key');
		$obj->valueType = $row->Field('valueType');
		$obj->maxAllowed = is_null($row->Field('maxAllowed')) ? null : intval($row->Field('maxAllowed'));
		$obj->description = trim($row->Field('description'));
		$obj->defaultValue = $row->Field('defaultValue');
		$obj->nitradoPath = $row->Field('nitradoPath');
		$obj->nitradoFormat = $row->Field('nitradoFormat');
		$obj->nitradoDeployStyle = $row->Field('nitradoDeployStyle');
		$obj->uiGroup = $row->Field('uiGroup');
		$obj->constraints = is_null($row->Field('constraints')) ? null : json_decode($row->Field('constraints'), true);
		$obj->customSort = $row->Field('customSort');
		$obj->gsaPlaceholder = $row->Field('gsaPlaceholder');
		return $obj;
	}*/
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['configOptionGroup']);
		$json['nativeEditorVersion'] = $this->nativeEditorVersion;
		$json['file'] = $this->file;
		$json['header'] = $this->header;
		$json['key'] = $this->key;
		$json['valueType'] = $this->valueType;
		$json['maxAllowed'] = $this->maxAllowed;
		$json['description'] = $this->description;
		$json['defaultValue'] = $this->defaultValue;
		if (is_null($this->nitradoPath) == false && is_null($this->nitradoFormat) == false && is_null($this->nitradoDeployStyle) == false) {
			$json['nitradoEquivalent'] = [
				'path' => $this->nitradoPath,
				'format' => $this->nitradoFormat,
				'deploy_style' => $this->nitradoDeployStyle
			];
		}
		$json['uiGroup'] = $this->uiGroup;
		$json['customSort'] = $this->customSort;
		$json['constraints'] = $this->constraints;
		$json['gsaPlaceholder'] = $this->gsaPlaceholder;
		$json['uwpChanges'] = $this->uwpChanges;
		return $json;
	}
	
	/*protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'nativeEditorVersion':
			return $this->nativeEditorVersion;
		case 'file':
			return $this->file;
		case 'header':
			return $this->header;
		case 'key':
			return $this->key;
		case 'valueType':
			return $this->valueType;
		case 'maxAllowed':
			return $this->maxAllowed;
		case 'description':
			return $this->description;
		case 'defaultValue':
			return $this->defaultValue;
		case 'nitradoPath':
			return $this->nitradoPath;
		case 'nitradoFormat':
			return $this->nitradoFormat;
		case 'nitradoDeployStyle':
			return $this->nitradoDeployStyle;
		case 'uiGroup':
			return $this->uiGroup;
		case 'constraints':
			return $this->constraints;
		case 'customSort':
			return $this->customSort;
		case 'gsaPlaceholder':
			return $this->gsaPlaceholder;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('file', $json)) {
			$this->file = $json['file'];
		}
		if (array_key_exists('header', $json)) {
			$this->header = $json['header'];
		}
		if (array_key_exists('key', $json)) {
			$this->key = $json['key'];
		}
		if (array_key_exists('valueType', $json)) {
			$this->valueType = $json['valueType'];
		}
		if (array_key_exists('maxAllowed', $json)) {
			if (is_null($json['maxAllowed']) || is_numeric($json['maxAllowed']) === false) {
				$this->maxAllowed = null;
			} else {
				$this->maxAllowed = intval($json['maxAllowed']);
			}
		}
		if (array_key_exists('description', $json)) {
			$this->description = $json['description'];
		}
		if (array_key_exists('defaultValue', $json)) {
			$this->defaultValue = $json['defaultValue'];
		}
		if (array_key_exists('nitrado_guided_equivalent', $json)) {
			if (is_array($json['nitrado_guided_equivalent'])) {
				$this->nitradoPath = $json['nitrado_guided_equivalent']['path'];
				$this->nitradoFormat = $json['nitrado_guided_equivalent']['format'];
				$this->nitradoDeployStyle = $json['nitrado_guided_equivalent']['deploy_style'];
			} else {
				$this->nitradoPath = null;
				$this->nitradoFormat = null;
				$this->nitradoDeployStyle = null;
			}
		}
		if (array_key_exists('uiGroup', $json)) {
			$this->uiGroup = $json['uiGroup'];
		}
		if (array_key_exists('constraints', $json)) {
			$this->constraints = $json['constraints'];
		}
		if (array_key_exists('customSort', $json)) {
			$this->customSort = $json['customSort'];
		}
		if (array_key_exists('gsaPlaceholder', $json)) {
			$this->gsaPlaceholder = $json['gsaPlaceholder'];
		}
	}*/
	
	public function NativeEditorInVersion(): ?int {
		return $this->nativeEditorVersion;
	}
	
	public function ConfigFileName(): string {
		return $this->file;
	}
	
	public function SectionHeader(): string {
		return $this->header;
	}
	
	public function KeyName(): string {
		return $this->key;
	}
	
	public function ValueType(): string {
		return $this->valueType;
	}
	
	public function MaxAllowed(): int {
		return $this->maxAllowed;
	}
	
	public function Description(): string {
		return $this->description;
	}
	
	public function DefaultValue(): mixed {
		return $this->defaultValue;
	}
	
	public function UIGroup(): string {
		return $this->uiGroup;
	}
	
	public function CustomSort(): string {
		return $this->customSort;
	}
	
	public function Constraints(): ?array {
		return $this->constraints;
	}
	
	public function GSAPlaceholder(): ?string {
		return $this->gsaPlaceholder;
	}
	
	public function UWPChanges(): ?array {
		return $this->uwpChanges;
	}
}

?>
