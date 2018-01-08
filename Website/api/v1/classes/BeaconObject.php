<?php

class BeaconObject implements JsonSerializable {
	private $object_id;
	private $object_group;
	private $label;
	private $min_version;
	private $mod_id;
	private $mod_name;
	
	public function __construct($object_id = null) {
		if ($object_id === null) {
			$this->object_id = BeaconCommon::GenerateUUID();
		} else {
			$this->object_id = $object_id;
		}
	}
	
	protected static function SQLColumns() {
		return array(
			'object_id',
			'label',
			'min_version',
			'mods.mod_id',
			'mods.name AS mod_name'
		);
	}
	
	protected static function TableName() {
		return 'objects';
	}
	
	protected static function BuildSQL() {
		$table = static::TableName();
		return 'SELECT ' . $table . '.tableoid::regclass AS table_name, ' . implode(', ', static::SQLColumns()) . ' FROM ' . $table . ' INNER JOIN mods ON (' . $table . '.mod_id = mods.mod_id)';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'object_id':
			return $this->object_id;
		case 'label':
			return $this->label;
		case 'min_version':
			return $this->min_version;
		case 'mods.mod_id':
			return $this->mod_id;
		default:
			return null;
		}
	}
	
	protected function Save() {
		$table = static::TableName();
		$columns = static::SQLColumns();
		
		$c = 1;
		$values = array();
		$active_columns = array();
		$set_pairs = array();
		foreach ($columns as $column) {
			$value = $this->GetColumnValue($column);
			if ($value !== null) {
				preg_match('/^([^\s\.]+\.)?([^\s\.]+)( AS [^\s\.]+)?$/i', $column, $matches);
				$placeholder = '$' . $c;
				$active_columns[] = $matches[2];
				$values[$placeholder] = $value;
				$set_pairs[] = $matches[2] . ' = ' . $placeholder;
				$c++;
			}
		}
		
		$placeholders = array_keys($values);
		$values = array_values($values);
		
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . $table . ' (' . implode(', ', $active_columns) . ') VALUES (' . implode(', ', $placeholders) . ') ON CONFLICT (object_id) DO UPDATE SET ' . implode(', ', $set_pairs) . ';', $values);
		$database->Commit();
	}
	
	public static function GetByObjectID($object_id) {
		if (is_array($object_id)) {
			$object_id = '{' . implode(',', $object_id) . '}';
		} else {
			$object_id = '{' . $object_id . '}';
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query($this->BuildSQL() . ' WHERE object_id = ANY($1);', $object_id);
		return static::FromResults($results);
	}
	
	protected static function FromResults(BeaconRecordSet $results) {
		if (($results === null) || ($results->RecordCount() == 0)) {
			return array();
		}
		
		$objects = array();
		while (!$results->EOF()) {
			$object = static::FromRow($results);
			if ($object !== null) {
				$objects[] = $object;
			}
			$results->MoveNext();
		}
		return $objects;
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = new static($row->Field('object_id'));
		$obj->object_group = $row->Field('table_name');
		$obj->label = $row->Field('label');
		$obj->min_version = $row->Field('min_version');
		$obj->mod_id = intval($row->Field('mod_id'));
		$obj->mod_name = $row->Field('mod_name');
		return $obj;
	}
	
	public function jsonSerialize() {
		return array(
			'id' => $this->object_id,
			'label' => $this->label,
			'min_version' => $this->min_version,
			'mod' => array(
				'id' => $this->mod_id,
				'name' => $this->mod_name
			)
		);
	}
	
	public function ObjectID() {
		return $this->object_id;
	}
	
	public function ObjectGroup() {
		return $this->object_group;
	}
	
	public function Label() {
		return $this->label;
	}
	
	public function SetLabel(string $label) {
		$this->label = $label;
	}
	
	public function MinVersion() {
		return $this->min_version;
	}
	
	public function ModID() {
		return $this->mod_id;
	}
	
	public function ModName() {
		return $this->mod_name;
	}
}

?>
		