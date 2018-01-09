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
	
	protected static function SortColumn() {
		return 'label';
	}
	
	protected static function TableName() {
		return 'objects';
	}
	
	protected static function BuildSQL(...$clauses) {
		if ((count($clauses) == 1) && (is_array($clauses[0]))) {
			$clauses = $clauses[0];
		}
		
		$table = static::TableName();
		$sql = 'SELECT ' . $table . '.tableoid::regclass AS table_name, ' . implode(', ', static::SQLColumns()) . ' FROM ' . $table . ' INNER JOIN mods ON (' . $table . '.mod_id = mods.mod_id)';
		if (count($clauses) != 0) {
			$sql .= ' WHERE ' . implode(' AND ', $clauses);
		}
		$sql .= ' ORDER BY ' . static::SortColumn() . ';';
		return $sql;
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'object_id':
			return $this->object_id;
		case 'label':
			return $this->label;
		case 'min_version':
			return $this->min_version;
		case 'mod_id':
			return $this->mod_id;
		default:
			return null;
		}
	}
	
	protected function Save() {
		$table = static::TableName();
		
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT column_name, data_type FROM information_schema.columns WHERE table_name = $1;", $table);
		$types = array();
		while (!$results->EOF()) {
			$types[$results->Field('column_name')] = $results->Field('data_type');
			$results->MoveNext();
		}
		
		$c = 1;
		$values = array();
		$active_columns = array();
		$set_pairs = array();
		foreach ($types as $column => $type) {
			$value = $this->GetColumnValue($column);
			if ($value !== null) {
				$type = isset($types[$column]) ? $types[$short_column_name] : 'text';
				$active_columns[] = $column;
				
				$placeholder = '$' . $c++;
				
				switch ($type) {
				case 'bytea':
					$placeholder = 'decode(' . $placeholder . ', \'hex\')';
					$values[$placeholder] = bin2hex($value);
					break;
				default:
					$values[$placeholder] = $value;
					break;
				}
				
				$set_pairs[] = $column . ' = ' . $placeholder;
			}
		}
		
		$placeholders = array_keys($values);
		$values = array_values($values);
		
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . $table . ' (' . implode(', ', $active_columns) . ') VALUES (' . implode(', ', $placeholders) . ') ON CONFLICT (object_id) DO UPDATE SET ' . implode(', ', $set_pairs) . ';', $values);
		$database->Commit();
	}
	
	public static function GetAll(int $min_version = 0, DateTime $updated_since = null) {
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('(min_version IS NULL OR min_version <= $1)', 'last_update > $2'), $min_version, $updated_since->format('Y-m-d H:i:sO'));
		return static::FromResults($results);
	}
	
	public static function GetByObjectID($object_id, int $min_version = 0, DateTime $updated_since = null) {
		if (is_array($object_id)) {
			$ids = array();
			foreach ($object_id as $item) {
				if (is_string($item)) {
					$id = $item;
				} elseif (is_subclass_of($item, 'BeaconObject')) {
					$id = $item->ObjectID();
				} else {
					$id = null;
				}
				if (($id !== null) && (!in_array($id, $ids))) {
					$ids[] = $id;
				}
			}
			$object_id = '{' . implode(',', $ids) . '}';
		} elseif (is_string($object_id)) {
			$object_id = '{' . $object_id . '}';
		} else {
			$object_id = '{}';
		}
		
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('object_id = ANY($1)', '(min_version IS NULL OR min_version <= $2)', 'last_update > $3'), $object_id, $min_version, $updated_since->format('Y-m-d H:i:sO'));
		return static::FromResults($results);
	}
	
	public static function GetByModID($mod_id, int $min_version = 0, DateTime $updated_since = null) {
		if (is_array($mod_id)) {
			$ids = array();
			foreach ($mod_id as $item) {
				if (is_string($item)) {
					$id = $item;
				} else {
					$id = null;
				}
				if (($id !== null) && (!in_array($id, $ids))) {
					$ids[] = $id;
				}
			}
			$mod_id = '{' . implode(',', $ids) . '}';
		} elseif (is_string($mod_id)) {
			$mod_id = '{' . $mod_id . '}';
		} else {
			$mod_id = '{}';
		}
		
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('mod_id = ANY($1)', '(min_version IS NULL OR min_version <= $2)', 'last_update > $3'), $mod_id, $min_version, $updated_since->format('Y-m-d H:i:sO'));
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
		$obj->mod_id = $row->Field('mod_id');
		$obj->mod_name = $row->Field('mod_name');
		return $obj;
	}
	
	public static function LastUpdate(int $min_version = 0) {
		$database = BeaconCommon::Database();
		$table = static::TableName();
		
		$results = $database->Query('SELECT MAX(last_update) AS most_recent_change FROM ' . $table . ' WHERE min_version IS NULL OR min_version <= $1;', $min_version);
		if ($results->Field('most_recent_change') !== null) {
			$change_time = new DateTime($results->Field('most_recent_change'));
		} else {
			$change_time = new DateTime('2000-01-01');
		}
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM deletions WHERE min_version IS NULL OR min_version <= $1;', $min_version);
		} else {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM deletions WHERE (min_version IS NULL OR min_version <= $1) AND from_table = $2;', $min_version, $table);
		}
		if ($results->Field('most_recent_delete') !== null) {
			$delete_time = new DateTime($results->Field('most_recent_delete'));
		} else {
			$delete_time = new DateTime('2000-01-01');
		}
		return ($change_time >= $delete_time) ? $change_time : $delete_time;
	}
	
	public static function Deletions(int $min_version = 0, DateTime $since = null) {
		if ($since === null) {
			$since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$table = static::TableName();
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT * FROM deletions WHERE (min_version IS NULL OR min_version <= $1) AND action_time > $2;', $min_version, $since->format('Y-m-d H:i:sO'));
		} else {
			$results = $database->Query('SELECT * FROM deletions WHERE (min_version IS NULL OR min_version <= $1) AND action_time > $2 AND from_table = $3;', $min_version, $since->format('Y-m-d H:i:sO'), $table);
		}
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = array(
				'object_id' => $results->Field('object_id'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label')
			);
			$results->MoveNext();
		}
		return $arr;
	}
	
	public function jsonSerialize() {
		return array(
			'id' => $this->object_id,
			'label' => $this->label,
			'min_version' => $this->min_version,
			'mod' => array(
				'id' => $this->mod_id,
				'name' => $this->mod_name
			),
			'group' => $this->object_group
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
		