<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ServiceGroupUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $serviceGroupUserId;
	protected string $serviceGroupId;
	protected string $userId;
	protected string $username;
	protected string $usernameFull;
	protected int $groupPermissions;
	protected int $servicePermissions;
	protected int $scriptPermissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupUserId = $row->Field('service_group_user_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->usernameFull = $row->Field('username_full');
		$this->groupPermissions = intval($row->Field('group_permissions'));
		$this->servicePermissions = intval($row->Field('service_permissions'));
		$this->scriptPermissions = intval($row->Field('script_permissions'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_users', [
			new DatabaseObjectProperty('serviceGroupUserId', ['columnName' => 'service_group_user_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('username', ['columnName' => 'username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
			new DatabaseObjectProperty('usernameFull', ['columnName' => 'username_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
			new DatabaseObjectProperty('groupPermissions', ['columnName' => 'group_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('servicePermissions', ['columnName' => 'service_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways, 'required' => false]),
			new DatabaseObjectProperty('scriptPermissions', ['columnName' => 'script_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways, 'required' => false]),
		], [
			'INNER JOIN public.users ON (service_group_users.user_id = users.user_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'usernameFull';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'username':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');

		if (isset($filters['usernameFull'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\%', '\\\\'], $filters['usernameFull']) . '%');
			$parameters->clauses[] = $schema->Accessor('usernameFull') . ' ILIKE $' . $placeholder;
		}
		if (isset($filters['username'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\%', '\\\\'], $filters['username']) . '%');
			$parameters->clauses[] = $schema->Accessor('username') . ' LIKE $' . $placeholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupUserId' => $this->serviceGroupUserId,
			'serviceGroupId' => $this->serviceGroupId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->usernameFull,
			'groupPermissions' => $this->groupPermissions,
			'servicePermissions' => $this->servicePermissions,
			'scriptPermissions' => $this->scriptPermissions,
		];
	}

	public function ServiceGroupUserId(): string {
		return $this->serviceGroupUserId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function GroupPermissions(): int {
		return $this->groupPermissions;
	}

	public function SetGroupPermissions(int $permissions): void {
		$this->SetProperty('groupPermissions', $permissions);
	}

	public function ServicePermissions(): int {
		return $this->servicePermissions;
	}

	public function SetServicePermissions(int $permissions): void {
		$this->SetProperty('servicePermissions', $permissions);
	}

	public function ScriptPermissions(): int {
		return $this->scriptPermissions;
	}

	public function SetScriptPermissions(int $permissions): void {
		$this->SetProperty('scriptPermissions', $permissions);
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['groupPermissions'])) {
			$groupPermissions = $properties['groupPermissions'];
			if (($groupPermissions & ServiceGroup::kPermissionAll) !== $groupPermissions) {
				throw new Exception('Invalid group permission bits.');
			}
		}
		if (isset($properties['servicePermissions'])) {
			$servicePermissions = $properties['servicePermissions'];
			if (($servicePermissions & Service::kPermissionAll) !== $servicePermissions) {
				throw new Exception('Invalid service permission bits.');
			}
		}
		if (isset($properties['scriptPermissions'])) {
			$scriptPermissions = $properties['scriptPermissions'];
			if (($scriptPermissions & Script::kPermissionAll) !== $scriptPermissions) {
				throw new Exception('Invalid script permission bits.');
			}
		}
		if (isset($properties['userId']) && isset($properties['serviceGroupId'])) {
			$group = ServiceGroup::Fetch($properties['serviceGroupId']);
			if (is_null($group)) {
				throw new Exception('Service group not found.');
			} elseif ($group->UserId() === $properties['userId']) {
				throw new Exception('The owner of the service group should not be added as a user.');
			}
		}
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		if ($user->UserId() === $this->userId) {
			return (self::kPermissionRead | self::kPermissionDelete);
		}

		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);
		if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceGroupId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT permissions FROM sentinel.service_group_permissions WHERE service_group_id = $1 AND user_id = $2;', $filters['serviceGroupId'], Core::UserId());
			if ($rows->RecordCount() !== 1 || ($rows->Field('permissions') & ServiceGroup::kPermissionRead) === 0) {
				throw new Exception('User does not have read permission on service group ' . $filters['serviceGroupId']);
			}
		} elseif (isset($filters['userId']) === false) {
			// If they are not listing by group, they must list by user.
			$filters['userId'] = Core::UserId();
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceGroupId']) === false) {
			return false;
		}

		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $newObjectProperties['serviceGroupId'], user: $user);
		if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
			return false;
		}

		return true;
	}
}

?>
