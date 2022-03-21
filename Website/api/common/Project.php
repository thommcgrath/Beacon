<?php

namespace BeaconAPI;

abstract class Project implements \JsonSerializable {
	const PUBLISH_STATUS_PRIVATE = 'Private';
	const PUBLISH_STATUS_REQUESTED = 'Requested';
	const PUBLISH_STATUS_APPROVED = 'Approved';
	const PUBLISH_STATUS_APPROVED_PRIVATE = 'Approved But Private';
	const PUBLISH_STATUS_DENIED = 'Denied';
	
	protected $project_id = '';
	protected $game_id = '';
	protected $game_specific = [];
	protected $user_id = '';
	protected $owner_id = '';
	protected $title = '';
	protected $description = '';
	protected $console_safe = true;
	protected $last_update = null;
	protected $revision = 1;
	protected $download_count = 0;
	protected $published = self::PUBLISH_STATUS_PRIVATE;
	protected $content = [];
	
	public static function SchemaName() {
		return 'public';
	}
		
	public static function TableName() {
		return 'projects';
	}
	
	public static function AllowedTableName() {
		return 'allowed_projects';
	}
	
	public static function GuestTableName() {
		return 'guest_projects';
	}
	
	public static function SQLColumns() {
		return [
			'project_id',
			'game_id',
			'user_id',
			'owner_id',
			'title',
			'description',
			'console_safe',
			'last_update',
			'revision',
			'download_count',
			'published',
			'game_specific'
		];
	}
	
	public function jsonSerialize() {
		throw new \Exception('Subclasses need to override.');
	}
		
	public function ProjectID() {
		return $this->project_id;
	}
	
	public function DocumentID() {
		// Legacy compatibility alias
		return $this->project_id;
	}
	
	public function GameID() {
		return $this->game_id;
	}
	
