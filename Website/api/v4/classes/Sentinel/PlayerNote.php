<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class PlayerNote extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $noteId;
	protected string $playerId;
	protected string $userId;
	protected string $username;
	protected float $dateCreated;
	protected float $dateModified;
	protected string $content;
	protected array $edits;

	public function __construct(BeaconRecordSet $row) {
		$this->noteId = $row->Field('note_id');
		$this->playerId = $row->Field('player_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('user_name');
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
		$this->content = $row->Field('content');
		$this->edits = json_decode($row->Field('edits'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'player_notes', [
			new DatabaseObjectProperty('noteId', ['primaryKey' => true, 'columnName' => 'note_id', 'required' => false]),
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('userName', ['columnName' => 'user_name', 'accessor' => 'users.username', 'required' => false]),
			new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('content', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('edits', ['columnName' => 'edits', 'required' => false, 'accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(edits_template))) FROM (SELECT EXTRACT(EPOCH FROM player_note_edits.previous_timestamp) AS \"previousTimestamp\", player_note_edits.previous_content AS \"previousContent\" FROM sentinel.player_note_edits INNER JOIN sentinel.player_notes AS A ON (player_note_edits.note_id = A.note_id) WHERE player_note_edits.note_id = player_notes.note_id ORDER BY player_note_edits.previous_timestamp DESC) AS edits_template), '[]')"]),
		], [
			"INNER JOIN public.users ON (player_notes.user_id = users.user_id)",
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('dateCreated') . ' DESC';
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'userId');

		if (isset($filters['content'])) {
			$contentPlaceholder = $parameters->AddValue($filters['content']);
			$languagePlaceholder = $parameters->AddValue('english');
			$parameters->clauses[] = '(player_notes.content_vector @@ websearch_to_tsquery($'. $languagePlaceholder . ', $'. $contentPlaceholder . ') OR ' . $schema->Accessor('noteId') . ' IN (SELECT note_id FROM sentinel.player_note_edits WHERE previous_content_vector @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $contentPlaceholder . ')))';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'noteId' => $this->noteId,
			'playerId' => $this->playerId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->userId, 0, 8),
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
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

	public function DateCreated(): float {
		return $this->dateCreated;
	}

	public function DateModified(): float {
		return $this->dateModified;
	}

	public function Content(): string {
		return $this->content;
	}

	public function SetContent(string $content): void {
		$this->SetProperty('content', trim($content));
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		return self::kPermissionRead | ($user->UserId() === $this->userId ? self::kPermissionUpdate : 0);
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['playerId']) === false) {
			throw new Exception('Must include playerId filter');
		}
	}
}

?>
