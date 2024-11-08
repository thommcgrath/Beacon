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
	protected string $scriptId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupScriptId = $row->Field('service_group_script_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->scriptId = $row->Field('script_id');
		$this->permissions = ($row->Field('permissions') | self::kPermissionRead) & self::kPermissionAll;
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_scripts', [
			new DatabaseObjectProperty('serviceGroupScriptId', ['primaryKey' => true, 'columnName' => 'service_group_script_id', 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('scriptId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupScriptId' => $this->serviceGroupScriptId,
			'serviceGroupId' => $this->serviceGroupId,
			'scriptId' => $this->scriptId,
			'permissions' => $this->permissions,
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

	public function Permissions(): int {
		return $this->permissions;
	}

	public function SetPermissions(int $permissions): void {
		$permissions = ($permissions | self::kPermissionRead) & self::kPermissionAll;
		$this->SetProperty('permissions', $permissions);
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['permissions'])) {
			$desiredPermissions = intval($properties['permissions']);
			if ($desiredPermissions <= 0) {
				throw new Exception('Permissions must be a positive integer');
			}
			if (($desiredPermissions & self::kPermissionAll) !== $desiredPermissions) {
				throw new Exception('Invalid permission bits');
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
		$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $this->scriptId, user: $user);
		if (($scriptPermissions & Script::kPermissionShare) === 0) {
			return self::kPermissionNone;
		}
		$groupPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);
		if (($groupPermissions & ServiceGroup::kPermissionUpdate) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
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
