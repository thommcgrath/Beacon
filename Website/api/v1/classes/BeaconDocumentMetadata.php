<?php

class BeaconDocumentMetadata implements JsonSerializable {
	protected $document_id = '';
	protected $name = '';
	protected $description = '';
	protected $revision = 1;
	protected $download_count = 0;
	protected $last_updated = null;
	protected $user_id = '';
	protected $is_public = false;
	
	public function DocumentID() {
		return $this->document_id;
	}
	
	public function Name() {
		return $this->name;
	}
	
	public function Description() {
		return $this->description;
	}
	
	public function Revision() {
		return $this->revision;
	}
	
	public function DownloadCount() {
		return $this->download_count;
	}
	
	public function LastUpdated() {
		return $this->last_updated;
	}
	
	public static function GetAll() {
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL());
		return self::GetFromResults($results);
	}
	
	public static function GetByDocumentID(string $document_id) {
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('document_id = ANY($1)'), '{' . $document_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetFromResults(BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$documents = array();
		while (!$results->EOF()) {
			$document = static::GetFromResult($results);
			if ($document !== null) {
				$documents[] = $document;
			}
			$results->MoveNext();
		}
		return $documents;
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$document = new static();
		$document->document_id = $results->Field('document_id');
		$document->name = $results->Field('title');
		$document->description = $results->Field('description');
		$document->revision = $results->Field('revision');
		$document->download_count = $results->Field('download_count');
		$document->last_updated = new DateTime($results->Field('last_update'));
		$document->user_id = $results->Field('user_id');
		$document->is_public = $results->Field('is_public');
		return $document;
	}
	
	protected static function BuildSQL(string $clause = '', string $order_by = 'last_update DESC', int $count = 0, int $offset = 0) {
		$sql = 'SELECT ' . implode(', ', static::DatabaseColumns()) . ' FROM documents';
		if ($clause !== '') {
			$sql .= ' WHERE ' . $clause;
		}
		if ($order_by !== '') {
			$sql .= ' ORDER BY ' . $order_by;
		}
		if ($count > 0) {
			$sql .= ' LIMIT ' . $count;
		}
		if ($offset > 0) {
			$sql .= ' OFFSET ' . $offset;
		}
		$sql .= ';';
		return $sql;
	}
	
	public static function DatabaseColumns() {
		return array('document_id', 'title', 'description', 'revision', 'download_count', 'last_update', 'user_id', 'is_public');
	}
	
	public function jsonSerialize() {
		return array(
			'document_id' => $this->document_id,
			'user_id' => $this->user_id,
			'name' => $this->name,
			'description' => $this->description,
			'revision' => intval($this->revision),
			'download_count' => intval($this->download_count),
			'last_updated' => $this->last_updated->format('Y-m-d H:i:sO'),
			'resource_url' => BeaconAPI::URL('/document.php/' . urlencode($this->document_id))
		);
	}
}

?>