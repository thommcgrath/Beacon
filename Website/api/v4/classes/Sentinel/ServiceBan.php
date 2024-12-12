<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ServiceBan extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
		Validate as protected MutableDatabaseObjectValidate;
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
			new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
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
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'issuerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
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

		if (preg_match('/^0002[0-9A-F]{28}$/i', $properties['playerId']) === 1) {
			// EOS ID that may or may not exist
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT player_id FROM sentinel.player_identifiers WHERE provider = $1 AND identifier = $2;', 'EOS', $properties['playerId']);
			if ($rows->RecordCount() === 1) {
				$properties['playerId'] = $rows->Field('player_id');
			} else {
				$newPlayerId = BeaconUUID::v4();
				$database->BeginTransaction();
				$database->Query('INSERT INTO sentinel.players (player_id, name) VALUES ($1, $2) RETURNING player_id;', $newPlayerId, 'Unseen Player');
				$database->Query('INSERT INTO sentinel.player_identifiers (player_id, provider, identifier, name) VALUES ($1, $2, $3, $4);', $newPlayerId, 'EOS', $properties['playerId'], 'Unseen Player');
				$database->Commit();
				$properties['playerId'] = $newPlayerId;
			}
		}
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT player_id FROM sentinel.players WHERE player_id = $1;', $properties['playerId']);
		if ($rows->RecordCount() !== 1) {
			throw new APIException('Player ' . $properties['playerId'] . ' does not exist.', 'playerNotFound');
		}

		$rows = $database->Query('SELECT service_ban_id FROM sentinel.service_bans WHERE player_id = $1 AND service_id = $2;', $properties['playerId'], $properties['serviceId']);
		if ($rows->RecordCount() !== 0) {
			throw new APIException('Player ' . $properties['playerId'] . ' is already banned on this server.', 'duplicate');
		}
	}
}

?>
