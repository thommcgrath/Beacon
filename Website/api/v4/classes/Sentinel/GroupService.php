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
	protected string $groupOwnerId;
	protected string $serviceId;
	protected string $serviceName;
	protected ?string $serviceNickname;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $serviceOwnerId;
	protected int $permissions;
	protected int $editableAssetsMask;
	protected int $shareableAssetsMask;

	public function __construct(BeaconRecordSet $row) {
		$this->groupServiceId = $row->Field('group_service_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->groupOwnerId = $row->Field('group_owner_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceName = $row->Field('service_name');
		$this->serviceNickname = $row->Field('service_nickname');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->serviceOwnerId = $row->Field('service_owner_id');
		$this->permissions = $row->Field('permissions');
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
				new DatabaseObjectProperty('groupOwnerId', ['columnName' => 'group_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.user_id']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceName', ['columnName' => 'service_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.name']),
				new DatabaseObjectProperty('serviceNickname', ['columnName' => 'service_nickname', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.nickname']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.color']),
				new DatabaseObjectProperty('serviceOwnerId', ['columnName' => 'service_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.user_id']),
				new DatabaseObjectProperty('permissions', ['required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.services ON (group_services.service_id = services.service_id)',
				'INNER JOIN sentinel.groups ON (group_services.group_id = groups.group_id)',
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
			case 'serviceName':
			case 'serviceNickname':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'groupOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'groupColor');
		$parameters->AddFromFilter($schema, $filters, 'serviceName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceNickname', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceColor');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupServiceId' => $this->groupServiceId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
			'groupOwnerId' => $this->groupOwnerId,
			'serviceId' => $this->serviceId,
			'serviceName' => $this->serviceName,
			'serviceNickname' => $this->serviceNickname,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'serviceOwnerId' => $this->serviceOwnerId,
			'permissions' => $this->permissions,
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
			// Ensure that the user is a member of this group before listing all servers for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.group_users WHERE group_id = $1 AND user_id = $2;', $filters['groupId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('You do not have any permissions on the requested group.');
			}
			return;
		}
		if (isset($filters['serviceId'])) {
			// Ensure that the user has some kind of permission on the service in question
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $filters['serviceId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('You do not have any permissions on the requested service.');
			}
			return;
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new Exception('You must filter on groupId or serviceId.');
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['groupId'], $user->UserId(), Group::GroupPermissionManage);
		if ($rows->RecordCount() === 0) {
			return false;
		}
		$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['serviceId'], $user->UserId(), Service::ServicePermissionManage);
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = self::kPermissionNone;
		$userId = $user->UserId();
		$manageGroup = false;
		$manageService = false;

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $this->groupId, $userId);
		if ($rows->RecordCount() === 1) {
			$permissions = $permissions | self::kPermissionRead;
			if (($rows->Field('permissions') & Group::GroupPermissionManage) > 0) {
				$manageGroup = true;
			}
		}
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $this->serviceId, $userId);
		if ($rows->RecordCount() === 1) {
			$permissions = $permissions | self::kPermissionRead;
			if (($rows->Field('permissions') & Service::ServicePermissionManage) > 0) {
				$manageService = true;
			}
		}

		if ($manageGroup && $manageService) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}
}

?>
