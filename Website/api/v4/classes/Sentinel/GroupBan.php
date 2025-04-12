<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, Exception, JsonSerializable;

class GroupBan extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Create as protected MDOCreate;
		Delete as protected MDODelete;
		InitializeProperties as protected MDOInitializeProperties;
	}

	protected string $groupBanId;
	protected string $groupId;
	protected string $playerId;
	protected string $playerName;
	protected array $playerAccounts;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerUsername;
	protected string $issuerUsernameFull;
	protected string $comments;

	public function __construct(BeaconRecordSet $row) {
		$this->groupBanId = $row->Field('group_ban_id');
		$this->groupId = $row->Field('group_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->playerAccounts = json_decode($row->Field('player_accounts'), true);
		$this->issuerId = $row->Field('issuer_id');
		$this->issuerUsername = $row->Field('issuer_username');
		$this->issuerUsernameFull = $row->Field('issuer_username_full');
		$this->expiration = is_null($row->Field('expiration')) === false ? round($row->Field('expiration')) : null;
		$this->comments = $row->Field('comments');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_bans',
			definitions: [
				new DatabaseObjectProperty('groupBanId', ['columnName' => 'group_ban_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id']),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => '%%TABLE%%.%%COLUMN%%', 'setter' => 'sentinel.get_player_id(%%PLACEHOLDER%%::CITEXT, TRUE)']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('playerAccounts', ['columnName' => 'player_accounts', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(ids_template))) FROM (SELECT player_identifiers.provider, player_identifiers.name, player_identifiers.identifier FROM sentinel.player_identifiers WHERE player_identifiers.player_id = group_bans.player_id) AS ids_template), \'[]\')']),
				new DatabaseObjectProperty('issuerId', ['columnName' => 'issuer_id', 'required' => false]),
				new DatabaseObjectProperty('issuerUsername', ['columnName' => 'issuer_username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('issuerUsernameFull', ['columnName' => 'issuer_username_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username_full']),
				new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('comments', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.players ON (players.player_id = group_bans.player_id)',
				'INNER JOIN public.users ON (group_bans.issuer_id = users.user_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'playerName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'playerName':
			case 'expiration':
			case 'issuerUsername':
			case 'issuerUsernameFull':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'issuerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'issuerUsername', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'issuerUsernameFull', 'ILIKE');

		if (isset($filters['expired'])) {
			if ($filters['expired'] == 'true') {
				$parameters->clauses[] = '(bans.expiration IS NOT NULL AND bans.expiration < CURRENT_TIMESTAMP)';
			} else {
				$parameters->clauses[] = '(bans.expiration IS NULL OR bans.expiration > CURRENT_TIMESTAMP)';
			}
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'groupBanId' => $this->groupBanId,
			'groupId' => $this->groupId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'playerAccounts' => $this->playerAccounts,
			'issuerId' => $this->issuerId,
			'issuerUsername' => $this->issuerUsername,
			'issuerUsernameFull' => $this->issuerUsernameFull,
			'expiration' => $this->expiration,
			'comments' => $this->comments,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		$requiredScopes[] = Application::kScopeUsersRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['groupId']) === false || Group::TestSentinelPermissions($filters['groupId'], Core::UserId()) === false) {
			throw new Exception('Forbidden');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['groupId']) === false || Group::TestSentinelPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageBans) === false) {
			return false;
		}
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = Group::GetSentinelPermissions($this->groupId, $user->UserId());
		if ($permissions === 0) {
			return self::kPermissionNone;
		}

		if (($permissions & PermissionBits::ManageBans) > 0) {
			return self::kPermissionAll;
		} else {
			return self::kPermissionRead;
		}
	}

	public static function Create(array $properties): DatabaseObject {
		// We need to tell affected servers. But we don't know what we're creating yet.
		$database = BeaconCommon::Database();
		$previousServiceIds = [];
		try {
			$rows = $database->Query('SELECT service_id FROM sentinel.active_bans WHERE player_id = sentinel.get_player_id($1::CITEXT);', $properties['playerId']);
			while (!$rows->EOF()) {
				$previousServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}
		} catch (Exception $err) {
		}

		$obj = static::MDOCreate($properties);

		try {
			$rows = $database->Query('SELECT player_identifiers.identifier FROM sentinel.player_identifiers INNER JOIN sentinel.active_bans ON (active_bans.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE active_bans.player_id = $2;', 'EOS', $obj->playerId);
			$epicId = $rows->Field('identifier');

			$rows = $database->Query('SELECT service_id FROM sentinel.active_bans WHERE player_id = $1;', $obj->playerId);
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
				BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($message));

				$rows->MoveNext();
			}
		} catch (Exception $err) {
		}

		return $obj;
	}

	public function Delete(): void {
		$previousServiceIds = [];
		$playerId = $this->playerId;
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.active_bans WHERE player_id = $1;', $playerId);
		while (!$rows->EOF()) {
			$previousServiceIds[] = $rows->Field('service_id');
			$rows->MoveNext();
		}

		$this->MDODelete();

		if (count($previousServiceIds) > 0) {
			$newServiceIds = [];
			$rows = $database->Query('SELECT service_id FROM sentinel.active_bans WHERE player_id = $1;', $playerId);
			while (!$rows->EOF()) {
				$newServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}

			$differences = array_diff($previousServiceIds, $newServiceIds);
			if (count($differences) > 0) {
				$rows = $database->Query('SELECT identifier FROM sentinel.player_identifiers WHERE player_id = $1 AND provider = $2;', $playerId, 'EOS');
				$epicId = $rows->Field('identifier');
				foreach ($differences as $serviceId) {
					$message = [
						'type' => 'admin',
						'command' => 'unbanplayer ' . $epicId,
					];
					BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.notifications.' . $serviceId . '.gameCommand', json_encode($message));
				}
			}
		}
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MDOInitializeProperties($properties);

		$properties['issuerId'] = Core::UserId();
	}
}

?>
