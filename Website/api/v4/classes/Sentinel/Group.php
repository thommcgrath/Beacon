<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Group extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	const GroupPermissionUsage = 1;
	const GroupPermissionManage = 2;

	protected string $groupId;
	protected string $userId;
	protected string $name;
	protected string $color;
	protected array $users;

	public function __construct(BeaconRecordSet $row) {
		$this->groupId = $row->Field('group_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');

		$userList = json_decode($row->Field('users'), true);
		$this->users = [];
		foreach ($userList as $user) {
			$this->users[$user['user_id']] = ($user['permissions'] | self::kPermissionRead) & self::kPermissionAll;
		}
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'groups', [
			new DatabaseObjectProperty('groupId', ['primaryKey' => true, 'columnName' => 'group_id', 'required' => false]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('users', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(users_template))) FROM (SELECT group_permissions.user_id, group_permissions.permissions FROM sentinel.group_permissions INNER JOIN sentinel.groups AS A ON (group_permissions.group_id = A.group_id) WHERE group_permissions.group_id = groups.group_id ORDER BY groups.name ASC) AS users_template), '[]')"]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->AddFromFilter($schema, $filters, 'color');

		if (isset($filters['userId'])) {
			$placeholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'groups.group_id IN (SELECT group_id FROM sentinel.group_permissions WHERE user_id = $' . $placeholder . ' AND permissions > 0)';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'groupId' => $this->groupId,
			'userId' => $this->userId,
			'name' => $this->name,
			'color' => $this->color,
			'users' => $this->users,
		];
	}

	public function GroupId(): string {
		return $this->groupId;
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

	public function Color(): string {
		return $this->color;
	}

	public function SetColor(string $color): void {
		$this->SetProperty('color', $color);
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		if ($user->UserId() === $this->userId) {
			return self::kPermissionAll;
		} elseif (array_key_exists($user->UserId(), $this->users)) {
			return $this->users[$user->UserId()];
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $this->groupId, $user->UserId());
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
