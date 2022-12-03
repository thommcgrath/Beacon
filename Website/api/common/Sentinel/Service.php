<?php

namespace BeaconAPI\Sentinel;

class Service implements \JsonSerializable {
	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;
	
	const ColorNone = 'None';
	const ColorBlue = 'Blue';
	const ColorBrown = 'Brown';
	const ColorGrey = 'Grey';
	const ColorGreen = 'Green';
	const ColorIndigo = 'Indigo';
	const ColorOrange = 'Orange';
	const ColorPink = 'Pink';
	const ColorPurple = 'Purple';
	const ColorRed = 'Red';
	const ColorTeal = 'Teal';
	const ColorYellow = 'Yellow';
	const Colors = [
		self::ColorNone,
		self::ColorBlue,
		self::ColorBrown,
		self::ColorGrey,
		self::ColorGreen,
		self::ColorIndigo,
		self::ColorOrange,
		self::ColorPink,
		self::ColorPurple,
		self::ColorRed,
		self::ColorTeal,
		self::ColorYellow
	];
	
	const PlatformPC = 'PC';
	const PlatformXbox = 'Xbox';
	const PlatformPlayStation = 'PlayStation';
	const PlatformSwitch = 'Switch';
	const Platforms = [
		self::PlatformPC,
		self::PlatformXbox,
		self::PlatformPlayStation,
		self::PlatformSwitch
	];
	
	protected $service_id = null;
	protected $user_id = null;
	protected $nitrado_service_id = null;
	protected $game_id = null;
	protected $last_success = null;
	protected $last_error = null;
	protected $in_error_state = null;
	protected $update_schedule = null;
	protected $name = null;
	protected $nickname = null;
	protected $ip_address = null;
	protected $slot_count = null;
	protected $expiration = null;
	protected $color = null;
	protected $platform = null;
	
