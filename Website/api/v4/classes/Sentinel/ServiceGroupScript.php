<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ServiceGroupScript extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $serviceGroupScriptId;
	protected string $serviceGroupId;
	protected string $serviceGroupName;
	protected string $scriptId;
	protected string $scriptName;
	protected int $grantedPermissions;
	protected int $sharedPermissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupScriptId = $row->Field('service_group_script_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceGroupName = $row->Field('service_group_name');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->grantedPermissions = $row->Field('granted_permissions');
		$this->sharedPermissions = $row->Field('shared_permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_scripts', [
			new DatabaseObjectProperty('serviceGroupScriptId', ['primaryKey' => true, 'columnName' => 'service_group_script_id', 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceGroupName', ['columnName' => 'service_group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'service_groups.name']),
			new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id']),
			new DatabaseObjectProperty('scriptName', ['columnName' => 'script_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.name']),
			new DatabaseObjectProperty('grantedPermissions', ['columnName' => 'granted_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('sharedPermissions', ['columnName' => 'shared_permissions', 'editable' => DatabaseObjectProperty::kEditableAlways]),
		], [
			'INNER JOIN sentinel.scripts ON (service_group_services.script_id = scripts.script_id)',
			'INNER JOIN sentinel.service_groups ON (service_group_services.service_group_id = service_groups.service_group_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('scriptId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
		$parameters->AddFromFilter($schema, $filters, 'scriptName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupScriptId' => $this->serviceGroupScriptId,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceGroupName' => $this->serviceGroupName,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'grantedPermissions' => $this->grantedPermissions,
			'sharedPermissions' => $this->sharedPermissions,
		];
	}

	public function ServiceGroupScriptId(): string {
		return $this->serviceGroupScriptId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function ScriptId(): string {
		return $this->scriptId;
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
			if (($desiredPermissions & self::kPermissionAll) !== $desiredPermissions) {
				throw new Exception('Invalid bits in grantedPermissions');
			}
		}
		if (isset($properties['sharedPermissions'])) {
			$desiredPermissions = intval($properties['sharedPermissions']);
			if ($desiredPermissions <= 0) {
				throw new Exception('sharedPermissions must be a positive integer');
			}
			if (($desiredPermissions & self::kPermissionAll) !== $desiredPermissions) {
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
		$requiredScopes[] = Application::kScopeSentinelScriptsRead;
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelScriptsWrite;
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		// To make any changes at all, the user must have share permission on the script.
		// If the user does not have update permission on the group, since they have share permission on the script, they should still be allowed to remove the script from the group.
		$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $this->scriptId, user: $user);
		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);

		$hasScriptSharedPermission = ($scriptPermissions & Script::kPermissionShare) > 0;
		$hasServiceGroupUpdatePermission = ($groupPermissions & ServiceGroup::kPermissionUpdate) > 0;
		if ($hasScriptSharedPermission && $hasServiceGroupUpdatePermission) {
			return self::kPermissionAll;
		} elseif ($hasScriptSharedPermission || $hasServiceGroupUpdatePermission) {
			return self::kPermissionDelete;
		} else {
			return self::kPermissionNone;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['scriptId']) === false || isset($newObjectProperties['serviceGroupId']) === false) {
			return false;
		}

		$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $newObjectProperties['scriptId'], user: $user);
		if (($scriptPermissions & Script::kPermissionShare) === 0) {
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
		if (isset($filters['scriptId'])) {
			$user = Core::User();
			$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $filters['scriptId'], user: $user);
			if (($scriptPermissions & Script::kPermissionShare) === 0) {
				throw new Exception('User does not have share permission on script ' . $filters['scriptId']);
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
