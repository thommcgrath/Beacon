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
	
	protected static function ListValueToParameter($value, array &$possible_columns) {
		if (is_string($value)) {
			if (strtoupper(substr($value, -2)) == '_C') {
				$possible_columns[] = 'class_string';
				return $value;
			} elseif (preg_match('/^[A-F0-9]{32}$/i', $value)) {
				$possible_columns[] = 'MD5(LOWER(path))';
				return $value;
			} else {
				$possible_columns[] = 'path';
				return $value;
			}
		}
		
		return parent::ListValueToParameter($value, $possible_columns);
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
		return ($this->availability & $mask) !== 0;
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
	
	public function RelatedObjectIDs() {
		return array();
	}
}

?>