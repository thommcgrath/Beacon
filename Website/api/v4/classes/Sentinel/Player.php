<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class Player extends DatabaseObject implements JsonSerializable {
	protected string $playerId;
	protected string $playerName;

	public function __construct(BeaconRecordSet $row) {
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('name');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'players', [
			new DatabaseObjectProperty('playerId', ['primaryKey' => true, 'columnName' => 'player_id']),
			new DatabaseObjectProperty('playerName', ['columnName' => 'name']),
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
			'playerName' => $this->playerName,
			'permissions' => 1,
		];
	}

	public function PlayerId(): string {
		return $this->playerId;
	}

	public function Name(): string {
		return $this->playerName;
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelPlayersRead;
	}
}

?>
