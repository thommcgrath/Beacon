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
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->groupId = $row->Field('group_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'groups',
			definitions: [
				new DatabaseObjectProperty('groupId', ['primaryKey' => true, 'columnName' => 'group_id', 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('permissions', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'group_permissions.permissions']),
			],
			joins: [
				'INNER JOIN sentinel.group_permissions ON (groups.group_id = group_permissions.group_id AND group_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'color');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupId' => $this->groupId,
			'userId' => $this->userId,
			'name' => $this->name,
			'color' => $this->color,
			'permissions' => $this->permissions,
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
		$permissions = static::GetUserPermissions($this->groupId, $user->UserId());
		if ($permissions === 0) {
			return 0;
		}

		if (($permissions & PermissionBits::EditGroup) > 0) {
			return self::kPermissionAll;
		} else {
			return self::kPermissionRead;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public static function GetUserPermissions(string $groupId, string $userId): int {
		if (BeaconCommon::IsUUID($groupId) === false || BeaconCommon::IsUUID($userId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $groupId, $userId);
		if ($rows->RecordCount() === 0) {
			return 0;
		}
		return $rows->Field('permissions');
	}

	public static function TestUserPermissions(string $groupId, string $userId, int $requiredBits = 1): bool {
		return (static::GetUserPermissions($groupId, $userId) & $requiredBits) > 0;
	}
}

?>
