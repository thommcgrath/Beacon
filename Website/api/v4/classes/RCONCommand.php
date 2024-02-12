<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class RCONCommand extends DatabaseObject implements JsonSerializable {
	protected string $commandId;
	protected string $gameId;
	protected string $name;
	protected string $description;
	protected array $parameters;

	protected function __construct(BeaconRecordSet $row) {
		$this->commandId = $row->Field('command_id');
		$this->gameId = $row->Field('game_id');
		$this->name = $row->Field('name');
		$this->description = $row->Field('description');
		$this->parameters = json_decode($row->Field('parameters'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'rcon_commands', [
			new DatabaseObjectProperty('commandId', ['primaryKey' => true, 'columnName' => 'command_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('description', ['editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('parameters', ['accessor' => 'COALESCE((SELECT array_to_json(array_agg(row_to_json(params_template))) FROM (SELECT rcon_parameters.name AS "name", rcon_parameters.data_type AS "type", rcon_parameters.description AS "description" FROM public.rcon_parameters WHERE rcon_parameters.command_id = rcon_commands.command_id ORDER BY rcon_parameters.position) AS params_template), \'[]\')', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->allowAll = true;
		$parameters->orderBy = 'name';
	}

	public function CommandId(): string {
		return $this->commandId;
	}

	public function GameId(): string {
		return $this->gameId;
	}

	public function Name(): string {
		return $this->name;
	}

	public function Description(): string {
		return $this->description;
	}

	public function Parameters(): array {
		return $this->parameters;
	}

	public function jsonSerialize(): mixed {
		return [
			'commandId' => $this->commandId,
			'gameId' => $this->gameId,
			'name' => $this->name,
			'description' => $this->description,
			'parameters' => $this->parameters,
		];
	}
}

?>
