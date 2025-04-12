<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class PlayerIdentifier extends DatabaseObject implements JsonSerializable {
	protected string $playerIdentifierId;
	protected string $playerId;
	protected string $provider;
	protected string $identifier;
	protected string $name;

	public function __construct(BeaconRecordSet $row) {
		$this->playerIdentifierId = $row->Field('player_identifier_id');
		$this->playerId = $row->Field('player_id');
		$this->provider = $row->Field('provider');
		$this->identifier = $row->Field('identifier');
		$this->name = $row->Field('name');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'player_identifiers',
			definitions: [
				new DatabaseObjectProperty('playerIdentifierId', ['columnName' => 'player_identifier_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
				new DatabaseObjectProperty('provider'),
				new DatabaseObjectProperty('identifier'),
				new DatabaseObjectProperty('name'),
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'name';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'name':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'provider', 'in');
		$parameters->AddFromFilter($schema, $filters, 'identifier', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'playerIdentifierId' => $this->playerIdentifierId,
			'playerId' => $this->playerId,
			'provider' => $this->provider,
			'identifier' => $this->identifier,
			'name' => $this->name,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
	}
}

?>
