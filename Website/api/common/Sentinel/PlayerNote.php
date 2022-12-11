<?php

namespace BeaconAPI\Sentinel;

class PlayerNote extends \BeaconAPI\DatabaseObject implements \JsonSerializable {
	protected $note_id = null;
	protected $player_id = null;
	protected $user_id = null;
	protected $post_time = null;
	protected $content = null;
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->note_id = $row->Field('note_id');
		$this->player_id = $row->Field('player_id');
		$this->user_id = $row->Field('user_id');
		$this->post_time = floatval($row->Field('post_time'));
		$this->content = $row->Field('content');
	}
	
	public static function SQLSchemaName(): string {
		return 'sentinel';
	}
	
	public static function SQLTableName(): string {
		return 'player_notes';
	}
	
	public static function SQLPrimaryKey(): string {
		return 'note_id';
	}
	
	public static function SQLColumns(): array {
		return [
			'note_id',
			'player_id',
			'user_id',
			'EXTRACT(EPOCH FROM post_time) AS post_time',
			'content'
		];
	}
	
	public static function Create(string $user_id, array $properties): PlayerNote {
		if (\BeaconCommon::HasAllKeys($properties, 'content', 'player_id') === false) {
			throw new \Exception('Missing required properties.');
		}
		if (\BeaconCommon::HasAnyKeys($properties, 'user_id', 'post_time')) {
			throw new \Exception('Some read-only properties have been included when they should not.');
		}
		
		if (isset($properties['note_id'])) {
			$note_id = $properties['note_id'];
			if (\BeaconCommon::IsUUID($note_id) === false) {
				throw new \Exception('Note UUID is not a UUID.');
			}
		} else {
			$note_id = \BeaconCommon::GenerateUUID();
			$properties['note_id'] = $note_id;
		}
		$properties['user_id'] = $user_id;
		
		foreach ($properties as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = \BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Insert(self::SQLLongTableName(), $properties);
			$database->Commit();
		} catch (\Exception $err) {
			$database->Rollback();
			throw $err;
		}
		
		return static::GetByNoteID($note_id);
	}
	
	public static function GetByNoteID(string $note_id): ?PlayerNote {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE note_id = $1;', $note_id);
		if ($rows->RecordCount() === 1) {
			return new static($rows);
		} else {
			return null;
		}
	}
	
	public static function GetByPlayerID(string $player_id): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE player_id = $1 ORDER BY post_time DESC;', $player_id);
		return static::FromRows($rows);
	}
	
	public static function GetByUserID(string $user_id): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE user_id = $1 ORDER BY post_time DESC;', $user_id);
		return static::FromRows($rows);
	}
	
	public static function GetByAuthorID(string $user_id): array {
		// Just an alias for GetByUserID
		return static::GetByUserID($user_id);
	}
	
	public static function Search(array $filters): array {
		$placeholder = 1;
		$clauses = [];
		$values = [];
		$offset = 0;
		$limit = 100;
		
		if (isset($filters['user_id']) && \BeaconCommon::IsUUID($filters['user_id'])) {
			$clauses[] = 'user_id = $' . $placeholder++;
			$values[] = $filters['user_id'];
		}
		
		if (isset($filters['player_id']) && \BeaconCommon::IsUUID($filters['player_id'])) {
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
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query($sql, $values);
		return static::FromRows($rows);
	}
	
	public function jsonSerialize(): mixed {
		return [
			'note_id' => $this->note_id,
			'player_id' => $this->player_id,
			'user_id' => $this->user_id,
			'post_time' => $this->post_time,
			'content' => $this->content
		];
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
	}
	
	public function NoteID(): string {
		return $this->note_id;
	}
	
	public function PlayerID(): string {
		return $this->player_id;
	}
	
	public function UserID(): string {
		return $this->user_id;
	}
	
	public function PostTime(): float {
		return $this->post_time;	
	}
	
	public function SetPostTime(float $post_time): drunk {
		$this->SetProperty('post_time', $post_time);
	}
	
	public function Content(): string {
		return $this->content;
	}
	
	public function SetContent(string $content): void {
		$this->SetProperty('content', trim($content));
	}
}

?>