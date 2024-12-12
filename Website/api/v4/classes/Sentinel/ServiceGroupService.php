<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ServiceGroupService extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $serviceGroupServiceId;
	protected string $serviceGroupId;
	protected string $serviceGroupName;
	protected string $serviceId;
	protected string $serviceName;
	protected ?string $serviceNickname;
	protected string $serviceDisplayName;
	protected string $serviceGameId;
	protected string $serviceColor;
	protected int $grantedPermissions;
	protected int $sharedPermissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupServiceId = $row->Field('service_group_service_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceGroupName = $row->Field('service_group_name');
		$this->serviceId = $row->Field('service_id');
		$this->serviceName = $row->Field('service_name');
		$this->serviceNickname = $row->Field('service_nickname');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceGameId = $row->Field('service_game_id');
		$this->serviceColor = $row->Field('service_color');
		$this->grantedPermissions = $row->Field('granted_permissions');
		$this->sharedPermissions = $row->Field('shared_permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_services', [
			new DatabaseObjectProperty('serviceGroupServiceId', ['columnName' => 'service_group_service_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceGroupName', ['columnName' => 'service_group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'service_groups.name']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('grantedPermissions', ['columnName' => 'granted_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('sharedPermissions', ['columnName' => 'shared_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('serviceName', ['columnName' => 'service_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.name']),
			new DatabaseObjectProperty('serviceNickname', ['columnName' => 'service_nickname', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.nickname']),
			new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'COALESCE(services.nickname, services.name)']),
			new DatabaseObjectProperty('serviceGameId', ['columnName' => 'service_game_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.game_id']),
			new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.color']),
		], [
			'INNER JOIN sentinel.services ON (service_group_services.service_id = services.service_id AND services.deleted = FALSE)',
			'INNER JOIN sentinel.service_groups ON (service_group_services.service_group_id = service_groups.service_group_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceNickname', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupServiceId' => $this->serviceGroupServiceId,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceGroupName' => $this->serviceGroupName,
			'serviceId' => $this->serviceId,
			'serviceName' => $this->serviceName,
			'serviceNickname' => $this->serviceNickname,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceGameId' => $this->serviceGameId,
			'serviceColor' => $this->serviceColor,
			'grantedPermissions' => $this->grantedPermissions,
			'sharedPermissions' => $this->sharedPermissions,
		];
	}

	public function ServiceGroupServiceId(): string {
		return $this->serviceGroupServiceId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function ServiceGroupName(): string {
		return $this->serviceGroupName;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function ServiceName(): string {
		return $this->serviceName;
	}

	public function GrantedPermissions(): int {
		return $this->grantedPermissions;
	}

	public function SharedPermissions(): int {
		return $this->sharedPermissions;
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['grantedPermissions'])) {
			$desiredPermissions = intval($properties['grantedPermissions']);
			if ($desiredPermissions <= 0) {
				throw new Exception('grantedPermissions must be a positive integer');
			}
			if (($desiredPermissions & Service::kPermissionAll) !== $desiredPermissions) {
				throw new Exception('Invalid bits in grantedPermissions');
			}
		}
		if (isset($properties['sharedPermissions'])) {
			$desiredPermissions = intval($properties['sharedPermissions']);
			if ($desiredPermissions <= 0) {
				throw new Exception('sharedPermissions must be a positive integer');
			}
			if (($desiredPermissions & Service::kPermissionAll) !== $desiredPermissions) {
				throw new Exception('Invalid bits in sharedPermissions');
			}
		}
		if (isset($properties['grantedPermissions']) && isset($properties['sharedPermissions'])) {
			$grantedPermissions = intval($properties['grantedPermissions']);
			$sharedPermissions = intval($properties['sharedPermissions']);
			if (($grantedPermissions & $sharedPermissions) !== $grantedPermissions) {
				throw new Exception('Any permissions included in grantedPermissions must also be included in sharedPermissions');
			}
		}
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		// To make any changes at all, the user must have share permission on the server.
		// If the user does not have update permission on the group, since they have share permission on the server, they should still be allowed to remove the server from the group.
		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $this->serviceId, user: $user);
		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);

		$hasServiceSharedPermission = ($servicePermissions & Service::kPermissionShare) > 0;
		$hasServiceGroupUpdatePermission = ($groupPermissions & ServiceGroup::kPermissionUpdate) > 0;
		if ($hasServiceSharedPermission && $hasServiceGroupUpdatePermission) {
			return self::kPermissionAll;
		} elseif ($hasServiceSharedPermission || $hasServiceGroupUpdatePermission) {
			return self::kPermissionDelete;
		} else {
			return self::kPermissionNone;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceId']) === false || isset($newObjectProperties['serviceGroupId']) === false) {
			return false;
		}

		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $newObjectProperties['serviceId'], user: $user);
		if (($servicePermissions & Service::kPermissionShare) === 0) {
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
			if (($servicePermissions & Service::kPermissionRead) === 0) {
				throw new Exception('User does not have read permission on service ' . $filters['serviceId']);
			}
		}
		if (isset($filters['serviceGroupId'])) {
			if (is_null($user)) {
				$user = Core::User();
			}
			$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $filters['serviceGroupId'], user: $user);
			if (($groupPermissions & ServiceGroup::kPermissionRead) === 0) {
				throw new Exception('User does not have read permission on service group ' . $filters['serviceGroupId']);
			}
		}
	}
}

?>
