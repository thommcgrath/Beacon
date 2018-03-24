<?php

class BeaconDocument extends BeaconDocumentMetadata {
	protected $content = '';
	
	public function Content() {
		return $this->content;
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$document = parent::GetFromResult($results);
		if ($document === null) {
			return null;
		}
		$document->content = json_decode($results->Field('formatted_contents'), true);
		return $document;
	}
	
	public static function DatabaseColumns() {
		$columns = parent::DatabaseColumns();
		$columns[] = 'jsonb_pretty(contents) AS formatted_contents';
		return $columns;
	}
	
	public function jsonSerialize() {
		return $this->content;
	}
}

?>