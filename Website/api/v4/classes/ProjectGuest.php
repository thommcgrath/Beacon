<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ProjectGuest implements JsonSerializable {
	protected string $projectId = '';
	protected string $userId = '';
	protected string $userPublicKey = '';
	protected string $username = '';
	
	protected function __construct(BeaconRecordSet $row) {
		$this->projectId = $row->Field('project_id');
		$this->userId = $row->Field('user_id');
		$this->userPublicKey = $row->Field('public_key');
		$this->username = $row->Field('username');
	}
	
	public static function Create(string $projectId, string $userId): ?static {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('INSERT INTO public.guest_projects (project_id, user_id) VALUES ($1, $2) ON CONFLICT (project_id, user_id) DO NOTHING RETURNING project_id, user_id;', $projectId, $userId);
		$database->Commit();
		return static::Fetch($projectId, $userId);
	}
	
	// This is a weird function
	public static function Fetch(string $projectId, string $userId): ?static {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT guest_projects.project_id, users.user_id, users.public_key, users.username FROM public.guest_projects INNER JOIN public.users ON (guest_projects.user_id = users.user_id) WHERE guest_projects.project_id = $1 AND guest_projects.user_id = $2;', $projectId, $userId);
		if ($rows->RecordCount() === 0) {
			return null;
		}
		return new static($rows);
	}
	
	public static function List(string $projectId): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT guest_projects.project_id, users.user_id, users.public_key, users.username FROM public.guest_projects INNER JOIN public.users ON (guest_projects.user_id = users.user_id) WHERE guest_projects.project_id = $1 ORDER BY users.username;', $projectId);
		$guests = [];
		while (!$rows->EOF()) {
			$guests[] = new static($rows);
			$rows->MoveNext();
		}
		return $guests;
	}
	
	public function ProjectId(): string {
		return $this->projectId;
	}
	
	public function Project(): Project {
		return Project::Fetch($this->projectId);
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function User(): User {
		return User::Fetch($this->userId);
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.guest_projects WHERE project_id = $1 AND user_id = $2;', $this->projectId, $this->userId);
		$database->Commit();
	}
	
	public function jsonSerialize(): mixed {
		return [
			'userId' => $this->userId,
			'publicKey' => $this->userPublicKey,
			'username' => $this->username,
			'usernameFull' => $this->username . '#' . substr($this->userId, 0, 8)
		];
	}
}

?>
