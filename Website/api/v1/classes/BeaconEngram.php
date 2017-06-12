<?php

class BeaconEngram implements JsonSerializable {
	const ENVIRONMENT_ISLAND = 1;
	const ENVIRONMENT_SCORCHED = 2;
	
	protected $classstring = '';
	protected $label = '';
	protected $availability = 0;
	protected $can_blueprint = false;
	protected $mod_id = null;
	protected $mod_name = null;
	
	public function ClassString() {
		return $this->classstring;
	}
	
	public function Label() {
		return $this->label;
	}
	
	public function Availability() {
		return $this->availability;
	}
	
	public function AvailableToIsland() {
		return ($this->availability & self::ENVIRONMENT_ISLAND) == self::ENVIRONMENT_ISLAND;
	}
	
	public function AvailableToScorched() {
		return ($this->availability & self::ENVIRONMENT_SCORCHED) == self::ENVIRONMENT_SCORCHED;
	}
	
	public function CanBlueprint() {
		return $this->can_blueprint;
	}
	
	public function ModID() {
		return $this->mod_id;
	}
	
	public function ModName() {
		return $this->mod_name;
	}
	
	public function SpawnCode() {
		$class_parts = explode('_', $this->classstring);
		array_shift($class_parts);
		array_pop($class_parts);
		return 'cheat gfi ' . strtolower(implode('_', $class_parts)) . ' 1 0 false';
	}
	
	protected static function GetFromResults(BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$engrams = array();
		while (!$results->EOF()) {
			$engram = self::GetFromResult($results);
			if ($engram !== null) {
				$engrams[] = $engram;
			}
			$results->MoveNext();
		}
		return $engrams;
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$engram = new static();
		$engram->classstring = $results->Field('classstring');
		$engram->label = $results->Field('label');
		$engram->availability = $results->Field('availability');
		$engram->can_blueprint = $results->Field('can_blueprint');
		$engram->mod_id = $results->Field('mod_workshop_id');
		$engram->mod_name = $results->Field('mod_name');
		return $engram;
	}
	
	public static function GetAll() {
		$database = BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL());
		return self::GetFromResults($results);
	}
	
	public static function GetByClass(string $class) {
		$database = BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('engrams.classstring = ANY($1)'), '{' . $class . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetByModID(string $mod_id) {
		$database = BeaconCommon::Database();
		if ($mod_id === '') {
			$results = $database->Query(self::BuildSQL('engrams.mod_id IS NULL'));
		} else {
			$results = $database->Query(self::BuildSQL('mods.workshop_id = ANY($1)'), '{' . $mod_id . '}');
		}
		return self::GetFromResults($results);
	}
	
	protected static function BuildSQL(string $clause = '') {
		$sql = 'SELECT engrams.classstring, engrams.label, engrams.availability, engrams.can_blueprint, mods.workshop_id AS mod_workshop_id, mods.name AS mod_name FROM engrams LEFT JOIN mods ON (engrams.mod_id = mods.mod_id) WHERE (engrams.min_version IS NULL OR engrams.min_version <= (SELECT build_number FROM updates ORDER BY build_number DESC LIMIT 1))';
		if ($clause !== '') {
			$sql .= ' AND ' . $clause;
		}
		$sql .= ' ORDER BY engrams.label;';
		return $sql;
	}
	
	public function jsonSerialize() {
		$environments = array();
		if ($this->AvailableToIsland()) {
			$environments[] = 'Island';
		}
		if ($this->AvailableToScorched()) {
			$environments[] = 'Scorched';
		}
		
		$class_parts = explode('_', $this->classstring);
		array_shift($class_parts);
		array_pop($class_parts);
		
		return array(
			'class' => $this->classstring,
			'label' => $this->label,
			'environments' => $environments,
			'can_blueprint' => $this->can_blueprint,
			'spawn' => $this->SpawnCode(),
			'resource_url' => BeaconAPI::URL('/engram.php/' . strtolower($this->classstring)),
			'mod_id' => $this->mod_id,
			'mod_name' => $this->mod_name
		);
	}
}

?>