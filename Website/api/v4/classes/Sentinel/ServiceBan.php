<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ServiceBan extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
	}

	protected string $serviceBanId;
	protected string $playerId;
	protected string $playerName;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerName;
	protected string $issuerNameFull;
	protected string $issuerComments;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceBanId = $row->Field('service_ban_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->expiration = is_null($row->Field('expiration')) === false ? intval($row->Field('expiration')) : null;
		$this->issuerId = $row->Field('issued_by');
		$this->issuerName = $row->Field('issuer_name');
		$this->issuerNameFull = $row->Field('issuer_name_full');
		$this->issuerComments = $row->Field('issuer_comments');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_bans', [
			new DatabaseObjectProperty('serviceBanId', ['columnName' => 'service_ban_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => '%%TABLE%%.%%COLUMN%%', 'setter' => "sentinel.get_player_id(%%PLACEHOLDER%%, TRUE)"]),
			new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'COALESCE(services.nickname, services.name)']),
			new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP($1)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('issuerId', ['columnName' => 'issued_by']),
			new DatabaseObjectProperty('issuerName', ['columnName' => 'issuer_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
			new DatabaseObjectProperty('issuerNameFull', ['columnName' => 'issuer_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
			new DatabaseObjectProperty('issuerComments', ['columnName' => 'issuer_comments']),
		], [
			'INNER JOIN public.users ON (service_bans.issued_by = users.user_id)',
			'INNER JOIN sentinel.players ON (service_bans.player_id = players.player_id)',
			'INNER JOIN sentinel.services ON (service_bans.service_id = services.service_id AND services.deleted = FALSE)',
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
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'LIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceBanId' => $this->serviceBanId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
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

		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $this->serviceId, user: $user);
		if (($permissions & Service::kPermissionControl) === 0) {
			return self::kPermissionNone;
		}
		return self::kPermissionAll;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceId'])) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $filters['serviceId'], Core::UserId());
			if ($rows->RecordCount() !== 1 || ($rows->Field('permissions') & Service::kPermissionControl) === 0) {
				throw new Exception('User does not have update permission on service ' . $filters['serviceId']);
			}
		} elseif (isset($filters['issuerId']) === false) {
			// If they are not listing by service, they must list by user.
			$filters['issuerId'] = Core::UserId();
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $newObjectProperties['serviceId'], user: $user);
		if (($permissions & Service::kPermissionControl) === 0) {
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
