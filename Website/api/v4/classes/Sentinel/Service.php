<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class Service extends DatabaseObject implements JsonSerializable {
	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;
	
	const GameArk = 'Ark';
	const Games = [
		self::GameArk
	];
	
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
	
	protected $serviceId = null;
	protected $userId = null;
	protected $nitradoServiceId = null;
	protected $gameId = null;
	protected $lastSuccess = null;
	protected $lastError = null;
	protected $inErrorState = null;
	protected $updateSchedule = null;
	protected $name = null;
	protected $nickname = null;
	protected $ipAddress = null;
	protected $gamePort = null;
	protected $slotCount = null;
	protected $expiration = null;
	protected $color = null;
	protected $platform = null;
	protected $rconPort = null;
	protected $gameSpecific = null;
	
	public function __construct(BeaconRecordSet $row) {
		$this->serviceId = $row->Field('service_id');
		$this->userId = $row->Field('user_id');
		$this->nitradoServiceId = intval($row->Field('nitrado_service_id'));
		$this->gameId = $row->Field('game_id');
		$this->lastSuccess = is_null($row->Field('last_success')) ? null : intval($row->Field('last_success'));
		$this->lastError = is_null($row->Field('last_error')) ? null : intval($row->Field('last_error'));
		$this->inErrorState = $row->Field('in_error_state');
		$this->updateSchedule = intval($row->Field('update_schedule'));
		$this->name = $row->Field('name');
		$this->nickname = $row->Field('nickname');
		$this->ipAddress = $row->Field('ip_address');
		$this->gamePort = intval($row->Field('game_port'));
		$this->slotCount = intval($row->Field('slot_count'));
		$this->expiration = intval($row->Field('expiration'));
		$this->color = $row->Field('color');
		$this->platform = $row->Field('platform');
		$this->rconPort = is_null($row->Field('rcon_port')) ? null : intval($row->Field('rcon_port'));
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'services', [
			new DatabaseObjectProperty('serviceId', ['primaryKey' => true, 'columnName' => 'service_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('nitradoServiceId', ['columnName' => 'nitrado_service_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('lastSuccess', ['columnName' => 'last_success']),
			new DatabaseObjectProperty('lastError', ['columnName' => 'last_error']),
			new DatabaseObjectProperty('inErrorState', ['columnName' => 'in_error_state']),
			new DatabaseObjectProperty('updateSchedule', ['columnName' => 'update_schedule']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('nickname'),
			new DatabaseObjectProperty('ipAddress', ['columnName' => 'ip_address']),
			new DatabaseObjectProperty('gamePort', ['columnName' => 'game_port']),
			new DatabaseObjectProperty('slotCount', ['columnName' => 'slot_count']),
			new DatabaseObjectProperty('expiration'),
			new DatabaseObjectProperty('color'),
			new DatabaseObjectProperty('platform'),
			new DatabaseObjectProperty('rconPort', ['columnName' => 'rcon_port']),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific'])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'nitradoServiceId');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'ipAddress');
		$parameters->AddFromFilter($schema, $filters, 'color');
		$parameters->AddFromFilter($schema, $filters, 'platform');
	}
	
	protected static function ValidateProperty(string $property, mixed $value): void {
		switch ($property) {
		case 'color':
			if (in_array($value, self::Colors) === false) {
				throw new Exception('Invalid color.');
			}
			break;
		case 'platform':
			if (in_array($value, self::Platforms) === false) {
				throw new Exception('Invalid platform.');
			}
			break;
		}
	}
	
	public function jsonSerialize(): mixed {
		return [
			'serviceId' => $this->serviceId,
			'userId' => $this->userId,
			'nitradoServiceId' => $this->nitradoServiceId,
			'gameId' => $this->gameId,
			'lastSuccess' => $this->lastSuccess,
			'lastError' => $this->lastError,
			'inErrorState' => $this->inErrorState,
			'updateSchedule' => $this->updateSchedule,
			'name' => $this->name,
			'nickname' => $this->nickname,
			'ipAddress' => $this->ipAddress,
			'gamePort' => $this->gamePort,
			'slotCount' => $this->slotCount,
			'expiration' => $this->expiration,
			'color' => $this->color,
			'platform' => $this->platform,
			'rconPort' => $this->rconPort,
			'gameSpecific' => $this->gameSpecific
		];
	}
	
	/*protected static function FromRows(BeaconRecordSet $rows): array {
		$services = [];
		while (!$rows->EOF()) {
			$services[] = new static($rows);
			$rows->MoveNext();
		}
		return $services;
	}
	
	public static function Create(string $userId, array $properties): Service {
		if (BeaconCommon::HasAllKeys($properties, 'nitrado_service_id', 'game_id', 'name', 'ip_address', 'slot_count', 'expiration', 'platform') === false) {
			throw new Exception('Missing required properties.');
		}
		if (BeaconCommon::HasAnyKeys($properties, 'last_success', 'last_error', 'in_error_state', 'update_schedule')) {
			throw new Exception('Some read-only properties have been included when they should not.');
		}
		
		if (isset($properties['service_id'])) {
			$serviceId = $properties['service_id'];
			if (BeaconCommon::IsUUID($serviceId) === false) {
				throw new Exception('Service UUID is not a UUID.');
			}
		} else {
			$serviceId = BeaconCommon::GenerateUUID();
			$properties['service_id'] = $serviceId;
		}
		$properties['user_id'] = $userId;
		
		if (is_numeric($properties['expiration'])) {
			$properties['expiration'] = date('Y-m-d H:i:s', $properties['expiration']);
		}
		
		foreach ($properties as $property => $value) {
			static::ValidateProperty($property, $value);
		}
		
		$database = BeaconCommon::Database();
		try {
			$database->BeginTransaction();
			$database->Insert('sentinel.services', $properties);
			$database->Commit();
			return static::GetByServiceID($serviceId);
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}
	
	public static function GetByServiceID(string $serviceId): ?Service {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE service_id = $1;', $serviceId);
		$services = static::FromRows($rows);
		if (count($services) === 1) {
			return $services[0];
		}
		return null;
	}
	
	public static function GetUserServices(string $userId, bool $include_shared): array {
		$columns = implode(', ', static::SQLColumns());
		$table = static::SQLSchemaName() . '.' . static::SQLTableName();
		$sql = "SELECT $columns FROM $table";
		if ($include_shared) {
			$sql .= " WHERE service_id IN (SELECT service_id FROM sentinel.resolved_permissions WHERE user_id = $1 AND (permissions & $2) = $2)";
		} else {
			$sql .= " WHERE user_id = $1";
		}
		$sql .= " ORDER BY COALESCE(nickname, name);";
		
		$database = BeaconCommon::Database();
		$rows = $database->Query($sql, $userId, static::PermissionView);
		$services = static::FromRows($rows);
		return $services;
	}
	
	public static function GetForGroupID(string $group_id): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE service_id IN (SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1) ORDER BY COALESCE(nickname, name);', $group_id);
		return static::FromRows($rows);
	}
	
	protected static function HookGetEditableProperties(): array {
		return ['name', 'nickname', 'color'];
	}
	
	protected function HookPrepareColumnWrite(string $property, int &$placeholder, array &$assignments, array &$values): void {
		switch ($property) {
		case 'last_error':
		case 'last_success':
		case 'expiration':
			$assignments[] = $property . ' = to_timestamp($' . $placeholder++ . ')';
			$values[] = $this->$property;
			break;
		case 'game_specific':
			$assignments[] = $property . ' = $' . $placeholder++;
			$values[] = json_encode($this->$property);
			break;
		default:
			parent::HookPrepareColumnWrite($property, $placeholder, $assignments, $values);
		}
	}*/
	
	public function ServiceId(): string {
		return $this->serviceId;
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function NitradoServiceId(): int {
		return $this->nitradoServiceId;
	}
	
	public function GameId(): string {
		return $this->gameId;
	}
	
	public function SetGameId(string $gameId): void {
		$this->SetProperty('game_id', $gameId);
	}
	
	public function LastSuccess(): int {
		return $this->lastSuccess;
	}
	
	public function SetLastSuccess(int $lastSuccess): void {
		$this->SetProperty('last_sucess', $lastSuccess);
	}
	
	public function LastError(): int {
		return $this->lastError;
	}
	
	public function SetLastError(int $lastError): void {
		$this->SetProperty('last_error', $lastError);
	}
	
	public function InErrorState(): bool {
		return $this->inErrorState;
	}
	
	public function UpdateSchedule(): int {
		return $this->updateSchedule;
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
	
	public function IpAddress(): string {
		return $this->ipAddress;
	}
	
	public function SetIpAddress(string $ipAddress): void {
		$this->SetProperty('ip_address', $ipAddress);
	}
	
	public function GamePort(): int {
		return $this->gamePort;
	}
	
	public function SetGamePort(int $port): void {
		$this->SetProperty('game_port', $port);
	}
	
	public function SlotCount(): int {
		return $this->slotCount;
	}
	
	public function SetSlotCount(int $slotCount): void {
		$this->SetProperty('slot_count', $slotCount);
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
	
	public function RconPort(): ?int {
		return $this->rconPort;
	}
	
	public function SetRconPort(?int $port): void {
		$this->SetProperty('rcon_port', $port);
	}
	
	public function GameSpecific(): array {
		return $this->gameSpecific;
	}
	
	public function SetGameSpecific(array $gameSpecific): void {
		$this->SetProperty('game_specific', $gameSpecific);
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ' . static::SQLSchemaName() . '.' . static::SQLTableName() . ' WHERE service_id = $1;', $this->serviceId);
		$database->Commit();
	}
	
	public function GetPermissions(string $userId): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.resolved_permissions WHERE service_id = $1 AND user_id = $2;', $this->serviceId, $userId);
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return 0;
		}
	}
	
	public function HasPermission(string $userId, int $desired_permissions): bool {
		$permissions = $this->GetPermissions($userId);
		return ($permissions & $desired_permissions) === $desired_permissions;
	}
	
	public function Log(string $message, ?string $level = null, ?string $type = null): void {
		$logMessage = LogMessage::Create($message, $this->serviceId, $level, $type);
		$logMessage->Save();
	}
	
	protected function LogException(Exception $err): void {
		echo $err->getMessage();
	}
	
	protected function TrackErrorState(bool $errored): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE sentinel.services SET ' . ($errored ? 'last_error' : 'last_success') . ' = CURRENT_TIMESTAMP WHERE service_id = $1;', $this->serviceId);
		$database->Commit();
		$this->inErrorState = $errored;
	}
	
	protected function GetOAuthToken(): OAuth {
		$token = OAuth::Lookup($this->userId, OAuth::ProviderNitrado);
		if (is_null($token)) {
			$err = new Exception('Service owner does not have an OAuth token.');
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		try {
			$token->Refresh(false);
		} catch (Exception $err) {
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		return $token;
	}
	
	public function RefreshDetails(): void {
		$token = $this->GetOAuthToken();
		
		$curl = curl_init('https://api.nitrado.net/services/' . $this->nitradoServiceId . '/gameservers');
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $token->AccessToken()
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		if ($status === 200) {
			$this->TrackErrorState(false);
		} else {
			$err = new Exception('Could not get gameserver details: ' . $response);
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		try {
			$responseJson = json_decode($response, true);
			$details = $responseJson['data'];
			$gameserver = $details['gameserver'];
		} catch (Exception $err) {
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		// Get service details for the expiration
		$curl = curl_init('https://api.nitrado.net/services/' . $this->nitradoServiceId);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $token->AccessToken()
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		if ($status === 200) {
			$this->TrackErrorState(false);
		} else {
			$err = new Exception('Could not get service details: ' . $response);
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		 
		try {
			$responseJson = json_decode($response, true);
			$details = $responseJson['data'];
			$service = $details['service'];
		} catch (Exception $err) {
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		try {
			// Update service record
			$this->SetIpAddress($gameserver['ip']);
			$this->SetGamePort($gameserver['port']);
			$this->SetSlotCount($gameserver['slots']);
			
			$suspendDate = new \DateTime($service['suspend_date']);
			$this->SetExpiration($suspendDate->getTimestamp());
			
			if (is_null($this->nickname) && isset($service['comment']) && empty($service['comment']) === false) {
				$this->SetNickname($service['comment']);
			}
			
			$game = $gameserver['game'];
			$gameSpecific = [];
			switch ($game) {
			case 'arkse':
				$gameId = self::GameArk;
				$platform = self::PlatformPC;
				break;
			case 'arkxb':
				$gameId = self::GameArk;
				$platform = self::PlatformXbox;
				break;
			case 'arkps':
				$gameId = self::GameArk;
				$platform = self::PlatformPlaystation;
				break;
			case 'arkswitch':
				$gameId = self::GameArk;
				$platform = self::PlatformSwitch;
				break;
			default:
				throw new Exception('Unsupported game ' . $game);
			}
			
			switch ($gameId) {
			case self::GameArk:
				$gameSpecific['path'] = $gameserver['game_specific']['path'];
				if ($gameserver['game_specific']['features']['has_rcon'] === true) {
					$this->SetRCONPort($gameserver['rcon_port']);
				} else {
					$this->SetRCONPort(null);
				}
				$gameSpecific['map'] = $gameserver['query']['map'];
				$gameSpecific['cluster'] = $gameserver['settings']['general']['clusterid'];
				$gameSpecific['admin-password'] = $gameserver['settings']['config']['admin-password'];
				$this->SetName($gameserver['settings']['config']['server-name']);
				break;
			}
			
			$this->SetGameId($gameId);
			$this->SetPlatform($platform);
			$this->SetGameSpecific($gameSpecific);
			
			$this->Save();
		} catch (Exception $err) {
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
	}
	
	public function DownloadFile(string $path): string {
		$token = $this->GetOAuthToken();
		
		$curl = curl_init('https://api.nitrado.net/services/' . $this->nitradoServiceId . '/gameservers/file_server/download?file=' . urlencode($path));
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $token->AccessToken()
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status === 200) {
			$this->TrackErrorState(false);
		} else {
			$err = new Exception('Could not get file download token for ' . $path . ', HTTP ' . $status . ': ' . $response);
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		try {
			$responseJson = json_decode($response, true);
			$downloadToken = $responseJson['data']['token']['token'];
			$downloadUrl = $responseJson['data']['token']['url'];
		} catch (Exception $err) {
			throw $err;
		}
		
		$curl = curl_init($downloadUrl);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'Authorization: Bearer ' . $token->AccessToken()
		]);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status === 200) {
			$this->TrackErrorState(false);
		} else {
			$err = new Exception('Could not download file at path ' . $path . ', HTTP ' . $status . ': ' . $response);
			$this->LogException($err);
			$this->TrackErrorState(true);
			throw $err;
		}
		
		return $response;
	}
	
	public function DownloadLatestLog(): void {
		switch ($this->gameId) {
		case self::GameArk:
			$root = $this->gameSpecific['path'];
			
			$path = $root . 'ShooterGame/Saved/Logs/ShooterGame_Last.log';
			$contents = $this->DownloadFile($path);
			ArkLogMessage::ConsumeLogFile($this->serviceId, $contents);
				
			$path = $root . 'ShooterGame/Saved/Logs/ShooterGame.log';
			$contents = $this->DownloadFile($path);
			ArkLogMessage::ConsumeLogFile($this->serviceId, $contents);
				
			/*$rconPort = $this->RCONPort();
			if (is_null($rconPort) === false) {
				$rcon_password = $this->gameSpecific['admin-password'];
				try {
					$client = new RCONClient($this->ipAddress, $rconPort, $rcon_password);
					$client->Connect();
					if ($client->IsAuthorized()) {
						$recent_logs = $client->SendCommand('GetGameLog');
						$client->Disconnect();
						if (is_null($recent_logs) === false) {
							echo "Logs: $recent_logs\n";
							ArkLogMessage::ConsumeLogFile($this->serviceId, $recent_logs);
						}
					}
				} catch (Exception $err) {
					$this->LogException($err);
				}
			}*/
			
			break;
		}
	}
}

?>