	public function GameURLComponent() {
		switch ($this->game_id) {
		case 'Ark':
			return 'ark';
		}
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function OwnerID() {
		return $this->owner_id;
	}
	
	public function Title() {
		return $this->title;
	}
	
	public function Name() {
		// Legacy compatibility alias
		return $this->title;
	}
	
	public function Description() {
		return $this->description;
	}
	
	public function ConsoleSafe() {
		return $this->console_safe;
	}
	
	public function LastUpdated() {
		return $this->last_update;
	}
	
	public function Revision() {
		return $this->revision;
	}
	
	public function DownloadCount() {
		return $this->download_count;
	}
	
	public function IsPublic() {
		return $this->published == PUBLISH_STATUS_APPROVED;
	}
	
	public function PublishStatus() {
		return $this->published;
	}
	
	public function SetPublishStatus(string $desired_status) {
		$database = \BeaconCommon::Database();
		
		$results = $database->Query('SELECT published FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE project_id = $1;', $this->project_id);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($desired_status == self::PUBLISH_STATUS_REQUESTED || $desired_status == self::PUBLISH_STATUS_APPROVED) {
			if ($current_status == self::PUBLISH_STATUS_APPROVED_PRIVATE) {
				$new_status = self::PUBLISH_STATUS_APPROVED;
			} elseif ($current_status == self::PUBLISH_STATUS_PRIVATE) {
				$new_status = self::PUBLISH_STATUS_REQUESTED;
				
				$attachment = array(
					'title' => $this->title,
					'text' => $this->description,
					'fallback' => 'Unable to show response buttons.',
					'callback_id' => 'publish_document:' . $this->project_id,
					'actions' => array(
						array(
							'name' => 'status',
							'text' => 'Approve',
							'type' => 'button',
							'value' => self::PUBLISH_STATUS_APPROVED,
							'confirm' => array(
								'text' => 'Are you sure you want to approve this project?',
								'ok_text' => 'Approve'
							)
						),
						array(
							'name' => 'status',
							'text' => 'Deny',
							'type' => 'button',
							'value' => self::PUBLISH_STATUS_DENIED,
							'confirm' => array(
								'text' => 'Are you sure you want to reject this project?',
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
					'text' => 'Request to publish project',
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
			$database->Query('UPDATE ' . static::SchemaName() . '.' . static::TableName() . ' SET published = $2 WHERE project_id = $1;', $this->project_id, $new_status);
			$database->Commit();
		}
		$this->published = $new_status;
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
	
	public function ResourceURL() {
		return \BeaconAPI::URL('document/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
	
	public static function GetAll() {
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('user_id = owner_id'));
		return self::GetFromResults($results);
	}
	
	public static function GetByDocumentID(string $project_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('project_id = ANY($1) AND user_id = owner_id'), '{' . $project_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetDocumentByID(string $project_id) {
		// Just an alias for GetByDocumentID to make sense with GetSharedDocumentByID
		return self::GetByDocumentID($project_id);
	}
	
	public static function GetSharedDocumentByID(string $project_id, $user_id) {
		if (is_null($user_id)) {
			return self::GetByDocumentID($project_id);
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('project_id = ANY($1) AND user_id = $2'), '{' . $project_id . '}', $user_id);
		$projects = self::GetFromResults($results);
		if (count($projects) === 0) {
			$projects = self::GetByDocumentID($project_id);
		}
		return $projects;
	}
	
	protected static function HookHandleSearchKey(string $column, $value, array &$clauses, array &$values, int &$next_placeholder) {
		
	}
	
	public static function Search(array $params, string $order_by = 'last_update DESC', int $count = 0, int $offset = 0, bool $count_only = false) {
		$next_placeholder = 1;
		$values = array();
		$clauses = array();
		
		foreach ($params as $column => $value) {
			switch ($column) {
			case 'project_id':
			case 'document_id':
			case 'id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'project_id = ANY($' . $next_placeholder++ . ')';
				} elseif (\BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'project_id = $' . $next_placeholder++;
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
			case 'console_safe':
				$values[] = boolval($value);
				$clauses[] = 'console_safe = $' . $next_placeholder++;
				break;
			default:
				static::HookHandleSearchKey($column, $value, $clauses, $values, $next_placeholder);
				break;
			}
		}
		
		// We want to list only "original" projects, not shared projects.
		$clauses[] = 'user_id = owner_id';
		
		$database = \BeaconCommon::Database();
		if ($count_only) {
			$sql = 'SELECT COUNT(project_id) AS project_count FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE ' . implode(' AND ', $clauses) . ';';
			$results = $database->Query($sql, $values);
			return $results->Field('project_count');
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
		
		$projects = array();
		while (!$results->EOF()) {
			$project = static::GetFromResult($results);
			if ($project !== null) {
				$projects[] = $project;
			}
			$results->MoveNext();
		}
		return $projects;
	}
	
	protected static function GetFromResult(\BeaconRecordSet $results) {
		// This is a factory method. Not my favorite, but it'll do.
		
		$game_id = $results->Field('game_id');
		$project = null;
		switch ($game_id) {
		case 'Ark':
			$project = new \Ark\Project();
			break;
		default:
			throw new \Exception('Unknown game ' . $game_id);
		}
		$project->project_id = $results->Field('project_id');
		$project->game_id = $game_id;
		$project->title = $results->Field('title');
		$project->description = $results->Field('description');
		$project->revision = intval($results->Field('revision'));
		$project->download_count = intval($results->Field('download_count'));
		$project->last_update = new \DateTime($results->Field('last_update'));
		$project->user_id = $results->Field('user_id');
		$project->owner_id = $results->Field('owner_id');
		$project->published = $results->Field('published');
		$project->console_safe = boolval($results->Field('console_safe'));
		$project->game_specific = json_decode($results->Field('game_specific'), true);
		return $project;
	}
	
	protected static function BuildSQL(string $clause = '', string $order_by = 'last_update DESC', int $count = 0, int $offset = 0) {
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SchemaName() . '.' . static::AllowedTableName();
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
	
	public function CloudStoragePath() {
		return static::GenerateCloudStoragePath($this->OwnerID(), $this->ProjectID());
	}
	
	public static function GenerateCloudStoragePath(string $user_id, string $project_id) {
		return '/' . strtolower($user_id) . '/Documents/' . strtolower($project_id) . '.beacon';
	}
	
	protected static function HookValidateMultipart(array &$required_vars, string &$reason) {
		return true;
	}
	
	protected static function HookMultipartAddProjectValues(array &$project, string &$reason) {
		return true;
	}
	
	public static function SaveFromMultipart(\BeaconUser $user, string &$reason) {
		$required_vars = ['keys', 'title', 'uuid', 'version'];
		if (static::HookValidateMultipart($required_vars, $reason) === false) {
			return false;
		}
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
		
		$project = [
			'Version' => intval($_POST['version']),
			'Identifier' => $_POST['uuid'],
			'Title' => $_POST['title'],
			'Description' => $_POST['description']
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
		$project['EncryptionKeys'] = $keys;
		
		if (static::HookMultipartAddProjectValues($project, $reason) === false) {
			return false;
		}
		
		return self::SaveFromArray($project, $user, $_FILES['contents'], $reason);
	}
	
	public static function SaveFromContent(string $project_id, \BeaconUser $user, $file_content, string &$reason) {
	}
	
	protected static function HookRowSaveData(array $project, array &$row_values) {
	}
	
	protected static function SaveFromArray(array $project, \BeaconUser $user, $contents, string &$reason) {
		$project_version = intval($project['Version']);
		if ($project_version < 2) {
			$reason = 'Version 1 projects are no longer not accepted.';
			return false;
		}
		
		$database = \BeaconCommon::Database();
		$project_id = $project['Identifier'];
		if (\BeaconCommon::IsUUID($project_id) === false) {
			$reason = 'Project identifier is not a v4 UUID.';
			return false;
		}
		$title = isset($project['Title']) ? $project['Title'] : '';
		$description = isset($project['Description']) ? $project['Description'] : '';
		
		// check if the project already exists
		$results = $database->Query('SELECT project_id FROM ' . static::SchemaName() . '.' . static::TableName() . ' WHERE project_id = $1;', $project_id);
		$new_project = $results->RecordCount() == 0;
		
		// confirm write permission of the project
		if ($new_project == false) {
			$results = $database->Query('SELECT role, owner_id FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE project_id = $1 AND user_id = $2;', $project_id, $user->UserID());
			if ($results->RecordCount() == 0) {
				$reason = 'Access denied for project ' . $project_id . '.';
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
		if (isset($project['EncryptionKeys']) && is_array($project['EncryptionKeys']) && \BeaconCommon::IsAssoc($project['EncryptionKeys'])) {
			$encryption_keys = $project['EncryptionKeys'];
			$allowed_users = array_keys($encryption_keys);
			
			$desired_guests = array();
			$results = $database->Query('SELECT user_id FROM users WHERE user_id = ANY($1) AND user_id != $2;', '{' . implode(',', $allowed_users) . '}', $owner_id);
			while (!$results->EOF()) {
				$desired_guests[] = $results->Field('user_id');
				$results->MoveNext();
			}
			
			$current_guests = array();
			$results = $database->Query('SELECT user_id FROM ' . static::SchemaName() . '.' . static::GuestTableName() . ' WHERE project_id = $1;', $project_id);
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
		
		if (\BeaconCloudStorage::PutFile(self::GenerateCloudStoragePath($owner_id, $project_id), $contents) === false) {
			$reason = 'Unable to upload project to cloud storage platform.';
			return false;
		}
		
		try {
			$row_values = [
				'title' => $title,
				'description' => $description,
				'console_safe' => true,
				'game_specific' => json_encode($this->game_specific)
			];
			static::HookRowSaveData($project, $row_values);
			
			$placeholder = 3;
			$values = [$project_id, $owner_id];
			
			$database->BeginTransaction();
			if ($new_project) {
				$columns = ['project_id', 'user_id', 'last_update'];
				$placeholders = ['$1', '$2', 'CURRENT_TIMESTAMP'];
				foreach ($row_values as $column => $value) {
					$columns[] = $database->EscapeIdentifier($column);
					$values[] = $value;
					$placeholders[] = '$' . strval($placeholder);
					$placeholder++;
				}
				
				$database->Query('INSERT INTO ' . static::SchemaName() . '.' . static::TableName() . ' (' . implode(', ', $columns) . ') VALUES (' . implode(', ', $placeholders) . ');', $values);
			} else {
				$assignments = ['revision = revision + 1', 'last_update = CURRENT_TIMESTAMP', 'deleted = FALSE'];
				foreach ($row_values as $column => $value) {
					$assignments[] = $database->EscapeIdentifier($column) . ' = $' . strval($placeholder);
					$values[] = $value;
					$placeholder++;
				}
				
				$database->Query('UPDATE ' . static::SchemaName() . '.' . static::TableName() . ' SET ' . implode(', ', $assignments) . ' WHERE project_id = $1 AND user_id = $2;', $values);
			}
			foreach ($guests_to_add as $guest_id) {
				$database->Query('INSERT INTO ' . static::SchemaName() . '.' . static::GuestTableName() . ' (project_id, user_id) VALUES ($1, $2);', $project_id, $guest_id);
			}
			foreach ($guests_to_remove as $guest_id) {
				$database->Query('DELETE FROM ' . static::SchemaName() . '.' . static::GuestTableName() . ' WHERE project_id = $1 AND user_id = $2;', $project_id, $guest_id);
			}
			$database->Commit();
		} catch (\Exception $err) {
			$reason = 'Database error: ' . $err->getMessage();
			return false;
		}
		
		return true;
	}
	
	public function Versions(): array {
		$path = self::GenerateCloudStoragePath($this->OwnerID(), $this->DocumentID());
		$versions = \BeaconCloudStorage::VersionsForFile($path);
		if ($versions === false) {
			return [];
		}
		$api_path = $this->ResourceURL();
		$api_query = '';
		$pos = strpos($api_path, '?');
		if ($pos !== false) {
			$api_query = substr($api_path, $pos + 1);
			$api_path = substr($api_path, 0, $pos);
		}
		if ($api_query !== '') {
			$api_query = '?' . $api_query;
		}
		for ($idx = 0; $idx < count($versions); $idx++) {
			$url = $this->ResourceURL();
			$versions[$idx]['resource_url'] = $api_path . '/versions/' . urlencode($versions[$idx]['version_id']) . $api_query;
		}
		return $versions;
	}
}
	
?>