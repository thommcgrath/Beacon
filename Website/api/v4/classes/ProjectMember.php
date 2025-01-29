<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ProjectMember implements JsonSerializable {
	public const kRoleOwner = 'Owner';
	public const kRoleAdmin = 'Admin';
	public const kRoleEditor = 'Editor';
	public const kRoleGuest = 'Guest';

	public const kPermissionsOwner = 90;
	public const kPermissionsAdmin = 80;
	public const kPermissionsEditor = 70;
	public const kPermissionsGuest = 10;

	protected string $projectId;
	protected string $userId;
	protected string $username;
	protected string $publicKey;
	protected string $role;
	protected int $permissions;
	protected ?string $encryptedPassword;
	protected ?string $fingerprint;

	protected function __construct(BeaconRecordSet $row) {
		$this->projectId = $row->Field('project_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username') ?? 'Anonymous';
		$this->publicKey = $row->Field('public_key');
		$this->role = $row->Field('role');
		$this->permissions = $row->Field('permissions');
		$this->encryptedPassword = $row->Field('encrypted_password');
		$this->fingerprint = $row->Field('fingerprint');
	}

	public static function Create(string $projectId, string $userId, string $role, ?string $encryptedPassword, ?string $fingerprint): ?static {
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$rows = $database->Query('INSERT INTO public.project_members (project_id, user_id, role, encrypted_password, fingerprint) VALUES ($1, $2, $3, $4, $5) ON CONFLICT (project_id, user_id) DO UPDATE SET role = EXCLUDED.role, encrypted_password = EXCLUDED.encrypted_password, fingerprint = EXCLUDED.fingerprint;', $projectId, $userId, $role, $encryptedPassword, $fingerprint);
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			return null;
		}
		return static::Fetch($projectId, $userId);
	}

	public static function Fetch(string $projectId, string $userId): ?static {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT project_members.project_id, project_members.role, public.project_role_permissions(project_members.role) AS permissions, project_members.encrypted_password, project_members.fingerprint, users.user_id, users.public_key, users.username FROM public.project_members INNER JOIN public.users ON (project_members.user_id = users.user_id) WHERE project_members.project_id = $1 AND project_members.user_id = $2;', $projectId, $userId);
		if ($rows->RecordCount() === 0) {
			return null;
		}
		return new static($rows);
	}

	public static function List(string $projectId): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT project_members.project_id, project_members.role, public.project_role_permissions(project_members.role) AS permissions, project_members.encrypted_password, project_members.fingerprint, users.user_id, users.public_key, users.username FROM public.project_members INNER JOIN public.users ON (project_members.user_id = users.user_id) WHERE project_members.project_id = $1 ORDER BY users.username;', $projectId);
		$guests = [];
		while (!$rows->EOF()) {
			$guests[] = new static($rows);
			$rows->MoveNext();
		}
		return $guests;
	}

	public function Delete(): bool {
		try {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $this->projectId, $this->userId);
			$database->Commit();
			return true;
		} catch (Exception $err) {
			$database->Rollback();
			return false;
		}
	}

	public function ProjectId(): string {
		return $this->projectId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Username(): string {
		return $this->username;
	}

	public function PublicKey(): string {
		return $this->publicKey;
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

	public function IsOwner(): bool {
		return $this->permissions >= self::kPermissionsOwner;
	}

	public function IsAdmin(): bool {
		return $this->permissions >= self::kPermissionsAdmin;
	}

	public function IsEditor(): bool {
		return $this->permissions >= self::kPermissionsEditor;
	}

	public function jsonSerialize(): mixed {
		return [
			'projectId' => $this->projectId,
			'userId' => $this->userId,
			'username' => $this->username,
			'publicKey' => $this->publicKey,
			'role' => $this->role,
			'permissions' => $this->permissions,
			'encryptedPassword' => $this->encryptedPassword,
			'fingerprint' => $this->fingerprint,
		];
	}

	public static function GenerateFingerprint(string $userId, string $username, string $publicKey, string $password): string {
		$userId = hex2bin(str_replace('-', '', $userId));
		if (str_starts_with($publicKey, '-----BEGIN PUBLIC KEY-----')) {
			$lines = explode("\n", trim($publicKey));
			array_pop($lines);
			array_shift($lines);
			$publicKey = base64_decode(implode('', $lines));
		} else {
			$publicKey = hex2bin($publicKey);
		}

		$pieces = [
			base64_decode('com2R8j7FkwXzwOUoMs6qNUXXATzZrfuqG7xjo9Lp3c='),
			$userId,
			$username,
			$password,
			$publicKey
		];

		return base64_encode(hash('sha3-256', implode('', $pieces), true));
	}

	public static function PermissionsForRole(string $role): int {
		switch ($role) {
		case self::kRoleOwner:
			return self::kPermissionsOwner;
		case self::kRoleAdmin:
			return self::kPermissionsAdmin;
		case self::kRoleEditor:
			return self::kPermissionsEditor;
		case self::kRoleGuest:
			return self::kPermissionsGuest;
		default:
			throw new Exception('Unknown role ' . $role);
		}
	}
}

?>
