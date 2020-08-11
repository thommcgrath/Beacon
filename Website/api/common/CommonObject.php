<?php

namespace BeaconAPI;

class CommonObject implements \JsonSerializable {
	protected $object_id;
	protected $object_group;
	protected $label;
	protected $alternate_label;
	protected $min_version = 0;
	protected $mod_id;
	protected $mod_name;
	protected $mod_workshop_id;
	protected $tags = array();
	
	const COLUMN_NOT_EXISTS = 'ae3eefbc-6dd0-4f92-ae3d-7cae5c6c9aee';
	
	public function __construct($object_id = null) {
		if ($object_id === null) {
			$this->object_id = \BeaconCommon::GenerateUUID();
		} else {
			$this->object_id = $object_id;
		}
	}
	
	protected static function SQLColumns() {
		return array(
			'object_id',
			'label',
			'alternate_label',
			'min_version',
			'tags',
			'mods.mod_id',
			'mods.name AS mod_name',
			'ABS(mods.workshop_id) AS mod_workshop_id'
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
		case 'alternate_label':
			return $this->alternate_label;
		case 'min_version':
			return $this->min_version;
		case 'mod_id':
			return $this->mod_id;
		case 'tags':
			return '{' . implode(',', $this->tags) . '}';
		default:
			return self::COLUMN_NOT_EXISTS;
		}
	}
	
	public function ConsumeJSON(array $json) {
		if (array_key_exists('label', $json)) {
			$this->label = $json['label'];
		}
		if (array_key_exists('alternate_label', $json)) {
			$this->alternate_label = $json['alternate_label'];
		}
		if (array_key_exists('min_version', $json)) {
			$this->min_version = $json['min_versoin'];
		}
		if (is_null($this->mod_id) && array_key_exists('mod_id', $json)) {
			$this->mod_id = $json['mod_id'];
		}
		if (array_key_exists('tags', $json) && is_array($json['tags'])) {
			$tags = array();
			foreach ($json['tags'] as $tag) {
				$tags[] = static::NormalizeTag($tag);
			}
			$this->tags = $tags;
		}
	}
	
	public function Save() {
		$table = static::TableName();
		
		$database = \BeaconCommon::Database();
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
			if ($value !== self::COLUMN_NOT_EXISTS) {
				$type = isset($types[$column]) ? $types[$column] : 'text';
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
		$results = $database->Query('SELECT object_id FROM objects WHERE object_id = $1;', $this->object_id);
		if ($results->RecordCount() == 0) {
			$database->Query('INSERT INTO ' . $table . ' (' . implode(', ', $active_columns) . ') VALUES (' . implode(', ', $placeholders) . ');', $values);
		} else {
			$database->Query('UPDATE ' . $table . ' SET ' . implode(', ', $set_pairs) . ' WHERE object_id = ' . $database->EscapeLiteral($results->Field('object_id')) . ';', $values);
		}
		$this->SaveChildrenHook($database);
		$database->Commit();
	}
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
	}
	
	protected static function PrepareLists($value_list) {
		if (is_string($value_list)) {
			$value_list = explode(',', $value_list);
		}
		if (!is_array($value_list)) {
			throw new \Exception('Must supply an array or comma-separated string.');
		}
		
		$values = array();
		foreach ($value_list as $value) {
			if (is_string($value)) {
				$value = trim($value);
			}
			
			$possible_columns = array();
			$converted_value = static::ListValueToParameter($value, $possible_columns);
			if ($converted_value !== null) {
				foreach ($possible_columns as $column) {
					if (array_key_exists($column, $values)) {
						$values[$column][] = $converted_value;
					} else {
						$values[$column] = array($converted_value);
					}
				}
			}
		}
		
		foreach ($values as $column => $elements) {
			$values[$column] = '{' . implode(',', array_unique($elements)) . '}';
		}
		
		return $values;
	}
	
