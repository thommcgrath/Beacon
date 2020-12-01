<?php

namespace BeaconAPI;

class Document implements \JsonSerializable {
	const PUBLISH_STATUS_PRIVATE = 'Private';
	const PUBLISH_STATUS_REQUESTED = 'Requested';
	const PUBLISH_STATUS_APPROVED = 'Approved';
	const PUBLISH_STATUS_APPROVED_PRIVATE = 'Approved But Private';
	const PUBLISH_STATUS_DENIED = 'Denied';
	
	protected $document_id = '';
	protected $name = '';
	protected $description = '';
	protected $revision = 1;
	protected $download_count = 0;
	protected $last_updated = null;
	protected $user_id = '';
	protected $owner_id = '';
	protected $published = self::PUBLISH_STATUS_PRIVATE;
	protected $map_mask = 0;
	protected $difficulty_value = 0;
	protected $console_safe = true;
	protected $mod_ids = '{}';
	protected $editors = '{}';
	protected $content = [];
	
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
	
	public function OwnerID() {
		return $this->owner_id;
	}
	
	public function IsPublic() {
		return $this->published == PUBLISH_STATUS_APPROVED;
	}
	
	public function PublishStatus() {
		return $this->published;
	}
	
	public function SetPublishStatus(string $desired_status) {
		$database = \BeaconCommon::Database();
		
		$results = $database->Query('SELECT published FROM documents WHERE document_id = $1;', $this->document_id);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($desired_status == self::PUBLISH_STATUS_REQUESTED || $desired_status == self::PUBLISH_STATUS_APPROVED) {
			if ($current_status == self::PUBLISH_STATUS_APPROVED_PRIVATE) {
				$new_status = self::PUBLISH_STATUS_APPROVED;
			} elseif ($current_status == self::PUBLISH_STATUS_PRIVATE) {
				$new_status = self::PUBLISH_STATUS_REQUESTED;
				
				$attachment = array(
					'title' => $this->name,
					'text' => $this->description,
					'fallback' => 'Unable to show response buttons.',
					'callback_id' => 'publish_document:' . $this->document_id,
					'actions' => array(
						array(
							'name' => 'status',
							'text' => 'Approve',
							'type' => 'button',
							'value' => self::PUBLISH_STATUS_APPROVED,
							'confirm' => array(
								'text' => 'Are you sure you want to approve this document?',
								'ok_text' => 'Approve'
							)
						),
						array(
							'name' => 'status',
							'text' => 'Deny',
							'type' => 'button',
							'value' => self::PUBLISH_STATUS_DENIED,
							'confirm' => array(
								'text' => 'Are you sure you want to reject this document?',
								'ok_text' => 'Deny'
							)
						)
					),
					'fields' => array()
				);
				
				$user = \BeaconUser::GetByUserID($this->user_id);
				if (is_null($user) === false) {
					if ($user->IsAnonymous()) {
						$username = 'Anonymous';
					} else {
						$username = $user->Username() . '#' . $user->Suffix();
					}
					$attachment['fields'][] = array(
						'title' => 'Author',
						'value' => $username
					);
				}
				
				$obj = array(
					'text' => 'Request to publish document',
					'attachments' => array($attachment)
				);
				\BeaconCommon::PostSlackRaw(json_encode($obj));	
			}
		} else {
			if ($current_status == self::PUBLISH_STATUS_APPROVED) {
				$new_status = self::PUBLISH_STATUS_APPROVED_PRIVATE;
			} elseif ($current_status == self::PUBLISH_STATUS_REQUESTED) {
				$new_status = self::PUBLISH_STATUS_PRIVATE;
			}
		}
		if ($new_status != $current_status) {
			$database->BeginTransaction();
			$database->Query('UPDATE documents SET published = $2 WHERE document_id = $1;', $this->document_id, $new_status);
			$database->Commit();
		}
		$this->published = $new_status;
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
	
	public function PreloadContent($version_id = null) {
		$content_key = (is_null($version_id) === true ? '' : $version_id);
		if (array_key_exists($content_key, $this->content) === true) {
			return $content_key;
		}
		
		$this->content[$content_key] = \BeaconCloudStorage::GetFile($this->CloudStoragePath(), true, $version_id);
		return $content_key;
	}	
	
	public function Content(bool $compressed = false, bool $parsed = true, $version_id = null) {
		try {
			$content_key = $this->PreloadContent($version_id);
		} catch (\Exception $err) {
			return '';
		}
		
		$content = $this->content[$content_key];
		$compressed = $compressed && ($parsed == false);
		$is_compressed = \BeaconCommon::IsCompressed($content);
		if ($is_compressed == true && $compressed == false) {
			$content = gzdecode($content);
		} elseif ($is_compressed == false && $compressed == true) {
			return gzencode($content);
		}
		if ($parsed) {
			return json_decode($content, true);
		} else {
			return $content;
		}
	}
	
	public function RequiredMods(bool $as_array) {
		if ($as_array) {
			if ($this->mod_ids === '{}') {
				return array();
			} else {
				return explode(',', substr($this->mod_ids, 1, strlen($this->mod_ids) - 2));
			}
		} else {
			return $this->mod_ids;
		}
	}
	
	public function ImplementedConfigs(bool $as_array) {
		if ($as_array) {
			if ($this->editors === '{}') {
				return array();
			} else {
				return explode(',', substr($this->editors, 1, strlen($this->editors) - 2));
			}
		} else {
			return $this->editors;
		}
	}
	
	public function ResourceURL() {
		return \BeaconAPI::URL('/document/' . urlencode($this->document_id) . '?name=' . urlencode($this->name));
	}
	
	public static function GetAll() {
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('user_id = owner_id'));
		return self::GetFromResults($results);
	}
	
