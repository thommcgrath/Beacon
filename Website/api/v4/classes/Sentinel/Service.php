<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, ServiceToken};
use BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class Service extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
		PreparePropertyValue as protected MutableDatabaseObjectPreparePropertyValue;
		Validate as protected MutableDatabaseObjectValidate;
	}

	const PermissionView = 1;
	const PermissionEdit = 2;
	const PermissionDelete = 4;

	const GameArk = 'Ark';
	const GameArkSA = 'ArkSA';
	const Games = [
		self::GameArk,
		self::GameArkSA,
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
	const PlatformUniversal = 'Universal';
	const Platforms = [
		self::PlatformPC,
		self::PlatformXbox,
		self::PlatformPlayStation,
		self::PlatformSwitch,
		self::PlatformUniversal,
	];

	protected string $serviceId;
	protected string $subscriptionId;
	protected string $gameId;
	protected string $connectionEncryptionKey;
	protected array $connectionDetails;
	protected string $connectionHash;
	protected ?float $lastSuccess;
	protected ?float $lastError;
	protected ?float $lastGamelogTimestamp;
	protected bool $inErrorState;
	protected string $name;
	protected ?string $nickname;
	protected string $color;
	protected string $platform;
	protected array $gameSpecific;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceId = $row->Field('service_id');
		$this->subscriptionId = $row->Field('subscription_id');
		$this->gameId = $row->Field('game_id');
		$this->connectionEncryptionKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), base64_decode($row->Field('connection_encryption_key')));
		$this->connectionDetails = json_decode(BeaconEncryption::SymmetricDecrypt($this->connectionEncryptionKey, base64_decode($row->Field('connection_details'))), true);
		$this->connectionHash = $row->Field('connection_hash');
		$this->lastSuccess = is_null($row->Field('last_success')) ? null : floatval($row->Field('last_success'));
		$this->lastError = is_null($row->Field('last_error')) ? null : floatval($row->Field('last_error'));
		$this->lastGamelogTimestamp = is_null($row->Field('last_gamelog_timestamp')) ? null : floatval($row->Field('last_gamelog_timestamp'));
		$this->inErrorState = $row->Field('in_error_state');
		$this->name = $row->Field('name');
		$this->nickname = $row->Field('nickname');
		$this->color = $row->Field('color');
		$this->platform = $row->Field('platform');
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'services', [
			new DatabaseObjectProperty('serviceId', ['primaryKey' => true, 'columnName' => 'service_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('subscriptionId', ['columnName' => 'subscription_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('connectionEncryptionKey', ['columnName' => 'connection_encryption_key', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('connectionDetails', ['columnName' => 'connection_details', 'dependsOn' => ['connectionEncryptionKey'], 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('connectionHash', ['columnName' => 'connection_hash', 'required' => false, 'dependsOn' => ['connectionDetails']]),
			new DatabaseObjectProperty('lastSuccess', ['columnName' => 'last_success', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false]),
			new DatabaseObjectProperty('lastError', ['columnName' => 'last_error', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false]),
			new DatabaseObjectProperty('lastGamelogTimestamp', ['columnName' => 'last_gamelog_timestamp', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false]),
			new DatabaseObjectProperty('inErrorState', ['columnName' => 'in_error_state', 'accessor' => 'COALESCE(EXTRACT(EPOCH FROM %%TABLE%%.last_error), 0) > COALESCE(EXTRACT(EPOCH FROM %%TABLE%%.last_success), 0)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('nickname', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('platform'),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific']),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->clauses[] = 'services.deleted = FALSE';
		$parameters->AddFromFilter($schema, $filters, 'serviceTokenId');
		$parameters->AddFromFilter($schema, $filters, 'nitradoServiceId');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'ipAddress');
		$parameters->AddFromFilter($schema, $filters, 'color');
		$parameters->AddFromFilter($schema, $filters, 'platform');

		if (isset($filters['userId'])) {
			$placeholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'services.service_id IN (SELECT service_id FROM sentinel.service_permissions WHERE user_id = $' . $placeholder . ' AND permissions > 0)';
		}

		if (isset($filters['serviceGroupId'])) {
			$placeholder = $parameters->AddValue($filters['serviceGroupId']);
			$parameters->clauses[] = 'services.service_id IN (SELECT service_id FROM sentinel.service_group_services WHERE group_id = $' . $placeholder . ')';
		}
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
		case 'connection_details':
			break;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceId' => $this->serviceId,
			'subscriptionId' => $this->subscriptionId,
			'gameId' => $this->gameId,
			'connectionDetails' => $this->connectionDetails,
			'lastSuccess' => $this->lastSuccess,
			'lastError' => $this->lastError,
			'lastGamelogTimestamp' => $this->lastGamelogTimestamp,
			'inErrorState' => $this->inErrorState,
			'name' => $this->name,
			'nickname' => $this->nickname,
			'color' => $this->color,
			'platform' => $this->platform,
			'gameSpecific' => $this->gameSpecific,
		];
	}

	protected static function InitializeProperties(array &$properties): void {
		$properties['connectionEncryptionKey'] = BeaconEncryption::GenerateKey(256);
		$properties['connectionHash'] = '';
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (array_key_exists('connectionDetails', $properties)) {
			$details = $properties['connectionDetails'];
			if (is_null($details)) {
				throw new Exception('connectionDetails must not be null');
			}
			if (is_array($details) === false) {
				throw new Exception('connectionDetails must be an object');
			}
			if (BeaconCommon::HasAllKeys($details, 'type') === false) {
				throw new Exception('connectionDetails must have a type key');
			}

			switch ($details['type']) {
			case 'Nitrado':
				if (BeaconCommon::HasAllKeys($details, 'serviceId', 'serviceTokenId') === false) {
					throw new Exception('connectionDetails must have serviceId and serviceTokenId keys for Nitrado connections');
				}
				if (filter_var($details['serviceId'], FILTER_VALIDATE_INT) == false) {
					throw new Exception('connectionDetails.serviceId is not a number');
				}
				if (BeaconCommon::IsUUID($details['serviceTokenId']) === false) {
					throw new Exception('connectionDetails.serviceTokenId is not a UUID');
				}
				break;
			case 'FTP':
				if (BeaconCommon::HasAllKeys($details, 'host', 'rconPort', 'rconPassword', 'ftpPort', 'ftpUser', 'ftpPassword', 'ftpUsePassiveMode', 'ftpMode', 'ftpPath') === false) {
					throw new Exception('connectionDetails must have host, rconPort, rconPassword, ftpPort, ftpUser, ftpPassword, ftpUsePassiveMode, ftpMode, and ftpPath keys for FTP connections');
				}
				if (filter_var($details['rconPort'], FILTER_VALIDATE_INT) === false || $details['rconPort'] < 1 || $details['rconPort'] > 65535) {
					throw new Exception('connectionDetails.rconPort must be a number between 1 and 65535');
				}
				if (filter_var($details['ftpPort'], FILTER_VALIDATE_INT) === false || $details['ftpPort'] < 1 || $details['ftpPort'] > 65535) {
					throw new Exception('connectionDetails.ftpPort must be a number between 1 and 65535');
				}
				if (filter_var($details['ftpUsePassiveMode'], FILTER_VALIDATE_BOOL) === false) {
					throw new Exception('connectionDetails.ftpUsePassiveMode must be true or false');
				}
				if (in_array($details['ftpMode'], ['insecure', 'sftp', 'required_tls', 'optional_tls', 'implied_tls']) === false) {
					throw new Exception('connectionDetails.ftpMode must be one of insecure, sftp, required_tls, optional_tls, or implied_tls');
				}
				if (in_array($details['ftpMode'], ['required_tls', 'optional_tls', 'implied_tls'])) {
					if (array_key_exists('ftpValidateCertificates', $details) === false) {
						throw new Exception('connectionDetails must have a ftpValidateCertificates key when TLS is enabeld');
					}
					if (filter_var($details['ftpValidateCertificates'], FILTER_VALIDATE_BOOL) === false) {
						throw new Exception('connectionDetails.ftpValidateCertificates must be true or false');
					}
				}
				if (empty($details['host'])) {
					throw new Exception('connectionDetails.host must not be empty');
				}
				if (empty($details['rconPassword'])) {
					throw new Exception('connectionDetails.rconPassword must not be empty');
				}
				if (empty($details['ftpUser'])) {
					throw new Exception('connectionDetails.ftpUser must not be empty');
				}
				if (empty($details['ftpPassword'])) {
					throw new Exception('connectionDetails.ftpPassword must not be empty');
				}
				if (empty($details['ftpPath'])) {
					throw new Exception('connectionDetails.ftpPath must not be empty');
				}
				break;
			default:
				throw new Exception('Connection detail type ' . $details['type'] . ' is not supported');
			}
		}
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		switch ($definition->PropertyName()) {
		case 'gameSpecific':
			return json_encode($value);
		case 'connectionEncryptionKey':
			return base64_encode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $value));
		case 'connectionDetails':
			return base64_encode(BeaconEncryption::SymmetricEncrypt($otherProperties['connectionEncryptionKey'], json_encode($value)));
		case 'connectionHash':
			$details = $otherProperties['connectionDetails'];
			$hashParts = [$details['type']];
			switch ($details['type']) {
			case 'Nitrado':
				$hashParts[] = strtolower($details['serviceId']);
				break;
			case 'FTP':
				$hashParts[] = strtolower($details['host']);
				$hashParts[] = intval($details['rconPort']);
				break;
			}
			$hashParts[] = '77345636-9d4c-429c-acc2-e400612e9974';
			return hash('sha3-256', implode(':', $hashParts));
		default:
			return static::MutableDatabaseObjectPreparePropertyValue($definition, $value, $otherProperties);
		}
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function SubscriptionId(): string {
		return $this->subscriptionId;
	}

	public function GameId(): string {
		return $this->gameId;
	}

	public function SetGameId(string $gameId): void {
		$this->SetProperty('gameId', $gameId);
	}

	public function LastSuccess(): ?float {
		return $this->lastSuccess;
	}

	public function SetLastSuccess(float $lastSuccess): void {
		$this->SetProperty('lastSuccess', $lastSuccess);
	}

	public function LastError(): ?float {
		return $this->lastError;
	}

	public function SetLastError(float $lastError): void {
		$this->SetProperty('lastError', $lastError);
	}

	public function LastGamelogTimestamp(): ?float {
		return $this->lastGamelogTimestamp;
	}

	public function InErrorState(): bool {
		return $this->inErrorState;
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

	public function GameSpecific(): array {
		return $this->gameSpecific;
	}

	public function SetGameSpecific(array $gameSpecific): void {
		$this->SetProperty('gameSpecific', $gameSpecific);
	}

	public function GetPermissions(string $userId): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $this->serviceId, $userId);
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

	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET deleted = TRUE WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->PrimaryKey());
		$database->Commit();
	}
}

?>
