<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
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

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesUpdate;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['serviceId']) === false) {
			throw new Exception('Must include serviceId');
		}

		$serviceId = $filters['serviceId'];
		$service = Service::Fetch($serviceId);
		if (is_null($service) || $service->HasPermission(Core::UserId(), DatabaseObject::kPermissionRead) === false) {
			throw new Exception('Service not found');
		}
	}

	public function GetPermissionsForUser(User $user): int {
		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $this->serviceId, user: $user);
		return $servicePermissions & DatabaseObject::kPermissionRead;
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		$servicePermissions = DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\Sentinel\Service', objectId: $newObjectProperties['serviceId'], user: $user);
		if (($servicePermissions & (DatabaseObject::kPermissionRead | DatabaseObject::kPermissionUpdate)) > 0) {
			return true;
		}
		return false;
	}
}

?>
