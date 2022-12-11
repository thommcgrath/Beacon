<?php

namespace BeaconAPI\Sentinel;

class Player extends \BeaconAPI\DatabaseObject implements \JsonSerializable {
	protected $player_id = null;
	protected $name = null;
	protected $identifiers = [];
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->player_id = $row->Field('player_id');
		$this->name = $row->Field('name');
		$this->identifiers = json_decode($row->Field('identifiers'), true);
	}
	
	public static function SQLSchemaName(): string {
		return 'sentinel';
	}
	
	public static function SQLTableName(): string{
		return 'players';
	}
	
	public static function SQLColumns(): array {
		return [
			'players.player_id',
			'players.name',
			'COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(ids_template))) FROM (SELECT player_identifiers.provider, player_identifiers.name, player_identifiers.identifier, player_identifiers.nitrado_hash FROM sentinel.player_identifiers INNER JOIN sentinel.players AS temp ON (player_identifiers.player_id = temp.player_id) WHERE player_identifiers.player_id = players.player_id) AS ids_template), \'[]\') AS identifiers'
		];
	}
	
	public function jsonSerialize(): mixed {
		return [
			'player_id' => $this->player_id,
			'name' => $this->name,
			'identifiers' => $this->identifiers
		];
	}
	
	public static function Create(string $name): Player {
		$player_id = \BeaconCommon::GenerateUUID();
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (player_id, name) VALUE ($1, $2);', $player_id, $name);
		$database->Commit();
		return static::GetByPlayerID($player_id);
	}
	
	public static function GetByPlayerId(string $player_id): ?Player {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE player_id = $1;', $player_id);
		$players = static::FromRows($rows);
		if (count($players) === 1) {
			return $players[0];
		} else {
			return null;
		}
	}
	
	public static function GetByName(string $name, ?string $provider): array {
		$database = \BeaconCommon::Database();
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName();
		$name_escaped = str_replace(['\\', '%', '_'], ['\\\\', '\\%', '\\_'], $name);
		$values = ['%' . $name_escaped . '%'];
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
}

?>