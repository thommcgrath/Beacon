<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class PlayerNote extends DatabaseObject implements JsonSerializable {
	protected $noteId = null;
	protected $playerId = null;
	protected $userId = null;
	protected $postTime = null;
	protected $content = null;
	
	public function __construct(BeaconRecordSet $row) {
		$this->noteId = $row->Field('note_id');
		$this->playerId = $row->Field('player_id');
		$this->userId = $row->Field('user_id');
		$this->postTime = floatval($row->Field('post_time'));
		$this->content = $row->Field('content');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'player_notes', [
			new DatabaseObjectProperty('noteId', ['primaryKey' => true, 'columnName' => 'note_id']),
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('postTime', ['columnName' => 'post_time']),
			new DatabaseObjectProperty('content')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('postTime') . ' DESC';
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
	}
	
	public function jsonSerialize(): mixed {
		return [
			'noteId' => $this->noteId,
			'playerId' => $this->playerId,
			'userId' => $this->userId,
			'postTime' => $this->postTime,
			'content' => $this->content
		];
	}
	
	/*public static function Create(string $userId, array $properties): PlayerNote {
		if (BeaconCommon::HasAllKeys($properties, 'content', 'player_id') === false) {
			throw new Exception('Missing required properties.');
		}
		if (BeaconCommon::HasAnyKeys($properties, 'user_id', 'post_time')) {
			throw new Exception('Some read-only properties have been included when they should not.');
		}
		
		if (isset($properties['note_id'])) {
			$noteId = $properties['note_id'];
			if (BeaconCommon::IsUUID($noteId) === false) {
				throw new Exception('Note UUID is not a UUID.');
			}
		} else {
			$noteId = BeaconCommon::GenerateUUID();
			$properties['note_id'] = $noteId;
		}
		$properties['user_id'] = $userId;
		
		foreach ($properties as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Insert(self::SQLLongTableName(), $properties);
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
		
		return static::Fetch($noteId);
	}
	
	public static function GetByNoteID(string $noteId): ?PlayerNote {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE note_id = $1;', $noteId);
		if ($rows->RecordCount() === 1) {
			return new static($rows);
		} else {
			return null;
		}
	}
	
	public static function GetByPlayerID(string $playerId): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE player_id = $1 ORDER BY post_time DESC;', $playerId);
		return static::FromRows($rows);
	}
	
	public static function GetByUserID(string $userId): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE user_id = $1 ORDER BY post_time DESC;', $userId);
		return static::FromRows($rows);
	}
	
	public static function GetByAuthorID(string $userId): array {
		// Just an alias for GetByUserID
		return static::GetByUserID($userId);
	}
	
	public static function Search(array $filters): array {
		$placeholder = 1;
		$clauses = [];
		$values = [];
		$offset = 0;
		$limit = 100;
		
		if (isset($filters['user_id']) && BeaconCommon::IsUUID($filters['user_id'])) {
			$clauses[] = 'user_id = $' . $placeholder++;
			$values[] = $filters['user_id'];
		}
		
		if (isset($filters['player_id']) && BeaconCommon::IsUUID($filters['player_id'])) {
			$clauses[] = 'player_id = $' . $placeholder++;
			$values[] = $filters['player_id'];
		}
		
		if (count($clauses) === 0) {
			return [];
		}
		
		if (isset($filters['offset']) && is_numeric($filters['offset'])) {
			$offset = intval($filters['offset']);
		}
		
		if (isset($filters['limit']) && is_numeric($filters['limit'])) {
			$limit = intval($filters['limit']);
		}
		
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE ' . implode(' AND ', $clauses) . ' ORDER BY post_time DESC OFFSET ' . $offset . ' LIMIT ' . $limit . ';';
		
		$database = BeaconCommon::Database();
		$rows = $database->Query($sql, $values);
		return static::FromRows($rows);
	}
	
	protected function HookPrepareColumnWrite(string $property, int &$placeholder, array &$assignments, array &$values): void {
		switch ($property) {
		case 'post_time':
			$assignments[] = $property . ' = to_timestamp($' . $placeholder++ . ')';
			$values[] = $this->$property;
			break;
		default:
			parent::HookPrepareColumnWrite($property, $placeholder, $assignments, $values);
		}
	}*/
	
	public function NoteId(): string {
		return $this->noteId;
	}
	
	public function PlayerId(): string {
		return $this->playerId;
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function PostTime(): float {
		return $this->postTime;	
	}
	
	public function SetPostTime(float $postTime): drunk {
		$this->SetProperty('post_time', $postTime);
	}
	
	public function Content(): string {
		return $this->content;
	}
	
	public function SetContent(string $content): void {
		$this->SetProperty('content', trim($content));
	}
}

?>