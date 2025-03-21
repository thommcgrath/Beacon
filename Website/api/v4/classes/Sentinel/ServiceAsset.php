<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, Exception, JsonSerializable;

class ServiceAsset extends DatabaseObject implements JsonSerializable, Asset {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
		Create as protected MDOCreate;
		Delete as protected MDODelete;
	}

	protected string $serviceAssetId;
	protected string $serviceId;
	protected string $serviceName;
	protected ?string $serviceNickname;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $serviceOwnerId;
	protected string $assetId;
	protected string $assetType;
	protected int $assetTypeMask;
	protected string $assetName;
	protected string $assetOwnerId;
	protected array $assetDetails;
	protected bool $assetEditable;
	protected bool $assetShareable;
	protected bool $editable;
	protected bool $shareable;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceAssetId = $row->Field('service_asset_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceName = $row->Field('service_name');
		$this->serviceNickname = $row->Field('service_nickname');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->serviceOwnerId = $row->Field('service_owner_id');
		$this->assetId = $row->Field('asset_id');
		$this->assetType = $row->Field('asset_type');
		$this->assetTypeMask = $row->Field('asset_mask');
		$this->assetName = $row->Field('asset_name');
		$this->assetOwnerId = $row->Field('asset_owner_id');
		$this->assetDetails = json_decode($row->Field('asset_details'), true);
		$this->assetEditable = $row->Field('asset_editable');
		$this->assetShareable = $row->Field('asset_shareable');
		$this->editable = $row->Field('editable');
		$this->shareable = $row->Field('shareable');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'service_assets',
			definitions: [
				new DatabaseObjectProperty('serviceAssetId', ['columnName' => 'service_asset_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceName', ['columnName' => 'service_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.name']),
				new DatabaseObjectProperty('serviceNickname', ['columnName' => 'service_nickname', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.nickname']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.color']),
				new DatabaseObjectProperty('serviceOwnerId', ['columnName' => 'service_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.user_id']),
				new DatabaseObjectProperty('assetId', ['columnName' => 'asset_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('assetType', ['columnName' => 'asset_type', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_type']),
				new DatabaseObjectProperty('assetTypeMask', ['columnName' => 'asset_mask', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'sentinel.mask_for_asset_type(asset_summaries.asset_type)']),
				new DatabaseObjectProperty('assetName', ['columnName' => 'asset_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.name']),
				new DatabaseObjectProperty('assetOwnerId', ['columnName' => 'asset_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.user_id']),
				new DatabaseObjectProperty('assetDetails', ['columnName' => 'asset_details', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.details']),
				new DatabaseObjectProperty('assetEditable', ['columnName' => 'asset_editable', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_permissions.editable']),
				new DatabaseObjectProperty('assetShareable', ['columnName' => 'asset_shareable', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_permissions.shareable']),
				new DatabaseObjectProperty('editable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.asset_summaries ON (service_assets.asset_id = asset_summaries.asset_id)',
				'INNER JOIN sentinel.asset_permissions ON (service_assets.asset_id = asset_permissions.asset_id AND asset_permissions.user_id = %%USER_ID%%)',
				'INNER JOIN sentinel.services ON (service_assets.service_id = services.service_id)',
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
			case 'serviceName':
			case 'serviceNickname':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'serviceOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceNickname', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetId');
		$parameters->AddFromFilter($schema, $filters, 'assetType');
		$parameters->AddFromFilter($schema, $filters, 'assetName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetOwnerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceAssetId' => $this->serviceAssetId,
			'serviceId' => $this->serviceId,
			'serviceName' => $this->serviceName,
			'serviceNickname' => $this->serviceNickname,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'serviceOwnerId' => $this->serviceOwnerId,
			'assetId' => $this->assetId,
			'assetType' => $this->assetType,
			'assetName' => $this->assetName,
			'assetOwnerId' => $this->assetOwnerId,
			'assetDetails' => $this->assetDetails,
			'assetEditable' => $this->assetEditable,
			'assetShareable' => $this->assetShareable,
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
			// Ensure that the user has permission on this asset before listing all services for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $filters['assetId'], $userId);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}
		if (isset($filters['serviceId'])) {
			// Ensure that the user has permission on this server before listing all assets for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $filters['serviceId'], $userId, Service::kPermissionUpdate);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}

		$filters['assetOwnerId'] = $userId;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['assetId']) === false || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['serviceId'], $user->UserId(), Service::ServicePermissionControl);
		if ($rows->RecordCount() !== 1) {
			return false;
		}

		$rows = $database->Query('SELECT 1 FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2 AND shareable = TRUE;', $newObjectProperties['assetId'], $user->UserId());
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		// The user needs control permission on the service
		$readable = false;
		$editableService = false;
		$editableAsset = false;
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $this->serviceId, $user->UserId());
		if ($rows->RecordCount() === 1) {
			return self::kPermissionRead | (($rows->Field('permissions') & Service::ServicePermissionControl) > 0 ? self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete : 0);
		}
		return self::kPermissionNone;
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['assetId']) === false || isset($properties['serviceId']) === false) {
			throw new Exception('Missing assetId or serviceId.');
		}

		$assetId = $properties['assetId'];
		$serviceId = $properties['serviceId'];
		if (BeaconCommon::IsUUID($assetId) === false || BeaconCommon::IsUUID($serviceId) === false) {
			throw new Exception('Both assetId and serviceId should be a UUID.');
		}
	}

	public static function Create(array $properties): DatabaseObject {
		// If this is a ban, we need to tell affected servers. But we don't know what we're creating yet.
		$banId = null;
		$database = null;
		if (isset($properties['assetId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.bans WHERE ban_id = $1;', $properties['assetId']);
			if ($rows->RecordCount() === 1) {
				$banId = $properties['assetId'];
			}
		}
		$previousServiceIds = [];
		if (empty($banId) === false) {
			$rows = $database->Query('SELECT service_resolved_assets.service_id FROM sentinel.service_resolved_assets WHERE service_resolved_assets.asset_id = $1;', $banId);
			while (!$rows->EOF()) {
				$previousServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}
		}

		$obj = static::MDOCreate($properties);

		try {
			if (empty($banId) === false) {
				$rows = $database->Query('SELECT player_identifiers.identifier FROM sentinel.player_identifiers INNER JOIN sentinel.bans ON (bans.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE bans.ban_id = $2;', 'EOS', $banId);
				$epicId = $rows->Field('identifier');

				$rows = $database->Query('SELECT service_resolved_assets.service_id FROM sentinel.service_resolved_assets WHERE service_resolved_assets.asset_id = $1;', $banId);
				while (!$rows->EOF()) {
					$serviceId =  $rows->Field('service_id');
					if (in_array($serviceId, $previousServiceIds)) {
						$rows->MoveNext();
						continue;
					}

					$message = [
						'type' => 'admin',
						'command' => 'banplayer ' . $epicId,
					];
					BeaconRabbitMQ::SendMessage('sentinel_watcher', 'sentinel.services.' . $serviceId . '.gameCommand', json_encode($message));

					$rows->MoveNext();
				}
			}
		} catch (Exception $err) {
		}

		return $obj;
	}

	public function Delete(): void {
		$banId = null;
		$previousServiceIds = [];
		$database = null;
		if ($this->assetType === 'Ban') {
			$banId = $this->assetId;
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT service_resolved_assets.service_id FROM sentinel.service_resolved_assets WHERE service_resolved_assets.asset_id = $1;', $banId);
			while (!$rows->EOF()) {
				$previousServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}
		}

		$this->MDODelete();

		if (count($previousServiceIds) > 0) {
			$newServiceIds = [];
			$rows = $database->Query('SELECT service_resolved_assets.service_id FROM sentinel.service_resolved_assets WHERE service_resolved_assets.asset_id = $1;', $banId);
			while (!$rows->EOF()) {
				$newServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}

			$differences = array_diff($previousServiceIds, $newServiceIds);
			if (count($differences) > 0) {
				$rows = $database->Query('SELECT player_identifiers.identifier FROM sentinel.player_identifiers INNER JOIN sentinel.bans ON (bans.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE bans.ban_id = $2;', 'EOS', $banId);
				$epicId = $rows->Field('identifier');
				foreach ($differences as $serviceId) {
					$message = [
						'type' => 'admin',
						'command' => 'unbanplayer ' . $epicId,
					];
					BeaconRabbitMQ::SendMessage('sentinel_watcher', 'sentinel.services.' . $serviceId . '.gameCommand', json_encode($message));
				}
			}
		}
	}

	public function AssetId(): string {
		return $this->assetId;
	}

	public function AssetType(): string {
		return $this->assetType;
	}

	public function AssetTypeMask(): int {
		return $this->assetTypeMask;
	}

	public function AssetName(): string {
		return $this->assetName;
	}
}

?>
