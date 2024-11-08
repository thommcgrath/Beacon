<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroupUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $serviceGroupUserId;
	protected string $serviceGroupId;
	protected string $userId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupUserId = $row->Field('service_group_user_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->userId = $row->Field('user_id');
		$this->permissions = intval($row->Field('permissions'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_users', [
			new DatabaseObjectProperty('serviceGroupUserId', ['columnName' => 'service_group_user_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('userId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');

		if (isset($filters['permissions'])) {
			$placeholder = $parameters->AddValue($filters['permissions']);
			$parameters->clauses[] = '(' . $schema->Accessor('permissions') . ' & $' . $placeholder . ') = $' . $placeholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupUserId' => $this->serviceGroupUserId,
			'serviceGroupId' => $this->serviceGroupId,
			'userId' => $this->userId,
			'permissions' => $this->permissions,
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

	public function Permissions(): int {
		return $this->permissions;
	}

	public function SetPermissions(int $permissions): void {
		$this->SetProperty('permissions', $permissions);
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
			if ($rows->RecordCount() !== 1 || ($rows->Field('permissions') & ServiceGroup::kPermissionUpdate) === 0) {
				throw new Exception('User does not have update permission on service group ' . $filters['serviceGroupId']);
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