	protected static function ListValueToParameter($value, array &$possible_columns) {
		if ($value instanceof self) {
			$possible_columns[] = 'object_id';
			return $value->ObjectID();
		}
		if (\BeaconCommon::IsUUID($value)) {
			$possible_columns[] = 'object_id';
			$possible_columns[] = 'mods.mod_id';
			return $value;
		}
		if (is_numeric($value)) {
			$numeric_value = $value + 0;
			if (is_int($numeric_value)) {
				$possible_columns[] = 'mods.workshop_id';
				return $numeric_value;
			}
		}
		if (is_string($value)) {
			if (strpos($value, ':') !== false) {
				list($column, $value) = explode(':', $value, 2);
				$possible_columns[] = $column;
				return $value;
			}
		}
		
		return null;
	}
	
	public static function GetAll(int $min_version = -1, \DateTime $updated_since = null, bool $confirmed_only = false) {
		return static::Get(null, $min_version, $updated_since, $confirmed_only);
	}
	
	public static function Get($values = null, int $min_version = -1, \DateTime $updated_since = null, bool $confirmed_only = false) {
		if ($values !== null) {
			$values = static::PrepareLists($values);
		} else {
			$values = array();
		}
		
		if ($updated_since === null) {
			$updated_since = new \DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = \BeaconCommon::MinVersion();
		}
		
		$clauses = array();
		$parameters = array(
			$min_version,
			$updated_since->format('Y-m-d H:i:sO')
		);
		
		$c = 3;
		foreach ($values as $column => $list) {
			if ($column == 'tags') {
				$tags = explode(',', substr($list, 1, -1));
				foreach ($tags as $tag) {
					$clauses[] = '$' . $c++ . ' = ANY(tags)';
					$parameters[] = $tag;
				}
			} else {
				$clauses[] = $column . ' = ANY($' . $c++ . ')';
				$parameters[] = $list;
			}
		}
		if (count($clauses) > 0) {
			$clauses = array('(' . implode(' OR ', $clauses) . ')');
		}
		array_unshift($clauses, 'min_version <= $1', $table = static::TableName() . '.last_update > $2');
		if ($confirmed_only == true) {
			$clauses[] = 'mods.confirmed = TRUE';
		}
		
		$database = \BeaconCommon::Database();
		$sql = static::BuildSQL($clauses);
		$results = $database->Query($sql, $parameters);
		return static::FromResults($results);
	}
	
	public static function GetByObjectID(string $object_id, int $min_version = -1, \DateTime $updated_since = null) {
		$objects = static::Get($object_id, $min_version, $updated_since);
		if (count($objects) == 1) {
			return $objects[0];
		}
	}
	
	public static function GetWithTag(string $tag, int $min_version = -1, \DateTime $updated_since = null) {
		$tag = self::NormalizeTag($tag);
		return static::Get('tags:' . $tag, $min_version, $updated_since);
	}
	
	protected static function FromResults(\BeaconRecordSet $results) {
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
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$tags = substr($row->Field('tags'), 1, -1);
		if (strlen($tags) > 0) {
			$tags = explode(',', $tags);
		} else {
			$tags = array();
		}
		asort($tags);
		
		$obj = new static($row->Field('object_id'));
		$obj->object_group = $row->Field('table_name');
		$obj->label = $row->Field('label');
		$obj->alternate_label = $row->Field('alternate_label');
		$obj->min_version = intval($row->Field('min_version'));
		$obj->mod_id = $row->Field('mod_id');
		$obj->mod_name = $row->Field('mod_name');
		$obj->mod_workshop_id = $row->Field('mod_workshop_id');
		$obj->tags = array_values($tags);
		return $obj;
	}
	
