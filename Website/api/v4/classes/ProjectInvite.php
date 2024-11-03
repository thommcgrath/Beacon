<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class ProjectInvite extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
	}

	protected string $inviteCode;
	protected string $projectId;
	protected string $projectPassword;
	protected string $role;
	protected string $creatorId;
	protected float $creationDate;
	protected float $expirationDate;

	protected function __construct(BeaconRecordSet $row) {
		$this->inviteCode = $row->Field('invite_code');
		$this->projectId = $row->Field('project_id');
		$this->projectPassword = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($row->Field('project_password')));
		$this->role = $row->Field('role');
		$this->creatorId = $row->Field('creator_id');
		$this->creationDate = floatval($row->Field('creation_date'));
		$this->expirationDate = floatval($row->Field('expiration_date'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = new DatabaseSchema('public', 'project_invites', [
			new DatabaseObjectProperty('inviteCode', ['primaryKey' => true, 'columnName' => 'invite_code', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('projectId', ['columnName' => 'project_id']),
			new DatabaseObjectProperty('projectPassword', ['columnName' => 'project_password']),
			new DatabaseObjectProperty('role'),
			new DatabaseObjectProperty('creatorId', ['columnName' => 'creator_id']),
			new DatabaseObjectProperty('creationDate', ['columnName' => 'creation_date', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('expirationDate', ['columnName' => 'expiration_date', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
		]);
		return $schema;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$table = $schema->Table();
		$parameters->AddFromFilter($schema, $filters, 'projectId');
		$parameters->orderBy = $schema->Accessor('creationDate') . ' DESC';
		$parameters->clauses[] = $schema->Table() . '.expiration_date >= CURRENT_TIMESTAMP';
	}

	public function jsonSerialize(): mixed {
		return [
			'inviteCode' => $this->inviteCode,
			'redeemUrl' => BeaconCommon::AbsoluteUrl('/invite/'. urlencode($this->inviteCode)),
			'projectId' => $this->projectId,
			'role' => $this->role,
			'creatorId' => $this->creatorId,
			'creationDate' => $this->creationDate,
			'expirationDate' => $this->expirationDate,
		];
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MutableDatabaseObjectInitializeProperties($properties);
		$properties['inviteCode'] = BeaconCommon::GenerateRandomKey(8, '23456789ABCDEFGHJKMNPRSTUVWXYZ');
		$properties['creatorId'] = $properties['userId'];
		$properties['creationDate'] = time();
		$properties['expirationDate'] = time() + 86400;

		if (isset($properties['projectPassword'])) {
			$properties['projectPassword'] = base64_encode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), base64_decode($properties['projectPassword'])));
		}
	}

	public function InviteCode(): string {
		return $this->inviteCode;
	}

	public function ProjectId(): string {
		return $this->projectId;
	}

	public function ProjectPassword(): string {
		return $this->projectPassword;
	}

	public function Role(): string {
		return $this->role;
	}

	public function CreatorId(): string {
		return $this->creatorId;
	}

	public function CreationDate(): float {
		return $this->creationDate;
	}

	public function ExpirationDate(): float {
		return $this->expirationDate;
	}

	public function IsExpired(): bool {
		return $this->expirationDate < time();
	}

	protected static function UserIsAdmin(User $user, string $projectId): bool {
		if (BeaconCommon::IsUUID($projectId) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT role FROM public.project_members WHERE user_id = $1 AND project_id = $2;', $user->UserId(), $projectId);
		if ($rows->RecordCount() !== 1) {
			return false;
		}
		$role = $rows->Field('role');

		return $role === ProjectMember::kRoleOwner || $role === ProjectMember::kRoleAdmin;
	}

	public static function GetNewObjectPermissionsForUser(User $user, ?array $newObjectProperties): int {
		if (is_null($newObjectProperties) || isset($newObjectProperties['projectId']) === false) {
			return DatabaseObject::kPermissionNone;
		}

		$projectId = strval($newObjectProperties['projectId']);
		$member = ProjectMember::Fetch($projectId, $user->UserId());
		if (is_null($member)) {
			return DatabaseObject::kPermissionNone;
		}

		try {
			$desiredPermissions = ProjectMember::PermissionsForRole($newObjectProperties['role']);
		} catch (Exception $err) {
			return DatabaseObject::kPermissionNone;
		}

		if ($desiredPermissions < $member->Permissions()) {
			return DatabaseObject::kPermissionAll;
		} else {
			return DatabaseObject::kPermissionNone;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		$member = ProjectMember::Fetch($this->projectId, $user->UserId());
		if (is_null($member)) {
			return DatabaseObject::kPermissionNone;
		}
		try {
			$rolePermissions = ProjectMember::PermissionsForRole($this->role);
		} catch (Exception $err) {
			return DatabaseObject::kPermissionNone;
		}
		if ($rolePermissions < $member->Permissions()) {
			return DatabaseObject::kPermissionAll;
		} else {
			return DatabaseObject::kPermissionNone;
		}
	}

	public static function CleanupExpired(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.project_invites WHERE expiration_date < CURRENT_TIMESTAMP;');
		$database->Commit();
	}
}

?>
