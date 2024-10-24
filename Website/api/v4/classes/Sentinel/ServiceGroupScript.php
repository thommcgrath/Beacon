<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
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
		$this->permissions = ($row->Field('permissions') | PermissionBits::ScriptRead) & PermissionBits::ScriptAll;
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

		if (isset($filters['serviceGroupId']) && isset($filters['userId'])) {
			$serviceGroupPlaceholder = $parameters->AddValue($filters['serviceGroupId']);
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$permissionPlaceholder = $parameters->AddValue(PermissionBits::ServiceGroupUpdateContents);
			$parameters->clauses[] = 'service_group_scripts.service_group_id IN (SELECT service_group_id FROM sentinel.service_group_permissions WHERE service_group_d = $' . $serviceGroupPlaceholder . ' AND (user_id = $' . $userPlaceholder . ' OR (permissions & $' . $permissionPlaceholder . ') > 0))';
		} elseif (isset($filters['userId'])) {
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'service_group_scripts.service_group_id IN (SELECT service_group_id FROM sentinel.service_group_permissions WHERE user_id = $' . $userPlaceholder . ')';
		}
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
		$permissions = ($permissions | PermissionBits::ScriptRead) & PermissionBits::ScriptAll;
		$this->SetProperty('permissions', $permissions);
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['permissions'])) {
			$desiredPermissions = intval($properties['permissions']);
			if ($desiredPermissions <= 0) {
				throw new Exception('Permissions must be a positive integer');
			}
			if (($desiredPermissions & PermissionBits::ScriptAll) !== $desiredPermissions) {
				throw new Exception('Invalid permission bits');
			}
		}
	}
}

?>
