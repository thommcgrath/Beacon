<?php
	
namespace BeaconAPI;

class Blueprint extends \BeaconObject {
	protected $availability;
	protected $path;
	protected $class_string;
	
	public static function GetByObjectPath(string $path, int $min_version = -1, DateTime $updated_since = null) {
		$objects = static::Get('path:' . $path, $min_version, $updated_since);
		if (count($objects) == 1) {
			return $objects[0];
		}
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'availability';
		$columns[] = 'path';
		$columns[] = 'class_string';
		return $columns;
	}
	
	protected static function TableName() {
		return 'blueprints';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'availability':
			return $this->availability;
		case 'path':
			return $this->path;
		case 'class_string':
			return $this->class_string;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('path', $json)) {
			$this->path = $json['path'];
		}
		if (array_key_exists('availability', $json) && is_int($json['availability'])) {
			$this->availability = intval($json['availability']);
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->availability = intval($row->Field('availability'));
		$obj->path = $row->Field('path');
		$obj->class_string = $row->Field('class_string');
		return $obj;
	}
	
	protected static function ListValueToParameter($value, array &$possible_columns) {
		if (is_string($value)) {
			if (strtoupper(substr($value, -2)) == '_C') {
				$possible_columns[] = 'class_string';
				return $value;
			} elseif (preg_match('/^[A-F0-9]{32}$/i', $value)) {
				$possible_columns[] = 'MD5(LOWER(path))';
				return $value;
			} elseif (strtolower(substr($value, 0, 6)) == '/game/') {
				$possible_columns[] = 'path';
				return $value;
			}
		}
		
		return parent::ListValueToParameter($value, $possible_columns);
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['availability'] = intval($this->availability);
		$json['path'] = $this->path;
		$json['class_string'] = $this->class_string;
		$json['spawn'] = $this->SpawnCode();
		
		return $json;
	}
	
	public function Path() {
		return $this->path;
	}
	
	public function Hash() {
		return md5(strtolower($this->path));
	}
	
	public function SetPath(string $path) {
		$this->path = $path;
		$this->class_string = self::ClassFromPath($path);
	}
	
	public function ClassString() {
		return $this->class_string;
	}
	
	public function IsAmbiguous() {
		// deprecated
		return false;
	}
	
	public function Availability() {
		return $this->availability;
	}
	
	public function SetAvailability(int $availability) {
		$this->availability = $availability;
	}
	
	public function AvailableTo(int $mask) {
		return ($this->availability & $mask) !== 0;
	}
	
	public function SetAvailableTo(int $mask, bool $available) {
		if ($available) {
			$this->availability = $this->availability | $mask;
		} else {
			$this->availability = $this->availability & ~$mask;
		}
	}
	
	public function SpawnCode() {
		return 'cheat summon ' . $this->ClassString();
	}
	
	protected static function ClassFromPath(string $path) {
		$components = explode('/', $path);
		$tail = array_pop($components);
		$components = explode('.', $tail);
		$class = array_pop($components);
		return $class . '_C';
	}
	
	public function RelatedObjectIDs() {
		return array();
	}
}

?>
