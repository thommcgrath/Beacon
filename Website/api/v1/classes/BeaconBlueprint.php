<?php

class BeaconBlueprint extends BeaconObject {
	private $availability;
	private $path;
	private $class_string;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'availability';
		$columns[] = 'path';
		$columns[] = 'class_string';
		return $columns;
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
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->availability = intval($row->Field('availability'));
		$obj->path = $row->Field('path');
		$obj->class_string = $row->Field('class_string');
		return $obj;
	}
	
	public static function GetByClass($class_string, int $min_version = 0, DateTime $updated_since = null) {
		if ((is_string($class_string)) && (strstr($class_string, ','))) {
			$class_string = explode(',', $class_string);
		}
		$class_strings = array();
		if (is_array($class_string)) {
			foreach ($class_string as $item) {
				if (is_string($item)) {
					$class_strings[] = trim($item);
				}
			}
		} elseif (is_string($class_string)) {
			$class_strings[] = trim($class_string);
		}
		$class_list = '{' . implode(',', array_unique($class_strings)) . '}';
		
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('class_string = ANY($1)', 'min_version <= $2', 'last_update > $3'), $class_list, $min_version, $updated_since->format('Y-m-d H:i:sO'));
		return static::FromResults($results);
	}
	
	public static function GetByHash($hash, int $min_version = 0, DateTime $updated_since = null) {
		if ((is_string($hash)) && (strstr($hash, ','))) {
			$hash = explode(',', $hash);
		}
		$hashes = array();
		if (is_array($hash)) {
			foreach ($hash as $item) {
				if (is_string($item)) {
					$hashes[] = trim($item);
				}
			}
		} elseif (is_string($hash)) {
			$hashes[] = trim($hash);
		}
		$hash_list = '{' . implode(',', array_unique($hashes)) . '}';
		
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('MD5(LOWER(path)) = ANY($1)', 'min_version <= $2', 'last_update > $3'), $hash_list, $min_version, $updated_since->format('Y-m-d H:i:sO'));
		return static::FromResults($results);
	}
	
	public function jsonSerialize() {
		$environments = array();
		if ($this->AvailableToIsland()) {
			$environments[] = 'Island';
		}
		if ($this->AvailableToScorched()) {
			$environments[] = 'Scorched';
		}
		if ($this->AvailableToCenter()) {
			$environments[] = 'Center';
		}
		if ($this->AvailableToRagnarok()) {
			$environments[] = 'Ragnarok';
		}
		if ($this->AvailableToAberration()) {
			$environments[] = 'Aberration';
		}
		
		$json = parent::jsonSerialize();
		$json['availability'] = intval($this->availability);
		$json['environments'] = $environments;
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
	
	public function Availability() {
		return $this->availability;
	}
	
	public function SetAvailability(int $availability) {
		$this->availability = $availability;
	}
	
	public function AvailableTo(int $mask) {
		return ($this->availability & $mask) === $mask;
	}
	
	public function SetAvailableTo(int $mask, bool $available) {
		if ($available) {
			$this->availability = $this->availability | $mask;
		} else {
			$this->availability = $this->availability & ~$mask;
		}
	}
	
	public function AvailableToIsland() {
		return $this->AvailableTo(BeaconMaps::TheIsland);
	}
	
	public function SetAvailableToIsland(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::TheIsland, $available);
	}
	
	public function AvailableToScorched() {
		return $this->AvailableTo(BeaconMaps::ScorchedEarth);
	}
	
	public function SetAvailableToScorched(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::ScorchedEarth, $available);
	}
	
	public function AvailableToCenter() {
		return $this->AvailableTo(BeaconMaps::TheCenter);
	}
	
	public function SetAvailableToCenter(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::TheCenter, $available);
	}
	
	public function AvailableToRagnarok() {
		return $this->AvailableTo(BeaconMaps::Ragnarok);
	}
	
	public function SetAvailableToRagnarok(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Ragnarok, $available);
	}
	
	public function AvailableToAberration() {
		return $this->AvailableTo(BeaconMaps::Aberration);
	}
	
	public function SetAvailableToAberration(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Aberration, $available);
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
}

?>