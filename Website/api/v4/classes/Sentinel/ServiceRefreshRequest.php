<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class ServiceRefreshRequest extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected $requestId = null;
	protected $serviceId = null;
	protected $serviceName = null;
	protected $serviceNickname = null;
	protected $userId = null;
	protected $requestedAt = null;
	protected $isPending = null;

	public function __construct(BeaconRecordSet $row) {
		$this->requestId = $row->Field('request_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceName = $row->Field('service_name');
		$this->serviceNickname = $row->Field('service_nickname');
		$this->userId = $row->Field('user_id');
		$this->requestedAt = intval($row->Field('request_time'));
		$this->isPending = $row->Field('is_pending');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_refresh_requests', [
			new DatabaseObjectProperty('requestId', ['primaryKey' => true, 'columnName' => 'request_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('serviceName', ['columnName' => 'service_name', 'accessor' => 'services.name', 'required' => false]),
			new DatabaseObjectProperty('serviceNickname', ['columnName' => 'service_nickname', 'accessor' => 'services.nickname', 'required' => false]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('requestedAt', ['columnName' => 'request_time', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('isPending', ['columnName' => 'is_pending', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
		], [
			"INNER JOIN sentinel.services ON (service_refresh_requests.service_id = services.service_id)",
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('requestedAt') . ' DESC';
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'isPending');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = '(' . $schema->Comparison('userId', '=', $userIdPlaceholder) . ' OR service_refresh_requests.service_id IN (SELECT service_id FROM sentinel.service_group_members WHERE group_id IN (SELECT group_id FROM sentinel.service_groups WHERE user_id = $' . $userIdPlaceholder . ') OR group_id IN (SELECT group_id FROM sentinel.service_group_permissions WHERE user_id = $' . $userIdPlaceholder . ')))';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'requestId' => $this->requestId,
			'serviceId' => $this->serviceId,
			'serviceName' => $this->serviceName,
			'serviceNickname' => $this->serviceNickname,
			'userId' => $this->userId,
			'requestedAt' => $this->requestedAt,
			'isPending' => $this->isPending,
		];
	}

	public function RequestId(): string {
		return $this->requestId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function ServiceName(): string {
		return $this->serviceName;
	}

	public function ServiceNickname(): ?string {
		return $this->serviceNickname;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function RequestedAt(): int {
		return $this->requestAt;
	}

	public function IsPending(): bool {
		return $this->isPending;
	}
}

?>
