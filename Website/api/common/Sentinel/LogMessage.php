<?php

namespace BeaconAPI\Sentinel;

class LogMessage implements \JsonSerializable {
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
	
	const SQLSchemaName = 'sentinel';
	const SQLTableName = 'service_logs';
	const SQLLongTableName = self::SQLSchemaName . '.' . self::SQLTableName;
	const SQLColumns = [
		self::SQLTableName . '.message_id',
		self::SQLTableName . '.service_id',
		self::SQLTableName . '.type',
		'EXTRACT(EPOCH FROM ' . self::SQLTableName . '.log_time) AS log_time',
		self::SQLTableName . '.message',
		self::SQLTableName . '.level',
		self::SQLTableName . '.analyzer_status',
		self::SQLTableName . '.metadata'
	];
	
	protected $message_id = null;
	protected $service_id = null;
	protected $type = null;
	protected $time = null;
	protected $message = null;
	protected $level = null;
	protected $analyzer_status = null;
	protected $metadata = null;
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row = null) {
		if (is_null($row) === false) {
			$this->message_id = $row->Field('message_id');
			$this->service_id = $row->Field('service_id');
			$this->type = $row->Field('type');
			$this->time = floatval($row->Field('log_time'));
			$this->message = $row->Field('message');
			$this->level = $row->Field('level');
			$this->analyzer_status = $row->Field('analyzer_status');
			$this->metadata = json_decode($row->Field('metadata'), true);
		} else {
			$this->message_id = \BeaconCommon::GenerateUUID();
			$this->time = time();
			$this->level = self::LogLevelInfo;
			$this->type = self::LogTypeService;
			$this->analyzer_status = self::AnalyzerStatusSkipped;
			$this->metadata = [];
		}
	}
	
	public static function Create(string $message, string $service_id, string $level = null, string $type = null): LogMessage {
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
	
	protected static function HookConsumeLogLines(string $service_id, array $lines): array {
		return [];
	}
	
	public static function ConsumeLogFile(string $service_id, mixed $file_handle): array {
		$file_content = stream_get_contents($file_handle);
		
		// normalize line endings
		$file_content = str_replace("\r\n", "\n", $file_content);
		$file_content = str_replace("\r", "\n", $file_content);
		
		// split
		$lines = explode("\n", $file_content);
		
		// let the game-specific class do the heavy lifting
		$messages = static::HookConsumeLogLines($service_id, $lines);
		
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
				$database->Query('INSERT INTO ' . self::SQLLongTableName . ' (message_id, service_id, type, log_time, message, level, analyzer_status, metadata) VALUES ($1, $2, $3, to_timestamp($4), $5, $6, $7, $8);', $message->message_id, $message->service_id, $message->type, $message->time, $message->message, $message->level, $message->analyzer_status, $metadata);
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
		$rows = $database->Query('SELECT ' . implode(', ', self::SQLColumns) . ' FROM ' . self::SQLLongTableName . ' WHERE message_id = $1;', $message_id);
		if ($rows->RecordCount() !== 0) {
			return null;
		}
		return new static($rows);
	}
	
	public static function GetMessagesForService(string $service_id, int $offset = 0, int $limit = 500): array {
		// Searches for a service or group
		$database = \BeaconCommon::Database();
		$rows = $database->Query('SELECT ' . implode(', ', self::SQLColumns) . ' FROM ' . self::SQLLongTableName . ' WHERE service_id = $1 OR service_id IN (SELECT service_id FROM sentinel.service_group_members WHERE group_id = $1) ORDER BY log_time DESC OFFSET $2 LIMIT $3;', $service_id, $offset, $limit);
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
	
	protected static function ResolveChatImage(string $image_path): string {
		switch ($image_path) {
		case '/Game/PrimalEarth/Emo/Emo_Blank.Emo_Blank':
			return '😐';
		case '/Game/PrimalEarth/Emo/Emo_Evil.Emo_Evil':
			return '😈';
		case '/Game/PrimalEarth/Emo/Emo_Eyes.Emo_Eyes':
			return '😳';
		case '/Game/PrimalEarth/Emo/Emo_Laugh.Emo_Laugh':
			return '😃';
		case '/Game/PrimalEarth/Emo/Emo_Sad.Emo_Sad':
			return '😢';
		case '/Game/PrimalEarth/Emo/Emo_Smile.Emo_Smile':
			return '😊';
		case '/Game/PrimalEarth/Emo/Emo_Tongue.Emo_Tongue':
			return '😝';
		case '/Game/PrimalEarth/Emo/Emo_Wink.Emo_Wink':
			return '😉';
		default:
			return "Image:$image_path:";
		}
	}
}

?>
