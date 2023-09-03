<?php

namespace BeaconAPI\v4\Ark;
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
		return new DatabaseSchema('ark', 'events', [
			New DatabaseObjectProperty('eventId', ['primaryKey' => true, 'columnName' => 'event_id']),
			New DatabaseObjectProperty('name', ['columnName' => 'event_name']),
			New DatabaseObjectProperty('arkCode', ['columnName' => 'event_code']),
			New DatabaseObjectProperty('rates', ['accessor' => '(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT event_rates.ini_option AS "configOptionId", event_rates.multiplier FROM ark.event_rates INNER JOIN ark.ini_options ON (event_rates.ini_option = ini_options.object_id) WHERE event_rates.event_id = events.event_id) AS rates_template)']),
			New DatabaseObjectProperty('colors', ['accessor' => '(SELECT json_agg(color_id ORDER BY color_id) FROM ark.event_colors WHERE event_colors.event_id = events.event_id)']),
			New DatabaseObjectProperty('engrams', ['accessor' => '(SELECT json_agg(object_id) FROM ark.event_engrams WHERE event_engrams.event_id = events.event_id)']),
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
	
	/*protected static function SQLColumns() {
		return [
			'ark.events.eventId',
			'ark.events.event_name',
			'ark.events.event_code',
			'(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT ark.event_rates.ini_option AS object_id, ark.event_rates.multiplier FROM ark.event_rates INNER JOIN ark.ini_options ON (ark.event_rates.ini_option = ark.ini_options.object_id) WHERE ark.event_rates.eventId = ark.events.eventId) AS rates_template) AS rates',
			'(SELECT json_agg(color_id ORDER BY color_id) FROM ark.event_colors WHERE ark.event_colors.eventId = ark.events.eventId) AS colors',
			'(SELECT json_agg(object_id) FROM ark.event_engrams WHERE ark.event_engrams.eventId = ark.events.eventId) AS engrams'
		];
	}
	
	public static function GetAll(\DateTime $updated_since = null) {
		$database = \BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.events;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.events WHERE last_update > $1;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForArkCode(string $code) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.events WHERE event_code = $1;', $code);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	public static function GetForUUID(string $uuid) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.events WHERE eventId = $1;', $uuid);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = new static();
		$obj->eventId = $row->Field('eventId');
		$obj->name = $row->Field('event_name');
		$obj->event_code = $row->Field('event_code');
		$obj->event_rates = is_null($row->Field('rates')) === false ? json_decode($row->Field('rates'), true) : [];
		$obj->event_colors = is_null($row->Field('colors')) === false ? json_decode($row->Field('colors'), true) : [];
		$obj->event_engrams = is_null($row->Field('engrams')) === false ? json_decode($row->Field('engrams'), true) : [];
		return $obj;
	}*/
	
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
