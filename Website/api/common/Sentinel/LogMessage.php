<?php

namespace BeaconAPI\Sentinel;

class LogMessage extends \BeaconAPI\DatabaseObject implements \JsonSerializable {
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
	
	protected $message_id = null;
	protected $service_id = null;
	protected $type = null;
	protected $time = null;
	protected $message = null;
	protected $level = null;
	protected $analyzer_status = null;
	protected $metadata = null;
	
	public static function SQLSchemaName(): string {
		return 'sentinel';
	}
	
	public static function SQLTableName(): string {
		return 'service_logs';
	}
	
	public static function SQLPrimaryKey(): string {
		return 'message_id';
	}
	
	public static function SQLColumns(): array {
		return [
			'message_id',
			'service_id',
			'type',
			'EXTRACT(EPOCH FROM log_time) AS log_time',
			'message',
			'level',
			'analyzer_status',
			'metadata'
		];
	}
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->message_id = $row->Field('message_id');
		$this->service_id = $row->Field('service_id');
		$this->type = $row->Field('type');
		$this->time = floatval($row->Field('log_time'));
		$this->message = $row->Field('message');
		$this->level = $row->Field('level');
		$this->analyzer_status = $row->Field('analyzer_status');
		$this->metadata = json_decode($row->Field('metadata'), true);
	}
	
	public static function Create(string $message, string $service_id, ?string $level = null, ?string $type = null): LogMessage {
		if (is_null($level) === false && in_array($level, self::LogLevels) === false) {
			throw new \Error('Invalid log level');
		}
		if (is_null($type) === false && in_array($type, self::LogTypes) === false) {
			throw new \Error('Invalid log type');
		}
		
		$log = new static();
		$log->message = $message;
		$log->service_id = $service_id;
		if (is_null($level) === false) {
			$log->level = $level;
		}
		if (is_null($type) === false) {
			$log->type = $type;
		}
		return $log;
	}
	
	protected static function HookConsumeLogLines(string $service_id, float $last_timestamp, array $lines): array {
		return [];
	}
	
	public static function ConsumeLogFile(string $service_id, string $file_content): array {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT COALESCE(EXTRACT(EPOCH FROM MAX(log_time)), 0) AS last_timestamp FROM sentinel.service_logs WHERE service_id = $1;', $service_id);
		$last_timestamp = floatval($rows->Field('last_timestamp'));
		
		// normalize line endings
		$file_content = str_replace("\r\n", "\n", $file_content);
		$file_content = str_replace("\r", "\n", $file_content);
		
		// split
		$lines = explode("\n", $file_content);
		
		// let the game-specific class do the heavy lifting
		$messages = static::HookConsumeLogLines($service_id, $last_timestamp, $lines);
		
		// save
		static::SaveLogs($messages);
		
		// and return
		return $messages;
	}
	
	public static function SaveLogs(array $messages): void {
		if (count($messages) === 0) {
			return;
		}
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			foreach ($messages as $message) {
				$metadata = count($message->metadata) > 0 ? json_encode($message->metadata) : '{}';
				$database->Query('INSERT INTO ' . static::SQLLongTableName() . ' (message_id, service_id, type, log_time, message, level, analyzer_status, metadata) VALUES ($1, $2, $3, to_timestamp($4), $5, $6, $7, $8);', $message->message_id, $message->service_id, $message->type, $message->time, $message->message, $message->level, $message->analyzer_status, $metadata);
			}
		} catch (\Exception $err) {
			$database->Rollback();
			throw $err;
		}
		$database->Commit();
	}
	
	public static function RunAnalyzer(): void {
		
	}
	
	public static function GetMessageByID(string $message_id): ?LogMessage {
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE message_id = $1;', $message_id);
		if ($rows->RecordCount() !== 0) {
			return null;
		}
		return new static($rows);
	}
	
	public static function GetMessagesForService(string $service_id, int $offset = 0, int $limit = 500): array {
		// Searches for a service or group
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SQLLongTableName() . ' WHERE service_id = $1 OR service_id IN (SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1) ORDER BY log_time DESC OFFSET $2 LIMIT $3;', $service_id, $offset, $limit);
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
			'message_id' => $this->message_id,
			'service_id' => $this->service_id,
			'type' => $this->type,
			'time' => $this->time,
			'message' => $this->message,
			'level' => $this->level,
			'analyzer_status' => $this->analyzer_status,
			'metadata' => $this->metadata
		];
	}
	
	public function MessageID(): string {
		return $this->message_id;
	}
	
	public function ServiceID(): string {
		return $this->service_id;
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
		return $this->analyzer_status;
	}
	
	public function MetaData(): array {
		return $this->metadata;
	}
	
	public function IsError(): bool {
		return 	in_array($this->level, self::ErrorLogLevels);
	}
	
	public static function Search(string $service_id, array $filters = [], bool $newest_first = true, int $page_num = 1, int $page_size = 250): array {
		$page_num = max($page_num, 1);
		$offset = $page_size * ($page_num - 1);
		$clauses = ['service_id = $1'];
		$values = [$service_id];
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
		
		$database = \BeaconCommon::Database();
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
	}
}

?>
