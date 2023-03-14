<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class Player extends DatabaseObject implements JsonSerializable {
	protected $playerId = null;
	protected $name = null;
	protected $identifiers = [];
	
	public function __construct(BeaconRecordSet $row) {
		$this->playerId = $row->Field('player_id');
		$this->name = $row->Field('name');
		$this->identifiers = json_decode($row->Field('identifiers'), true);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'players', [
			new DatabaseObjectProperty('playerId', ['primaryKey' => true, 'columnName' => 'player_id']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('identifiers', ['accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(ids_template))) FROM (SELECT player_identifiers.provider, player_identifiers.name, player_identifiers.identifier, player_identifiers.nitrado_hash FROM sentinel.player_identifiers INNER JOIN sentinel.players AS temp ON (player_identifiers.player_id = temp.player_id) WHERE player_identifiers.player_id = players.player_id) AS ids_template), '[]')"])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
	}
	
	public function jsonSerialize(): mixed {
		return [
			'playerId' => $this->playerId,
			'name' => $this->name,
			'identifiers' => $this->identifiers
		];
	}
	
	public static function Create(string $name): Player {
		$playerId = BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (player_id, name) VALUE ($1, $2);', $playerId, $name);
		$database->Commit();
		return static::GetByPlayerID($playerId);
	}
	
	public static function GetByPlayerId(string $playerId): ?Player {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE player_id = $1;', $playerId);
		$players = static::FromRows($rows);
		if (count($players) === 1) {
			return $players[0];
		} else {
			return null;
		}
	}
	
	public static function GetByName(string $name, ?string $provider): array {
		$database = BeaconCommon::Database();
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName();
		$nameEscaped = str_replace(['\\', '%', '_'], ['\\\\', '\\%', '\\_'], $name);
		$values = ['%' . $nameEscaped . '%'];
		if (is_null($provider)) {
			$sql .= ' WHERE name LIKE $1 OR player_id IN (SELECT player_id FROM sentinel.player_identifiers WHERE name LIKE $1)';
		} else {
			$sql .= ' INNER JOIN sentinel.player_identifiers ON (players.player_id = player_identifiers.player_id) WHERE player_identifiers.name LIKE $1 AND player_identifiers.provider = $2';
			$values[] = $provider;
		}
		$sql .= ' ORDER BY players.name LIMIT 20;';
		$rows = $database->Query($sql, $values);
		return static::FromRows($rows);
	}
	
	public function PlayerID(): string {
		return $this->playerId;
	}
	
	public function Name(): string {
		return $this->name;
	}
}

?>