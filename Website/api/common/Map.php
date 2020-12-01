<?php

namespace BeaconAPI;

class Map implements \JsonSerializable {
	protected $map_id = null;
	protected $mod_id = null;
	protected $label = null;
	protected $ark_identifier = null;
	protected $difficulty_scale = null;
	protected $is_official = null;
	protected $mask = null;
	protected $sort = null;
	
	public function __construct($source) {
		if (is_null($source)) {
			throw new Exception('Cannot create a BeaconMap from null');
		}
		
		if ($source instanceof Map) {
			$this->map_id = $source->map_id;
			$this->mod_id = $source->mod_id;
			$this->label = $source->label;
			$this->ark_identifier = $source->ark_identifier;
			$this->difficulty_scale = $source->difficulty_scale;
			$this->is_official = $source->is_official;
			$this->mask = $source->mask;
			$this->sort = $source->sort;
		} elseif ($source instanceof \BeaconRecordSet) {
			$this->map_id = $source->Field('map_id');
			$this->mod_id = $source->Field('mod_id');
			$this->label = $source->Field('label');
			$this->ark_identifier = $source->Field('ark_identifier');
			$this->difficulty_scale = floatval($source->Field('difficulty_scale'));
			$this->is_official = boolval($source->Field('official'));
			$this->mask = intval($source->Field('mask'));
			$this->sort = intval($source->Field('sort'));
		} else {
			throw new Exception('Cannot create BeaconMap from ' . get_class($source));
		}
	}
	
	public function Name() {
		return $this->label;
	}
	
	public function Label() {
		return $this->label;
	}
	
	public function MapID() {
		return $this->map_id;
	}
	
	public function ObjectID() {
		return $this->map_id;
	}
	
	public function Identifier() {
		return $this->ark_identifier;
	}
	
	public function Difficulty() {
		return $this->difficulty_scale;
	}
	
	public function DifficultyScale() {
		return $this->difficulty_scale;
	}
	
	public function Official() {
		return $this->is_official;
	}
	
	public function IsOfficial() {
		return $this->is_official;
	}
	
	public function Mask() {
		return $this->mask;
	}
	
	public function Sort() {
		return $this->sort;
	}
	
	public function jsonSerialize() {
		return [
			'map_id' => $this->map_id,
			'mod_id' => $this->mod_id,
			'label' => $this->label,
			'identifier' => $this->ark_identifier,
			'difficulty' => $this->difficulty_scale,
			'official' => $this->is_official,
			'mask' => $this->mask,
			'sort' => $this->sort
		];
	}
	
	protected static function SQLColumns() {
		return ['map_id', 'maps.mod_id', 'label', 'ark_identifier', 'difficulty_scale', 'official', 'mask', 'sort'];
	}
	
	public static function GetAll(\DateTime $since = null) {
		if (is_null($since)) {
			$since = new \DateTime('2000-01-01');
		}
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM maps INNER JOIN mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND maps.last_update > $1 ORDER BY official DESC, sort;', $since->format('Y-m-d H:i:sO'));
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}
	
	public static function GetForMapID(string $map_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM maps INNER JOIN mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND map_id = $1 ORDER BY official DESC, sort;', $map_id);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;	
	}
	
	public static function GetForMask(int $mask) {
		if ($mask === 0) {
			return static::GetAll();
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM maps INNER JOIN mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND (mask & $1) = mask ORDER BY official DESC, sort;', $mask);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}
	
	public static function GetNamed(string $name) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM maps INNER JOIN mods ON (maps.mod_id = mods.mod_id) WHERE mods.confirmed = TRUE AND label = $1 OR ark_identifier = $1 ORDER BY official DESC, sort;', $name);
		$maps = [];
		while (!$results->EOF()) {
			$maps[] = new static($results);
			$results->MoveNext();
		}
		return $maps;
	}
	
	public static function CombinedMask(array $maps) {
		$combined = 0;
		foreach ($maps as $map) {
			$combined = ($combined | $map->Mask());
		}
		return $combined;
	}
}

?>