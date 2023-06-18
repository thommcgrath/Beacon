<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconRecordSet, BeaconSearch, DateTime, Exception, JsonSerializable;

abstract class Project extends DatabaseObject implements JsonSerializable {
	public const kPublishStatusPrivate = 'Private';
	public const kPublishStatusRequested = 'Requested';
	public const kPublishStatusApproved = 'Approved';
	public const kPublishStatusApprovedPrivate = 'Approved But Private';
	public const kPublishStatusDenied = 'Denied';
	
	protected $projectId = '';
	protected $gameId = '';
	protected $gameSpecific = [];
	protected $userId = '';
	protected $ownerId = '';
	protected $title = '';
	protected $description = '';
	protected $consoleSafe = true;
	protected $lastUpdate = null;
	protected $revision = 1;
	protected $downloadCount = 0;
	protected $published = self::kPublishStatusPrivate;
	protected $content = [];
	protected $storagePath = null;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->projectId = $row->Field('project_id');
		$this->gameId = $row->Field('game_id');
		$this->title = $row->Field('title');
		$this->description = $row->Field('description');
		$this->revision = intval($row->Field('revision'));
		$this->downloadCount = intval($row->Field('download_count'));
		$this->lastUpdate = new DateTime($row->Field('last_update'));
		$this->userId = $row->Field('user_id');
		$this->ownerId = $row->Field('owner_id');
		$this->published = $row->Field('published');
		$this->consoleSafe = boolval($row->Field('console_safe'));
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
		$this->storagePath = $row->Field('storage_path');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = new DatabaseSchema('public', 'allowed_projects', [
			new DatabaseObjectProperty('projectId', ['primaryKey' => true, 'columnName' => 'project_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('ownerId', ['columnName' => 'owner_id']),
			new DatabaseObjectProperty('title'),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('consoleSafe', ['columnName' => 'console_safe']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update']),
			new DatabaseObjectProperty('revision'),
			new DatabaseObjectProperty('downloadCount', ['columnName' => 'download_count']),
			new DatabaseObjectProperty('published'),
			new DatabaseObjectProperty('storagePath', ['columnName' => 'storage_path'])
		]);
		$schema->SetWriteableTable('projects');
		return $schema;
	}
	
	protected static function NewInstance(BeaconRecordSet $rows): Project {
		$gameId = $rows->Field('game_id');
		switch ($gameId) {
		case 'Ark':
			return new Ark\Project($rows);
			break;
		default:
			throw new Exception('Unknown game ' . $gameId);
		}
	}
	
	public static function Fetch(string $uuid): ?static {
		$schema = static::DatabaseSchema();
		$userId = Core::UserId();
		$database = BeaconCommon::Database();
			
		$sql = 'SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1');
		$values = [$uuid];
		if (is_null($userId) === false) {
			$sql .= ' AND ' . $schema->Accessor('userId') . ' = ' . $schema->Setter('userId', '$2') . ';';
			$values[] = $userId;
		} else {
			$sql .= ' AND ' . $schema->Accessor('userId') . ' = ' . $schema->Accessor('ownerId') . ';';
		}
		
		header('Fetch: ' . $sql);
		$rows = $database->Query($sql, $values);
		if (is_null($rows) || $rows->RecordCount() !== 1) {
			return null;
		}
		return static::NewInstance($rows);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$table = $schema->Table();
		
		$sort_column = $schema->Accessor('lastUpdate');
		$sort_direction = 'DESC';
		if (isset($filters['sort'])) {
			switch ($filters['sort']) {
			case 'download_count':
			case 'downloadCount':
				$sort_column = $schema->Accessor('downloadCount');
				break;
			case 'name':
				$sort_column = $schema->Accessor('title');
				break;
			case 'console_safe':
			case 'consoleSafe':
				$sort_column = $schema->Accessor('consoleSafe');
				break;
			case 'description':
				$sort_column = $schema->Accessor('description');
				break;
			}
		}
		if (isset($filters['direction'])) {
			$sort_direction = (strtolower($filters['direction']) === 'desc' ? 'DESC' : 'ASC');
		}
		$parameters->orderBy = "{$sort_column} {$sort_direction}";
		
		if (isset($filters['userId']) && empty($filters['userId']) === false) {
			$parameters->AddFromFilter($schema, $filters, 'userId');
		} else {
			$parameters->clauses[] = $schema->Accessor('userId') . ' = ' . $schema->Accessor('ownerId');
		}
		
		$parameters->AddFromFilter($schema, $filters, 'published');
		$parameters->AddFromFilter($schema, $filters, 'consoleSafe');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		
		if (isset($filters['search']) && empty($filters['search']) === false) {
			$search = new BeaconSearch();
			$results = $search->Search($filters['search'], null, 100, 'Document');
			if (count($results) > 0) {
				$ids = [];
				foreach ($results as $result) {
					$ids[] = $result['objectID'];
				}
				$parameters->clauses[] = $schema->Comparison('projectId', '=', 'ANY(' . $parameters->placeholder++ . ')');
				$parameters->values[] = '{' . implode(',', $ids) . '}';
			} else {
				$parameters->clauses[] = $schema->Comparison('projectId', '=', "'00000000-0000-0000-0000-000000000000'");
			}
		}
	}
	
	public function jsonSerialize(): mixed {
		return [
			'projectId' => $this->projectId,
			'gameId' => $this->gameId,
			'userId' => $this->userId,
			'ownerId' => $this->ownerId,
			'name' => $this->title,
			'description' => $this->description,
			'revision' => $this->revision,
			'downloadCount' => $this->downloadCount,
			'lastUpdated' => $this->lastUpdate->format('Y-m-d H:i:sO'),
			'consoleSafe' => $this->consoleSafe,
			'published' => $this->published
		];
	}
		
	public function ProjectId(): string {
		return $this->projectId;
	}
	
	public function GameId(): string {
		return $this->gameId;
	}
	
	public function GameURLComponent(): string {
		switch ($this->gameId) {
		case 'Ark':
			return 'ark';
		}
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function OwnerId(): string {
		return $this->ownerId;
	}
	
	public function Title(): string {
		return $this->title;
	}
	
	public function Description(): string {
		return $this->description;
	}
	
	public function ConsoleSafe(): bool {
		return $this->consoleSafe;
	}
	
	public function LastUpdated(): DateTime {
		return $this->lastUpdate;
	}
	
	public function Revision(): int {
		return $this->revision;
	}
	
	public function DownloadCount(): int {
		return $this->downloadCount;
	}
	
	public function IncrementDownloadCount(bool $autosave = true): void {
		$this->SetProperty('download_count', $this->downloadCount + 1);
		if ($autosave) {
			$this->Save();
		}
	}
	
	public function IsPublic(): bool {
		return $this->published == self::kPublishStatusApproved;
	}
	
	public function PublishStatus(): string {
		return $this->published;
	}
	
	public function SetPublishStatus(string $desired_status): void {
		$database = BeaconCommon::Database();
		$schema = static::DatabaseSchema();
		
		$results = $database->Query('SELECT published FROM ' . $schema->Table() . ' WHERE project_id = $1;', $this->projectId);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($desired_status == self::kPublishStatusRequested || $desired_status == self::kPublishStatusApproved) {
			if ($current_status == self::kPublishStatusApprovedPrivate) {
				$new_status = self::kPublishStatusApproved;
			} elseif ($current_status == self::kPublishStatusPrivate) {
				if (empty(trim($this->description))) {
					$new_status = self::kPublishStatusDenied;
				} else {
					$new_status = self::kPublishStatusRequested;
					$attachment = array(
						'title' => $this->title,
						'text' => $this->description,
						'fallback' => 'Unable to show response buttons.',
						'callback_id' => 'publish_document:' . $this->projectId,
						'actions' => [
							[
								'name' => 'status',
								'text' => 'Approve',
								'type' => 'button',
								'value' => self::kPublishStatusApproved,
								'confirm' => [
									'text' => 'Are you sure you want to approve this project?',
									'ok_text' => 'Approve'
								]
							],
							[
								'name' => 'status',
								'text' => 'Deny',
								'type' => 'button',
								'value' => self::kPublishStatusDenied,
								'confirm' => [
									'text' => 'Are you sure you want to reject this project?',
									'ok_text' => 'Deny'
								]
							]
						],
						'fields' => array()
					);
					
					$user = User::Fetch($this->userId);
					if (is_null($user) === false) {
						if ($user->IsAnonymous()) {
							$username = 'Anonymous';
						} else {
							$username = $user->Username() . '#' . $user->Suffix();
						}
						$attachment['fields'][] = [
							'title' => 'Author',
							'value' => $username
						];
					}
					
					$obj = [
						'text' => 'Request to publish project',
						'attachments' => array($attachment)
					];
					BeaconCommon::PostSlackRaw(json_encode($obj));
				}
			}
		} else {
			if ($current_status == self::kPublishStatusApproved) {
				$new_status = self::kPublishStatusApprovedPrivate;
			} elseif ($current_status == self::kPublishStatusRequested) {
				$new_status = self::kPublishStatusPrivate;
			}
		}
		if ($new_status != $current_status) {
			$database->BeginTransaction();
			$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET published = $2 WHERE project_id = $1;', $this->projectId, $new_status);
			$database->Commit();
		}
		$this->published = $new_status;
	}
	
	public function PreloadContent($version_id = null): string {
		$content_key = (is_null($version_id) === true ? '' : $version_id);
		if (array_key_exists($content_key, $this->content) === true) {
			return $content_key;
		}
		
		$this->content[$content_key] = BeaconCloudStorage::GetFile($this->CloudStoragePath(), true, $version_id);
		return $content_key;
	}	
	
	public function Content(bool $compressed = false, bool $parsed = true, $version_id = null): string|array {
		try {
			$content_key = $this->PreloadContent($version_id);
		} catch (Exception $err) {
			return '';
		}
		
		$content = $this->content[$content_key];
		$compressed = $compressed && ($parsed == false);
		$is_compressed = BeaconCommon::IsCompressed($content);
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
	
	public function CloudStoragePath(): string {
		if (is_null($this->storagePath)) {
			$this->storagePath = '/Projects/' . strtolower($projectId) . '.beacon';
		}
		return $this->storagePath;
	}
	
	public static function SaveFromMultipart(User $user, string &$reason): bool {
		$required_vars = ['keys', 'title', 'uuid', 'version'];
		if (static::ValidateMultipart($required_vars, $reason) === false) {
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
		
		if (BeaconCommon::IsCompressed($_FILES['contents']['tmp_name'], true) === false) {
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
			if (BeaconCommon::IsUUID($key) === false) {
				$reason = 'Key `' . $key . '` is not a v4 UUID.';
				return false;
			}
			$value = substr($member, $pos + 1);
			$keys[$key] = $value;
		}
		$project['EncryptionKeys'] = $keys;
		
		if (static::MultipartAddProjectValues($project, $reason) === false) {
			return false;
		}
		
		return self::SaveFromArray($project, $user, $_FILES['contents'], $reason);
	}
	
	protected static function ValidateMultipart(array &$required_vars, string &$reason): bool {
		return true;
	}
	
	protected static function MultipartAddProjectValues(array &$project, string &$reason): bool {
		return true;
	}
	
	protected static function AddColumnValues(array $project, array &$row_values): bool {
		return true;
	}
	
	protected static function SaveFromArray(array $project, User $user, $contents, string &$reason): bool {
		$project_version = filter_var($project['Version'], FILTER_VALIDATE_INT);
		if ($project_version === false || $project_version < 2) {
			$reason = 'Version 1 projects are no longer not accepted.';
			return false;
		}
		
		$schema = static::DatabaseSchema();
		
		$database = BeaconCommon::Database();
		$projectId = $project['Identifier'];
		if (BeaconCommon::IsUUID($projectId) === false) {
			$reason = 'Project identifier is not a v4 UUID.';
			return false;
		}
		$title = isset($project['Title']) ? $project['Title'] : '';
		$description = isset($project['Description']) ? $project['Description'] : '';
		$gameId = isset($project['GameID']) ? $project['GameID'] : 'Ark';
		
		// check if the project already exists
		$results = $database->Query('SELECT project_id, storage_path FROM ' . $schema->Table() . ' WHERE project_id = $1;', $projectId);
		$new_project = $results->RecordCount() == 0;
		$storagePath = null;
		
		// confirm write permission of the project
		if ($new_project == false) {
			$storagePath = $results->Field('storage_path');
			
			$results = $database->Query('SELECT role, owner_id FROM ' . $schema->Table() . ' WHERE project_id = $1 AND user_id = $2;', $projectId, $user->UserId());
			if ($results->RecordCount() == 0) {
				$reason = 'Access denied for project ' . $projectId . '.';
				return false;
			}
			$role = $results->Field('role');
			$ownerId = $results->Field('owner_id');
		} else {
			$storagePath = static::CloudStoragePath($projectId);
			$role = 'Owner';
			$ownerId = $user->UserId();
		}
		
		if (BeaconCloudStorage::PutFile($storagePath, $contents) === false) {
			$reason = 'Unable to upload project to cloud storage platform.';
			return false;
		}
		
		try {
			$row_values = [
				'title' => $title,
				'description' => $description,
				'console_safe' => true,
				'game_specific' => '{}',
				'game_id' => $gameId
			];
			static::AddColumnValues($project, $row_values);
			
			$placeholder = 3;
			$values = [$projectId, $ownerId];
			
			$database->BeginTransaction();
			if ($new_project) {
				$columns = ['project_id', 'user_id', 'last_update', 'storage_path'];
				$values[] = $storagePath;
				$placeholders = ['$1', '$2', 'CURRENT_TIMESTAMP', '$3'];
				$placeholder++;
				foreach ($row_values as $column => $value) {
					$columns[] = $database->EscapeIdentifier($column);
					$values[] = $value;
					$placeholders[] = '$' . strval($placeholder);
					$placeholder++;
				}
				
				$database->Query('INSERT INTO ' . $schema->Table() . ' (' . implode(', ', $columns) . ') VALUES (' . implode(', ', $placeholders) . ');', $values);
			} else {
				$assignments = ['revision = revision + 1', 'last_update = CURRENT_TIMESTAMP', 'deleted = FALSE'];
				foreach ($row_values as $column => $value) {
					$assignments[] = $database->EscapeIdentifier($column) . ' = $' . strval($placeholder);
					$values[] = $value;
					$placeholder++;
				}
				
				$database->Query('UPDATE ' . $schema->Table() . ' SET ' . implode(', ', $assignments) . ' WHERE project_id = $1 AND user_id = $2;', $values);
			}
			$database->Commit();
		} catch (Exception $err) {
			$reason = 'Database error: ' . $err->getMessage();
			return false;
		}
		
		return true;
	}
	
	public function Versions(): array {
		$versions = BeaconCloudStorage::VersionsForFile($this->storagePath);
		if ($versions === false) {
			return [];
		}
		$url = Core::URL('projects/' . urlencode($this->projectId));
		for ($idx = 0; $idx < count($versions); $idx++) {
			$version = $versions[$idx];
			$versions[$idx] = [
				'latest' => $version['latest'],
				'versionId' => $version['version_id'],
				'date' => $version['date'],
				'size' => $version['size']
			];
		}
		return $versions;
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		if ($this->userId === $this->ownerId) {
			// Project owner. If there are other users, pick one to transfer ownership to.
			$rows = $database->Query('SELECT user_id FROM public.guest_projects WHERE project_id = $1;', $this->projectId);
			if ($rows->RecordCount() > 0) {
				$new_owner_id = $rows->Field('user_id');
				$database->BeginTransaction();
				$database->Query('UPDATE public.projects SET user_id = $2 WHERE project_id = $1;', $this->projectId, $new_owner_id);
				$database->Query('DELETE FROM public.guest_projects WHERE project_id = $1 AND user_id = $2;', $this->projectId, $new_owner_id);
				$database->Commit();
			} else {
				$database->BeginTransaction();
				$database->Query('UPDATE public.projects SET deleted = TRUE WHERE project_id = $1;', $this->projectId);
				$database->Commit();	
			}
		} else {
			// Project guest. Remove the user.
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.guest_projects WHERE project_id = $1 AND user_id = $2;', $this->projectId, $this->userId);
			$database->Commit();
		}
	}
}
	
?>
