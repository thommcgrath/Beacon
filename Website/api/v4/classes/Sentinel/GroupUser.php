<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class GroupUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $groupUserId;
	protected string $groupId;
	protected string $groupName;
	protected string $groupColor;
	protected string $groupOwnerId;
	protected string $userId;
	protected string $username;
	protected int $permissions;
	protected int $editableAssetsMask;
	protected int $shareableAssetsMask;

	public function __construct(BeaconRecordSet $row) {
		$this->groupUserId = $row->Field('group_user_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->groupOwnerId = $row->Field('group_owner_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->permissions = $row->Field('permissions');
		$this->editableAssetsMask = $row->Field('editable_assets');
		$this->shareableAssetsMask = $row->Field('shareable_assets');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_users',
			definitions: [
				new DatabaseObjectProperty('groupUserId', ['columnName' => 'group_user_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupName', ['columnName' => 'group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.name']),
				new DatabaseObjectProperty('groupColor', ['columnName' => 'group_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.color']),
				new DatabaseObjectProperty('groupOwnerId', ['columnName' => 'group_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.user_id']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('username', ['columnName' => 'username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('permissions', ['required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('editableAssetsMask', ['columnName' => 'editable_assets', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareableAssetsMask', ['columnName' => 'shareable_assets', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN public.users ON (group_users.user_id = users.user_id)',
				'INNER JOIN sentinel.groups ON (group_users.group_id = groups.group_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'groupName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'groupName':
			case 'username':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'groupOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupUserId' => $this->groupUserId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
			'groupOwnerId' => $this->groupOwnerId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->userId, 0, 8),
			'permissions' => $this->permissions,
			'editableAssetsMask' => $this->editableAssetsMask,
			'shareableAssetsMask' => $this->shareableAssetsMask,
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
		$userId = Core::UserId();
		if (isset($filters['groupId'])) {
			// Ensure that the user is a member of this group before listing all users for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.group_users WHERE group_id = $1 AND user_id = $2;', $filters['groupId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}

		// Otherwise, force listing their own members
		$filters['userId'] = $userId;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['userId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['groupId'], $user->UserId(), Group::GroupPermissionManage);
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$userId = $user->UserId();
		if ($this->userId == $userId) {
			// The user cannot edit themselves, but must be able to remove themselves from the group. Unless they are the group owner.
			if ($this->groupOwnerId == $userId) {
				return self::kPermissionRead;
			} else {
				return self::kPermissionRead | self::kPermissionDelete;
			}
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $this->groupId, $userId);
		if ($rows->RecordCount() === 0) {
			return self::kPermissionNone;
		}
		$permissions = self::kPermissionRead;
		if (($row->Field('permissions') & Group::GroupPermissionManage) > 0) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}
}

?>
