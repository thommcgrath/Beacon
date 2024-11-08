<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroupService extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $serviceGroupServiceId;
	protected string $serviceGroupId;
	protected string $serviceId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupServiceId = $row->Field('service_group_service_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceId = $row->Field('service_id');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_services', [
			new DatabaseObjectProperty('serviceGroupServiceId', ['columnName' => 'service_group_service_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupServiceId' => $this->serviceGroupServiceId,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceId' => $this->serviceId,
			'permissions' => $this->permissions,
		];
	}

	public function ServiceGroupServiceId(): string {
		return $this->serviceGroupServiceId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function Permissions(): int {
		return $this->permissions;
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $this->serviceId, user: $user);
		if (($servicePermissions & Script::kPermissionUpdate) === 0) {
			return self::kPermissionNone;
		}
		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);
		if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceId']) === false || isset($newObjectProperties['serviceGroupId']) === false) {
			return false;
		}

		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $newObjectProperties['serviceId'], user: $user);
		if (($servicePermissions & Script::kPermissionUpdate) === 0) {
			return false;
		}

		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $newObjectProperties['serviceGroupId'], user: $user);
		if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
			return false;
		}

		return true;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$user = null;
		if (isset($filters['serviceId'])) {
			$user = Core::User();
			$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $filters['serviceId'], user: $user);
			if (($servicePermissions & Script::kPermissionUpdate) === 0) {
				throw new Exception('User does not have update permission on service ' . $filters['serviceId']);
			}
		}
		if (isset($filters['serviceGroupId'])) {
			if (is_null($user)) {
				$user = Core::User();
			}
			$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $filters['serviceGroupId'], user: $user);
			if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
				throw new Exception('User does not have update permission on service group ' . $filters['serviceGroupId']);
			}
		}
	}
}

?>
