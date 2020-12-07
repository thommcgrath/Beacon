<?php

namespace BeaconAPI;

class ConfigLine extends \BeaconObject {
	const FILE_GAME_INI = 'Game.ini';
	const FILE_GAMEUSERSETTINGS_INI = 'GameUserSettings.ini';
	const FILE_COMMANDLINE_FLAG = 'CommandLineFlag'; // A flag has no equals sign, it's presence means true.
	const FILE_COMMANDLINE_OPTION = 'CommandLineOption'; // An option, on the other hand, has a value assigned with an equals sign.
	
	const TYPE_NUMERIC = 'Numeric';
	const TYPE_TEXT = 'Text';
	const TYPE_ARRAY = 'Array';
	const TYPE_STRUCTURE = 'Structure';
	const TYPE_BOOLEAN = 'Boolean';
	
	const NITRADO_FORMAT_VALUE = 'Value'; // In the returned JSON, the value is the raw value after the equal sign.
	const NITRADO_FORMAT_LINE = 'Line'; // In the returned JSON, the value is the full line or lines.
	
	protected $native_editor_version = null;
	protected $file = '';
	protected $header = '';
	protected $key = '';
	protected $value_type = '';
	protected $max_allowed = 0;
	protected $description = '';
	protected $default_value = '';
	protected $nitrado_path = null;
	protected $nitrado_format = null;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'native_editor_version';
		$columns[] = 'file';
		$columns[] = 'header';
		$columns[] = 'key';
		$columns[] = 'value_type';
		$columns[] = 'max_allowed';
		$columns[] = 'description';
		$columns[] = 'default_value';
		$columns[] = 'nitrado_path';
		$columns[] = 'nitrado_format';
		return $columns;
	}
	
	protected static function TableName() {
		return 'ini_options';
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->native_editor_version = $row->Field('native_editor_version');
		$obj->file = $row->Field('file');
		$obj->header = $row->Field('header');
		$obj->key = $row->Field('key');
		$obj->value_type = $row->Field('value_type');
		$obj->max_allowed = intval($row->Field('max_allowed'));
		$obj->description = trim($row->Field('description'));
		$obj->default_value = $row->Field('default_value');
		$obj->nitrado_path = $row->Field('nitrado_path');
		$obj->nitrado_format = $row->Field('nitrado_format');
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['native_editor_version'] = $this->native_editor_version;
		$json['file'] = $this->file;
		$json['header'] = $this->header;
		$json['key'] = $this->key;
		$json['value_type'] = $this->value_type;
		$json['max_allowed'] = $this->max_allowed;
		$json['description'] = $this->description;
		$json['default_value'] = $this->default_value;
		$json['resource_url'] = \BeaconAPI::URL('/ini_option/' . urlencode($this->ObjectID()));
		if (is_null($this->nitrado_path) == false && is_null($this->nitrado_format) == false) {
			$json['nitrado_guided_equivalent'] = [
				'path' => $this->nitrado_path,
				'format' => $this->nitrado_format
			];
		}
		return $json;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'native_editor_version':
			return $this->native_editor_version;
		case 'file':
			return $this->file;
		case 'header':
			return $this->header;
		case 'key':
			return $this->key;
		case 'value_type':
			return $this->value_type;
		case 'max_allowed':
			return $this->max_allowed;
		case 'description':
			return $this->description;
		case 'default_value':
			return $this->default_value;
		case 'nitrado_path':
			return $this->nitrado_path;
		case 'nitrado_format':
			return $this->nitrado_format;
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
		if (array_key_exists('value_type', $json)) {
			$this->value_type = $json['value_type'];
		}
		if (array_key_exists('max_allowed', $json)) {
			$this->max_allowed = intval($json['max_allowed']);
		}
		if (array_key_exists('description', $json)) {
			$this->description = $json['description'];
		}
		if (array_key_exists('default_value', $json)) {
			$this->default_value = $json['default_value'];
		}
		if (array_key_exists('nitrado_guided_equivalent', $json)) {
			$this->nitrado_path = $json['nitrado_guided_equivalent']['path'];
			$this->nitrado_format = $json['nitrado_guided_equivalent']['format'];
		}
	}
	
	public function NativeEditorInVersion() {
		return $this->native_editor_version;
	}
	
	public function ConfigFileName() {
		return $this->file;
	}
	
	public function SectionHeader() {
		return $this->header;
	}
	
	public function KeyName() {
		return $this->key;
	}
	
	public function ValueType() {
		return $this->value_type;
	}
	
	public function MaxAllowed() {
		return $this->max_allowed;
	}
	
	public function Description() {
		return $this->description;
	}
	
	public function DefaultValue() {
		return $this->default_value;
	}
}

?>