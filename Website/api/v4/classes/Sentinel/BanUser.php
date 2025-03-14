<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class BanUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $banUserId;
	protected string $banId;
	protected string $playerId;
	protected string $playerName;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerName;
	protected string $issuerNameFull;
	protected string $issuerComments;
	protected string $userId;
	protected string $userName;
	protected string $userNameFull;
	protected bool $editable;
	protected bool $shareable;

	public function __construct(BeaconRecordSet $row) {
		$this->banUserId = $row->Field('ban_user_id');
		$this->banId = $row->Field('ban_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->expiration = is_null($row->Field('expiration')) === false ? round($row->Field('expiration')) : null;
		$this->issuerId = $row->Field('issued_by');
		$this->issuerName = $row->Field('issuer_name');
		$this->issuerNameFull = $row->Field('issuer_name_full');
		$this->issuerComments = $row->Field('issuer_comments');
		$this->userId = $row->Field('user_id');
		$this->userName = $row->Field('user_name');
		$this->userNameFull = $row->Field('user_name_full');
		$this->editable = $row->Field('editable');
		$this->shareable = $row->Field('shareable');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'ban_users',
			definitions: [
				new DatabaseObjectProperty('banUserId', ['columnName' => 'ban_user_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('banId', ['columnName' => 'ban_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.player_id']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM bans.expiration)']),
				new DatabaseObjectProperty('issuerId', ['columnName' => 'issued_by', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.issued_by']),
				new DatabaseObjectProperty('issuerName', ['columnName' => 'issuer_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'issuers.username']),
				new DatabaseObjectProperty('issuerNameFull', ['columnName' => 'issuer_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(issuers.username || '#' || LEFT(issuers.user_id::TEXT, 8))"]),
				new DatabaseObjectProperty('issuerComments', ['columnName' => 'issuer_comments', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'bans.issuer_comments']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('userName', ['columnName' => 'user_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('userNameFull', ['columnName' => 'user_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
				new DatabaseObjectProperty('editable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('shareable', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.bans ON (ban_users.ban_id = bans.ban_id)',
				'INNER JOIN public.users ON (ban_users.user_id = users.user_id)',
				'INNER JOIN public.users AS issuers ON (bans.issued_by = issuers.user_id)',
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
			case 'userName':
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
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'userName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'userNameFull', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'banUserId' => $this->banUserId,
			'banId' => $this->banId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'expiration' => $this->expiration,
			'issuerId' => $this->issuerId,
			'issuerName' => $this->issuerName,
			'issuerNameFull' => $this->issuerNameFull,
			'issuerComments' => $this->issuerComments,
			'userId' => $this->userId,
			'userName' => $this->userName,
			'userNameFull' => $this->userNameFull,
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
		$hasUserFilter = isset($filters['userId']);
		$hasIssuerFilter = isset($filters['issuerId']);

		if ($hasUserFilter && $filters['userId'] === $userId) {
			return;
		} elseif ($hasIssuerFilter && $filters['issuerId'] === $userId) {
			return;
		} elseif (($hasUserFilter && $hasIssuerFilter === false) || ($hasUserFilter === false && $hasIssuerFilter == false)) {
			$filters['issuerId'] = $userId;
		} elseif ($hasUserFilter === false && $hasIssuerFilter) {
			$filters['userId'] = $userId;
		} else {
			throw new Exception('Must list by your userId or issuerId.');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['banId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.ban_permissions WHERE ban_id = $1 AND user_id = $2 AND shareable = TRUE;', $newObjectProperties['banId'], $user->UserId());
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		switch ($user->UserId()) {
		case $this->issuerId:
			return self::kPermissionRead | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		case $this->userId:
			return self::kPermissionRead | self::kPermissionDelete;
		default:
			return self::kPermissionNone;
		}
	}
}

?>
