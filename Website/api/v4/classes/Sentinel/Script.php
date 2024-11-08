<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class Script extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	const LanguageJavascript = 'JavaScript';

	const kPermissionShare = 16;
	const kPermissionAll = (self::kPermissionCreate | self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete | self::kPermissionShare);

	protected string $scriptId;
	protected string $userId;
	protected string $name;
	protected string $language;
	protected string $code;
	protected ?string $storageKey;
	protected float $dateCreated;
	protected float $dateModified;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->language = $row->Field('language');
		$this->code = $row->Field('code');
		$this->storageKey = $row->Field('storage_key');
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'scripts', [
			new DatabaseObjectProperty('scriptId', ['primaryKey' => true, 'columnName' => 'script_id', 'required' => false]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('language', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('code', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('storage_key', ['columnName' => 'storage_key', 'editable' => DatabaseObjectProperty::kEditableAlways, 'required' => false]),
			new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');

		if (isset($filters['userId'])) {
			$placeholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'scripts.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $' . $placeholder . ' AND permissions > 0)';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'name' => $this->name,
			'language' => $this->language,
			'code' => $this->code,
			'storageKey' => $this->storageKey,
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
		];
	}

	public function ScriptId(): string {
		return $this->scriptId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Name(): string {
		return $this->name;
	}

	public function SetName(string $name): void {
		$this->SetProperty('name', $name);
	}

	public function Language(): string {
		return $this->language;
	}

	public function SetLanguage(string $language): void {
		$this->SetProperty('language', $language);
	}

	public function Code(): string {
		return $this->code;
	}

	public function SetCode(string $code): void {
		$this->SetProperty('code', $code);
	}

	public function StorageKey(): string {
		return $this->storageKey;
	}

	public function SetStorageKey(string $storageKey): void {
		$this->SetProperty('storageKey', $storageKey);
	}

	public function DateCreated(): float {
		return $this->dateCreated;
	}

	public function DateModified(): float {
		return $this->dateModified;
	}

	public function GetUserPermissions(string $userId): int {
		if ($userId === $this->userId) {
			return 9223372036854775807;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $this->scriptId, $userId);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return 0;
		}
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelScriptsRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelScriptsWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		if ($user->UserId() === $this->userId) {
			return self::kPermissionAll;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $this->scriptId, $user->UserId());
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return self::kPermissionNone;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}
}

?>
