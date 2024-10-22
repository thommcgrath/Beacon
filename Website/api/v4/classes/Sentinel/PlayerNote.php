<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class PlayerNote extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Edit as protected MutableDatabaseObjectEdit;
	}

	protected string $noteId;
	protected string $playerId;
	protected string $userId;
	protected float $postTime;
	protected string $content;
	protected array $edits;

	public function __construct(BeaconRecordSet $row) {
		$this->noteId = $row->Field('note_id');
		$this->playerId = $row->Field('player_id');
		$this->userId = $row->Field('user_id');
		$this->postTime = floatval($row->Field('post_time'));
		$this->content = $row->Field('content');
		$this->edits = json_decode($row->Field('edits'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'player_notes', [
			new DatabaseObjectProperty('noteId', ['primaryKey' => true, 'columnName' => 'note_id', 'required' => false]),
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('postTime', ['columnName' => 'post_time', 'required' => false, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('content', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('edits', ['columnName' => 'edits', 'required' => false, 'accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(edits_template))) FROM (SELECT EXTRACT(EPOCH FROM player_note_edits.edit_time) AS edit_time, player_note_edits.previous_content FROM sentinel.player_note_edits INNER JOIN sentinel.player_notes AS A ON (player_note_edits.note_id = A.note_id) WHERE player_note_edits.note_id = player_notes.note_id ORDER BY player_note_edits.edit_time DESC) AS edits_template), '[]')"]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
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
			'content' => $this->content,
			'edits' => $this->edits,
		];
	}

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

	public function Edit(array $properties, bool $restoreDefaults = false): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			if (isset($properties['content']) && $properties['content'] !== $this->content) {
				$database->Query('INSERT INTO sentinel.player_note_edits (note_id, previous_content) VALUES ($1, $2);', $this->noteId, $this->content);
			}
			$this->MutableDatabaseObjectEdit($properties, $restoreDefaults);
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
		$database->Commit();
	}
}

?>
