<?php

namespace BeaconAPI\Sentinel;

class PlayerNote implements \JsonSerializable {
	protected $note_id = null;
	protected $player_id = null;
	protected $user_id = null;
	protected $post_time = null;
	protected $content = null;
	
	protected static function AlgoliaIndexName(): string {
		return \BeaconCommon::GetGlobal('Algolia Player Notes Index Name') ?? 'player_notes-lab';
	}
	
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
	
	public static function SQLLongTableName(): string {
		return static::SQLSchemaName() . '.' . static::SQLTableName();
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
	
	protected static function FromRows(\BeaconPostgreSQLRecordSet $rows): array {
		$notes = [];
		while (!$rows->EOF()) {
			$notes[] = new static($rows);
			$rows->MoveNext();
		}
		return $notes;
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
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
		
		$note = static::GetByNoteID($note_id);
		
		$requests = [
			[
				'action' => 'updateObject',
				'body' => [
					'objectID' => $note->NoteID(),
					'content' => $note->Content(),
					'player_id' => $note->PlayerID(),
					'user_id' => $note->UserID(),
					'post_time' => $note->PostTime()
				]
			]
		];
		
		$app_id = \BeaconCommon::GetGlobal('Algolia Application ID');
		$index = static::AlgoliaIndexName();
		$api_key = \BeaconCommon::GetGlobal('Algolia API Key');
		
		$url = 'https://' . urlencode($app_id) . '.algolia.net/1/indexes/' . urlencode($index) . '/batch';
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Content-Type: application/json',
			'X-Algolia-Application-Id: ' . $app_id,
			'X-Algolia-API-Key: ' . $api_key
		]);
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(['requests' => $requests]));
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status !== 200) {
			throw new \Exception('Could not sync note with search index.');
		}
		
		return $note;
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
		if (isset($filters['content'])) {
			return static::SearchWithAlgolia($filters);
		} else {
			return static::SearchLocally($filters);
		}
	}
	
	protected static function SearchLocally(array $filters): array {
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
	
	protected static function SearchWithAlgolia(array $filters): array {
		$app_id = \BeaconCommon::GetGlobal('Algolia Application ID');
		$index = static::AlgoliaIndexName();
		$api_key = \BeaconCommon::GetGlobal('Algolia API Key');
		
		$offset = 0;
		$limit = 100;
		$query = $filters['content'];
		$facets = [];
		
		if (isset($filters['user_id']) && \BeaconCommon::IsUUID($filters['user_id'])) {
			$facets[] = 'user_id:' . $filters['user_id'];
		}
		
		if (isset($filters['player_id']) && \BeaconCommon::IsUUID($filters['player_id'])) {
			$facets[] = 'player_id:' . $filters['player_id'];
		}
		
		if (isset($filters['offset']) && is_numeric($filters['offset'])) {
			$offset = intval($filters['offset']);
		}
		
		if (isset($filters['limit']) && is_numeric($filters['limit'])) {
			$limit = intval($filters['limit']);
		}
		
		$url = 'https://' . urlencode($app_id) . '.algolia.net/1/indexes/' . urlencode($index) . '?query=' . urlencode(mb_strtolower($query)) . '&hitsPerPage=' . $limit;
		if (count($facets) > 0) {
			$url .= '&facets=' . urlencode(implode(' AND ', $facets));
		}
		
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'X-Algolia-Application-Id: ' . $app_id,
			'X-Algolia-API-Key: ' . $api_key
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		if ($status !== 200) {
			return [];
		}
		
		$results = json_decode($response, true);
		$notes = [];
		foreach ($results['hits'] as $hit) {
			$notes[] = [
				'note_id' => $hit['objectID'],
				'player_id' => $hit['player_id'],
				'user_id' => $hit['user_id'],
				'post_time' => $hit['post_time'],
				'content' => $hit['content']
			];
		}
		return $notes;
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
	
	protected function SetProperty(string $property, mixed $value): void {
		if ($this->$property !== $value) {
			static::ValidateProperty($property, $value);
			$this->$property = $value;
			$this->changed_properties[] = $property;
		}
	}
	
	public function Save(): void {
		if (count($this->changed_properties) === 0) {
			return;
		}
		
		$placeholder = 1;
		$assignments = [];
		$values = [];
		foreach ($this->changed_properties as $property) {
			switch ($property) {
			case 'post_time':
				$assignments[] = $property . ' = to_timestamp($' . $placeholder++ . ')';
				break;
			default:
				$assignments[] = $property . ' = $' . $placeholder++;
				break;
			}
			$values[] = $this->$property;
		}
		$values[] = $this->note_id;
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('UPDATE ' . static::SQLLongTableName() . ' SET ' . implode(', ', $assignments) . ' WHERE service_id = $' . $placeholder++ . ' RETURNING ' . implode(', ', static::SQLColumns()) . ';', $values);
		$database->Commit();
		
		$this->__construct($rows);
		$this->changed_properties = [];
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