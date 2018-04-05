<?php

class BeaconArticle extends BeaconArticleMetadata {
	protected $body;
	
	protected function __construct(BeaconRecordSet $result) {
		parent::__construct($result);
		
		$this->body = $result->Field('body');
	}
	
	protected static function Columns() {
		$columns = parent::Columns();
		$columns[] = 'body';
		return $columns;
	}
	
	public function Body() {
		return $this->body;
	}
}

?>