	public static function GetByDocumentID(string $document_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('document_id = ANY($1) AND user_id = owner_id'), '{' . $document_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetDocumentByID(string $document_id) {
		// Just an alias for GetByDocumentID to make sense with GetSharedDocumentByID
		return self::GetByDocumentID($document_id);
	}
	
	public static function GetSharedDocumentByID(string $document_id, $user_id) {
		if (is_null($user_id)) {
			return self::GetByDocumentID($document_id);
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('document_id = ANY($1) AND user_id = $2'), '{' . $document_id . '}', $user_id);
		$documents = self::GetFromResults($results);
		if (count($documents) === 0) {
			$documents = self::GetByDocumentID($document_id);
		}
		return $documents;
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
				} elseif (\BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'document_id = $' . $next_placeholder++;
				}
				break;
			case 'public':
			case 'is_public':
				$clauses[] = 'published = \'Approved\'';
				break;
			case 'published':
				$values[] = $value;
				$clauses[] = 'published = $' . $next_placeholder++;
				break;
			case 'user_id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'user_id = ANY($' . $next_placeholder++ . ')';
				} elseif (is_null($value)) {
					$clauses[] = 'user_id IS NULL';
				} elseif (\BeaconCommon::IsUUID($value)) {
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
		
		// We want to list only "original" documents, not shared documents.
		$clauses[] = 'user_id = owner_id';
		
		$database = \BeaconCommon::Database();
		if ($count_only) {
			$sql = 'SELECT COUNT(document_id) AS document_count FROM allowed_documents WHERE ' . implode(' AND ', $clauses) . ';';
			$results = $database->Query($sql, $values);
			return $results->Field('document_count');
		} else {
			$sql = static::BuildSQL(implode(' AND ', $clauses), $order_by, $count, $offset);
			$results = $database->Query($sql, $values);
			return self::GetFromResults($results);
		}
	}
	
