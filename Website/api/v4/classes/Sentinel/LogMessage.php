<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
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
			new DatabaseObjectProperty('time', ['columnName' => 'log_time']),
			new DatabaseObjectProperty('message'),
			new DatabaseObjectProperty('level'),
			new DatabaseObjectProperty('analyzerStatus', ['columnName' => 'analyzer_status']),
			new DatabaseObjectProperty('metadata')
		]);	
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('time') . ' DESC';
		$parameters->AddFromFilter($schema, $filters, 'type');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'level');
		$parameters->AddFromFilter($schema, $filters, 'analyzerStatus');
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
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE service_id = $1 OR service_id IN (SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1) ORDER BY log_time DESC OFFSET $2 LIMIT $3;', $serviceId, $offset, $limit);
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
	
	/*public static function Search(string $serviceId, array $filters = [], bool $newest_first = true, int $page_num = 1, int $page_size = 250): array {
		$page_num = max($page_num, 1);
		$offset = $page_size * ($page_num - 1);
		$clauses = ['service_id = $1'];
		$values = [$serviceId];
		$placeholder = 2;
		if (isset($filters['query']) && empty($filters['query']) === false) {
			$clauses[] = 'message_vector @@ phraseto_tsquery(\'english\', $' . $placeholder++ . ')';
			$values[] = $filters['query'];
		}
		if (isset($filters['message_type']) && empty($filters['message_type']) === false) {
			$clauses[] = 'type = $' . $placeholder++;
			$values[] = $filters['message_type'];
		}
		if (isset($filters['event_type']) && empty($filters['event_type']) === false) {
			$clauses[] = 'metadata @> $' . $placeholder++;
			$values[] = json_encode(['event' => $filters['event_type']]);
		}
		if (isset($filters['min_level']) && isset($filters['max_level']) && empty($filters['min_level']) === false && empty($filters['max_level']) === false) {
			if ($filters['min_level'] === $filters['max_level']) {
				$clauses[] = 'level = $' . $placeholder++;
				$values[] = $filters['min_level'];
			} else {
				$clauses[] = 'sentinel.log_level_position(level) BETWEEN sentinel.log_level_position($' . $placeholder++ . ') AND sentinel.log_level_position($' . $placeholder++ . ')';
				$values[] = $filters['min_level'];
				$values[] = $filters['max_level'];
			}
		} else if (isset($filters['min_level']) && empty($filters['min_level']) === false) {
			$clauses[] = 'sentinel.log_level_position(level) >= sentinel.log_level_position($' . $placeholder++ . ')';
			$values[] = $filters['min_level'];
		} else if (isset($filters['max_level']) && empty($filters['max_level']) === false) {
			$clauses[] = 'sentinel.log_level_position(level) <= sentinel.log_level_position($' . $placeholder++ . ')';
			$values[] = $filters['max_level'];
		}
		if (isset($filters['newer_than']) && isset($filters['older_than']) && is_numeric($filters['newer_than']) && is_numeric($filters['older_than'])) {
			$clauses[] = 'log_time BETWEEN to_timestamp($' . $placeholder++ . ') AND to_timestamp($' . $placeholder++ . ')';
			$values[] = floatval($filters['newer_than']);
			$values[] = floatval($filters['older_than']);
		} else if (isset($filters['newer_than']) && is_numeric($filters['newer_than'])) {
			$clauses[] = 'log_time >= to_timestamp($' . $placeholder++ . ')';
			$values[] = floatval($filters['newer_than']);
		} else if (isset($filters['older_than']) && is_numeric($filters['older_than'])) {
			$clauses[] = 'log_time <= to_timestamp($' . $placeholder++ . ')';
			$values[] = floatval($filters['older_than']);
		}
		$main_sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE ' . implode(' AND ', $clauses) . ' ORDER BY log_time';
		$total_sql = 'SELECT COUNT(message_id) AS num_results FROM ' . static::SQLLongTableName() . ' WHERE ' . implode(' AND ', $clauses);
		if ($newest_first) {
			$main_sql .= ' DESC';
		}
		$main_sql .= ' OFFSET ' . $offset . ' LIMIT ' . $page_size . ';';
		$total_sql .= ';';
		
		$database = BeaconCommon::Database();
		$rows = $database->Query($main_sql, $values);
		$totals = $database->Query($total_sql, $values);
		$total = intval($totals->Field('num_results'));
		
		$results = [
			'total' => $total,
			'page' => $page_num,
			'range' => [
				'start' => $offset + 1,
				'end' => min($total, $offset + $page_size)
			],
			'params' => [
				'filters' => $filters,
				'newest_first' => $newest_first,
				'page_num' => $page_num,
				'page_size' => $page_size
			],
			'messages' => static::FromRows($rows)
		];
		return $results;
	}*/
}

?>
