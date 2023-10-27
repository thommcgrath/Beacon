<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Event extends DatabaseObject implements JsonSerializable {
	protected string $eventId;
	protected string $name;
	protected string $arkCode;
	protected array $rates;
	protected array $colors;
	protected array $engrams;
	protected int $lastUpdate;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->eventId = $row->Field('event_id');
		$this->name = $row->Field('event_name');
		$this->arkCode = $row->Field('event_code');
		$this->rates = is_null($row->Field('rates')) === false ? json_decode($row->Field('rates'), true) : [];
		$this->colors = is_null($row->Field('colors')) === false ? json_decode($row->Field('colors'), true) : [];
		$this->engrams = is_null($row->Field('engrams')) === false ? json_decode($row->Field('engrams'), true) : [];
		$this->lastUpdate = round($row->Field('last_update'));
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('arksa', 'events', [
			New DatabaseObjectProperty('eventId', ['primaryKey' => true, 'columnName' => 'event_id']),
			New DatabaseObjectProperty('name', ['columnName' => 'event_name']),
			New DatabaseObjectProperty('arkCode', ['columnName' => 'event_code']),
			New DatabaseObjectProperty('rates', ['accessor' => '(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT event_rates.ini_option AS "configOptionId", event_rates.multiplier FROM arksa.event_rates INNER JOIN arksa.ini_options ON (event_rates.ini_option = ini_options.object_id) WHERE event_rates.event_id = events.event_id) AS rates_template)']),
			New DatabaseObjectProperty('colors', ['accessor' => '(SELECT json_agg(color_id ORDER BY color_id) FROM arksa.event_colors WHERE event_colors.event_id = events.event_id)']),
			New DatabaseObjectProperty('engrams', ['accessor' => '(SELECT json_agg(object_id) FROM arksa.event_engrams WHERE event_engrams.event_id = events.event_id)']),
			New DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = 'event_name';
		$parameters->AddFromFilter($schema, $filters, 'arkCode');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		}
		
		$results = static::Search(['arkCode' => $uuid], true);
		if (count($results) === 1) {
			return $results[0];
		}
		
		return null;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'eventId' => $this->eventId,
			'arkCode' => $this->arkCode,
			'label' => $this->name,
			'rates' => $this->rates,
			'colors' => $this->colors,
			'engrams' => $this->engrams,
			'lastUpdate' => $this->lastUpdate
		];
	}
	
	public function EventId(): string {
		return $this->eventId;
	}
	
	public function Label(): string {
		return $this->name;
	}
	
	public function ArkCode(): string {
		return $this->ak_code;
	}
	
	public function Rates(): array {
		return $this->rates;
	}
	
	public function Colors(): array {
		return $this->colors;
	}
	
	public function Engrams(): array {
		return $this->engrams;
	}
}

?>