	public static function LastUpdate(int $min_version = -1) {
		$database = \BeaconCommon::Database();
		$table = static::TableName();
		
		if ($min_version == -1) {
			$min_version = \BeaconCommon::MinVersion();
		}
		
		$results = $database->Query('SELECT MAX(last_update) AS most_recent_change FROM ' . $table . ' WHERE min_version <= $1;', $min_version);
		if ($results->Field('most_recent_change') !== null) {
			$change_time = new \DateTime($results->Field('most_recent_change'));
		} else {
			$change_time = new \DateTime('2000-01-01');
		}
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM deletions WHERE min_version <= $1;', $min_version);
		} else {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM deletions WHERE min_version <= $1 AND from_table = $2;', $min_version, $table);
		}
		if ($results->Field('most_recent_delete') !== null) {
			$delete_time = new \DateTime($results->Field('most_recent_delete'));
		} else {
			$delete_time = new \DateTime('2000-01-01');
		}
		return ($change_time >= $delete_time) ? $change_time : $delete_time;
	}
	
	public static function Deletions(int $min_version = -1, \DateTime $since = null) {
		if ($since === null) {
			$since = new \DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = \BeaconCommon::MinVersion();
		}
		
		$database = \BeaconCommon::Database();
		$table = static::TableName();
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT * FROM deletions WHERE min_version <= $1 AND action_time > $2;', $min_version, $since->format('Y-m-d H:i:sO'));
		} else {
			$results = $database->Query('SELECT * FROM deletions WHERE min_version <= $1 AND action_time > $2 AND from_table = $3;', $min_version, $since->format('Y-m-d H:i:sO'), $table);
		}
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = array(
				'object_id' => $results->Field('object_id'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label'),
				'tag' => $results->Field('tag')
			);
			$results->MoveNext();
		}
		return $arr;
	}
	
	public function jsonSerialize() {
		return array(
			'id' => $this->object_id,
			'label' => $this->label,
			'alternate_label' => $this->alternate_label,
			'mod' => array(
				'id' => $this->mod_id,
				'name' => $this->mod_name
			),
			'group' => $this->object_group,
			'tags' => $this->tags
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
	
	public function AlternateLabel() {
		return $this->alternate_label;
	}
	
	public function SetAlternateLabel(string $alternate_label) {
		$this->alternate_label = $alternate_label;
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
	
	public function ModWorkshopID() {
		return $this->mod_workshop_id;
	}
	
	public function Delete() {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::TableName() . ' WHERE object_id = $1;', $this->object_id);
		$database->Commit();
	}
	
	public static function NormalizeTag(string $tag) {
		$tag = strtolower($tag);
		$tag = preg_replace('/[^\w]/', '', $tag);
		return $tag;
	}
	
	public function Tags() {
		return $this->tags;
	}
	
	public function AddTag(string $tag) {
		$tag = self::NormalizeTag($tag);
		if (!in_array($tag, $this->tags)) {
			$this->tags[] = $tag;
		}
	}
	
	public function RemoveTag(string $tag) {
		$tag = self::NormalizeTag($tag);
		if (in_array($tag, $this->tags)) {
			$arr = array();
			foreach ($this->tags as $current_tag) {
				if ($current_tag !== $tag) {
					$arr[] = $current_tag;
				}
			}
			$this->tags = $arr;
		}
	}
	
	public function IsTagged(string $tag) {
		return in_array(self::NormalizeTag($tag), $this->tags);
	}
	
	public static function DeleteObjects(string $object_id, string $user_id) {
		$database = \BeaconCommon::Database();
		$escaped_table = $database->EscapeIdentifier(static::TableName());
		
		$database->BeginTransaction();
		$results = $database->Query('SELECT mods.user_id, ' . $escaped_table . '.object_id FROM ' . $escaped_table . ' INNER JOIN mods ON (' . $escaped_table . '.mod_id = mods.mod_id) WHERE ' . $escaped_table . '.object_id = ANY($1) FOR UPDATE OF ' . $escaped_table . ';', '{' . $object_id . '}');
		$objects = array();
		while (!$results->EOF()) {
			if ($results->Field('user_id') !== $user_id) {
				$database->Rollback();
				return false;
			}
			$objects[] = $results->Field('object_id');
			$results->MoveNext();
		}
		if (count($objects) == 0) {
			$database->Rollback();
			return true;
		}
		$database->Query('DELETE FROM ' . $escaped_table . ' WHERE object_id = ANY($1);', '{' . implode(',', $objects) . '}');
		$database->Commit();
		return true;
	}
}

?>
