<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Bucket extends DatabaseObject implements JsonSerializable, Asset {
	use MutableDatabaseObject;

	protected string $bucketId;
	protected string $userId;
	protected string $username;
	protected string $name;

	public function __construct(BeaconRecordSet $row) {
		$this->bucketId = $row->Field('bucket_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->name = $row->Field('name');
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
			],
			joins: [
				'INNER JOIN public.users ON (buckets.user_id = users.user_id)',
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
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = '$' . $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = "buckets.bucket_id IN (SELECT asset_id FROM sentinel.asset_permissions WHERE user_id = {$userIdPlaceholder})";
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'bucketId' => $this->bucketId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->username, 0, 8),
			'name' => $this->name,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT editable FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $this->bucketId, $user->UserId());
		if ($rows->RecordCount() !== 1) {
			return self::kPermissionNone;
		}

		$permissions = self::kPermissionRead;
		if ($rows->Field('editable') === true) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}

	public function AssetId(): string {
		return $this->bucketId;
	}

	public function AssetType(): string {
		return 'Bucket';
	}

	public function AssetTypeMask(): int {
		return 2;
	}

	public function AssetName(): string {
		return $this->name;
	}
}

?>
