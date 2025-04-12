<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class LogMessage extends DatabaseObject implements JsonSerializable {
	const LogLevelDebug = 'Debug';
	const LogLevelInfo = 'Informational';
	const LogLevelNotice = 'Notice';
	const LogLevelWarning = 'Warning';
	const LogLevelError = 'Error';
	const LogLevelCritical = 'Critical';
	const LogLevelAlert = 'Alert';
	const LogLevelEmergency = 'Emergency';
	const LogLevels = [
		self::LogLevelDebug,
		self::LogLevelInfo,
		self::LogLevelNotice,
		self::LogLevelWarning,
		self::LogLevelError,
		self::LogLevelCritical,
		self::LogLevelAlert,
		self::LogLevelEmergency
	];
	const ErrorLogLevels = [
		self::LogLevelError,
		self::LogLevelCritical,
		self::LogLevelAlert,
		self::LogLevelEmergency
	];

	const LogTypeService = 'Service';
	const LogTypeGameplay = 'Gameplay';
	const LogTypes = [
		self::LogTypeService,
		self::LogTypeGameplay
	];

	const AnalyzerStatusSkipped = 'Skipped';
	const AnalyzerStatusPending = 'Pending';
	const AnalyzerStatusAnalyzed = 'Analyzed';
	const AnalyzerStatuses = [
		self::AnalyzerStatusSkipped,
		self::AnalyzerStatusPending,
		self::AnalyzerStatusAnalyzed
	];

	const EventCron = 'cron';
	const EventChat = 'chat';
	const EventClockTemperingDetected = 'clockTamperingDetected';
	const EventClusterIdChanged = 'clusterIdChanged';
	const EventDinoClaimed = 'dinoClaimed';
	const EventDinoDied = 'dinoDied';
	const EventDinoDownloaded = 'dinoDownloaded';
	const EventDinoFrozen = 'dinoFrozen';
	const EventDinoMatured = 'dinoMatured';
	const EventDinoRenamed = 'dinoRenamed';
	const EventDinoTamed = 'dinoTamed';
	const EventDinoTribeChanged = 'dinoTribeChanged';
	const EventDinoUnclaimed = 'dinoUnclaimed';
	const EventDinoUnfrozen = 'dinoUnfrozen';
	const EventDinoUploaded = 'dinoUploaded';
	const EventPlayerJoined = 'playerJoined';
	const EventPlayerCuffed = 'playerCuffed';
	const EventPlayerDied = 'playerDied';
	const EventPlayerLeft = 'playerLeft';
	const EventPlayerNamed = 'playerRenamed';
	const EventPlayerSpawned = 'playerSpawned';
	const EventPlayerTribeChanged = 'playerTribeChanged';
	const EventPlayerUncuffed = 'playerUncuffed';
	const EventProblemDetected = 'problemDetected';
	const EventRollbackDetected = 'rollbackDetected';
	const EventServerConnected = 'serverConnected';
	const EventServerDisconnected = 'serverDisconnected';
	const EventStructureDestroyed = 'structureDestroyed';
	const EventTribeCreated = 'tribeCreated';
	const EventTribeDestroyed = 'tribeDestroyed';
	const EventTribeRenamed = 'tribeRenamed';
	const Events = [
		self::EventCron,
		self::EventChat,
		self::EventClockTemperingDetected,
		self::EventClusterIdChanged,
		self::EventDinoClaimed,
		self::EventDinoDied,
		self::EventDinoDownloaded,
		self::EventDinoFrozen,
		self::EventDinoMatured,
		self::EventDinoRenamed,
		self::EventDinoTamed,
		self::EventDinoTribeChanged,
		self::EventDinoUnclaimed,
		self::EventDinoUnfrozen,
		self::EventDinoUploaded,
		self::EventPlayerJoined,
		self::EventPlayerCuffed,
		self::EventPlayerDied,
		self::EventPlayerLeft,
		self::EventPlayerNamed,
		self::EventPlayerSpawned,
		self::EventPlayerTribeChanged,
		self::EventPlayerUncuffed,
		self::EventProblemDetected,
		self::EventRollbackDetected,
		self::EventServerConnected,
		self::EventServerDisconnected,
		self::EventStructureDestroyed,
		self::EventTribeCreated,
		self::EventTribeDestroyed,
		self::EventTribeRenamed,
	];

	protected string $messageId;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $eventName;
	protected string $type;
	protected float $time;
	protected string $level;
	protected string $analyzerStatus;
	protected array $metadata;
	protected string $message;

	public function __construct(BeaconRecordSet $row) {
		$this->messageId = $row->Field('message_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->eventName = $row->Field('event_name');
		$this->type = $row->Field('type');
		$this->time = floatval($row->Field('log_time'));
		$this->level = $row->Field('level');
		$this->analyzerStatus = $row->Field('analyzer_status');
		$this->metadata = json_decode($row->Field('metadata'), true);
		$this->message = $row->Field('message');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'service_logs',
			definitions: [
				new DatabaseObjectProperty('messageId', ['primaryKey' => true, 'columnName' => 'message_id']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('type'),
				new DatabaseObjectProperty('time', ['columnName' => 'log_time', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('eventName', ['columnName' => 'event_name']),
				new DatabaseObjectProperty('level'),
				new DatabaseObjectProperty('analyzerStatus', ['columnName' => 'analyzer_status']),
				new DatabaseObjectProperty('metadata'),
				new DatabaseObjectProperty('message', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'service_log_messages.message']),
			],
			joins: [
				'INNER JOIN sentinel.service_log_messages ON (service_log_messages.message_id = service_logs.message_id)',
				'INNER JOIN sentinel.services ON (services.service_id = service_logs.service_id)',
				'INNER JOIN sentinel.service_permissions ON (service_logs.service_id = service_permissions.service_id AND service_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		if (isset($filters['sortDirection'])) {
			$sortDirection = (strtolower($filters['sortDirection']) === 'ascending' ? 'ASC' : 'DESC');
		} else {
			$sortDirection = 'DESC';
		}
		if (isset($filters['sortedColumn']) && $schema->hasProperty($filters['sortedColumn'])) {
			$parameters->orderBy = $schema->Accessor($filters['sortedColumn']) . ' ' . $sortDirection;
		} else {
			$parameters->orderBy = $schema->Accessor('time') . ' ' . $sortDirection;
		}

		$language = 'en';
		if (isset($filters['lang']) && strlen($filters['lang']) === 2) {
			$language = strtolower($filters['lang']);
		}
		$langPlaceholder = $parameters->AddValue($language);
		$parameters->clauses[] = 'service_log_messages.language = $' . $langPlaceholder;

		$parameters->allowAll = true;

		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'analyzerStatus', 'in');
		$parameters->AddFromFilter($schema, $filters, 'eventName', 'in');
		$parameters->AddFromFilter($schema, $filters, 'type', 'in');
		$parameters->AddFromFilter($schema, $filters, 'level', 'in');

		if (isset($filters['message'])) {
			$queryPlaceholder = $parameters->AddValue($filters['message']);
			$parameters->clauses[] = 'service_log_messages.vector @@ websearch_to_tsquery(sentinel.language_shortcode_to_regconfig($' . $langPlaceholder . '), $' . $queryPlaceholder . ')';
		}

		$metadataFilters = ['characterId', 'tribeId', 'playerId', 'dinoId'];
		foreach ($metadataFilters as $filter) {
			if (isset($filters[$filter]) && BeaconCommon::IsUUID($filters[$filter])) {
				$placeholder = $parameters->AddValue('%"' . $filters[$filter] . '"%');
				$parameters->clauses[] = $schema->Accessor('metadata') . '::TEXT ILIKE $' . $placeholder;
			}
		}
	}

	public static function GetMessageByID(string $messageId): ?LogMessage {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE message_id = $1;', $messageId);
		if ($rows->RecordCount() !== 0) {
			return null;
		}
		return new static($rows);
	}

	public static function GetMessagesForService(string $serviceId, int $offset = 0, int $limit = 500): array {
		// Searches for a service or group
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE service_id = $1 OR service_id IN (SELECT service_id FROM sentinel.service_group_services WHERE group_id = $1) ORDER BY log_time DESC OFFSET $2 LIMIT $3;', $serviceId, $offset, $limit);
		$messages = [];
		while (!$rows->EOF()) {
			$messages[] = new static($rows);
			$rows->MoveNext();
		}
		return $messages;
	}

	public function Save(): void {
		$messages = [$this];
		static::SaveLogs($messages);
	}

	public function jsonSerialize(): mixed {
		return [
			'messageId' => $this->messageId,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'eventName' => $this->eventName,
			'type' => $this->type,
			'time' => $this->time,
			'level' => $this->level,
			'analyzerStatus' => $this->analyzerStatus,
			'metadata' => $this->metadata,
			'message' => $this->message,
		];
	}

	public function MessageId(): string {
		return $this->messageId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function Type(): string {
		return $this->type;
	}

	public function Time(): float {
		return $this->time;
	}

	public function Level(): string {
		return $this->level;
	}

	public function AnalyzerStatus(): string {
		return $this->analyzerStatus;
	}

	public function MetaData(): array {
		return $this->metadata;
	}

	public function IsError(): bool {
		return 	in_array($this->level, self::ErrorLogLevels);
	}

	public function GetPermissionsForUser(User $user): int {
		if (Service::TestSentinelPermissions($this->serviceId, $user->UserId())) {
			return self::kPermissionRead;
		} else {
			return self::kPermissionNone;
		}
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
	}
}

?>
