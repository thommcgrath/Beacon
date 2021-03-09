<?php

namespace BeaconAPI;

class Event implements \JsonSerializable {
	protected $event_id;
	protected $event_name;
	protected $event_code;
	protected $event_rates;
	protected $event_colors;
	protected $event_engrams;
	
	protected static function SQLColumns() {
		return [
			'events.event_id',
			'events.event_name',
			'events.event_code',
			'(SELECT json_agg(row_to_json(rates_template)) FROM (SELECT event_rates.ini_option AS object_id, event_rates.multiplier FROM event_rates INNER JOIN ini_options ON (event_rates.ini_option = ini_options.object_id) WHERE event_rates.event_id = events.event_id) AS rates_template) AS rates',
			'(SELECT json_agg(color_id ORDER BY color_id) FROM event_colors WHERE event_colors.event_id = events.event_id) AS colors',
			'(SELECT json_agg(object_id) FROM event_engrams WHERE event_engrams.event_id = events.event_id) AS engrams'
		];
	}
	
	public static function GetAll(\DateTime $updated_since = null) {
		$database = \BeaconCommon::Database();
		if (is_null($updated_since)) {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM events;');
		} else {
			$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM events WHERE last_update > $1;', $updated_since->format('Y-m-d H:i:sO'));
		}
		
		return static::FromRows($results);
	}
	
	public static function GetForArkCode(string $code) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM events WHERE event_code = $1;', $code);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	public static function GetForUUID(string $uuid) {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM events WHERE event_id = $1;', $uuid);
		if ($results->RecordCount() === 1) {
			return static::FromRow($results);
		} else {
			return null;
		}
	}
	
	protected static function FromRows(\BeaconRecordSet $results) {
		if (($results === null) || ($results->RecordCount() == 0)) {
			return array();
		}
		
		$objects = array();
		while (!$results->EOF()) {
			$object = static::FromRow($results);
			if ($object !== null) {
				$objects[] = $object;
			}
			$results->MoveNext();
		}
		return $objects;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = new static();
		$obj->event_id = $row->Field('event_id');
		$obj->event_name = $row->Field('event_name');
		$obj->event_code = $row->Field('event_code');
		$obj->event_rates = json_decode($row->Field('rates'), true);
		$obj->event_colors = json_decode($row->Field('colors'), true);
		$obj->event_engrams = json_decode($row->Field('engrams'), true);
		return $obj;
	}
	
	public function jsonSerialize() {
		return [
			'event_id' => $this->event_id,
			'label' => $this->event_name,
			'ark_code' => $this->event_code,
			'rates' => $this->event_rates,
			'colors' => $this->event_colors,
			'engrams' => $this->event_engrams
		];
	}
	
	public function Label() {
		return $this->event_name;
	}
	
	public function ArkCode() {
		return $this->event_code;
	}
	
	public function UUID() {
		return $this->event_id;
	}
	
	public function Rates() {
		return $this->event_rates;
	}
	
	public function Colors() {
		return $this->event_colors;
	}
	
	public function Engrams() {
		return $this->event_engrams;
	}
}

?>
