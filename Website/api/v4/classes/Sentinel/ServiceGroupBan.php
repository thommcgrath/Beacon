<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ServiceGroupBan extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
	}

	protected string $serviceGroupBanId;
	protected string $playerId;
	protected string $playerName;
	protected string $serviceGroupId;
	protected string $serviceGroupName;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerName;
	protected string $issuerNameFull;
	protected string $issuerComments;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupBanId = $row->Field('service_group_ban_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceGroupName = $row->Field('service_group_name');
		$this->expiration = is_null($row->Field('expiration')) === false ? intval($row->Field('expiration')) : null;
		$this->issuerId = $row->Field('issued_by');
		$this->issuerName = $row->Field('issuer_name');
		$this->issuerNameFull = $row->Field('issuer_name_full');
		$this->issuerComments = $row->Field('issuer_comments');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_bans', [
			new DatabaseObjectProperty('serviceGroupBanId', ['columnName' => 'service_group_ban_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => '%%TABLE%%.%%COLUMN%%', 'setter' => "sentinel.get_player_id(%%PLACEHOLDER%%, TRUE)"]),
			new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceGroupName', ['columnName' => 'service_group_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'service_groups.name']),
			new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('issuerId', ['columnName' => 'issued_by']),
			new DatabaseObjectProperty('issuerName', ['columnName' => 'issuer_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
			new DatabaseObjectProperty('issuerNameFull', ['columnName' => 'issuer_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
			new DatabaseObjectProperty('issuerComments', ['columnName' => 'issuer_comments', 'editable' => DatabaseObjectProperty::kEditableAlways]),
		], [
			'INNER JOIN public.users ON (service_group_bans.issued_by = users.user_id)',
			'INNER JOIN sentinel.players ON (service_group_bans.player_id = players.player_id)',
			'INNER JOIN sentinel.service_groups ON (service_group_bans.service_group_id = service_groups.service_group_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'playerName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'username':
			case 'playerName':
			case 'expiration':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'issuerId');
		$parameters->AddFromFilter($schema, $filters, 'issuerName', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'issuerNameFull', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupName', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'LIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupBanId' => $this->serviceGroupBanId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceGroupName' => $this->serviceGroupName,
			'expiration' => $this->expiration,
			'issuerId' => $this->issuerId,
			'issuerName' => $this->issuerName,
			'issuerNameFull' => $this->issuerNameFull,
			'issuerComments' => $this->issuerComments,
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
		if ($user->UserId() === $this->issuerId) {
			return self::kPermissionAll;
		}

		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $this->serviceGroupId, user: $user);
		if (($permissions & ServiceGroup::kPermissionUpdate) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceGroupId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT permissions FROM sentinel.service_group_permissions WHERE service_group_id = $1 AND user_id = $2;', $filters['serviceGroupId'], Core::UserId());
			if ($rows->RecordCount() !== 1 || ($rows->Field('permissions') & ServiceGroup::kPermissionUpdate) === 0) {
				throw new Exception('User does not have update permission on service group ' . $filters['serviceGroupId']);
			}
		} elseif (isset($filters['issuerId']) === false) {
			// If they are not listing by service, they must list by user.
			$filters['issuerId'] = Core::UserId();
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceGroupId']) === false) {
			return false;
		}

		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\ServiceGroup', objectId: $newObjectProperties['serviceGroupId'], user: $user);
		if (($permissions & ServiceGroup::kPermissionUpdate) === 0) {
			return false;
		}

		return true;
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MutableDatabaseObjectInitializeProperties($properties);
		$properties['issuerId'] = $properties['userId'];
	}
}

?>
