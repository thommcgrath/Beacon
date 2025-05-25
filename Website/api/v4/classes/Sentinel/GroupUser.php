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
	protected string $usernameFull;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->groupUserId = $row->Field('group_user_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->groupOwnerId = $row->Field('group_owner_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->usernameFull = $row->Field('username_full');
		$this->permissions = $row->Field('permissions');
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
				new DatabaseObjectProperty('usernameFull', ['columnName' => 'username_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username_full']),
				new DatabaseObjectProperty('permissions', ['required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
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
			case 'usernameFull':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'SEARCH');
		$parameters->AddFromFilter($schema, $filters, 'groupOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'username', 'SEARCH');
		$parameters->AddFromFilter($schema, $filters, 'usernameFull', 'SEARCH');
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
			'usernameFull' => $this->usernameFull,
			'permissions' => $this->permissions,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		$requiredScopes[] = Application::kScopeUsersRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$userId = Core::UserId();
		if (isset($filters['groupId'])) {
			// Ensure that the user is a member of this group before listing all users for it
			if (Group::TestSentinelPermissions($filters['groupId'], $userId) === false) {
				throw new Exception('Forbidden');
			}
			return;
		}

		// Otherwise, force listing their own memberships
		$filters['userId'] = $userId;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['userId']) === false) {
			return false;
		}

		return Group::TestSentinelPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageUsers);
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = Group::GetSentinelPermissions($this->groupId, $user->UserId());
		if ($permissions === 0) {
			return self::kPermissionNone;
		}

		if (($permissions & PermissionBits::ManageUsers) > 0) {
			return self::kPermissionAll;
		} else {
			return self::kPermissionRead;
		}
	}
}

?>
