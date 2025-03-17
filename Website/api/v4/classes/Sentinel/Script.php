<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Script extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	const ObjectPermissionFlag = 4;

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
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'scripts',
			definitions: [
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('language', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('code', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			],
			joins: [
			],
			options: DatabaseSchema::OptionDistinct,
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'name';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'name':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = '$' . $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = "scripts.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = {$userIdPlaceholder})";
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'name' => $this->name,
			'language' => $this->language,
			'code' => $this->code,
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT editable FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $this->scriptId, $user->UserId());
		if ($rows->RecordCount() !== 1) {
			return self::kPermissionNone;
		}

		$permissions = self::kPermissionRead;
		if ($rows->Field('editable') === true) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}
}

?>
