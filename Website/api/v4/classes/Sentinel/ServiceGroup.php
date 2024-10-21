<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroup extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;

	protected string $groupId;
	protected string $userId;
	protected string $name;
	protected string $color;

	public function __construct(BeaconRecordSet $row) {
		$this->groupId = $row->Field('service_group_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_groups', [
			new DatabaseObjectProperty('groupId', ['primaryKey' => true, 'columnName' => 'service_group_id', 'required' => false]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'color');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupId' => $this->groupId,
			'userId' => $this->userId,
			'name' => $this->name,
			'color' => $this->color
		];
	}

	public function GroupId(): string {
		return $this->groupId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Name(): string {
		return $this->name;
	}

	public function SetName(string $name): void {
		$this->SetProperty('name', $name);
	}

	public function Color(): string {
		return $this->color;
	}

	public function SetColor(string $color): void {
		$this->SetProperty('color', $color);
	}

	public function AddService(string $serviceId, string $userId): bool {
		if (BeaconCommon::IsUUID($serviceId) === false) {
			return false;
		}

		$service = Service::Fetch($serviceId);
		if (is_null($service) || $service->HasPermission($userId, Service::PermissionEdit) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $serviceId);
		if ($rows->RecordCount() !== 0) {
			return false;
		}

		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.service_group_members (group_id, service_id) VALUES ($1, $2);', $this->groupId, $serviceId);
		$database->Commit();
		return true;
	}

	public function RemoveService(string $serviceId, string $userId): bool {
		if (BeaconCommon::IsUUID($serviceId) === false) {
			return false;
		}

		$service = Service::Fetch($serviceId);
		if (is_null($service) || $service->HasPermission($userId, Service::PermissionEdit) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $serviceId);
		if ($rows->RecordCount() !== 1) {
			return false;
		}

		$database->BeginTransaction();
		$database->Query('DELETE FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $serviceId);
		$database->Commit();
		return true;
	}

	public function LoadServices(bool $fullObjects = true): array {
		if ($fullObjects) {
			return Service::Search(['serviceGroupId' => $this->groupId]);
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1;', $this->groupId);
		$ids = [];
		while (!$rows->EOF()) {
			$ids[] = $rows->Field('service_id');
			$rows->MoveNext();
		}
		return $ids;
	}

	public function GetPermissions(string $userId): int {
		if ($userId === $this->userId) {
			return 9223372036854775807;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_group_permissions WHERE group_id = $1 AND user_id = $2;', $this->groupId, $userId);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return 0;
		}
	}

	public function HasPermission(string $userId, int $desiredPermissions): bool {
		$permissions = $this->GetPermissions($userId);
		return ($permissions & $desiredPermissions) === $desiredPermissions;
	}
}

?>
