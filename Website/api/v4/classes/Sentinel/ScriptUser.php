<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ScriptUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $scriptUserId;
	protected string $scriptId;
	protected string $userId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptUserId = $row->Field('script_user_id');
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->permissions = ($row->Field('permissions') | Script::kPermissionRead) & Script::kPermissionAll;
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

		$scriptFiltered = isset($filters['scriptId']);
		$userFiltered = isset($filters['userId']);

		if ($scriptFiltered === true && $userFiltered === true) {
			$scriptPlaceholder = $parameters->AddValue($filters['scriptId']);
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$permissionPlaceholder = $parameters->AddValue(Script::kPermissionRead);
			$parameters->clauses[] = 'script_users.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE script_id = $' . $scriptPlaceholder . ' AND user_id = $' . $userPlaceholder . ' AND (permissions & $' . $permissionPlaceholder . ') = $' . $permissionPlaceholder . ')';
		} elseif ($scriptFiltered === false && $userFiltered === true) {
			$userPlaceholder = $parameters->AddValue($filters['userId']);
			$permissionPlaceholder = $parameters->AddValue(Script::kPermissionRead);
			$parameters->clauses[] = 'script_users.script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $' . $userPlaceholder . ' AND (permissions & $' . $permissionPlaceholder . ') = $' . $permissionPlaceholder . ')';
		} elseif ($scriptFiltered === true && $userFiltered === false) {
			$scriptPlaceholder = $parameters->AddValue($filters['scriptId']);
			$parameters->clauses[] = 'script_users.script_id = $' . $scriptPlaceholder;
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
		$permissions = ($permissions | Script::kPermissionRead) & Script::kPermissionAll;
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
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelScriptsWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		if ($user->UserId() === $this->userId) {
			return (self::kPermissionRead | self::kPermissionDelete);
		}

		$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $this->scriptId, user: $user);
		if (($scriptPermissions & Script::kPermissionShare) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['scriptId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT permissions FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $filters['scriptId'], Core::UserId());
			if ($rows->RecordCount() !== 1 || ($rows->Field('permissions') & Script::kPermissionShare) === 0) {
				throw new Exception('User does not have share permission on script ' . $filters['scriptId']);
			}
		} elseif (isset($filters['userId']) === false) {
			// If they are not listing by script, they must list by user.
			$filters['userId'] = Core::UserId();
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['scriptId']) === false) {
			return false;
		}

		$scriptPermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Script', objectId: $newObjectProperties['scriptId'], user: $user);
		if (($scriptPermissions & Script::kPermissionShare) === 0) {
			return false;
		}

		return true;
	}
}

?>
