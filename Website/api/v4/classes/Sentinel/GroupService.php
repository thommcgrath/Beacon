<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class GroupService extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $groupServiceId;
	protected string $groupId;
	protected string $groupName;
	protected string $groupColor;
	protected int $groupPermissions;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected int $permissionsMask;

	public function __construct(BeaconRecordSet $row) {
		$this->groupServiceId = $row->Field('group_service_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->groupPermissions = $row->Field('group_permissions') ?? 0;
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->permissionsMask = $row->Field('permissions_mask');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_services',
			definitions: [
				new DatabaseObjectProperty('groupServiceId', ['columnName' => 'group_service_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupName', ['columnName' => 'group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.name']),
				new DatabaseObjectProperty('groupColor', ['columnName' => 'group_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.color']),
				new DatabaseObjectProperty('groupPermissions', ['columnName' => 'group_permissions', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'group_permissions.permissions']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.color']),
				new DatabaseObjectProperty('permissionsMask', ['columnName' => 'permissions_mask', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.services ON (group_services.service_id = services.service_id)',
				'INNER JOIN sentinel.groups ON (group_services.group_id = groups.group_id)',
				'LEFT JOIN sentinel.group_permissions ON (group_permissions.group_id = groups.group_id AND group_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'serviceDisplayName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'groupName':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'groupColor');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceColor');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupServiceId' => $this->groupServiceId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
			'groupPermissions' => $this->groupPermissions,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'permissionsMask' => $this->permissionsMask,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$userId = Core::UserId();
		if (isset($filters['groupId'])) {
			if (Group::TestSentinelPermissions($filters['groupId'], $userId)) {
				return;
			} else {
				throw new Exception('You do not have any permissions on the requested group.');
			}
		}
		if (isset($filters['serviceId'])) {
			if (Service::TestSentinelPermissions($filters['serviceId'], $userId)) {
				return;
			} else {
				throw new Exception('You do not have any permissions on the requested service.');
			}
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new Exception('You must filter on groupId or bucketId.');
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		return Group::TestSentinelPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageServices) && Service::TestSentinelPermissions($newObjectProperties['serviceId'], $user->UserId(), PermissionBits::ShareServices);
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$groupPermissions = Group::GetSentinelPermissions($this->groupId, $userId);
		$servicePermissions = Service::GetSentinelPermissions($this->serviceId, $userId);

		if ($groupPermissions > 0 || $servicePermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($groupPermissions & PermissionBits::ManageServices) > 0 && ($servicePermissions & PermissionBits::ShareServices) > 0) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}
}

?>