	public static function GetFromResults(\BeaconRecordSet $results) {
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
	
	protected static function GetFromResult(\BeaconRecordSet $results) {
		$document = new static();
		$document->document_id = $results->Field('document_id');
		$document->name = $results->Field('title');
		$document->description = $results->Field('description');
		$document->revision = intval($results->Field('revision'));
		$document->download_count = intval($results->Field('download_count'));
		$document->last_updated = new \DateTime($results->Field('last_update'));
		$document->user_id = $results->Field('user_id');
		$document->owner_id = $results->Field('owner_id');
		$document->published = $results->Field('published');
		$document->map_mask = intval($results->Field('map'));
		$document->difficulty_value = floatval($results->Field('difficulty'));
		$document->console_safe = boolval($results->Field('console_safe'));
		$document->mod_ids = is_null($results->Field('mods')) ? '{}' : $results->Field('mods');
		$document->editors = is_null($results->Field('included_editors')) ? '{}' : $results->Field('included_editors');
		return $document;
	}
	
	protected static function BuildSQL(string $clause = '', string $order_by = 'last_update DESC', int $count = 0, int $offset = 0) {
		$sql = 'SELECT ' . implode(', ', static::DatabaseColumns()) . ' FROM allowed_documents';
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
			'owner_id',
			'published',
			'map',
			'difficulty',
			'console_safe',
			'mods',
			'included_editors'
		);
	}
	
