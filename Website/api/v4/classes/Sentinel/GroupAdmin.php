<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconRecordSet, JsonSerializable;

class GroupAdmin extends DatabaseObject implements JsonSerializable {
	use Admin;

	protected string $groupAdminId;
	protected string $groupId;
	protected string $groupName;
	protected string $groupColor;
	protected string $playerId;
	protected string $playerName;

	public function __construct(BeaconRecordSet $row) {
		$this->groupAdminId = $row->Field('group_admin_id');
		$this->groupId = $row->Field('group_id');
		$this->groupName = $row->Field('group_name');
		$this->groupColor = $row->Field('group_color');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_admins',
			definitions: [
				new DatabaseObjectProperty('groupAdminId', ['columnName' => 'group_admin_id', 'primaryKey' => true, 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('groupName', ['columnName' => 'group_name', 'accessor' => 'groups.name', 'editable' => DatabaseObjectProperty::kEditableNever]),
				new DatabaseObjectProperty('groupColor', ['columnName' => 'group_color', 'accessor' => 'groups.color', 'editable' => DatabaseObjectProperty::kEditableNever]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'accessor' => 'players.name', 'editable' => DatabaseObjectProperty::kEditableNever]),
			],
			joins: [
				'INNER JOIN sentinel.groups ON (%%TABLE%%.group_id = groups.group_id)',
				'INNER JOIN sentinel.players ON (%%TABLE%%.player_id = players.player_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'playerName';
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'groupName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupAdminId' => $this->groupAdminId,
			'groupId' => $this->groupId,
			'groupName' => $this->groupName,
			'groupColor' => $this->groupColor,
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
		if (isset($filters['groupId'])) {
			if (Group::TestSentinelPermissions($filters['groupId'], $userId)) {
				return;
			} else {
				throw new APIException(message: 'You do not have any permissions on the requested group.', code: 'forbidden', httpStatus: 403);
			}
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new APIException(message: 'You must filter on groupId.', code: 'forbidden', httpStatus: 403);
	}

	// User must have ManageAdmins permission on the group.
	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['playerId']) === false) {
			return false;
		}

		if (Group::TestSentinelPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageAdmins) === false) {
			return false;
		}

		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$groupPermissions = Group::GetSentinelPermissions($this->groupId, $userId);

		if ($groupPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($groupPermissions & PermissionBits::ManageAdmins) > 0) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}

	public function GroupId(): string {
		return $this->groupId;
	}

	public function PlayerId(): string {
		return $this->playerId;
	}

	public function GroupName(): string {
		return $this->groupName;
	}

	public function GroupColor(): string {
		return $this->groupColor;
	}

	public function PlayerName(): string {
		return $this->playerName;
	}
}

?>
