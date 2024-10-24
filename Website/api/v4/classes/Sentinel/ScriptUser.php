<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, PermissibleObject};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ScriptUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Validate as protected MutableDatabaseObjectValidate;
	}
	use PermissibleObject;

	protected string $scriptUserId;
	protected string $scriptId;
	protected string $userId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptUserId = $row->Field('script_user_id');
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->permissions = ($row->Field('permissions') | PermissionBits::ScriptRead) & PermissionBits::ScriptAll;
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'script_users', [
			new DatabaseObjectProperty('scriptUserId', ['primaryKey' => true, 'columnName' => 'script_user_id', 'required' => false]),
			new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('scriptId');

		if (isset($filters['scriptId']) && isset($filters['userId'])) {
			$scriptPlaceholder = $parameters->AddValue($filters['scriptId']);
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$permissionPlaceholder = $parameters->AddValue(PermissionBits::ScriptSharing);
			$parameters->clauses[] = 'script_users.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE script_id = $' . $scriptPlaceholder . ' AND (user_id = $' . $userPlaceholder . ' OR (permissions & $' . $permissionPlaceholder . ') > 0))';
		} elseif (isset($filters['userId'])) {
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'script_users.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $' . $userPlaceholder . ')';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptUserId' => $this->scriptUserId,
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'permissions' => $this->permissions,
		];
	}

	public function ScriptUserId(): string {
		return $this->scriptUserId;
	}

	public function ScriptId(): string {
		return $this->scriptId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Permissions(): int {
		return $this->permissions;
	}

	public function SetPermissions(int $permissions): void {
		$permissions = ($permissions | PermissionBits::ScriptRead) & PermissionBits::ScriptAll;
		$this->SetProperty('permissions', $permissions);
	}

	public function GetUserPermissions(string $userId): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $this->scriptId, $userId);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return 0;
		}
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
