<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, DateTime, Exception;

class GenericObject extends DatabaseObject implements \JsonSerializable {
	protected $objectId;
	protected $objectGroup;
	protected $label;
	protected $alternateLabel;
	protected $minVersion = 0;
	protected $contentPackId;
	protected $contentPackName;
	protected $contentPackSteamId;
	protected $tags = [];
	protected $lastUpdate = 0;
	
	//const COLUMN_NOT_EXISTS = 'ae3eefbc-6dd0-4f92-ae3d-7cae5c6c9aee';
	
	protected function __construct(BeaconRecordSet $row) {
		$tags = substr($row->Field('tags'), 1, -1);
		if (strlen($tags) > 0) {
			$tags = explode(',', $tags);
		} else {
			$tags = [];
		}
		asort($tags);
		
		$this->objectId = $row->Field('object_id');
		$this->objectGroup = $row->Field('object_group');
		$this->label = $row->Field('label');
		$this->alternateLabel = $row->Field('alternate_label');
		$this->minVersion = intval($row->Field('min_version'));
		$this->contentPackId = $row->Field('mod_id');
		$this->contentPackName = $row->Field('mod_name');
		$this->contentPackSteamId = $row->Field('mod_workshop_id');
		$this->tags = array_values($tags);
		$this->lastUpdate = $row->Field('last_update');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'objects', [
			new DatabaseObjectProperty('objectId', ['primaryKey' => true, 'columnName' => 'object_id']),
			new DatabaseObjectProperty('objectGroup', ['accessor' => 'SUBSTRING(%%TABLE%%.tableoid::regclass::TEXT, 5)', 'columnName' => 'object_group']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('alternateLabel', ['columnName' => 'alternate_label']),
			new DatabaseObjectProperty('tags'),
			new DatabaseObjectProperty('minVersion', ['accessor' => 'GREATEST(%%TABLE%%.min_version, mods.min_version)', 'setter' => '%%PLACEHOLDER%%', 'columnName' => 'min_version']),
			new DatabaseObjectProperty('contentPackId', ['accessor' => 'mods.mod_id', 'setter' => '%%PLACEHOLDER%%', 'columnName' => 'mod_id']),
			new DatabaseObjectProperty('contentPackName', ['accessor' => 'mods.name', 'columnName' => 'mod_name']),
			new DatabaseObjectProperty('contentPackSteamId', ['accessor' => 'ABS(mods.workshop_id)', 'columnName' => 'mod_workshop_id']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => "%%TABLE%%.%%COLUMN%% AT TIME ZONE 'UTC'"])
		], [
			'INNER JOIN ark.mods ON (%%TABLE%%.mod_id = mods.mod_id)'
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('label');
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		
		if (isset($filters['contentPackId'])) {
			if (BeaconCommon::IsUUID($filters['contentPackId']) === true) {
				$parameters->clauses[] = $schema->Comparison('contentPackId', '=', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('contentPackSteamId', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['contentPackId'];
		}
		
		if (isset($filters['tag'])) {
			$parameters->clauses[] = $schema->Setter('tags', $parameters->placeholder++) . ' = ANY(' . $schema->Accessor('tags') . ')';
			$parameters->values[] = $filters['tag'];
		}
		
		if (isset($filters['tags'])) {
			$tags = explode(',', $filters['tags']);
			foreach ($tags as $tag) {
				$parameters->clauses[] = $schema->Setter('tags', $parameters->placeholder++) . ' = ANY(' . $schema->Accessor('tags') . ')';
				$parameters->values[] = $tag;
			}
		}
	}
	
	/*protected static function PreparePropertyValue(string $propertyName, DatabaseObjectProperty $definition, mixed $value, string &$setter): mixed {
		switch ($propertyName) {
		case 'tags':
			$tags = [];
			if (is_string($value)) {
				$tags = explode(',', $value);
			} else if (is_array($value)) {
				$tags = $value;
			}
			sort($tags);
			$setter = 'ARRAY(SELECT JSONB_ARRAY_ELEMENTS_TEXT(' . $setter . '))';
			return json_encode($tags);
			break;
		default:
			return parent::PreparePropertyValue($propertyName, $definition, $value, $setter);
		}
	}*/
	
	public static function CheckClassPermission(?User $user, array $members, int $desiredPermissions): bool {
		// If the only thing the user wants is read, that will be allowed
		if ($desiredPermissions === DatabaseObject::kPermissionRead) {
			return true;
		}
		
		if (is_null($user) || count($members) === 0) {
			return false;
		}
		
		$contentPacks = [];
		foreach ($members as $memberData) {
			if (isset($memberData['contentPackId']) === false) {
				return false;
			}
			
			$contentPackId = $memberData['contentPackId'];
			if (isset($contentPacks[$contentPackId])) {
				// Already confirmed ok
				continue;
			}
			
			if (BeaconCommon::IsUUID($contentPackId) === false) {
				return false;
			}
			
			$contentPack = ContentPack::Fetch($contentPackId);
			if (is_null($contentPack)) {
				return false;
			}
			
			if ($contentPack->UserId() !== $contentPack->UserId()) {
				return false;
			}
			
			// approved
			$contentPacks[$contentPackId] = $contentPack;
		}
		
		return true;
	}
	
	/*protected static function BuildSQL(...$clauses) {
		if ((count($clauses) == 1) && (is_array($clauses[0]))) {
			$clauses = $clauses[0];
		}
		
		$schema = static::SchemaName();
		$table = static::TableName();
		$sql = 'SELECT SUBSTRING(' . $table . '.tableoid::regclass::TEXT, 5) AS table_name, ' . implode(', ', static::SQLColumns()) . ' FROM ' . $schema . '.' . $table . ' INNER JOIN ark.mods ON (' . $table . '.mod_id = mods.mod_id)';
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
			$this->min_version = $json['min_version'];
		}
		if (is_null($this->mod_id) && isset($json['mod']['id'])) {
			$this->mod_id = $json['mod']['id'];
		}
		if (array_key_exists('tags', $json) && is_array($json['tags'])) {
			$tags = array();
			foreach ($json['tags'] as $tag) {
				$tags[] = static::NormalizeTag($tag);
			}
			$this->tags = $tags;
		}
	}
	
	public static function FromJSON(array $json) {
		if (array_key_exists('id', $json)) {
			$object_id = $json['id'];
		} else {
			$object_id = null;
		}
		
		$obj = new static($object_id);
		$obj->ConsumeJSON($json);
		return $obj;
	}
	
	public function Save() {
		$schema = static::SchemaName();
		$table = static::TableName();
		
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = $1 AND table_name = $2;", $schema, $table);
		$types = [];
		while (!$results->EOF()) {
			$types[$results->Field('column_name')] = $results->Field('data_type');
			$results->MoveNext();
		}
		
		$c = 1;
		$values = [];
		$active_columns = [];
		$set_pairs = [];
		foreach ($types as $column => $type) {
			$value = $this->GetColumnValue($column);
			if ($value === self::COLUMN_NOT_EXISTS) {
				continue;
			}
			
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
		
		$placeholders = array_keys($values);
		$values = array_values($values);
		
		$database->BeginTransaction();
		$results = $database->Query('SELECT object_id FROM ' . $this->SchemaName() . '.' . $this->TableName() . ' WHERE object_id = $1;', $this->object_id);
		if ($results->RecordCount() == 0) {
			$database->Query('INSERT INTO ' . $schema . '.' . $table . ' (' . implode(', ', $active_columns) . ') VALUES (' . implode(', ', $placeholders) . ');', $values);
		} else {
			$database->Query('UPDATE ' . $schema . '.' . $table . ' SET ' . implode(', ', $set_pairs) . ' WHERE object_id = ' . $database->EscapeLiteral($results->Field('object_id')) . ';', $values);
		}
		$this->SaveChildrenHook($database);
		$database->Commit();
	}
	
	protected function SaveChildrenHook(BeaconDatabase $database) {
	}
	
	protected static function PrepareLists($value_list) {
		if (is_string($value_list)) {
			$value_list = explode(',', $value_list);
		}
		if (!is_array($value_list)) {
			throw new Exception('Must supply an array or comma-separated string.');
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
		if (BeaconCommon::IsUUID($value)) {
			$possible_columns[] = 'object_id';
			$possible_columns[] = 'ark.mods.mod_id';
			return $value;
		}
		if (is_numeric($value)) {
			$numeric_value = $value + 0;
			if (is_int($numeric_value)) {
				$possible_columns[] = 'ark.mods.workshop_id';
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
	
	public static function GetAll(int $min_version = -1, DateTime $updated_since = null, bool $confirmed_only = false) {
		return static::Get(null, $min_version, $updated_since, $confirmed_only);
	}
	
	public static function Get($values = null, int $min_version = -1, DateTime $updated_since = null, bool $confirmed_only = false) {
		if ($values !== null) {
			$values = static::PrepareLists($values);
		} else {
			$values = array();
		}
		
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
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
		array_unshift($clauses, 'GREATEST(' . static::TableName() . '.min_version, mods.min_version) <= $1', static::TableName() . '.last_update > $2');
		if ($confirmed_only == true) {
			$clauses[] = 'ark.mods.confirmed = TRUE';
		}
		
		$database = BeaconCommon::Database();
		$sql = static::BuildSQL($clauses);
		$results = $database->Query($sql, $parameters);
		return static::FromResults($results);
	}
	
	public static function GetByObjectID(string $object_id, int $min_version = -1, DateTime $updated_since = null) {
		$objects = static::Get($object_id, $min_version, $updated_since);
		if (count($objects) == 1) {
			return $objects[0];
		}
	}
	
	public static function GetWithTag(string $tag, int $min_version = -1, DateTime $updated_since = null) {
		$tag = self::NormalizeTag($tag);
		return static::Get('tags:' . $tag, $min_version, $updated_since);
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
	}*/
	
	public static function LastUpdate(int $min_version = -1) {
		$database = BeaconCommon::Database();
		$schema = static::SchemaName();
		$table = static::TableName();
		
		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
		}
		
		$results = $database->Query('SELECT MAX(last_update) AS most_recent_change FROM ' . $schema . '.' . $table . ' WHERE min_version <= $1;', $min_version);
		if ($results->Field('most_recent_change') !== null) {
			$change_time = new DateTime($results->Field('most_recent_change'));
		} else {
			$change_time = new DateTime('2000-01-01');
		}
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM ' . $schema . '.deletions WHERE min_version <= $1;', $min_version);
		} else {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM ' . $schema . '.deletions WHERE min_version <= $1 AND from_table = $2;', $min_version, $table);
		}
		if ($results->Field('most_recent_delete') !== null) {
			$delete_time = new DateTime($results->Field('most_recent_delete'));
		} else {
			$delete_time = new DateTime('2000-01-01');
		}
		return ($change_time >= $delete_time) ? $change_time : $delete_time;
	}
	
	public static function Deletions(int $min_version = -1, DateTime $since = null) {
		if ($since === null) {
			$since = new DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
		}
		
		$database = BeaconCommon::Database();
		$schema = static::SchemaName();
		$table = static::TableName();
		
		if ($table == self::TableName()) {
			$results = $database->Query('SELECT * FROM ' . $schema . '.deletions WHERE min_version <= $1 AND action_time > $2;', $min_version, $since->format('Y-m-d H:i:sO'));
		} else {
			$results = $database->Query('SELECT * FROM ' . $schema . '.deletions WHERE min_version <= $1 AND action_time > $2 AND from_table = $3;', $min_version, $since->format('Y-m-d H:i:sO'), $table);
		}
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = [
				'objectId' => $results->Field('object_id'),
				'minVersion' => $results->Field('min_version'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label'),
				'tag' => $results->Field('tag')
			];
			$results->MoveNext();
		}
		return $arr;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'objectId' => $this->objectId,
			'objectGroup' => $this->objectGroup,
			'label' => $this->label,
			'alternateLabel' => $this->alternateLabel,
			'contentPack' => [
				'id' => $this->contentPackId,
				'name' => $this->contentPackName
			],
			'tags' => $this->tags,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate
		];
	}
	
	public function ObjectId(): string {
		return $this->objectId;
	}
	
	public function ObjectGroup(): string {
		return $this->objectGroup;
	}
	
	public function Label(): string {
		return $this->label;
	}
	
	public function SetLabel(string $label): void {
		$this->label = $label;
	}
	
	public function AlternateLabel(): ?string {
		return $this->alternateLabel;
	}
	
	public function SetAlternateLabel(?string $alternateLabel): void {
		$this->alternateLabel = $alternateLabel;
	}
	
	public function MinVersion(): int {
		return $this->minVersion;
	}
	
	public function ModId(): string {
		return $this->modId;
	}
	
	public function ModName(): string {
		return $this->modName;
	}
	
	public function ModWorkshopId(): string {
		return $this->modWorkshopId;
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
		$database = BeaconCommon::Database();
		$escaped_schema = $database->EscapeIdentifier(static::SchemaName());
		$escaped_table = $database->EscapeIdentifier(static::TableName());
		
		$database->BeginTransaction();
		$results = $database->Query('SELECT mods.user_id, ' . $escaped_table . '.object_id FROM ' . $escaped_schema . '.' . $escaped_table . ' INNER JOIN ' . $escaped_schema . '.mods ON (' . $escaped_table . '.mod_id = mods.mod_id) WHERE ' . $escaped_table . '.object_id = ANY($1) FOR UPDATE OF ' . $escaped_table . ';', '{' . $object_id . '}');
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
		$database->Query('DELETE FROM ' . $escaped_schema . '.' . $escaped_table . ' WHERE object_id = ANY($1);', '{' . implode(',', $objects) . '}');
		$database->Commit();
		return true;
	}
}

?>
