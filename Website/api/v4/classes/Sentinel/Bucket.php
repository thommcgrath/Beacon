<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconChannelEvent, BeaconCommon, BeaconPusher, BeaconRecordSet, JsonSerializable;

class Bucket extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		HookModified As MDOHookModified;
		InitializeProperties as protected MDOInitializeProperties;
	}
	use SentinelObject;

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
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		if (is_null($user)) {
			return self::kPermissionNone;
		} elseif ($user->UserId() === $this->userId) {
			$bucketPermissions = $this->permissions;
		} else {
			$bucketPermissions = static::GetSentinelPermissions($this->bucketId, $user->UserId());
		}

		$permissions = 0;
		if (($bucketPermissions & PermissionBits::Membership) > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($bucketPermissions & PermissionBits::EditBuckets) > 0) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}

	protected function HookModified(int $operation): void {
		$this->MDOHookModified($operation);

		$socketId = BeaconPusher::SocketIdFromHeaders();
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT user_id FROM sentinel.bucket_permissions WHERE bucket_id = $1;', $this->bucketId);
		$events = [];
		while (!$rows->EOF()) {
			$events[] = new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($rows->Field('user_id')), eventName: 'bucketsUpdated', body: $this->bucketId, socketId: $socketId);
			$rows->MoveNext();
		}
		BeaconPusher::SharedInstance()->SendEvents($events);
	}

	public static function GetSentinelPermissions(string $objectId, string $userId): int {
		if (BeaconCommon::IsUUID($objectId) === false || BeaconCommon::IsUUID($userId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.bucket_permissions WHERE bucket_id = $1 AND user_id = $2;', $objectId, $userId);
		if ($rows->RecordCount() === 0) {
			return 0;
		}
		return $rows->Field('permissions');
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MDOInitializeProperties($properties);
		$properties['userId'] = Core::UserId();
	}
}

?>
