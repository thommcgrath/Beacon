<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class RCONCommand extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $logId;
	protected string $serviceId;
	protected string $userId;
	protected string $command;
	protected int $queueTime;
	protected ?int $executeTime;
	protected ?string $response;

	public function __construct(BeaconRecordSet $row) {
		$this->logId = $row->Field('log_id');
		$this->serviceId = $row->Field('service_id');
		$this->userId = $row->Field('user_id');
		$this->command = $row->Field('command');
		$this->queueTime = intval($row->Field('queue_time'));
		$this->executeTime = is_null($row->Field('execute_time')) ? null : intval($row->Field('execute_time'));
		$this->response = is_null($row->Field('response')) ? null : $row->Field('response');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'rcon_logs', [
			new DatabaseObjectProperty('logId', ['primaryKey' => true, 'columnName' => 'log_id', 'required' => false]),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('command'),
			new DatabaseObjectProperty('queueTime', ['columnName' => 'queue_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('executeTime', ['columnName' => 'execute_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
			new DatabaseObjectProperty('response', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('queueTime');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
	}

	public function jsonSerialize(): mixed {
		return [
			'logId' => $this->logId,
			'serviceId' => $this->serviceId,
			'userId' => $this->userId,
			'command' => $this->command,
			'queueTime' => $this->queueTime,
			'executeTime' => $this->executeTime,
			'response' => $this->response,
		];
	}

	public function LogId(): string {
		return $this->logId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Command(): string {
		return $this->command;
	}

	public function QueueTime(): int {
		return $this->queueTime;
	}

	public function ExecuteTime(): ?int {
		return $this->executeTime;
	}

	public function Response(): ?string {
		return $this->response;
	}
}

?>
