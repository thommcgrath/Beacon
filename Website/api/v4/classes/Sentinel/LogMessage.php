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

	protected $messageId = null;
	protected $serviceId = null;
	protected $type = null;
	protected $time = null;
	protected $message = null;
	protected $level = null;
	protected $analyzerStatus = null;
	protected $metadata = null;

	public function __construct(BeaconRecordSet $row) {
		$this->messageId = $row->Field('message_id');
		$this->serviceId = $row->Field('service_id');
		$this->type = $row->Field('type');
		$this->time = floatval($row->Field('log_time'));
		$this->message = $row->Field('message');
		$this->level = $row->Field('level');
		$this->analyzerStatus = $row->Field('analyzer_status');
		$this->metadata = json_decode($row->Field('metadata'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_logs', [
			new DatabaseObjectProperty('messageId', ['primaryKey' => true, 'columnName' => 'message_id']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('time', ['columnName' => 'log_time', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('message'),
			new DatabaseObjectProperty('level'),
			new DatabaseObjectProperty('analyzerStatus', ['columnName' => 'analyzer_status']),
			new DatabaseObjectProperty('metadata')
		]);
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

		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'analyzerStatus');

		if (isset($filters['message'])) {
			$languagePlaceholder = $parameters->AddValue('english');
			$queryPlaceholder = $parameters->AddValue($filters['message']);
			$parameters->clauses[] = 'message @@ websearch_to_tsquery($' . $languagePlaceholder . ', $' . $queryPlaceholder . ')';
		}

		if (isset($filters['type'])) {
			$types = explode(',', $filters['type']);
			if (count($types) === 0) {
				$placeholder = $parameters->AddValue($types[0]);
				$parameters->clauses[] = $schema->Accessor('type') . ' = $' . $placeholder;
			} elseif (count($types) > 0) {
				$placeholders = [];
				foreach ($types as $type) {
					$placeholders[] = '$' . $parameters->AddValue($type);
				}
				$parameters->clauses[] = $schema->Accessor('type') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}

		if (isset($filters['level'])) {
			$levels = explode(',', $filters['level']);
			if (count($levels) === 0) {
				$placeholder = $parameters->AddValue($levels[0]);
				$parameters->clauses[] = $schema->Accessor('level') . ' = $' . $placeholder;
			} elseif (count($levels) > 0) {
				$placeholders = [];
				foreach ($levels as $level) {
					$placeholders[] = '$' . $parameters->AddValue($level);
				}
				$parameters->clauses[] = $schema->Accessor('level') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}
	}

	public static function Create(string $message, string $serviceId, ?string $level = null, ?string $type = null): LogMessage {
		if (is_null($level) === false && in_array($level, self::LogLevels) === false) {
			throw new Exception('Invalid log level');
		}
		if (is_null($type) === false && in_array($type, self::LogTypes) === false) {
			throw new Exception('Invalid log type');
		}

		$log = new static();
		$log->message = $message;
		$log->serviceId = $serviceId;
		if (is_null($level) === false) {
			$log->level = $level;
		}
		if (is_null($type) === false) {
			$log->type = $type;
		}
		return $log;
	}

	protected static function HookConsumeLogLines(string $serviceId, float $last_timestamp, array $lines): array {
		return [];
	}

	public static function ConsumeLogFile(string $serviceId, string $file_content): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT COALESCE(EXTRACT(EPOCH FROM MAX(log_time)), 0) AS last_timestamp FROM sentinel.service_logs WHERE service_id = $1;', $serviceId);
		$last_timestamp = floatval($rows->Field('last_timestamp'));

		// normalize line endings
		$file_content = str_replace("\r\n", "\n", $file_content);
		$file_content = str_replace("\r", "\n", $file_content);

		// split
		$lines = explode("\n", $file_content);

		// let the game-specific class do the heavy lifting
		$messages = static::HookConsumeLogLines($serviceId, $last_timestamp, $lines);

		// save
		static::SaveLogs($messages);

		// and return
		return $messages;
	}

	public static function SaveLogs(array $messages): void {
		if (count($messages) === 0) {
			return;
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			foreach ($messages as $message) {
				$metadata = count($message->metadata) > 0 ? json_encode($message->metadata) : '{}';
				$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (message_id, service_id, type, log_time, message, level, analyzer_status, metadata) VALUES ($1, $2, $3, to_timestamp($4), $5, $6, $7, $8);', $message->messageId, $message->serviceId, $message->type, $message->time, $message->message, $message->level, $message->analyzerStatus, $metadata);
			}
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
		$database->Commit();
	}

	public static function RunAnalyzer(): void {

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
			'type' => $this->type,
			'time' => $this->time,
			'message' => $this->message,
			'level' => $this->level,
			'analyzerStatus' => $this->analyzerStatus,
			'metadata' => $this->metadata
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

	public function Message(): string {
		return $this->message;
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

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceId']) === false) {
			throw new Exception('Must include a serviceId');
		}

		$serviceId = $filters['serviceId'];
		$service = Service::Fetch($serviceId);
		if (is_null($service) || $service->HasPermission(Core::UserId(), Service::kPermissionRead) === false) {
			throw new Exception('Service not found');
		}
	}

	public function GetPermissionsForUser(User $user): int {
		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $this->serviceId, user: $user);
		return $servicePermissions & DatabaseObject::kPermissionRead;
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeSentinelLogsRead;
	}
}

?>
