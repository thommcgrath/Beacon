<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime;

class Template extends DatabaseObject implements \JsonSerializable {
	protected $templateId;
	protected $gameId;
	protected $label;
	protected $minVersion;
	protected $lastUpdate;
	protected $contents;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->templateId = $row->Field('object_id');
		$this->gameId = $row->Field('game_id');
		$this->label = $row->Field('label');
		$this->minVersion = $row->Field('min_version');
		$this->lastUpdate = $row->Field('last_update');
		$this->contents = $row->Field('contents');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'templates', [
			new DatabaseObjectProperty('templateId', ['primaryKey' => true, 'columnName' => 'object_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update']),
			new DatabaseObjectProperty('contents')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Table() . '.label';
		$parameters->AddFromFilter($schema, $filters, 'game_id');
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
			'contents' => $this->contents
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
		return $this->minVersio ;
	}
	
	public function Contents(): string {
		return $this->contents;
	}
}

?>
