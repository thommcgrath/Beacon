<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ServiceUser extends DatabaseObject implements JsonSerializable {
	protected string $serviceUserId;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $userId;
	protected string $username;
	protected string $usernameFull;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceUserId = $row->Field('service_user_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->usernameFull = $row->Field('username_full');
		$this->permissions = intval($row->Field('permissions'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_permissions', [
			new DatabaseObjectProperty('serviceUserId', ['columnName' => 'service_user_id', 'primaryKey' => true, 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'uuid_generate_v5(%%TABLE%%.service_id, %%TABLE%%.user_id::TEXT)']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('username', ['columnName' => 'username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
			new DatabaseObjectProperty('usernameFull', ['columnName' => 'username_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "users.username_full"]),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		], [
			'INNER JOIN public.users ON (%%TABLE%%.user_id = users.user_id)',
			'INNER JOIN sentinel.services ON (%%TABLE%%.service_id = services.service_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'usernameFull';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'username':
			case 'usernameFull':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');

		if (isset($filters['usernameFull'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\%', '\\\\'], $filters['usernameFull']) . '%');
			$parameters->clauses[] = $schema->Accessor('usernameFull') . ' ILIKE $' . $placeholder;
		}
		if (isset($filters['username'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\%', '\\\\'], $filters['username']) . '%');
			$parameters->clauses[] = $schema->Accessor('username') . ' LIKE $' . $placeholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceUserId' => $this->serviceUserId,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->usernameFull,
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

	public function GetPermissionsForUser(User $user): int {
		if ($user->UserId() === $this->userId) {
			return self::kPermissionRead;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $filters['serviceId'], Core::UserId());
		if ($rows->RecordCount() === 1) {
			return self::kPermissionRead;
		}

		return self::kPermissionNone;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $filters['serviceId'], Core::UserId());
			if ($rows->RecordCount() !== 1) {
				throw new Exception('User does not have update permission on service ' . $filters['serviceId']);
			}
		} elseif (isset($filters['userId']) === false) {
			// If they are not listing by service, they must list by user.
			$filters['userId'] = Core::UserId();
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return false;
	}

	public function ServiceUserId(): string {
		return $this->serviceUserId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Username(): string {
		return $this->username;
	}

	public function UsernameFull(): string {
		return $this->usernameFull;
	}

	public function Permissions(): int {
		return $this->permissions;
	}
}

?>
