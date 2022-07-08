<?php

class BeaconArticle extends BeaconArticleMetadata {
	protected $body;
	
	protected function __construct(BeaconRecordSet $result): void {
		parent::__construct($result);
		
		$this->body = $result->Field('body');
	}
	
	protected static function Columns(): array {
		$columns = parent::Columns();
		$columns[] = 'body';
		return $columns;
	}
	
	public function Body(): string {
		return $this->body;
	}
}

?>