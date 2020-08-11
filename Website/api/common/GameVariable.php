<?php

namespace BeaconAPI;

class GameVariable implements \JsonSerializable {
	protected $key;
	protected $value;

	public function __construct(\BeaconRecordSet $results) {
		$this->key = $results->Field('key');
		$this->value = $results->Field('value');
	}

	public static function GetAll(\DateTime $updated_since = null) {
		if ($updated_since === null) {
			$updated_since = new \DateTime('2000-01-01');
		}

		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT * FROM game_variables WHERE last_update > $1;', $updated_since->format('Y-m-d H:i:sO'));
		$topics = array();
		while (!$results->EOF()) {
			$topics[] = new static($results);
			$results->MoveNext();
		}
		return $topics;
	}

	public function jsonSerialize() {
		return array(
			'key' => $this->key,
			'value' => $this->value
		);
	}
}

?>
