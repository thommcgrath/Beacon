<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconPusher, BeaconRecordSet, JsonSerializable;

class Bucket extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		HookModified As MDOHookModified;
	}

	protected string $bucketId;
	protected string $userId;
	protected string $username;
	protected string $name;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->bucketId = $row->Field('bucket_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->name = $row->Field('name');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'buckets',
			definitions: [
				new DatabaseObjectProperty('bucketId', ['columnName' => 'bucket_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('username', ['columnName' => 'username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableNever, 'required' => false, 'accessor' => 'bucket_permissions.permissions']),
			],
			joins: [
				'INNER JOIN public.users ON (buckets.user_id = users.user_id)',
				'INNER JOIN sentinel.bucket_permissions ON (buckets.bucket_id = bucket_permissions.bucket_id AND bucket_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'name';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'name':
			case 'username':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'bucketId' => $this->bucketId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->username, 0, 8),
			'name' => $this->name,
			'permissions' => $this->permissions,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	protected static function UserHasPermission(string $bucketId, string $userId): bool {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.bucket_permissions WHERE bucket_id = $1 AND user_id = $2;', $bucketId, $userId);
		return $rows->RecordCount() === 1;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		if (static::UserHasPermission($this->bucketId, $user->UserId())) {
			return self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete;
		} else {
			return self::kPermissionNone;
		}
	}

	protected function HookModified(): void {
		$this->MDOHookModified();

		$pusher = BeaconPusher::SharedInstance();
		$socketId = BeaconPusher::SocketIdFromHeaders();
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT user_id FROM sentinel.bucket_permissions WHERE bucket_id = $1;', $this->bucketId);
		while (!$rows->EOF()) {
			$channel = 'user-' . str_replace('-', '', $rows->Field('user_id'));
			$pusher->TriggerEvent($channel, 'buckets-changed', $this->bucketId, $socketId);
			$rows->MoveNext();
		}
	}

	public static function GetUserPermissions(string $bucketId, string $userId): int {
		if (BeaconCommon::IsUUID($bucketId) === false || BeaconCommon::IsUUID($userId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.bucket_permissions WHERE bucket_id = $1 AND user_id = $2;', $bucketId, $userId);
		if ($rows->RecordCount() === 0) {
			return 0;
		}
		return $rows->Field('permissions');
	}

	public static function TestUserPermissions(string $bucketId, string $userId, int $requiredBits = 1): bool {
		return (static::GetUserPermissions($bucketId, $userId) & $requiredBits) > 0;
	}
}

?>
