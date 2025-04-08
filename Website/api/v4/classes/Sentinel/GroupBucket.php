<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class GroupBucket extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $groupBucketId;
	protected string $groupId;
	protected string $groupName;
	protected string $groupColor;
	protected string $bucketId;
	protected string $bucketName;
	protected int $permissionsMask;

	public function __construct(BeaconRecordSet $row) {
		$this->groupBucketId = $row->Field('group_bucket_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->bucketId = $row->Field('bucket_id');
		$this->bucketName = $row->Field('bucket_name');
		$this->permissionsMask = $row->Field('permissions_mask');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_buckets',
			definitions: [
				new DatabaseObjectProperty('groupBucketId', ['columnName' => 'group_bucket_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupName', ['columnName' => 'group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.name']),
				new DatabaseObjectProperty('groupColor', ['columnName' => 'group_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.color']),
				new DatabaseObjectProperty('bucketId', ['columnName' => 'bucket_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('bucketName', ['columnName' => 'bucket_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'buckets.name']),
				new DatabaseObjectProperty('permissionsMask', ['columnName' => 'permissions_mask', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.buckets ON (group_buckets.bucket_id = buckets.bucket_id)',
				'INNER JOIN sentinel.groups ON (group_buckets.group_id = groups.group_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'bucketName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'groupName':
			case 'bucketName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'groupColor');
		$parameters->AddFromFilter($schema, $filters, 'bucketId');
		$parameters->AddFromFilter($schema, $filters, 'bucketName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupBucketId' => $this->groupBucketId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
			'bucketId' => $this->bucketId,
			'bucketName' => $this->bucketName,
			'permissionsMask' => $this->permissionsMask,
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
			if (Group::TestUserPermissions($filters['groupId'], $userId)) {
				return;
			} else {
				throw new Exception('You do not have any permissions on the requested group.');
			}
		}
		if (isset($filters['bucketId'])) {
			if (Bucket::TestUserPermissions($filters['bucketId'], $userId)) {
				return;
			} else {
				throw new Exception('You do not have any permissions on the requested bucket.');
			}
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new Exception('You must filter on groupId or bucketId.');
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['bucketId']) === false) {
			return false;
		}

		return Group::TestUserPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageBuckets) && Bucket::TestUserPermissions($newObjectProperties['bucketId'], $user->UserId(), PermissionBits::ShareBuckets);
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$groupPermissions = Group::GetUserPermissions($this->groupId, $userId);
		$bucketPermissions = Bucket::GetUserPermissions($this->bucketId, $userId);

		if ($groupPermissions > 0 || $bucketPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($groupPermissions & PermissionBits::ManageBuckets) > 0 && ($bucketPermissions & PermissionBits::ShareBuckets) > 0) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}
}

?>
