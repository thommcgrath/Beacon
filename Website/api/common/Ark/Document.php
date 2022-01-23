<?php

namespace BeaconAPI\Ark;

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
	
	public static function SaveFromMultipart(\BeaconUser $user, string &$reason) {
		$required_vars = ['difficulty', 'editors', 'keys', 'map', 'mods', 'title', 'uuid', 'version'];
		$missing_vars = [];
		foreach ($required_vars as $var) {
			if (isset($_POST[$var]) === false || empty($_POST[$var]) === true) {
				$missing_vars[] = $var;
			}
		}
		if (isset($_POST['description']) === false) {
			// description is allowed to be empty
			$missing_vars[] = 'description';
		}
		if (isset($_FILES['contents']) === false) {
			$missing_vars[] = 'contents';
			sort($missing_vars);
		}
		if (count($missing_vars) > 0) {
			$reason = 'The following parameters are missing: `' . implode('`, `', $missing_vars) . '`';
			return false;
		}
		
		$upload_status = $_FILES['contents']['error'];
		switch ($upload_status) {
		case UPLOAD_ERR_OK:
			break;
		case UPLOAD_ERR_NO_FILE:
			$reason = 'No file included.';
			break;
		case UPLOAD_ERR_INI_SIZE:
		case UPLOAD_ERR_FORM_SIZE:
			$reason = 'Exceeds maximum file size.';
			break;
		default:
			$reason = 'Other error ' . $upload_status . '.';
			break;
		}
		
		if (\BeaconCommon::IsCompressed($_FILES['contents']['tmp_name'], true) === false) {
			$source = $_FILES['contents']['tmp_name'];
			$destination = $source . '.gz';
			if ($read_handle = fopen($source, 'rb')) {
				if ($write_handle = gzopen($destination, 'wb9')) {
					while (!feof($read_handle)) {
						gzwrite($write_handle, fread($read_handle, 524288));
					}
					gzclose($write_handle);
				} else {
					fclose($read_handle);
					$reason = 'Could not create compressed file.';
					return false;
				}
				fclose($read_handle);
			} else {
				$reason = 'Could not read uncompressed file.';
				return false;
			}
			unlink($source);
			rename($destination, $source);
		}
		
		$document = [
			'Version' => intval($_POST['version']),
			'Identifier' => $_POST['uuid'],
			'Title' => $_POST['title'],
			'Description' => $_POST['description'],
			'Map' => intval($_POST['map']),
			'DifficultyValue' => floatval($_POST['difficulty']),
			'EditorNames' => array_unique(explode(',', $_POST['editors']))
		];
		$keys_members = explode(',', $_POST['keys']);
		$keys = [];
		foreach ($keys_members as $member) {
			$pos = strpos($member, ':');
			if ($pos === false) {
				$reason = 'Parameter `keys` expects a comma-separated list of key:value pairs.';
				return false;
			}
			$key = substr($member, 0, $pos);
			if (\BeaconCommon::IsUUID($key) === false) {
				$reason = 'Key `' . $key . '` is not a v4 UUID.';
				return false;
			}
			$value = substr($member, $pos + 1);
			$keys[$key] = $value;
		}
		$document['EncryptionKeys'] = $keys;
		$mods_members = explode(',', $_POST['mods']);
		$mods = [];
		foreach ($mods_members as $mod_id) {
			if (\BeaconCommon::IsUUID($mod_id) === false) {
				$reason = 'Mod UUID `' . $mod_id . '` is not a v4 UUID.';
				return false;
			}
			$mods[$mod_id] = true;
		}
		$document['ModSelections'] = $mods;
		sort($document['EditorNames']);
		
		return self::SaveFromArray($document, $user, $_FILES['contents'], $reason);
	}
	
	public static function SaveFromContent(string $document_id, \BeaconUser $user, $file_content, string &$reason) {
		if (empty($file_content)) {
			$reason = 'File is empty';
			return false;
		}
		
		if (\BeaconCommon::IsCompressed($file_content)) {
			$file_content_compressed = $file_content;
			$file_content = gzdecode($file_content_compressed);
		} else {
			$file_content_compressed = null;
		}
		
		try {
			$iter = \JsonMachine\JsonMachine::fromString($file_content, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
		} catch (\Exception $err) {
			$reason = 'Unable to parse JSON.';
			return false;
		}
		
		$document = ['EditorNames' => []];
		foreach ($iter as $key => $value) {
			switch ($key) {
			case 'Version':
			case 'Identifier':
			case 'EncryptionKeys':
			case 'Map':
			case 'Description':
			case 'Title':
			case 'DifficultyValue':
			case 'ModSelections':
			case 'ConsoleModsOnly';
				$document[$key] = json_decode($value, true);
				break;
			case 'Configs':
				$configs_iterator = \JsonMachine\JsonMachine::fromString($value, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
				foreach ($configs_iterator as $config_name => $config_contents) {
					if ($config_name === 'Metadata') {
						$config_parsed = json_decode($config_contents, true);
						$document['Title'] = $config_parsed['Title'];
						$document['Description'] = $config_parsed['Description'];
					} elseif ($config_name === 'Difficulty') {
						$config_parsed = json_decode($config_contents, true);
						$document['DifficultyValue'] = $config_parsed['MaxDinoLevel'] / 30;
					} else {
						$document['EditorNames'][] = $config_name;
					}
				}
				break;
			case 'Config Sets':
				$sets_iterator = \JsonMachine\JsonMachine::fromString($value, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
				foreach ($sets_iterator as $set_name => $set_contents) {
					$configs_iterator = \JsonMachine\JsonMachine::fromString($set_contents, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
					foreach ($configs_iterator as $config_name => $config_contents) {
						if ($set_name === 'Base' && $config_name === 'Metadata') {
							$config_parsed = json_decode($config_contents, true);
							$document['Title'] = $config_parsed['Title'];
							$document['Description'] = $config_parsed['Description'];
						} elseif ($set_name === 'Base' && $config_name === 'Difficulty') {
							$config_parsed = json_decode($config_contents, true);
							$document['DifficultyValue'] = $config_parsed['MaxDinoLevel'] / 30;
						} else {
							$document['EditorNames'][] = $config_name;
						}
					}
				}
				break;
			case 'LootSources':
				$document['EditorNames'][] = 'LootDrops';
				break;
			}
		}
		$document['EditorNames'] = array_unique($document['EditorNames']);
		sort($document['EditorNames']);
		
		// Catch some common errors
		if (!\BeaconCommon::HasAllKeys($document, 'Version', 'Identifier')) {
			$reason = 'Not all keys are present.';
			return false;
		}
		if (empty($document_id) == false && strtolower($document['Identifier']) !== strtolower($document_id)) {
			$reason = 'Document UUID of ' . strtolower($document['Identifier']) . ' in content does not match the resource UUID of ' . strtolower($document_id) . '.';
			return false;
		}
		
		if (is_null($file_content_compressed)) {
			$file_content_compressed = gzencode($file_content);
		}
		
		return self::SaveFromArray($document, $user, $file_content_compressed, $reason);
	}
	
	protected static function SaveFromArray(array $document, \BeaconUser $user, $contents, string &$reason) {
		$document_version = intval($document['Version']);
		if ($document_version < 2) {
			$reason = 'Version 1 documents are no longer not accepted.';
			return false;
		}
		
		$database = \BeaconCommon::Database();
		$document_id = $document['Identifier'];
		if (\BeaconCommon::IsUUID($document_id) === false) {
			$reason = 'Document identifier is not a v4 UUID.';
			return false;
		}
		$title = isset($document['Title']) ? $document['Title'] : '';
		$description = isset($document['Description']) ? $document['Description'] : '';
		$difficulty = isset($document['DifficultyValue']) ? $document['DifficultyValue'] : 4;
		$mask = isset($document['Map']) ? $document['Map'] : 4;
		
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
				$owner_id = $user->ParentAccountID();
			} else {
				$role = 'Owner';
				$owner_id = $user->UserID();
			}
		}
		
		$guests_to_add = [];
		$guests_to_remove = [];
		if (isset($document['EncryptionKeys']) && is_array($document['EncryptionKeys']) && \BeaconCommon::IsAssoc($document['EncryptionKeys'])) {
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
		
		$mod_ids = [];
		if (isset($document['ModSelections'])) {
			$console_safe = true;
			foreach ($document['ModSelections'] as $mod_id => $mod_enabled) {
				if ($mod_enabled) {
					$rows = $database->Query('SELECT mod_id, console_safe FROM mods WHERE confirmed = TRUE AND mod_id = $1;', $mod_id);
					if ($rows->RecordCount() === 1) {
						$mod_ids[] = $mod_id;
						$console_safe = $console_safe && $rows->Field('console_safe');
					}
				}
			}
		} elseif (isset($document['ConsoleModsOnly'])) {
			$console_mods_only = $document['ConsoleModsOnly'];
			$rows = $database->Query('SELECT mod_id FROM mods WHERE confirmed = TRUE AND console_safe = TRUE AND default_enabled = TRUE;');
			while (!$rows->EOF()) {
				$mod_ids[] = $rows->Field('mod_id');
				$rows->MoveNext();
			}
		} else {
			$console_safe = false;
		}
		
		if (\BeaconCloudStorage::PutFile(self::GenerateCloudStoragePath($owner_id, $document_id), $contents) === false) {
			$reason = 'Unable to upload document to cloud storage platform.';
			return false;
		}
		
		$idx = array_search('Difficulty', $document['EditorNames']);
		if ($idx !== false) {
			unset($document['EditorNames'][$idx]);
		}
		$idx = array_search('Metadata', $document['EditorNames']);
		if ($idx !== false) {
			unset($document['EditorNames'][$idx]);
		}
		
		$mods = '{' . implode(',', $mod_ids) . '}';
		$editors = '{' . implode(',', $document['EditorNames']) . '}';
		try {
			$database->BeginTransaction();
			$was_searchable = $database->Query('SELECT id FROM search_contents WHERE id = $1;', $document_id)->RecordCount() === 1;
			if ($new_document) {
				$database->Query('INSERT INTO documents (document_id, user_id, title, description, map, difficulty, console_safe, mods, included_editors, last_update) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, CURRENT_TIMESTAMP);', $document_id, $owner_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
			} else {
				$database->Query('UPDATE documents SET revision = revision + 1, title = $3, description = $4, map = $5, difficulty = $6, console_safe = $7, mods = $8, included_editors = $9, last_update = CURRENT_TIMESTAMP, deleted = FALSE WHERE document_id = $1 AND user_id = $2;', $document_id, $owner_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
			}
			$is_searchable = $database->Query('SELECT id FROM search_contents WHERE id = $1;', $document_id)->RecordCount() === 1;
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
		
		return true;
	}
}

?>
