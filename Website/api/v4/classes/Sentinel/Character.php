<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Character extends DatabaseObject implements JsonSerializable {
	protected string $characterId;
	protected string $characterName;
	protected int $specimenId;
	protected string $playerId;
	protected string $playerName;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $tribeId;
	protected string $tribeName;

	public function __construct(BeaconRecordSet $row) {
		$this->characterId = $row->Field('character_id');
		$this->characterName = $row->Field('character_name');
		$this->specimenId = $row->Field('specimen_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->tribeId = $row->Field('tribe_id');
		$this->tribeName = $row->Field('tribe_name');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'characters',
			definitions: [
				new DatabaseObjectProperty('characterId', ['columnName' => 'character_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('characterName', ['columnName' => 'character_name', 'accessor' => 'characters.name']),
				new DatabaseObjectProperty('specimenId', ['columnName' => 'specimen_id']),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => 'players.player_id']),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'accessor' => 'players.name']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'accessor' => 'services.service_id']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'accessor' => 'services.color']),
				new DatabaseObjectProperty('tribeId', ['columnName' => 'tribe_id', 'accessor' => 'tribes.tribe_id']),
				new DatabaseObjectProperty('tribeName', ['columnName' => 'tribe_name', 'accessor' => 'tribes.name']),
			],
			joins: [
				'INNER JOIN sentinel.players ON (characters.player_id = players.player_id)',
				'INNER JOIN sentinel.tribes ON (characters.tribe_id = tribes.tribe_id)',
				'INNER JOIN sentinel.services ON (characters.service_id = services.service_id)',
				'INNER JOIN sentinel.service_permissions ON (characters.service_id = service_permissions.service_id AND service_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'characterName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'characterName':
			case 'playerName':
			case 'serviceDisplayName':
			case 'tribeName':
			case 'specimenId':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'characterName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'tribeName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'specimenId');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'tribeId');
	}

	public function jsonSerialize(): mixed {
		return [
			'characterId' => $this->characterId,
			'characterName' => $this->characterName,
			'specimenId' => $this->specimenId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'tribeId' => $this->tribeId,
			'tribeName' => $this->tribeName,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public function SpecimenId(): int {
		return $this->specimenId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}
}

?>
