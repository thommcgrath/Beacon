<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class PlayerSession extends DatabaseObject implements JsonSerializable {
	protected string $playerSessionId;
	protected string $playerId;
	protected string $playerName;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected float $connectTime;
	protected ?float $disconnectTime;
	protected float $playTime;

	public function __construct(BeaconRecordSet $row) {
		$this->playerSessionId = $row->Field('player_session_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->connectTime = $row->Field('connect_time');
		$this->disconnectTime = $row->Field('disconnect_time');
		$this->playTime = $row->Field('play_time');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'player_sessions',
			definitions: [
				new DatabaseObjectProperty('playerSessionId', ['columnName' => 'player_session_id', 'required' => false, 'primaryKey' => true]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'accessor' => 'players.name']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'accessor' => 'services.service_id']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('connectTime', ['columnName' => 'connect_time', 'accessor' => 'EXTRACT(EPOCH FROM LOWER(%%TABLE%%.active_times))']),
				new DatabaseObjectProperty('disconnectTime', ['columnName' => 'disconnect_time', 'accessor' => 'EXTRACT(EPOCH FROM UPPER(%%TABLE%%.active_times))']),
				new DatabaseObjectProperty('playTime', ['columnName' => 'play_time', 'accessor' => 'EXTRACT(EPOCH FROM COALESCE(UPPER(%%TABLE%%.active_times), CURRENT_TIMESTAMP) - LOWER(%%TABLE%%.active_times))']),
			],
			joins: [
				'INNER JOIN sentinel.players ON (player_sessions.player_id = players.player_id)',
				'INNER JOIN sentinel.services ON (player_sessions.service_id = services.service_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'connectTime';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'connectTime':
			case 'playerName':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'SEARCH');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'SEARCH');

		if (isset($filters['groupId'])) {
			$groupIdPlaceholder = $parameters->AddValue($filters['groupId']);
			$parameters->clauses[] = 'player_sessions.service_id IN (SELECT service_id FROM sentinel.group_services WHERE service_id = $' . $groupIdPlaceholder . ')';
		}

		if (isset($filters['isConnected'])) {
			$connectedPlaceholder = $parameters->AddValue($filters['isConnected']);
			$parameters->clauses[] = 'UPPER_INF(player_sessions.active_times) = $' . $connectedPlaceholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'playerSessionId' => $this->playerSessionId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'connectTime' => $this->connectTime,
			'disconnectTime' => $this->disconnectTime,
			'playTime' => $this->playTime,
			'isConnected' => is_null($this->disconnectTime),
		];
	}
}

?>
