<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class GroupAsset extends DatabaseObject implements JsonSerializable, Asset {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $groupAssetId;
	protected string $groupId;
	protected string $groupName;
	protected string $groupColor;
	protected string $groupUserId;
	protected string $assetId;
	protected string $assetType;
	protected string $assetName;
	protected string $assetOwnerId;
	protected bool $editable;
	protected bool $shareable;

	public function __construct(BeaconRecordSet $row) {
		$this->groupAssetId = $row->Field('group_asset_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->groupUserId = $row->Field('group_user_id');
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
			table: 'group_assets',
			definitions: [
				new DatabaseObjectProperty('groupAssetId', ['columnName' => 'group_asset_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupName', ['columnName' => 'group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.name']),
				new DatabaseObjectProperty('groupColor', ['columnName' => 'group_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.color']),
				new DatabaseObjectProperty('groupUserId', ['columnName' => 'group_user_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'groups.user_id']),
				new DatabaseObjectProperty('assetId', ['columnName' => 'asset_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('assetType', ['columnName' => 'asset_type', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_type']),
				new DatabaseObjectProperty('assetName', ['columnName' => 'asset_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.name']),
				new DatabaseObjectProperty('assetOwnerId', ['columnName' => 'asset_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.user_id']),
				new DatabaseObjectProperty('editable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.asset_summaries ON (group_assets.asset_id = asset_summaries.asset_id)',
				'INNER JOIN sentinel.groups ON (group_assets.group_id = groups.group_id)',
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
			case 'groupName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupUserId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetId');
		$parameters->AddFromFilter($schema, $filters, 'assetType');
		$parameters->AddFromFilter($schema, $filters, 'assetName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetOwnerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupAssetId' => $this->groupAssetId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
			'groupUserId' => $this->groupUserId,
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
			// Ensure that the user has permission on this asset before listing all groups for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $filters['assetId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}
		if (isset($filters['groupId'])) {
			// Ensure that the user has permission on this server before listing all assets for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $filters['groupId'], $userId, Group::kPermissionUpdate);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}

		$filters['assetOwnerId'] = $userId;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['assetId']) === false || isset($newObjectProperties['groupId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['groupId'], $user->UserId(), Group::kPermissionUpdate);
		if ($rows->RecordCount() !== 1) {
			return false;
		}

		$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2 AND shareable = TRUE;', $newObjectProperties['assetId'], $user->UserId());
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		// The user must have the correct permission on the group and the asset
		$readable = false;
		$editableGroup = false;
		$editableAsset = false;
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $this->groupId, $user->UserId());
		if ($rows->RecordCount() === 1) {
			$readable = true;
			$editableGroup = ($rows->Field('permissions') & Group::kPermissionUpdate) > 0;
		}

		$rows = $database->Query('SELECT shareable FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $this->assetId, $user->UserId());
		if ($rows->RecordCount() === 1) {
			$readable = true;
			$editableAsset = $rows->Field('shareable');
		}

		$permissions = self::kPermissionNone;
		if ($readable) {
			$permissions = $permissions | self::kPermissionRead;
			if ($editableAsset && $editableGroup) {
				$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
			}
		}
		return $permissions;
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['assetId']) === false || isset($properties['groupId']) === false) {
			throw new Exception('Missing assetId or groupId.');
		}

		$assetId = $properties['assetId'];
		$groupId = $properties['groupId'];
		if (BeaconCommon::IsUUID($assetId) === false || BeaconCommon::IsUUID($groupId) === false) {
			throw new Exception('Both assetId and groupId should be a UUID.');
		}
	}

	public function AssetId(): string {
		return $this->assetId;
	}
}

?>
