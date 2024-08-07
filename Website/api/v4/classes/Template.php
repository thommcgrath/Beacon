<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime, JsonSerializable;

class Template extends DatabaseObject implements JsonSerializable {
	protected string $templateId;
	protected string $gameId;
	protected string $label;
	protected int $minVersion;
	protected int $lastUpdate;
	protected string $contents;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->templateId = $row->Field('object_id');
		$this->gameId = $row->Field('game_id');
		$this->label = $row->Field('label');
		$this->minVersion = $row->Field('min_version');
		$this->lastUpdate = round($row->Field('last_update'));
		$this->contents = $row->Field('contents');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'templates', [
			new DatabaseObjectProperty('templateId', ['primaryKey' => true, 'columnName' => 'object_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('contents')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Table() . '.label';
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->allowAll = true;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'templateId' => $this->templateId,
			'gameId' => $this->gameId,
			'label' => $this->label,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate,
			'contents' => base64_encode(gzencode($this->contents))
		];
	}
	
	public function TemplateId(): string {
		return $this->templateId;
	}
	
	public function GameId(): string {
		return $this->gameId;
	}
	
	public function Label(): string {
		return $this->label;
	}
	
	public function MinVersion(): int {
		return $this->minVersion;
	}
	
	public function Contents(): string {
		return $this->contents;
	}
}

?>
