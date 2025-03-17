<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class UserAsset extends DatabaseObject implements JsonSerializable, Asset {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $userAssetId;
	protected string $userId;
	protected string $username;
	protected string $assetId;
	protected string $assetType;
	protected string $assetName;
	protected string $assetOwnerId;
	protected bool $editable;
	protected bool $shareable;

	public function __construct(BeaconRecordSet $row) {
		$this->userAssetId = $row->Field('user_asset_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('user_name');
		$this->assetId = $row->Field('asset_id');
		$this->assetType = $row->Field('asset_type');
		$this->assetName = $row->Field('asset_name');
		$this->assetOwnerId = $row->Field('asset_owner_id');
		$this->editable = $row->Field('editable');
		$this->shareable = $row->Field('shareable');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'user_assets',
			definitions: [
				new DatabaseObjectProperty('userAssetId', ['columnName' => 'user_asset_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('username', ['columnName' => 'user_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('assetId', ['columnName' => 'asset_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('assetType', ['columnName' => 'asset_type', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_type']),
				new DatabaseObjectProperty('assetName', ['columnName' => 'asset_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.name']),
				new DatabaseObjectProperty('assetOwnerId', ['columnName' => 'asset_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.user_id']),
				new DatabaseObjectProperty('editable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.asset_summaries ON (user_assets.asset_id = asset_summaries.asset_id)',
				'INNER JOIN public.users ON (user_assets.user_id = users.user_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'assetName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'assetName':
			case 'username':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetId');
		$parameters->AddFromFilter($schema, $filters, 'assetType');
		$parameters->AddFromFilter($schema, $filters, 'assetName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetOwnerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'userAssetId' => $this->userAssetId,
			'userId' => $this->userId,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->userId, 0, 8),
			'assetId' => $this->assetId,
			'assetType' => $this->assetType,
			'assetName' => $this->assetName,
			'assetOwnerId' => $this->assetOwnerId,
			'editable' => $this->editable,
			'shareable' => $this->shareable,
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
		if (isset($filters['assetId'])) {
			// Ensure that the user has permission on this asset before listing all users for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $filters['assetId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}
		if (isset($filters['userId'])) {
			return;
		}

		$filters['assetOwnerId'] = $userId;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['assetId']) === false || isset($newObjectProperties['userId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2 AND shareable = TRUE;', $newObjectProperties['assetId'], $user->UserId());
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		if ($this->userId === $user->UserId()) {
			// The user of this object can always see and delete it
			return self::kPermissionRead | self::kPermissionDelete;
		} elseif ($this->assetOwnerId === $user->UserId()) {
			return self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete;
		}

		// Editing the permissions on this asset required sharing permissions.
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT shareable FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $1;', $this->assetId, $user->UserId());
		if ($rows->RecordCount() === 0) {
			return self::kPermissionNone;
		}

		$permissions = self::kPermissionRead;
		if ($rows->Field('shareable') === true) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['assetId']) === false || isset($properties['userId']) === false) {
			throw new Exception('Missing assetId or userId.');
		}

		$assetId = $properties['assetId'];
		$userId = $properties['userId'];
		if (BeaconCommon::IsUUID($assetId) === false || BeaconCommon::IsUUID($userId) === false) {
			throw new Exception('Both assetId and userId should be a UUID.');
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT user_id FROM sentinel.asset_summaries WHERE asset_id = $1;', $assetId);
		if ($rows->RecordCount() === 0) {
			throw new Exception('Could not find asset ' . $assetId . '.');
		} elseif ($rows->Field('user_id') === $userId) {
			throw new Exception('You should not assign an asset to its owner.');
		}
	}

	public function AssetId(): string {
		return $this->assetId;
	}
}

?>
