<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroup extends DatabaseObject implements JsonSerializable {
	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;
	
	protected $groupId = null;
	protected $userId = null;
	protected $name = null;
	protected $color = null;
	
	public function __construct(BeaconRecordSet $row) {
		$this->groupId = $row->Field('group_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_groups', [
			new DatabaseObjectProperty('groupId', ['primaryKey' => true, 'columnName' => 'group_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('color')
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
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
	
	/*protected static function ValidateProperty(string $property, mixed $value): void {
		switch ($property) {
		case 'color':
			if (in_array($value, Service::Colors) === false) {
				throw new Exception('Invalid color.');
			}
			break;
		default:
			parent::ValidateProperty($property, $value);
		}
	}
	
	public static function Create(string $userId, array $properties, array $members = []): ServiceGroup {
		if (BeaconCommon::HasAllKeys($properties, 'name') === false) {
			throw new Exception('Missing required properties.');
		}
		
		if (isset($properties['group_id'])) {
			$groupId = $properties['group_id'];
			if (BeaconCommon::IsUUID($groupId) === false) {
				throw new Exception('Group UUID is not a UUID.');
			}
		} else {
			$groupId = BeaconCommon::GenerateUUID();
		}
		
		$insert_values = [
			'name' => $properties['name'],
			'user_id' => $userId,
			'group_id' => $groupId
		];
		if (isset($properties['color'])) {
			$insert_values['color'] = $properties['color'];
		}
		
		foreach ($insert_values as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Insert(static::SQLLongTableName(), $insert_values);
		$group = static::GetByGroupID($groupId);
		
		foreach ($members as $service_id) {
			$group->AddService($service_id);	
		}
		
		$database->Commit();
		
		return $group;
	}
	
	public static function GetByGroupID(string $groupId): ?ServiceGroup {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE group_id = $1;', $groupId);
		$services = static::FromRows($rows);
		if (count($services) === 1) {
			return $services[0];
		}
		return null;
	}
	
	public static function GetForUserID(string $userId): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE user_id = $1;', $userId);
		return static::FromRows($rows);
	}
	
	public static function GetForServiceID(string $service_id): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE group_id IN (SELECT group_id FROM sentinel.service_group_members WHERE service_id = $1);', $service_id);
		return static::FromRows($rows);
	}
	
	public static function GetWithPermission(string $userId, int $permissions): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE group_id IN (SELECT group_id FROM sentinel.service_group_permissions WHERE user_id = $1 AND (permissions & $2) = $2;', $userId, $permissions);
		return static::FromRows($rows);
	}
	
	protected static function HookGetEditableProperties(): array {
		return ['name', 'color'];
	}*/
	
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
	
	public function AddService(string $service_id, string $userId): bool {
		if (BeaconCommon::IsUUID($service_id) === false) {
			return false;
		}
		
		$service = Service::GetByServiceID($service_id);
		if (is_null($service) || $service->HasPermission($userId, Service::PermissionEdit) === false) {
			return false;
		}
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $service_id);
		if ($rows->RecordCount() !== 0) {
			return false;
		}
		
		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.service_group_members (group_id, service_id) VALUES ($1, $2);', $this->groupId, $service_id);
		$database->Commit();
		return true;
	}
	
	public function RemoveService(string $service_id, string $userId): bool {
		if (BeaconCommon::IsUUID($service_id) === false) {
			return false;
		}
		
		$service = Service::GetByServiceID($service_id);
		if (is_null($service) || $service->HasPermission($userId, Service::PermissionEdit) === false) {
			return false;
		}
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $service_id);
		if ($rows->RecordCount() !== 1) {
			return false;
		}
		
		$database->BeginTransaction();
		$database->Query('DELETE FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->groupId, $service_id);
		$database->Commit();
		return true;
	}
	
	public function LoadServices(bool $full_objects = true): array {
		if ($full_objects) {
			return Service::GetForGroupID($this->groupId);
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
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE group_id = $1;', $this->groupId);
		$database->Commit();
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
