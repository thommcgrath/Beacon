<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconRecordSet, JsonSerializable;

class ServiceAdmin extends DatabaseObject implements JsonSerializable {
	use Admin;

	protected string $serviceAdminId;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $playerId;
	protected string $playerName;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceAdminId = $row->Field('service_admin_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'service_admins',
			definitions: [
				new DatabaseObjectProperty('serviceAdminId', ['columnName' => 'service_admin_id', 'primaryKey' => true, 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name', 'editable' => DatabaseObjectProperty::kEditableNever]),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'accessor' => 'services.color', 'editable' => DatabaseObjectProperty::kEditableNever]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'accessor' => 'players.name', 'editable' => DatabaseObjectProperty::kEditableNever]),
			],
			joins: [
				'INNER JOIN sentinel.services ON (%%TABLE%%.service_id = services.service_id)',
				'INNER JOIN sentinel.players ON (%%TABLE%%.player_id = players.player_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'playerName';
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceAdminId' => $this->serviceAdminId,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$userId = Core::UserId();
		if (isset($filters['serviceId'])) {
			if (Service::TestSentinelPermissions($filters['serviceId'], $userId)) {
				return;
			} else {
				throw new APIException(message: 'You do not have any permissions on the requested service.', code: 'forbidden', httpStatus: 403);
			}
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new APIException(message: 'You must filter on serviceId.', code: 'forbidden', httpStatus: 403);
	}

	// User must have ManageAdmins permission on the service.
	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['serviceId']) === false || isset($newObjectProperties['playerId']) === false) {
			return false;
		}

		if (Service::TestSentinelPermissions($newObjectProperties['serviceId'], $user->UserId(), PermissionBits::ManageAdmins) === false) {
			return false;
		}

		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$servicePermissions = Service::GetSentinelPermissions($this->serviceId, $userId);

		if ($servicePermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($servicePermissions & PermissionBits::ManageAdmins) > 0) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function PlayerId(): string {
		return $this->playerId;
	}

	public function ServiceDisplayName(): string {
		return $this->serviceDisplayName;
	}

	public function ServiceColor(): string {
		return $this->serviceColor;
	}

	public function PlayerName(): string {
		return $this->playerName;
	}
}

?>
