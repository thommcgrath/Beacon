<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class ScriptTest extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Create as protected MDOCreate;
	}

	protected string $requestId;
	protected string $scriptData;
	protected string $userId;
	protected float $queueTime;
	protected ?float $completionTime;
	protected ?string $output;

	public function __construct(BeaconRecordSet $row) {
		$this->requestId = $row->Field('request_id');
		$this->scriptData = $row->Field('script_data');
		$this->userId = $row->Field('user_id');
		$this->queueTime = floatval($row->Field('queue_time'));
		$this->completionTime = is_null($row->Field('completed_time')) ? null : floatval($row->Field('completed_time'));
		$this->output = $row->Field('output');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'script_tests',
			definitions: [
				new DatabaseObjectProperty('requestId', ['columnName' => 'request_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('scriptData', ['columnName' => 'script_data']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('queueTime', ['columnName' => 'queue_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('completionTime', ['columnName' => 'completed_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('output', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
	}

	public function jsonSerialize(): mixed {
		return [
			'requestId' => $this->requestId,
			'scriptData' => $this->scriptData,
			'userId' => $this->userId,
			'queueTime' => $this->queueTime,
			'completionTime' => $this->completionTime,
			'output' => $this->output,
			'pending' => is_null($this->completionTime),
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		return true;
	}

	public static function Create(array $properties): DatabaseObject {
		try {
			return static::MDOCreate($properties);
		} catch (Exception $err) {
			switch ($err->getCode()) {
			case 23601:
				// Busy
				throw new APIException(message: $err->getMessage(), code: 'testAlreadyRunning', httpStatus: 412);
			default:
				throw $err;
			}
		}
	}
}

?>
