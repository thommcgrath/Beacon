<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, DateTime;

class TemplateSelector extends DatabaseObject implements \JsonSerializable {
	protected $templateSelectorId;
	protected $gameId;
	protected $label;
	protected $minVersion;
	protected $lastUpdate;
	protected $language;
	protected $code;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->templateSelectorId = $row->Field('object_id');
		$this->gameId = $row->Field('game_id');
		$this->label = $row->Field('label');
		$this->minVersion = $row->Field('min_version');
		$this->lastUpdate = $row->Field('last_update');
		$this->language = $row->Field('language');
		$this->code = $row->Field('code');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'template_selectors', [
			new DatabaseObjectProperty('templateSelectorId', ['primaryKey' => true, 'columnName' => 'object_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('label'),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update']),
			new DatabaseObjectProperty('language'),
			new DatabaseObjectProperty('code')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('label');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->allowAll = true;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'templateSelectorId' => $this->templateSelectorId,
			'gameId' => $this->gameId,
			'label' => $this->label,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate,
			'language' => $this->language,
			'code' => $this->code
		];
	}
	
	public function TemplateSelectorId(): string {
		return $this->templateSelectorId;
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
	
	public function Language(): string {
		return $this->language;
	}
	
	public function Code(): string {
		return $this->code;
	}
}

?>
