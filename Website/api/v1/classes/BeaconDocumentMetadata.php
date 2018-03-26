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
	protected $map_mask = 0;
	protected $difficulty_value = 0;
	protected $console_safe = true;
	
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
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function IsPublic() {
		return $this->is_public;
	}
	
	public function MapMask() {
		return $this->map_mask;
	}
	
	public function DifficultyValue() {
		return $this->difficulty_value;
	}
	
	public function ConsoleSafe() {
		return $this->console_safe;
	}
	
	public function LookupRequiredMods() {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT DISTINCT mods.mod_id FROM (SELECT DISTINCT jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(contents->\'LootSources\')->\'ItemSets\')->\'ItemEntries\')->\'Items\')->>\'Path\' AS path FROM documents WHERE document_id = $1) AS items LEFT JOIN (engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id)) ON (items.path = engrams.path);', $this->document_id);
		$mods = array();
		while (!$results->EOF()) {
			$mod_id = $results->Field('mod_id');
			if (is_null($mod_id)) {
				$mods[] = null; // yes
			} else {
				$mods[] = BeaconMod::GetByModID($mod_id);
			}
			$results->MoveNext();
		}
		return $mods;
	}
	
	public function ResourceURL() {
		return BeaconAPI::URL('/document.php/' . urlencode($this->document_id));
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
	
	public static function Search(array $params, string $order_by = 'last_update DESC', int $count = 0, int $offset = 0, bool $count_only = false) {
		$next_placeholder = 1;
		$values = array();
		$clauses = array();
		
		foreach ($params as $column => $value) {
			switch ($column) {
			case 'document_id':
			case 'id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'document_id = ANY($' . $next_placeholder++ . ')';
				} elseif (BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'document_id = $' . $next_placeholder++;
				}
				break;
			case 'public':
			case 'is_public':
				$values[] = boolval($value);
				$clauses[] = 'is_public = $' . $next_placeholder++;
				break;
			case 'user_id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'user_id = ANY($' . $next_placeholder++ . ')';
				} elseif (is_null($value)) {
					$clauses[] = 'user_id IS NULL';
				} elseif (BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'user_id = $' . $next_placeholder++;
				}
				break;
			case 'map':
			case 'map_mask':
			case 'map_all':
				$values[] = intval($value);
				$clauses[] = 'map & $' . $next_placeholder . ' = $' . $next_placeholder++;
				break;
			case 'map_any':
				$values[] = intval($value);
				$clauses[] = 'map & $' . $next_placeholder++ . ' != 0';
				break;
			case 'console_safe':
				$values[] = boolval($value);
				$clauses[] = 'console_safe = $' . $next_placeholder++;
				break;
			}
		}
		
		$database = BeaconCommon::Database();
		if ($count_only) {
			$sql = 'SELECT COUNT(document_id) AS document_count FROM documents WHERE ' . implode(' AND ', $clauses) . ';';
			$results = $database->Query($sql, $values);
			return $results->Field('document_count');
		} else {
			$sql = static::BuildSQL(implode(' AND ', $clauses), $order_by, $count, $offset);
			$results = $database->Query($sql, $values);
			return self::GetFromResults($results);
		}
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
		$document->revision = intval($results->Field('revision'));
		$document->download_count = intval($results->Field('download_count'));
		$document->last_updated = new DateTime($results->Field('last_update'));
		$document->user_id = $results->Field('user_id');
		$document->is_public = boolval($results->Field('is_public'));
		$document->map_mask = intval($results->Field('map'));
		$document->difficulty_value = floatval($results->Field('difficulty'));
		$document->console_safe = boolval($results->Field('console_safe'));
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
		return array(
			'document_id',
			'title',
			'description',
			'revision',
			'download_count',
			'last_update',
			'user_id',
			'is_public',
			'map',
			'difficulty',
			'console_safe'
		);
	}
	
	public function jsonSerialize() {
		return array(
			'document_id' => $this->document_id,
			'user_id' => $this->user_id,
			'name' => $this->name,
			'description' => $this->description,
			'revision' => $this->revision,
			'download_count' => $this->download_count,
			'last_updated' => $this->last_updated->format('Y-m-d H:i:sO'),
			'map_mask' => $this->map_mask,
			'difficulty_value' => $this->difficulty_value,
			'console_safe' => $this->console_safe,
			'resource_url' => $this->ResourceURL()
		);
	}
}

?>