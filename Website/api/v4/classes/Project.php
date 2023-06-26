<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconRecordSet, BeaconSearch, BeaconUUID, DateTime, Exception, JsonSerializable, PharData;

abstract class Project extends DatabaseObject implements JsonSerializable {
	public const kPublishStatusPrivate = 'Private';
	public const kPublishStatusRequested = 'Requested';
	public const kPublishStatusApproved = 'Approved';
	public const kPublishStatusApprovedPrivate = 'Approved But Private';
	public const kPublishStatusDenied = 'Denied';
	
	protected string $projectId;
	protected string $gameId;
	protected array $gameSpecific;
	protected string $userId;
	protected string $ownerId;
	protected string $name;
	protected string $description;
	protected bool $consoleSafe;
	protected int $lastUpdate;
	protected int $revision;
	protected int $downloadCount;
	protected string $published;
	protected string $storagePath;
	protected array $content = [];
	
	protected function __construct(BeaconRecordSet $row) {
		$this->projectId = $row->Field('project_id');
		$this->gameId = $row->Field('game_id');
		$this->name = $row->Field('title');
		$this->description = $row->Field('description');
		$this->revision = intval($row->Field('revision'));
		$this->downloadCount = intval($row->Field('download_count'));
		$this->lastUpdate = round($row->Field('last_update'));
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
			new DatabaseObjectProperty('name', ['columnName' => 'title']),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('consoleSafe', ['columnName' => 'console_safe']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
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
		
		//header('Fetch: ' . $sql);
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
				$sort_column = $schema->Accessor('name');
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
		} else if (isset($filters['ownerId']) && empty($filters['ownerId']) === false) {
			$parameters->AddFromFilter($schema, $filters, 'ownerId');
		} else {
			$parameters->clauses[] = $schema->Accessor('userId') . ' = ' . $schema->Accessor('ownerId');
		}
		
		$parameters->AddFromFilter($schema, $filters, 'published');
		$parameters->AddFromFilter($schema, $filters, 'consoleSafe');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'name');
		
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
			'name' => $this->name,
			'description' => $this->description,
			'revision' => $this->revision,
			'downloadCount' => $this->downloadCount,
			'lastUpdate' => $this->lastUpdate,
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
	
	public function Name(): string {
		return $this->name;
	}
	
	// Deprecated
	public function Title(): string {
		return $this->name;
	}
	
	public function Description(): string {
		return $this->description;
	}
	
	public function ConsoleSafe(): bool {
		return $this->consoleSafe;
	}
	
	public function LastUpdate(): int {
		return $this->lastUpdate;
	}
	
	public function Revision(): int {
		return $this->revision;
	}
	
	public function DownloadCount(): int {
		return $this->downloadCount;
	}
	
	public function IncrementDownloadCount(bool $autosave = true): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("UPDATE public.projects SET download_count = download_count + 1 WHERE project_id = $1;", $this->projectId);
		$database->Commit();
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
					$attachment = [
						'title' => $this->name,
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
						'fields' => []
					];
					
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
	
	public static function IsBinaryProjectFormat(string $content): bool {
		return bin2hex(substr($content, 0, 8)) === '3029a1c4fab67728';
	}
	
	public function Content(bool $compressOutput = false, bool $parsed = true, $version_id = null): string|array {
		try {
			$content_key = $this->PreloadContent($version_id);
		} catch (Exception $err) {
			return '';
		}
		
		$content = $this->content[$content_key];
		$compressOutput = $compressOutput && ($parsed === false);
		if (static::IsBinaryProjectFormat($content)) {
			// v7+ project
			if ($parsed === true) {
				$archivePath = tempnam(sys_get_temp_dir(), $this->projectId . '.tar.gz');
				file_put_contents($archivePath, substr($content, 8));
				$archive = new PharData($archivePath);
				$manifest = json_decode($archive['Manifest.json']->getContent(), true);
				$version = $manifest['Version'];
				$content = $archive['v ' . $version . '.json']->getContent();
				$archive = null;
				unlink($archivePath);
			}
		} else {
			$isCompressed = BeaconCommon::IsCompressed($content);
			if ($isCompressed === true && $compressOutput === false) {
				$content = gzdecode($content);
			} elseif ($isCompressed === false && $compressOutput === true) {
				return gzencode($content);
			}
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
	
	public static function Save(User $user, array $manifest): ?static {
		$projectId = $manifest['ProjectId'] ?? '';
		if (BeaconUUID::Validate($projectId) === false) {
			throw new Exception('ProjectId should be a UUID.', 400);
		}
		
		$project = static::Fetch($projectId);
		$ownerId = $user->UserId();
		if (is_null($project) === false) {
			$ownerId = $project->OwnerId();
			if ($project->UserId() !== $user->UserId()) {
				throw new Exception('You are not authorized to write to this project.', 403);
			}
		}
		
		$projectName = $manifest['Name'] ?? '';
		$errorDetails['name'] = $projectName;
		if (empty($projectName)) {
			throw new Exception('Project name should not be empty.', 400);
		}
		
		$existingProjects = static::Search(['name' => $projectName, 'ownerId' => $ownerId], true);
		if (count($existingProjects) > 0) {
			$nameError = true;
			if (is_null($project) === false) {
				foreach ($existingProjects as $existingProject) {
					if ($existingProject->ProjectId() === $projectId) {
						$nameError = false;
						break;
					}
				}
			}
			if ($nameError) {
				throw new Exception('There is already a project with this name. Please choose another.', 400);
			}
		}
		
		$now = new DateTime();
		$description = $manifest['Description'] ?? '';
		$gameId = $manifest['GameId'] ?? '';
		$columns = [
			'title' => $projectName,
			'description' => $description,
			'console_safe' => $manifest['IsConsole'] ?? false,
			'game_specific' => [],
			'deleted' => false,
			'last_update' => $now->format('Y-m-d H:i:s.uO')
		];
		if (is_null($project)) {
			$columns['project_id'] = $projectId;
			$columns['game_id'] = $gameId;
			$columns['user_id'] = $ownerId;
			$columns['storage_path'] = '/Projects/' . $projectId . '.beacon';
			$columns['revision'] = 1;
		} else {
			$columns['revision'] = $project->Revision() + 1;
		}
		
		switch ($gameId) {
		case 'Ark':
			$columns['game_specific']['map'] = $manifest['Map'] ?? 1;
			$columns['game_specific']['difficulty'] = $manifest['Difficulty'] ?? 4.0;
			$columns['game_specific']['include_editors'] = $manifest['Editors'] ?? [];
			
			$mods = $manifest['ModSelections'] ?? [];
			$enabledModIds = [];
			foreach ($mods as $modId => $enabled) {
				if ($enabled === false) {
					continue;
				}
				
				$enabledModIds[] = $modId;
				if ($columns['console_safe'] !== true) {
					continue;
				}
				
				$mod = Ark\ContentPack::Fetch($modId);
				if (is_null($mod) || $mod->ConsoleSafe() === true) {
					continue;
				}
				
				$columns['console_safe'] = false;
			}
			
			break;
		default:
			throw new Exception('Unknown game ' . $gameId . '.', 400);
		}
		
		$columns['game_specific'] = json_encode($columns['game_specific']);
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		if (is_null($project)) {
			$database->Insert('public.projects', $columns);
		} else {
			$database->Update('public.projects', $columns, ['project_id' => $projectId]);
		}
		$database->Commit();
		
		return static::Fetch($projectId);
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
