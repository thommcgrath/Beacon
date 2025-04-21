<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class PlayerNameChange extends DatabaseObject implements JsonSerializable {
	protected string $historyId;
	protected string $playerId;
	protected string $name;
	protected float $changeTime;

	public function __construct(BeaconRecordSet $row) {
		$this->historyId = $row->Field('history_id');
		$this->playerId = $row->Field('player_id');
		$this->name = $row->Field('name');
		$this->changeTime = floatval($row->Field('change_time'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'player_name_history',
			definitions: [
				new DatabaseObjectProperty('historyId', ['columnName' => 'history_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id']),
				new DatabaseObjectProperty('name'),
				new DatabaseObjectProperty('changeTime', ['columnName' => 'change_time', 'required' => false, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'changeTime';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'changeTime':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'playerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'historyId' => $this->historyId,
			'playerId' => $this->playerId,
			'name' => $this->name,
			'changeTime' => $this->changeTime,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
	}
}

?>
