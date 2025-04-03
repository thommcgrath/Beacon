<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, Exception, JsonSerializable;

class ServiceBan extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject{
		Create as protected MDOCreate;
		Delete as protected MDODelete;
	}

	protected string $serviceBanId;
	protected string $serviceId;
	protected string $playerId;
	protected string $playerName;
	protected array $playerAccounts;
	protected ?int $expiration;
	protected string $comments;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceBanId = $row->Field('service_ban_id');
		$this->serviceId = $row->Field('service_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->playerAccounts = json_decode($row->Field('player_accounts'), true);
		$this->expiration = is_null($row->Field('expiration')) === false ? round($row->Field('expiration')) : null;
		$this->comments = $row->Field('comments');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'service_bans',
			definitions: [
				new DatabaseObjectProperty('serviceBanId', ['columnName' => 'service_ban_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => '%%TABLE%%.%%COLUMN%%', 'setter' => 'sentinel.get_player_id(%%PLACEHOLDER%%::CITEXT, TRUE)']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('playerAccounts', ['columnName' => 'player_accounts', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(ids_template))) FROM (SELECT player_identifiers.provider, player_identifiers.name, player_identifiers.identifier FROM sentinel.player_identifiers WHERE player_identifiers.player_id = service_bans.player_id) AS ids_template), \'[]\')']),
				new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('comments', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.players ON (players.player_id = service_bans.player_id)',
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
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');

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
			'serviceBanId' => $this->serviceBanId,
			'serviceId' => $this->serviceId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'playerAccounts' => $this->playerAccounts,
			'expiration' => $this->expiration,
			'comments' => $this->comments,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
	}

	protected static function CheckServiceOwner(string $serviceId, string $userId): bool {
		if (BeaconCommon::IsUUID($serviceId) === false || BeaconCommon::IsUUID($userId) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.services WHERE service_id = $1 AND user_id = $2;', $serviceId, $userId);
		return $rows->RecordCount() === 1;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceId']) === false || static::CheckServiceOwner($filters['serviceId'], Core::UserId()) === false) {
			throw new Exception('Forbidden');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['serviceId']) === false || static::CheckServiceOwner($newObjectProperties['serviceId'], $user->UserId()) === false) {
			return false;
		}
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		if (static::CheckServiceOwner($this->serviceId, $user->UserId())) {
			return self::kPermissionAll;
		} else {
			return self::kPermissionNone;
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
}

?>
