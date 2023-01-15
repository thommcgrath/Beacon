<?php

namespace BeaconAPI\v4;
use DateTime, BeaconCommon, BeaconRecordSet;

class HelpTopic implements \JsonSerializable {
	protected $config_name;
	protected $title;
	protected $body;
	protected $detail_url;
	
	public function __construct(BeaconRecordSet $results) {
		$this->config_name = $results->Field('config_name');
		$this->title = $results->Field('title');
		$this->body = $results->Field('body');
		$this->detail_url = $results->Field('detail_url');
	}
	
	public static function GetAll(DateTime $updated_since = null): array {
		if ($updated_since === null) {
			$updated_since = new DateTime('2000-01-01');
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT * FROM help_topics WHERE last_update > $1;', $updated_since->format('Y-m-d H:i:sO'));
		$topics = [];
		while (!$results->EOF()) {
			$topics[] = new static($results);
			$results->MoveNext();
		}
		return $topics;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'topic' => $this->config_name,
			'title' => $this->title,
			'body' => $this->body,
			'detail_url' => $this->detail_url
		];
	}
}

?>
