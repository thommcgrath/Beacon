<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class BanAssignment extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $banAssignmentId;
	protected string $banId;
	protected string $playerId;
	protected string $playerName;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerName;
	protected string $issuerNameFull;
	protected string $issuerComments;
	protected string $assetId;
	protected string $assetType;
	protected string $assetName;
	protected ?string $assetNickname;
	protected string $assetDisplayName;
	protected string $assetColor;
	protected bool $editable;
	protected bool $shareable;

	public function __construct(BeaconRecordSet $row) {
		$this->banAssignmentId = $row->Field('ban_assignment_id');
		$this->banId = $row->Field('ban_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->expiration = is_null($row->Field('expiration')) === false ? round($row->Field('expiration')) : null;
		$this->issuerId = $row->Field('issued_by');
		$this->issuerName = $row->Field('issuer_name');
		$this->issuerNameFull = $row->Field('issuer_name_full');
		$this->issuerComments = $row->Field('issuer_comments');
		$this->assetId = $row->Field('asset_id');
		$this->assetType = $row->Field('asset_type');
		$this->assetName = $row->Field('asset_name');
		$this->assetNickname = $row->Field('asset_nickname');
		$this->assetDisplayName = $row->Field('asset_display_name');
		$this->assetColor = $row->Field('asset_color');
		$this->editable = $row->Field('editable');
		$this->shareable = $row->Field('shareable');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'ban_assignments',
			definitions: [
				new DatabaseObjectProperty('banAssignmentId', ['columnName' => 'ban_assignment_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('banId', ['columnName' => 'ban_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.player_id']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM bans.expiration)']),
				new DatabaseObjectProperty('issuerId', ['columnName' => 'issued_by', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.issued_by']),
				new DatabaseObjectProperty('issuerName', ['columnName' => 'issuer_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('issuerNameFull', ['columnName' => 'issuer_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
				new DatabaseObjectProperty('issuerComments', ['columnName' => 'issuer_comments', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.issuer_comments']),
				new DatabaseObjectProperty('assetId', ['columnName' => 'asset_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('assetType', ['columnName' => 'asset_type', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_type']),
				new DatabaseObjectProperty('assetName', ['columnName' => 'asset_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_name']),
				new DatabaseObjectProperty('assetNickname', ['columnName' => 'asset_nickname', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_nickname']),
				new DatabaseObjectProperty('assetDisplayName', ['columnName' => 'asset_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_display_name']),
				new DatabaseObjectProperty('assetColor', ['columnName' => 'asset_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'asset_summaries.asset_color']),
				new DatabaseObjectProperty('editable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.bans ON (ban_assignments.ban_id = bans.ban_id)',
				'INNER JOIN sentinel.asset_summaries ON (ban_assignments.asset_id = asset_summaries.asset_id)',
				'INNER JOIN public.users ON (bans.issued_by = users.user_id)',
				'INNER JOIN sentinel.players ON (bans.player_id = players.player_id)',
			],
			options: DatabaseSchema::OptionDistinct,
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'playerName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'issuerName':
			case 'playerName':
			case 'expiration':
			case 'assetType':
			case 'assetName':
			case 'assetNickname':
			case 'assetDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'issuerId');
		$parameters->AddFromFilter($schema, $filters, 'issuerName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'issuerNameFull', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'assetId');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = '$' . $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = "bans.ban_id IN (SELECT ban_id FROM sentinel.ban_permissions WHERE user_id = {$userIdPlaceholder})";
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'banAssignmentId' => $this->banAssignmentId,
			'banId' => $this->banId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'expiration' => $this->expiration,
			'issuerId' => $this->issuerId,
			'issuerName' => $this->issuerName,
			'issuerNameFull' => $this->issuerNameFull,
			'issuerComments' => $this->issuerComments,
			'assetId' => $this->assetId,
			'assetType' => $this->assetType,
			'assetName' => $this->assetName,
			'assetNickname' => $this->assetNickname,
			'assetDisplayName' => $this->assetDisplayName,
			'assetColor' => $this->assetColor,
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
		$filters['userId'] = Core::UserId();
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['assetId']) === false || isset($newObjectProperties['banId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.ban_permissions WHERE ban_id = $1 AND user_id = $2 AND shareable = TRUE;', $newObjectProperties['banId'], $user->UserId());
		if ($rows->RecordCount() !== 1) {
			return false;
		}
		$rows = $database->Query('SELECT 1 FROM sentinel.asset_object_permissions WHERE asset_id = $1 AND user_id = $2 AND (editable_objects & $3) > 0;', $newObjectProperties['assetId'], $user->UserId(), Ban::ObjectPermissionFlag);
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT readable_objects, editable_objects FROM sentinel.asset_object_permissions WHERE asset_id = $1 AND user_id = $2;', $this->assetId, $user->UserId());
		if ($rows->RecordCount() !== 1) {
			return 0;
		}

		$permissions = self::kPermissionNone;
		if ((intval($rows->Field('readable_objects')) & Ban::ObjectPermissionFlag) > 0) {
			$permissions = $permissions | self::kPermissionRead;
			if ((intval($rows->Field('editable_objects')) & Ban::ObjectPermissionFlag) > 0) {
				$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
			}
		}

		return $permissions;
	}
}

?>