	protected $changed_properties = [];
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->service_id = $row->Field('service_id');
		$this->user_id = $row->Field('user_id');
		$this->nitrado_service_id = intval($row->Field('nitrado_service_id'));
		$this->game_id = $row->Field('game_id');
		$this->last_success = is_null($row->Field('last_success')) ? null : intval($row->Field('last_success'));
		$this->last_error = is_null($row->Field('last_error')) ? null : intval($row->Field('last_error'));
		$this->in_error_state = $row->Field('in_error_state');
		$this->update_schedule = intval($row->Field('update_schedule'));
		$this->name = $row->Field('name');
		$this->nickname = $row->Field('nickname');
		$this->ip_address = $row->Field('ip_address');
		$this->slot_count = intval($row->Field('slot_count'));
		$this->expiration = intval($row->Field('expiration'));
		$this->color = $row->Field('color');
		$this->platform = $row->Field('platform');
	}
	
	public static function SQLSchemaName(): string {
		return 'sentinel';
	}
	
	public static function SQLTableName(): string {
		return 'services';
	}
	
	public static function SQLLongTableName(): string {
		return static::SQLSchemaName() . '.' . static::SQLTableName();
	}
	
	public static function SQLColumns(): array {
		return [
			'service_id',
			'user_id',
			'nitrado_service_id',
			'game_id',
			'EXTRACT(EPOCH FROM last_success) AS last_success',
			'EXTRACT(EPOCH FROM last_error) AS last_error',
			'in_error_state',
			'update_schedule',
			'name',
			'nickname',
			'ip_address',
			'slot_count',
			'EXTRACT(EPOCH FROM expiration) AS expiration',
			'color',
			'platform'
		];
	}
	
	protected static function FromRows(\BeaconPostgreSQLRecordSet $rows): array {
		$services = [];
		while (!$rows->EOF()) {
			$services[] = new static($rows);
			$rows->MoveNext();
		}
		return $services;
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
		switch ($property) {
		case 'color':
			if (in_array($value, self::Colors) === false) {
				throw new \Exception('Invalid color.');
			}
			break;
		case 'platform':
			if (in_array($value, self::Platforms) === false) {
				throw new \Exception('Invalid platform.');
			}
			break;
		}
	}
	
	public static function Create(string $user_id, array $properties): Service {
		if (\BeaconCommon::HasAllKeys($properties, 'nitrado_service_id', 'game_id', 'name', 'ip_address', 'slot_count', 'expiration', 'platform') === false) {
			throw new \Exception('Missing required properties.');
		}
		if (\BeaconCommon::HasAnyKeys($properties, 'last_success', 'last_error', 'in_error_state', 'update_schedule')) {
			throw new \Exception('Some read-only properties have been included when they should not.');
		}
		
		if (isset($properties['service_id'])) {
			$service_id = $properties['service_id'];
			if (\BeaconCommon::IsUUID($service_id) === false) {
				throw new \Exception('Service UUID is not a UUID.');
			}
		} else {
			$service_id = \BeaconCommon::GenerateUUID();
			$properties['service_id'] = $service_id;
		}
		$properties['user_id'] = $user_id;
		
		if (is_numeric($properties['expiration'])) {
			$properties['expiration'] = date('Y-m-d H:i:s', $properties['expiration']);
		}
		
		foreach ($properties as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = \BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Insert('sentinel.services', $properties);
			$database->Commit();
			return static::GetByServiceID($service_id);
		} catch (\Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}
	
	public static function GetByServiceID(string $service_id): ?Service {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE service_id = $1;', $service_id);
		$services = static::FromRows($rows);
		if (count($services) === 1) {
			return $services[0];
		}
		return null;
	}
	
	public static function GetUserServices(string $user_id, bool $include_shared): array {
		$columns = implode(', ', static::SQLColumns());
		$table = static::SQLSchemaName() . '.' . static::SQLTableName();
		$sql = "SELECT $columns FROM $table";
		if ($include_shared) {
			$sql .= " WHERE service_id IN (SELECT service_id FROM sentinel.resolved_permissions WHERE user_id = $1 AND (permissions & $2) = $2)";
		} else {
			$sql .= " WHERE user_id = $1";
		}
		$sql .= " ORDER BY COALESCE(nickname, name);";
		
		$database = \BeaconCommon::Database();
		$rows = $database->Query($sql, $user_id, static::PermissionView);
		$services = static::FromRows($rows);
		return $services;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'service_id' => $this->service_id,
			'user_id' => $this->user_id,
			'nitrado_service_id' => $this->nitrado_service_id,
			'game_id' => $this->game_id,
			'last_success' => $this->last_success,
			'last_error' => $this->last_error,
			'in_error_state' => $this->in_error_state,
			'update_schedule' => $this->update_schedule,
			'name' => $this->name,
			'nickname' => $this->nickname,
			'ip_address' => $this->ip_address,
			'slot_count' => $this->slot_count,
			'expiration' => $this->expiration,
			'color' => $this->color,
			'platform' => $this->platform
		];
	}
	
	protected function SetProperty(string $property, mixed $value): void {
		if ($this->$property !== $value) {
			static::ValidateProperty($property, $value);
			$this->$property = $value;
			$this->changed_properties[] = $property;
		}
	}
	
	public function Edit(array $properties): void {
		$whitelist = ['name', 'nickname', 'color'];
		foreach ($whitelist as $property_name) {
			if (array_key_exists($property_name, $properties)) {
				$this->SetProperty($property_name, $properties[$property_name]);
			}
		}
		
		$this->Save();
	}
	
	public function Save(): void {
		if (count($this->changed_properties) === 0) {
			return;
		}
		
		$placeholder = 1;
		$assignments = [];
		$values = [];
		foreach ($this->changed_properties as $property) {
			switch ($property) {
			case 'last_error':
			case 'last_success':
			case 'expiration':
				$assignments[] = $property . ' = to_timestamp($' . $placeholder++ . ')';
				break;
			default:
				$assignments[] = $property . ' = $' . $placeholder++;
				break;
			}
			$values[] = $this->$property;
		}
		$values[] = $this->service_id;
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('UPDATE ' . static::SQLLongTableName() . ' SET ' . implode(', ', $assignments) . ' WHERE service_id = $' . $placeholder++ . ' RETURNING ' . implode(', ', static::SQLColumns()) . ';', $values);
		$database->Commit();
		
		$this->__construct($rows);
		$this->changed_properties = [];
	}
	
	public function ServiceID(): string {
		return $this->service_id;
	}
	
	public function UserID(): string {
		return $this->user_id;
	}
	
	public function NitradoServiceID(): int {
		return $this->nitrado_service_id;
	}
	
	public function GameID(): string {
		return $this->game_id;
	}
	
	public function SetGameID(string $game_id): void {
		$this->SetProperty('game_id', $game_id);
	}
	
	public function LastSuccess(): int {
		return $this->last_success;
	}
	
	public function SetLastSuccess(int $last_success): void {
		$this->SetProperty('last_sucess', $last_success);
		$this->SetProperty('in_error_state', $this->last_error > $this->last_success);
	}
	
	public function LastError(): int {
		return $this->last_error;
	}
	
	public function SetLastError(int $last_error): void {
		$this->SetProperty('last_error', $last_error);
		$this->SetProperty('in_error_state', $this->last_error > $this->last_success);
	}
	
	public function InErrorState(): bool {
		return $this->in_error_state;
	}
	
	public function UpdateSchedule(): int {
		return $this->update_schedule;
	}
	
	public function Name(): string {
		return $this->name;
	}
	
	public function SetName(string $value): void {
		$this->SetProperty('name', $value);
	}
	
	public function Nickname(): mixed {
		return $this->nickname;
	}
	
	public function SetNickname(mixed $nickname): void {
		$this->SetProperty('nickname', $nickname);
	}
	
	public function IPAddress(): string {
		return $this->ip_address;
	}
	
	public function SetIPAddress(string $ip_address): void {
		$this->SetProperty('ip_address', $ip_address);
	}
	
	public function SlotCount(): int {
		return $this->slot_count;
	}
	
	public function SetSlotCount(int $slot_count): void {
		$this->SetProperty('slot_count', $slot_count);
	}
	
	public function Expiration(): int {
		return $this->expiration;
	}
	
	public function SetExpiration(int $expiration): void {
		$this->SetProperty('expiration', $expiration);
	}
	
	public function Color(): string {
		return $this->color;
	}
	
	public function SetColor(string $color): void {
		$this->SetProperty('color', $color);
	}
	
	public function Platform(): string {
		return $this->platform;
	}
	
	public function SetPlatform(string $platform): void {
		$this->SetProperty('platform', $platform);
	}
	
	public function Delete(): void {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE service_id = $1;', $this->service_id);
		$database->Commit();
	}
	
	public function GetPermissions(string $user_id): int {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.resolved_permissions WHERE service_id = $1 AND user_id = $2;', $this->service_id, $user_id);
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
	
	public function Log(): void {
		
	}
}

?>
