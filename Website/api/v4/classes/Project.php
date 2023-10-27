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
	protected string $role;
	protected int $permissions;
	protected ?string $encryptedPassword;
	protected ?string $fingerprint;
	protected string $name;
	protected string $description;
	protected bool $consoleSafe;
	protected int $lastUpdate;
	protected int $revision;
	protected int $downloadCount;
	protected string $communityStatus;
	protected string $storagePath;
	protected bool $deleted;
	protected array $content = [];

	protected function __construct(BeaconRecordSet $row) {
		$this->projectId = $row->Field('project_id');
		$this->gameId = $row->Field('game_id');
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
		$this->userId = $row->Field('user_id');
		$this->role = $row->Field('role');
		$this->permissions = $row->Field('permissions');
		$this->encryptedPassword = $row->Field('encrypted_password');
		$this->fingerprint = $row->Field('fingerprint');
		$this->name = $row->Field('title');
		$this->description = $row->Field('description');
		$this->consoleSafe = boolval($row->Field('console_safe'));
		$this->lastUpdate = round($row->Field('last_update'));
		$this->revision = intval($row->Field('revision'));
		$this->downloadCount = intval($row->Field('download_count'));
		$this->communityStatus = $row->Field('published');
		$this->storagePath = $row->Field('storage_path');
		$this->deleted = $row->Field('deleted');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = new DatabaseSchema('public', 'projects', [
			new DatabaseObjectProperty('projectId', ['primaryKey' => true, 'columnName' => 'project_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'accessor' => 'project_members.user_id']),
			new DatabaseObjectProperty('role', ['accessor' => 'project_members.role']),
			new DatabaseObjectProperty('permissions', ['accessor' => 'public.project_role_permissions(project_members.role)']),
			new DatabaseObjectProperty('encryptedPassword', ['columnName' => 'encrypted_password', 'accessor' => 'project_members.encrypted_password']),
			new DatabaseObjectProperty('fingerprint', ['accessor' => 'project_members.fingerprint']),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific']),
			new DatabaseObjectProperty('name', ['columnName' => 'title']),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('consoleSafe', ['columnName' => 'console_safe']),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('revision'),
			new DatabaseObjectProperty('downloadCount', ['columnName' => 'download_count']),
			new DatabaseObjectProperty('communityStatus', ['columnName' => 'published']),
			new DatabaseObjectProperty('storagePath', ['columnName' => 'storage_path']),
			new DatabaseObjectProperty('deleted'),
		], [
			'INNER JOIN public.project_members ON (project_members.project_id = projects.project_id)'
		]);
		return $schema;
	}

	protected static function NewInstance(BeaconRecordSet $rows): Project {
		$gameId = $rows->Field('game_id');
		switch ($gameId) {
		case 'Ark':
			return new Ark\Project($rows);
			break;
		case '7DaysToDie':
			return new SDTD\Project($rows);
			break;
		case 'ArkSA':
			return new ArkSA\Project($rows);
			break;
		default:
			throw new Exception('Unknown game ' . $gameId);
		}
	}

	public static function Fetch(string $uuid): ?static {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();

		$sql = 'SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ' AND ' . $schema->Accessor('role') . ' = ' . $schema->Setter('role', '$2');
		$values = [$uuid, 'Owner'];

		//header('Fetch: ' . $sql);
		$rows = $database->Query($sql, $values);
		if (is_null($rows) || $rows->RecordCount() !== 1) {
			return null;
		}
		return static::NewInstance($rows);
	}

	public static function FetchForUser(string $projectId, User|string $userId): ?static {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();

		if (!is_string($userId)) {
			$userId = $userId->UserId();
		}

		$sql = 'SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ' AND ' . $schema->Accessor('userId') . ' = ' . $schema->Setter('userId', '$2');
		$values = [$projectId, $userId];
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
		} else {
			$parameters->clauses[] = $schema->Accessor('role') . " = 'Owner'";
		}

		$parameters->AddFromFilter($schema, $filters, 'communityStatus');
		$parameters->AddFromFilter($schema, $filters, 'consoleSafe');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'name');
		$parameters->AddFromFilter($schema, $filters, 'role');

		$deleted = $filters['deleted'] ?? $filters['isDeleted'] ?? false;
		if (is_null($deleted) === false) {
			$parameters->clauses[] = $schema->Comparison('deleted', '=', $parameters->placeholder++);
			$parameters->values[] = filter_var($deleted, FILTER_VALIDATE_BOOLEAN);
		}

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

		$namespaces = ['Ark' => 'Ark', 'SDTD' => '7DaysToDie'];
		$namespaceClauses = [];
		foreach ($namespaces as $namespace => $identifier) {
			$namespacedParameters = new DatabaseSearchParameters();
			$namespacedParameters->placeholder = $parameters->placeholder;
			$namespacedProject = "\\BeaconAPI\\v4\\{$namespace}\\Project";
			$namespacedProject::ExtendSearchParameters($namespacedParameters, $filters, true);
			if (count($namespacedParameters->clauses) > 0) {
				$namespaceClauses[] = "(game_id = '{$identifier}' AND " . implode(' AND ', $namespacedParameters->clauses) . ')';
				$parameters->values = array_merge($parameters->values, $namespacedParameters->values);
				$parameters->placeholder = $namespacedParameters->placeholder;
			}
		}
		if (count($namespaceClauses) > 0) {
			$parameters->clauses[] = '(' . implode(' OR ', $namespaceClauses) . ')';
		}
	}

	protected static function ExtendSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		//
	}

	public function jsonSerialize(): mixed {
		return [
			'projectId' => $this->projectId,
			'gameId' => $this->gameId,
			'userId' => $this->userId,
			'role' => $this->role,
			'name' => $this->name,
			'description' => $this->description,
			'revision' => $this->revision,
			'downloadCount' => $this->downloadCount,
			'lastUpdate' => $this->lastUpdate,
			'consoleSafe' => $this->consoleSafe,
			'communityStatus' => $this->communityStatus,
			'isDeleted' => $this->deleted,
		];
	}

	public function ProjectId(): string {
		return $this->projectId;
	}

	public function PusherChannelName(): string {
		return 'project-' . strtolower(str_replace('-', '', $this->projectId));
	}

	public function GameId(): string {
		return $this->gameId;
	}

	public function GameURLComponent(): string {
		switch ($this->gameId) {
		case 'Ark':
			return 'ark';
		case '7DaysToDie':
			return '7dtd';
		}
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Role(): string {
		return $this->role;
	}

	public function Permissions(): int {
		return $this->permissions;
	}

	public function EncryptedPassword(): ?string {
		return $this->encryptedPassword;
	}

	public function Fingerprint(): ?string {
		return $this->fingerprint;
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
		return $this->communityStatus == self::kPublishStatusApproved;
	}

	public function PublishStatus(): string {
		return $this->communityStatus;
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
		$this->communityStatus = $new_status;
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
				$version = $manifest['version'];
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

	public function IsDeleted(): bool {
		return $this->deleted;
	}

	public static function Save(User $user, array $manifest): ?static {
		$projectId = $manifest['projectId'] ?? '';
		if (BeaconUUID::Validate($projectId) === false) {
			throw new Exception('ProjectId should be a UUID.', 400);
		}

		$newMemberList = $manifest['members'];

		$database = BeaconCommon::Database();
		$project = static::FetchForUser($projectId, $user->UserId());
		$members = [];
		if (is_null($project) === false) {
			if ($project->Permissions() <= 10) {
				throw new Exception('You are not authorized to write to this project.', 403);
			}

			// Only accept users who are already in the member list
			$rows = $database->Query('SELECT user_id, role, fingerprint FROM project_members WHERE project_id = $1;', $projectId);
			while (!$rows->EOF()) {
				$userId = $rows->Field('user_id');
				$fingerprint = $rows->Field('fingerprint');
				$role = $rows->Field('role');

				if (array_key_exists($userId, $newMemberList)) {
					$member = $newMemberList[$userId];
					if (BeaconCommon::HasAllKeys($member, 'role', 'encryptedPassword', 'fingerprint') === false) {
						throw new Exception('Member ' . $userId . ' must have keys role, encryptedPassword, and fingerprint.', 400);
					}

					if ($role !== $member['role'] || $fingerprint !== $member['fingerprint']) {
						$members[] = [
							'userId' => $userId,
							'role' => $member['role'],
							'encryptedPassword' => $member['encryptedPassword'],
							'fingerprint' => $member['fingerprint'],
						];
					}
				}

				$rows->MoveNext();
			}
		} else {
			if (array_key_exists($user->UserId(), $newMemberList) === false) {
				throw new Exception('Member list must contain an entry for user ' . $user->UserId(), 400);
			}

			// Only accept the owner
			$member = $newMemberList[$user->UserId()];
			if (BeaconCommon::HasAllKeys($member, 'encryptedPassword', 'fingerprint') === false) {
				throw new Exception('Member ' . $userId . ' must have keys encryptedPassword, and fingerprint.', 400);
			}
			$members[] = [
				'userId' => $user->UserId(),
				'role' => 'Owner',
				'encryptedPassword' => $member['encryptedPassword'],
				'fingerprint' => $member['fingerprint'],
			];
		}

		$projectName = $manifest['name'] ?? '';
		$errorDetails['name'] = $projectName;
		if (empty($projectName)) {
			throw new Exception('Project name should not be empty.', 400);
		}

		$projectOwnerId = $user->UserId();
		if (is_null($project) === false && $project->Role() !== 'Owner') {
			$ownerProject = static::Fetch($projectId);
			$projectOwnerId = $ownerProject->UserId();
		}

		$existingProjects = static::Search(['name' => $projectName, 'userId' => $projectOwnerId, 'role' => 'Owner'], true);
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
		$description = $manifest['description'] ?? '';
		$gameId = $manifest['gameId'] ?? '';
		$columns = [
			'game_id' => $gameId,
			'title' => $projectName,
			'description' => $description,
			'console_safe' => $manifest['isConsole'] ?? false,
			'game_specific' => [],
			'deleted' => false,
			'last_update' => $now->format('Y-m-d H:i:s.uO')
		];
		if (is_null($project)) {
			$columns['project_id'] = $projectId;
			$columns['storage_path'] = '/Projects/' . $projectId . '.beacon';
			$columns['revision'] = 1;
		} else {
			$columns['revision'] = $project->Revision() + 1;
		}

		switch ($gameId) {
		case 'Ark':
		case 'ArkSA':
			$columns['game_specific']['map'] = $manifest['map'] ?? 1;
			$columns['game_specific']['difficulty'] = $manifest['difficulty'] ?? 4.0;
			$columns['game_specific']['included_editors'] = $manifest['editors'] ?? [];

			$mods = $manifest['modSelections'] ?? [];
			$enabledModIds = [];
			foreach ($mods as $modId => $enabled) {
				if ($enabled === false) {
					continue;
				}

				$enabledModIds[] = $modId;
				if ($columns['console_safe'] !== true) {
					continue;
				}

				$mod = ContentPack::Fetch($modId);
				if (is_null($mod) || $mod->IsConsoleSafe() === true) {
					continue;
				}

				$columns['console_safe'] = false;
			}

			break;
		case '7DaysToDie':
			break;
		default:
			throw new Exception('Unknown game ' . $gameId . '.', 400);
		}

		$columns['game_specific'] = json_encode($columns['game_specific']);
		$database->BeginTransaction();
		if (is_null($project)) {
			$database->Insert('public.projects', $columns);
		} else {
			$database->Update('public.projects', $columns, ['project_id' => $projectId]);
		}
		foreach ($members as $member) {
			$database->Query('INSERT INTO public.project_members (project_id, user_id, role, encrypted_password, fingerprint) VALUES ($1, $2, $3, $4, $5) ON CONFLICT (project_id, user_id) DO UPDATE SET role = EXCLUDED.role, encrypted_password = EXCLUDED.encrypted_password, fingerprint = EXCLUDED.fingerprint;', $projectId, $member['userId'], $member['role'], $member['encryptedPassword'], $member['fingerprint']);
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
		if ($this->role === 'Owner') {
			$rows = $database->Query('SELECT user_id FROM public.project_members WHERE project_id = $1 AND user_id != $2 ORDER BY public.project_role_permissions(role) DESC LIMIT 1;', $this->projectId, $this->userId);
			if ($rows->RecordCount() === 1) {
				// Move ownership
				$newUserId = $rows->Field('user_id');
				$database->BeginTransaction();
				$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $this->projectId, $this->userId);
				$database->Query('UPDATE public.project_members SET role = $3 WHERE project_id = $1 AND user_id = $2;', $this->projectId, $newUserId, 'Owner');
				$database->Commit();
			} else {
				// The project has no other members, so delete it. Do no remove the project member row in case it has to be restored.
				$database->BeginTransaction();
				$database->Query('UPDATE public.projects SET deleted = TRUE WHERE project_id = $1;', $this->projectId);
				$database->Commit();
			}
		} else {
			// Remove the user from the project
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $this->projectId, $this->userId);
			$database->Commit();
		}
	}
}

?>
