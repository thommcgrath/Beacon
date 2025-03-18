<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class Player extends DatabaseObject implements JsonSerializable {
	protected string $playerId;
	protected string $name;
	protected array $identifiers;
	protected array $history;
	protected array $characters;

	public function __construct(BeaconRecordSet $row) {
		$this->playerId = $row->Field('player_id');
		$this->name = $row->Field('name');
		$this->identifiers = json_decode($row->Field('identifiers'), true);
		$this->history = json_decode($row->Field('history'), true);
		$this->characters = json_decode($row->Field('characters'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'players', [
			new DatabaseObjectProperty('playerId', ['primaryKey' => true, 'columnName' => 'player_id']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('identifiers', ['accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(ids_template))) FROM (SELECT player_identifiers.provider, player_identifiers.name, player_identifiers.identifier FROM sentinel.player_identifiers INNER JOIN sentinel.players AS A ON (player_identifiers.player_id = A.player_id) WHERE player_identifiers.player_id = players.player_id) AS ids_template), '[]')"]),
			new DatabaseObjectProperty('history', ['accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(history_template))) FROM (SELECT player_name_history.name, EXTRACT(EPOCH FROM player_name_history.change_time) AS \"changeTime\" FROM sentinel.player_name_history INNER JOIN sentinel.players AS B ON (player_name_history.player_id = B.player_id) WHERE player_name_history.player_id = players.player_id ORDER BY player_name_history.change_time DESC) AS history_template), '[]')"]),
			new DatabaseObjectProperty('characters', ['accessor' => "COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(characters_template))) FROM (SELECT services.service_id AS \"serviceId\", services.name AS \"serviceName\", services.color AS \"serviceColor\", characters.specimen_id AS \"specimenId\", characters.name, characters.tribe_id AS \"tribeId\", tribes.name AS \"tribeName\" FROM sentinel.characters INNER JOIN sentinel.services ON (characters.service_id = services.service_id) INNER JOIN sentinel.players AS C ON (characters.player_id = C.player_id) INNER JOIN sentinel.tribes ON (characters.tribe_id = tribes.tribe_id) WHERE characters.player_id = players.player_id ORDER BY characters.name) AS characters_template), '[]')"]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->allowAll = true;

		if (isset($filters['identifier'])) {
			$placeholder = $parameters->AddValue($filters['identifier']);
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.player_identifiers WHERE identifier = $' . $placeholder . ')';
		}
		if (isset($filters['specimenId'])) {
			$placeholder = $parameters->AddValue($filters['specimenId']);
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.characters WHERE specimen_id = $' . $placeholder . ')';
		}
		if (isset($filters['name'])) {
			$namePlaceholder = $parameters->AddValue($filters['name']);
			$languagePlaceholder = $parameters->AddValue('english');
			$parameters->clauses[] = '(' . $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.player_name_history WHERE name_vector @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $namePlaceholder . ')) OR ' . $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.characters WHERE name_vector @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $namePlaceholder . ')))';
		} elseif (isset($filters['characterName'])) {
			$namePlaceholder = $parameters->AddValue($filters['characterName']);
			$languagePlaceholder = $parameters->AddValue('english');
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.characters WHERE name_vector @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $namePlaceholder . '))';
		} elseif (isset($filters['playerName'])) {
			$namePlaceholder = $parameters->AddValue($filters['playerName']);
			$languagePlaceholder = $parameters->AddValue('english');
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.player_name_history WHERE name_vector @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $namePlaceholder . '))';
		}
		if (isset($filters['serviceId'])) {
			$placeholder = $parameters->AddValue($filters['serviceId']);
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.characters WHERE service_id = $' . $placeholder . ')';
		} elseif (isset($filters['serviceGroupId'])) {
			$placeholder = $parameters->AddValue($filters['serviceGroupId']);
			$parameters->clauses[] = $schema->Accessor('playerId') . ' IN (SELECT player_id FROM sentinel.characters WHERE service_id IN (SELECT service_id FROM sentinel.service_group_services WHERE service_group_id = $' . $placeholder . '))';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'playerId' => $this->playerId,
			'name' => $this->name,
			'identifiers' => $this->identifiers,
			'history' => $this->history,
			'characters' => $this->characters,
		];
	}

	public function PlayerId(): string {
		return $this->playerId;
	}

	public function Name(): string {
		return $this->name;
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelPlayersRead;
	}
}

?>
