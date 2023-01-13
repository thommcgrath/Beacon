<?php

namespace BeaconAPI\Sentinel;

class ServiceGroup extends \BeaconAPI\DatabaseObject implements \JsonSerializable {
	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;
	
	protected $group_id = null;
	protected $user_id = null;
	protected $name = null;
	protected $color = null;
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->group_id = $row->Field('group_id');
		$this->user_id = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');
	}
	
	public static function SQLSchemaName(): string {
		return 'sentinel';
	}
	
	public static function SQLTableName(): string {
		return 'service_groups';
	}
	
	public static function SQLPrimaryKey(): string {
		return 'group_id';
	}
	
	public static function SQLColumns(): array {
		return [
			'group_id',
			'user_id',
			'name',
			'color'
		];
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
		switch ($property) {
		case 'color':
			if (in_array($value, Service::Colors) === false) {
				throw new \Exception('Invalid color.');
			}
			break;
		default:
			parent::ValidateProperty($property, $value);
		}
	}
	
	public static function Create(string $user_id, array $properties, array $members = []): ServiceGroup {
		if (\BeaconCommon::HasAllKeys($properties, 'name') === false) {
			throw new \Exception('Missing required properties.');
		}
		
		if (isset($properties['group_id'])) {
			$group_id = $properties['group_id'];
			if (\BeaconCommon::IsUUID($group_id) === false) {
				throw new \Exception('Group UUID is not a UUID.');
			}
		} else {
			$group_id = \BeaconCommon::GenerateUUID();
		}
		
		$insert_values = [
			'name' => $properties['name'],
			'user_id' => $user_id,
			'group_id' => $group_id
		];
		if (isset($properties['color'])) {
			$insert_values['color'] = $properties['color'];
		}
		
		foreach ($insert_values as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Insert(static::SQLLongTableName(), $insert_values);
		$group = static::GetByGroupID($group_id);
		
		foreach ($members as $service_id) {
			$group->AddService($service_id);	
		}
		
		$database->Commit();
		
		return $group;
	}
	
	public static function GetByGroupID(string $group_id): ?ServiceGroup {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE group_id = $1;', $group_id);
		$services = static::FromRows($rows);
		if (count($services) === 1) {
			return $services[0];
		}
		return null;
	}
	
	public static function GetForUserID(string $user_id): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE user_id = $1;', $user_id);
		return static::FromRows($rows);
	}
	
	public static function GetForServiceID(string $service_id): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE group_id IN (SELECT group_id FROM sentinel.service_group_members WHERE service_id = $1);', $service_id);
		return static::FromRows($rows);
	}
	
	public static function GetWithPermission(string $user_id, int $permissions): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE group_id IN (SELECT group_id FROM sentinel.service_group_permissions WHERE user_id = $1 AND (permissions & $2) = $2;', $user_id, $permissions);
		return static::FromRows($rows);
	}
	
	public function jsonSerialize(): mixed {
		return [
			'group_id' => $this->group_id,
			'user_id' => $this->user_id,
			'name' => $this->name,
			'color' => $this->color
		];
	}
	
	protected static function HookGetEditableProperties(): array {
		return ['name', 'color'];
	}
	
	public function GroupID(): string {
		return $this->group_id;
	}
	
	public function UserID(): string {
		return $this->user_id;
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
	
	public function AddService(string $service_id, string $user_id): bool {
		if (\BeaconCommon::IsUUID($service_id) === false) {
			return false;
		}
		
		$service = Service::GetByServiceID($service_id);
		if (is_null($service) || $service->HasPermission($user_id, Service::PermissionEdit) === false) {
			return false;
		}
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->group_id, $service_id);
		if ($rows->RecordCount() !== 0) {
			return false;
		}
		
		$database->BeginTransaction();
		$database->Query('INSERT INTO sentinel.service_group_members (group_id, service_id) VALUES ($1, $2);', $this->group_id, $service_id);
		$database->Commit();
		return true;
	}
	
	public function RemoveService(string $service_id, string $user_id): bool {
		if (\BeaconCommon::IsUUID($service_id) === false) {
			return false;
		}
		
		$service = Service::GetByServiceID($service_id);
		if (is_null($service) || $service->HasPermission($user_id, Service::PermissionEdit) === false) {
			return false;
		}
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->group_id, $service_id);
		if ($rows->RecordCount() !== 1) {
			return false;
		}
		
		$database->BeginTransaction();
		$database->Query('DELETE FROM sentinel.service_group_members WHERE group_id = $1 AND service_id = $2;', $this->group_id, $service_id);
		$database->Commit();
		return true;
	}
	
	public function LoadServices(bool $full_objects = true): array {
		if ($full_objects) {
			return Service::GetForGroupID($this->group_id);
		}
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1;', $this->group_id);
		$ids = [];
		while (!$rows->EOF()) {
			$ids[] = $rows->Field('service_id');
			$rows->MoveNext();
		}
		return $ids;
	}
	
	public function Delete(): void {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE group_id = $1;', $this->group_id);
		$database->Commit();
	}
	
	public function GetPermissions(string $user_id): int {
		if ($user_id === $this->user_id) {
			return 9223372036854775807;	
		}
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_group_permissions WHERE group_id = $1 AND user_id = $2;', $this->group_id, $user_id);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return 0;
		}
	}
	
	public function HasPermission(string $user_id, int $desired_permissions): bool {
		$permissions = $this->GetPermissions($user_id);
		return ($permissions & $desired_permissions) === $desired_permissions;
	}
}

?>
