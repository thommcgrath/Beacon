<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime;

class Event extends DatabaseObject implements \JsonSerializable {
	protected $event_id;
	protected $name;
	protected $ark_code;
	protected $rates = [];
	protected $colors = [];
	protected $engrams = [];
	
	protected function __construct(BeaconRecordSet $row) {
		$this->event_id = $row->Field('event_id');
		$this->name = $row->Field('event_name');
		$this->ark_code = $row->Field('event_code');
		$this->rates = is_null($row->Field('rates')) === false ? json_decode($row->Field('rates'), true) : [];
		$this->colors = is_null($row->Field('colors')) === false ? json_decode($row->Field('colors'), true) : [];
		$this->engrams = is_null($row->Field('engrams')) === false ? json_decode($row->Field('engrams'), true) : [];
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'events', [
			New DatabaseObjectProperty('event_id', ['primaryKey' => true]),
			New DatabaseObjectProperty('name', ['columnName' => 'event_name']),
			New DatabaseObjectProperty('ark_code', ['columnName' => 'event_code']),
			New DatabaseObjectProperty('rates', ['accessor' => '(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT ark.event_rates.ini_option AS object_id, ark.event_rates.multiplier FROM ark.event_rates INNER JOIN ark.ini_options ON (ark.event_rates.ini_option = ark.ini_options.object_id) WHERE ark.event_rates.event_id = ark.events.event_id) AS rates_template)']),
			New DatabaseObjectProperty('colors', ['accessor' => '(SELECT json_agg(color_id ORDER BY color_id) FROM ark.event_colors WHERE ark.event_colors.event_id = ark.events.event_id)']),
			New DatabaseObjectProperty('engrams', ['accessor' => '(SELECT json_agg(object_id) FROM ark.event_engrams WHERE ark.event_engrams.event_id = ark.events.event_id)'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$parameters->allowAll = true;
		$parameters->orderBy = 'event_name';
		$parameters->AddFromFilter(static::DatabaseSchema(), $filters, 'ark_code');
	}
	
	public static function Fetch(string $uuid): ?DatabaseObject {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		}
		
		$results = static::Search(['ark_code' => $uuid], true);
		if (count($results) === 1) {
			return $results[0];
		}
		
		return null;
	}
	
	protected static function SQLColumns() {
		return [
			'ark.events.event_id',
			'ark.events.event_name',
			'ark.events.event_code',
			'(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT ark.event_rates.ini_option AS object_id, ark.event_rates.multiplier FROM ark.event_rates INNER JOIN ark.ini_options ON (ark.event_rates.ini_option = ark.ini_options.object_id) WHERE ark.event_rates.event_id = ark.events.event_id) AS rates_template) AS rates',
			'(SELECT json_agg(color_id ORDER BY color_id) FROM ark.event_colors WHERE ark.event_colors.event_id = ark.events.event_id) AS colors',
			'(SELECT json_agg(object_id) FROM ark.event_engrams WHERE ark.event_engrams.event_id = ark.events.event_id) AS engrams'
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
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ark.events WHERE event_id = $1;', $uuid);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = new static();
		$obj->event_id = $row->Field('event_id');
		$obj->name = $row->Field('event_name');
		$obj->event_code = $row->Field('event_code');
		$obj->event_rates = is_null($row->Field('rates')) === false ? json_decode($row->Field('rates'), true) : [];
		$obj->event_colors = is_null($row->Field('colors')) === false ? json_decode($row->Field('colors'), true) : [];
		$obj->event_engrams = is_null($row->Field('engrams')) === false ? json_decode($row->Field('engrams'), true) : [];
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'event_id' => $this->event_id,
			'label' => $this->name,
			'ark_code' => $this->ark_code,
			'rates' => $this->rates,
			'colors' => $this->colors,
			'engrams' => $this->engrams
		];
	}
	
	public function EventId(): string {
		return $this->event_id;
	}
	
	public function Label(): string {
		return $this->name;
	}
	
	public function ArkCode(): string {
		return $this->ak_code;
	}
	
	public function Rates(): ?array {
		return $this->rates;
	}
	
	public function Colors(): ?array {
		return $this->colors;
	}
	
	public function Engrams(): ?array {
		return $this->engrams;
	}
}

?>