	public function jsonSerialize() {
		return array(
			'document_id' => $this->document_id,
			'user_id' => $this->user_id,
			'owner_id' => $this->owner_id,
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
	
	public function CloudStoragePath() {
		return static::GenerateCloudStoragePath($this->OwnerID(), $this->DocumentID());
	}
	
	public static function GenerateCloudStoragePath(string $user_id, string $document_id) {
		return '/' . strtolower($user_id) . '/Documents/' . strtolower($document_id) . '.beacon';
	}
	
	public static function SaveFromContent(string $document_id, \BeaconUser $user, $content, string &$reason) {
		if (is_array($content)) {
			$document = $content;
		} elseif (is_string($content)) {
			if (\BeaconCommon::IsCompressed($content)) {
				$content = gzdecode($content);
			}
			$document = json_decode($content, true);
			if (is_null($document)) {
				$reason = 'Unable to parse JSON.';
				return false;
			}
		} else {
			$reason = 'Supplied content is unknown data type.';
			return false;
		}
		
		if (!\BeaconCommon::HasAllKeys($document, 'Version', 'Identifier')) {
			$reason = 'Not all keys are present.';
			return false;
		}
		if (is_null($document_id) == false && strtolower($document['Identifier']) !== strtolower($document_id)) {
			$reason = 'Document UUID of ' . strtolower($document['Identifier']) . ' in content does not match the resource UUID of ' . strtolower($document_id) . '.';
			return false;
		}
		
		$document_version = intval($document['Version']);
		if ($document_version < 2) {
			$reason = 'Version 1 documents are no longer not accepted.';
			return false;
		}
		
		$database = \BeaconCommon::Database();
		$document_id = $document['Identifier'];
		
		// check if the document already exists
		$results = $database->Query('SELECT document_id FROM documents WHERE document_id = $1;', $document_id);
		$new_document = $results->RecordCount() == 0;
		
		// confirm write permission of the document
		if ($new_document == false) {
			$results = $database->Query('SELECT role, owner_id FROM allowed_documents WHERE document_id = $1 AND user_id = $2;', $document_id, $user->UserID());
			if ($results->RecordCount() == 0) {
				$reason = 'Access denied for document ' . $document_id . '.';
				return false;
			}
			$role = $results->Field('role');
			$owner_id = $results->Field('owner_id');
		} else {
			if ($user->IsChildAccount()) {
				$role = 'Team';
				$owner_id = $user->ParentAccount();
			} else {
				$role = 'Owner';
				$owner_id = $user->UserID();
			}
		}
		
		// gather document details
		$editor_names = array();
		$mod_ids = array();
		$loot_drops_config = null;
		$console_safe = false;
		$title = '';
		$description = '';
		$difficulty = 4;
		$mask = 1;
		$public = false;
		if (array_key_exists('Map', $document)) {
			$mask = intval($document['Map']);
		}
		$guests_to_add = array();
		$guests_to_remove = array();
		if ($document_version >= 4 && array_key_exists('EncryptionKeys', $document) && is_array($document['EncryptionKeys']) && \BeaconCommon::IsAssoc($document['EncryptionKeys'])) {
			$encryption_keys = $document['EncryptionKeys'];
			$allowed_users = array_keys($encryption_keys);
			
			$desired_guests = array();
			$results = $database->Query('SELECT user_id FROM users WHERE user_id = ANY($1) AND user_id != $2;', '{' . implode(',', $allowed_users) . '}', $owner_id);
			while (!$results->EOF()) {
				$desired_guests[] = $results->Field('user_id');
				$results->MoveNext();
			}
			
			$current_guests = array();
			$results = $database->Query('SELECT user_id FROM guest_documents WHERE document_id = $1;', $document_id);
			while (!$results->EOF()) {
				$current_guests[] = $results->Field('user_id');
				$results->MoveNext();
			}
			
			$guests_to_add = array_diff($desired_guests, $current_guests);
			$guests_to_remove = array_diff($current_guests, $desired_guests);
			
			if ($role !== 'Owner' && (count($guests_to_add) > 0 || count($guests_to_remove) > 0)) {
				$reason = 'Only the owner may add or remove users.';
				return false;
			}
		}
		if ($document_version >= 3) {
			if ($document_version >= 5) {
				$base = $document['Config Sets']['Base'];
			} else {
				$base = $document['Configs'];
			}
			foreach ($base as $configname => $configcontent) {
				if ($configname === 'LootDrops') {
					$loot_drops_config = $configcontent['Contents'];
					$editor_names[] = $configname;
				} elseif ($configname === 'Metadata') {
					$title = $configcontent['Title'];
					$description = $configcontent['Description'];
					$public = $configcontent['Public'];
				} elseif ($configname === 'Difficulty') {
					$difficulty = intval($configcontent['MaxDinoLevel']) / 30;
				} else {
					$editor_names[] = $configname;
				}
			}
		} else {
			$loot_drops_config = $document['LootSources'];
			if (array_key_exists('Title', $document)) {
				$title = $document['Title'];
			}
			if (array_key_exists('Description', $document)) {
				$description = $document['Description'];
			}
			if (array_key_exists('DifficultyValue', $document)) {
				$difficulty = $document['DifficultyValue'];
			}
			if (array_key_exists('Public', $document)) {
				$public = $document['Public'];
			}
			$editor_names[] = 'LootDrops';
		}
		if (is_null($loot_drops_config) === false) {
			$engram_classes = array();
			$engram_paths = array();
			try {
				foreach($loot_drops_config as $drop) {
					$sets = $drop['ItemSets'];
					foreach ($sets as $set) {
						$entries = $set['ItemEntries'];
						foreach ($entries as $entry) {
							$items = $entry['Items'];
							foreach ($items as $item) {
								if (array_key_exists('Path', $item)) {
									$engram_paths[] = $database->EscapeLiteral($item['Path']);
								} elseif (array_key_exists('Class', $item)) {
									$engram_classes[] = $database->EscapeLiteral($item['Class']);
								}
							}
						}
					}
				}
				
				$engram_classes = array_unique($engram_classes);
				$engram_paths = array_unique($engram_paths);
				$clauses = array();
				if (count($engram_classes) > 0) {
					$clauses[] = 'engrams.class_string IN (' . implode(',', $engram_classes) . ')';
				}
				if (count($engram_paths) > 0) {
					$clauses[] = 'engrams.path IN (' . implode(',', $engram_paths) . ')';
				}
				
				if (count($clauses) > 0) {
					try {
						$mods_lookup = $database->Query('SELECT DISTINCT mods.mod_id, mods.console_safe FROM engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id) WHERE ' . implode(' OR ', $clauses) . ';');
						if ($mods_lookup->RecordCount() > 0) {
							$console_safe = true;
						}
						while (!$mods_lookup->EOF()) {
							$console_safe = $console_safe && $mods_lookup->Field('console_safe');
							$mod_ids[] = $mods_lookup->Field('mod_id');
							$mods_lookup->MoveNext();
						}
						
						// that finds us the known mods, but doesn't help us with the rest.
						if (array_key_exists('23ecf24c-377f-454b-ab2f-d9d8f31a5863', $mod_ids) === false && count($engram_classes) > 0) {
							$unknown_results = $database->Query('SELECT * FROM (VALUES (' . implode('),(', $engram_classes) . ')) AS list(class_string) WHERE NOT EXISTS (SELECT class_string FROM engrams WHERE engrams.class_string = list.class_string);');
							if ($unknown_results->RecordCount() > 0) {
								$console_safe = false;
								$mod_ids[] = '23ecf24c-377f-454b-ab2f-d9d8f31a5863';
							}
						}
						if (array_key_exists('23ecf24c-377f-454b-ab2f-d9d8f31a5863', $mod_ids) === false && count($engram_paths) > 0) {
							$unknown_results = $database->Query('SELECT * FROM (VALUES (' . implode('),(', $engram_paths) . ')) AS list(path) WHERE NOT EXISTS (SELECT path FROM engrams WHERE engrams.path = list.path);');
							if ($unknown_results->RecordCount() > 0) {
								$console_safe = false;
								$mod_ids[] = '23ecf24c-377f-454b-ab2f-d9d8f31a5863';
							}
						}
					} catch (\Exception $err) {
						$reason = 'Database error: ' . $err->getMessage();
						return false;
					}
				}
			} catch (\Exception $err) {
			}
		}
		
		if (\BeaconCloudStorage::PutFile(self::GenerateCloudStoragePath($owner_id, $document_id), gzencode(json_encode($document))) === false) {
			$reason = 'Unable to upload document to cloud storage platform.';
			return false;
		}
		
		$mods = '{' . implode(',',$mod_ids) . '}';
		$editors = '{' . implode(',', $editor_names) . '}';
		try {
			$database->BeginTransaction();
			if ($new_document) {
				$database->Query('INSERT INTO documents (document_id, user_id, title, description, map, difficulty, console_safe, mods, included_editors, last_update) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, CURRENT_TIMESTAMP);', $document_id, $owner_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
			} else {
				$database->Query('UPDATE documents SET revision = revision + 1, title = $3, description = $4, map = $5, difficulty = $6, console_safe = $7, mods = $8, included_editors = $9, last_update = CURRENT_TIMESTAMP WHERE document_id = $1 AND user_id = $2;', $document_id, $owner_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
			}
			foreach ($guests_to_add as $guest_id) {
				$database->Query('INSERT INTO guest_documents (document_id, user_id) VALUES ($1, $2);', $document_id, $guest_id);
			}
			foreach ($guests_to_remove as $guest_id) {
				$database->Query('DELETE FROM guest_documents WHERE document_id = $1 AND user_id = $2;', $document_id, $guest_id);
			}
			$database->Commit();
		} catch (\Exception $err) {
			$reason = 'Database error: ' . $err->getMessage();
			return false;
		}
		
		// see if a publish request is needed
		if (\BeaconCommon::MinVersion() < 10300107) {
			$documents = self::GetByDocumentID($document_id);
			if (count($documents) == 1) {
				if ($public) {
					$documents[0]->SetPublishStatus(self::PUBLISH_STATUS_REQUESTED);
				} else {
					$documents[0]->SetPublishStatus(self::PUBLISH_STATUS_PRIVATE);
				}
			}
		}
		
		return true;
	}
}

?>
