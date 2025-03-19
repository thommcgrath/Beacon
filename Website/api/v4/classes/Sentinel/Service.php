<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, ResourceLimit, User};
use BeaconCommon, BeaconDatabase, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class Service extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		SaveChildObjects as protected MutableDatabaseObjectSaveChildObjects;
		InitializeProperties as protected MutableDatabaseObjectInitializeProperties;
		PreparePropertyValue as protected MutableDatabaseObjectPreparePropertyValue;
		Validate as protected MutableDatabaseObjectValidate;
	}

	const ServicePermissionUsage = 1;
	const ServicePermissionControl = 2;
	const ServicePermissionManage = 4;

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

	const LanguageArabic = 'ar';
	const LanguageArmenian = 'hy';
	const LanguageBasque = 'eu';
	const LanguageCatalan = 'ca';
	const LanguageDanish = 'da';
	const LanguageDutch = 'nl';
	const LanguageEnglish = 'en';
	const LanguageFinnish = 'fi';
	const LanguageFrench = 'fr';
	const LanguageGerman = 'de';
	const LanguageGreek = 'el';
	const LanguageHindi = 'hi';
	const LanguageHungarian = 'hu';
	const LanguageIndonesian = 'id';
	const LanguageIrish = 'ga';
	const LanguageItalian = 'it';
	const LanguageLithuanian = 'lt';
	const LanguageNepali = 'ne';
	const LanguageNorwegian = 'no';
	const LanguagePortuguese = 'pt';
	const LanguageRomanian = 'ro';
	const LanguageRussian = 'ru';
	const LanguageSerbian = 'sr';
	const LanguageSpanish = 'es';
	const LanguageSwedish = 'sv';
	const LanguageTamil = 'ta';
	const LanguageTurkish = 'tr';
	const LanguageYiddish = 'yi';
	const Languages = [
		self::LanguageArabic,
		self::LanguageArmenian,
		self::LanguageBasque,
		self::LanguageCatalan,
		self::LanguageDanish,
		self::LanguageDutch,
		self::LanguageEnglish,
		self::LanguageFinnish,
		self::LanguageFrench,
		self::LanguageGerman,
		self::LanguageGreek,
		self::LanguageHindi,
		self::LanguageHungarian,
		self::LanguageIndonesian,
		self::LanguageIrish,
		self::LanguageItalian,
		self::LanguageLithuanian,
		self::LanguageNepali,
		self::LanguageNorwegian,
		self::LanguagePortuguese,
		self::LanguageRomanian,
		self::LanguageRussian,
		self::LanguageSerbian,
		self::LanguageSpanish,
		self::LanguageSwedish,
		self::LanguageTamil,
		self::LanguageTurkish,
		self::LanguageYiddish,
	];
	// Just because the API supports 28 languages, doesn't mean Sentinel has translations for all of them.
	const SupportedLanguages = [
		self::LanguageEnglish,
	];

	protected string $serviceId;
	protected string $userId;
	protected string $gameId;
	protected string $accessKey;
	protected string $accessKeyHash;
	protected bool $isConnected;
	protected ?int $connectionChangeTime;
	protected string $name;
	protected ?string $nickname;
	protected string $displayName;
	protected string $color;
	protected string $platform;
	protected array $gameSpecific;
	protected float $gameClock;
	protected int $currentPlayers;
	protected int $maxPlayers;
	protected array $languages;
	protected string $clusterId;
	protected bool $allowClusterIdChange;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceId = $row->Field('service_id');
		$this->userId = $row->Field('user_id');
		$this->gameId = $row->Field('game_id');
		$this->accessKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($row->Field('access_key')));
		$this->accessKeyHash = $row->Field('access_key_hash');
		$this->isConnected = $row->Field('is_connected');
		$this->connectionChangeTime = is_null($row->Field('connection_change_time')) === false ? round($row->Field('connection_change_time')) : null;
		$this->name = $row->Field('name');
		$this->nickname = $row->Field('nickname');
		$this->displayName = $row->Field('display_name');
		$this->color = $row->Field('color');
		$this->platform = $row->Field('platform');
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
		$this->gameClock = floatval($row->Field('game_clock'));
		$this->currentPlayers = intval($row->Field('current_players'));
		$this->maxPlayers = intval($row->Field('max_players'));
		$this->clusterId = $row->Field('cluster_id');
		$this->allowClusterIdChange = $row->Field('allow_cluster_id_change');

		$languages = $row->Field('languages');
		$languages = substr($languages, 1, strlen($languages) - 2);
		$this->languages = explode(',', $languages);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'services', [
			new DatabaseObjectProperty('serviceId', ['primaryKey' => true, 'columnName' => 'service_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('accessKey', ['columnName' => 'access_key', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('accessKeyHash', ['columnName' => 'access_key_hash', 'dependsOn' => ['accessKey'], 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('isConnected', ['columnName' => 'is_connected', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('connectionChangeTime', ['columnName' => 'connection_change_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('nickname', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('displayName', ['columnName' => 'display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('platform'),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific']),
			new DatabaseObjectProperty('gameClock', ['columnName' => 'game_clock', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('currentPlayers', ['columnName' => 'current_players', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('maxPlayers', ['columnName' => 'max_players', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('languages', ['required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways, 'accessor' => 'ARRAY(SELECT language FROM sentinel.service_languages WHERE service_languages.service_id = services.service_id)']),
			new DatabaseObjectProperty('clusterId', ['columnName' => 'cluster_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('allowClusterIdChange', ['columnName' => 'allow_cluster_id_change', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();

		$sortOrder = 'ASC';
		$sortColumn = 'displayName';
		if (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') {
			$sortOrder = 'DESC';
		}
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'displayName':
			case 'nickname':
			case 'name':
			case 'gameId':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortOrder;

		$parameters->orderBy = $schema->Accessor('name');
		$parameters->AddFromFilter($schema, $filters, 'serviceTokenId');
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'color');
		$parameters->AddFromFilter($schema, $filters, 'platform');

		if (isset($filters['accessKey'])) {
			$accessKeyHash = BeaconCommon::Base64UrlEncode(hash('sha3-512', BeaconCommon::Base64UrlDecode($filters['accessKey']), true));
			$placeholder = $parameters->AddValue($accessKeyHash);
			$parameters->clauses[] = 'services.access_key_hash = $' . $placeholder;
		}

		if (isset($filters['userId'])) {
			$placeholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = 'services.service_id IN (SELECT service_id FROM sentinel.service_permissions WHERE user_id = $' . $placeholder . ' AND permissions > 0)';
		}

		if (isset($filters['serviceGroupId'])) {
			$placeholder = $parameters->AddValue($filters['serviceGroupId']);
			$parameters->clauses[] = 'services.service_id IN (SELECT service_id FROM sentinel.service_group_services WHERE group_id = $' . $placeholder . ')';
		}

		if (isset($filters['searchableName'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $filters['searchableName']) . '%');
			$parameters->clauses[] = '(services.name ILIKE $' . $placeholder . ' OR services.nickname ILIKE $' . $placeholder . ')';
		} elseif (isset($filters['displayName'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $filters['displayName']) . '%');
			$parameters->clauses[] = $schema->Accessor('displayName') . ' ILIKE $' . $placeholder;
		} elseif (isset($filters['nickname'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $filters['nickname']) . '%');
			$parameters->clauses[] = $schema->Accessor('nickname') . ' ILIKE $' . $placeholder;
		} elseif (isset($filters['name'])) {
			$placeholder = $parameters->AddValue('%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $filters['name']) . '%');
			$parameters->clauses[] = $schema->Accessor('name') . ' ILIKE $' . $placeholder;
		}
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['languages'])) {
			$languages = $properties['languages'];
			if (is_array($languages) === false) {
				throw new Exception('Languages should be an array of ISO639 2-character language codes.');
			}
			foreach ($languages as $code) {
				if (in_array($code, self::SupportedLanguages) === false) {
					throw new Exception('Beacon Sentinel does not support language ' . $code . '.');
				}
			}
		}
	}

	// This function doesn't appear to ever get called
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
		case 'languages':
			if (is_array($value) === false) {
				throw new Exception('Languages should be an array of ISO639 2-character language codes.');
			}
			foreach ($value as $code) {
				if (in_array($code, self::SupportedLanguages) === false) {
					throw new Exception('Beacon Sentinel does not support language ' . $code . '.');
				}
			}
			break;
		}
	}

	public function jsonSerialize(): mixed {
		$json = [
			'serviceId' => $this->serviceId,
			'userId' => $this->userId,
			'gameId' => $this->gameId,
			'accessKey' => BeaconCommon::Base64UrlEncode($this->accessKey),
			'accessKeyHash' => $this->accessKeyHash,
			'isConnected' => $this->isConnected,
			'connectionChangeTime' => $this->connectionChangeTime,
			'name' => $this->name,
			'nickname' => $this->nickname,
			'displayName' => $this->displayName,
			'color' => $this->color,
			'platform' => $this->platform,
			'gameSpecific' => $this->gameSpecific,
			'gameClock' => $this->gameClock,
			'currentPlayers' => $this->currentPlayers,
			'maxPlayers' => $this->maxPlayers,
			'languages' => $this->languages,
			'clusterId' => $this->clusterId,
			'allowClusterIdChange' => $this->allowClusterIdChange,
		];

		return $json;
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MutableDatabaseObjectInitializeProperties($properties);

		$properties['accessKey'] = BeaconEncryption::GenerateKey(256);
		$properties['accessKeyHash'] = '';
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		switch ($definition->PropertyName()) {
		case 'gameSpecific':
			return json_encode($value);
		case 'accessKey':
			return BeaconCommon::Base64UrlEncode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $value));
		case 'accessKeyHash':
			return BeaconCommon::Base64UrlEncode(hash('sha3-512', $otherProperties['accessKey'], true));
		case 'languages':
			return '{' . implode(',', $this->languages) . '}';
		default:
			return static::MutableDatabaseObjectPreparePropertyValue($definition, $value, $otherProperties);
		}
	}

	protected function SaveChildObjects(BeaconDatabase $database): void {
		$this->MutableDatabaseObjectSaveChildObjects($database);

		$database->Query('DELETE FROM sentinel.service_languages WHERE service_id = $1 AND NOT (language = ANY($2));', $this->serviceId, '{' . implode(',', $this->languages) . '}');
		foreach ($this->languages as $code) {
			$database->Query('INSERT INTO sentinel.service_languages (service_id, language) VALUES ($1, $2) ON CONFLICT (service_id, language) DO UPDATE SET language = $2 WHERE service_languages.language != EXCLUDED.language;', $this->serviceId, $code);
		}
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function GameId(): string {
		return $this->gameId;
	}

	public function SetGameId(string $gameId): void {
		$this->SetProperty('gameId', $gameId);
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

	public function PusherChannelName(): string {
		return 'service-' . strtolower(str_replace('-', '', $this->serviceId));
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

	public static function GetResourceLimitsForUser(User $user): ?ResourceLimit {
		$subscriptions = Subscription::Search(['userId' => $user->UserId()], true);
		if (count($subscriptions) !== 1 || $subscriptions[0]->IsSuspended()) {
			return new ResourceLimit(0, 0);
		}
		return new ResourceLimit($subscriptions[0]->UsedServices(), $subscriptions[0]->MaxServices());
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2;', $this->serviceId, $user->UserId());
		if ($rows->RecordCount() === 1) {
			return $rows->Field('permissions');
		} else {
			return DatabaseObject::kPermissionNone;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}
}

?>
