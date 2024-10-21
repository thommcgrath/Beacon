<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroupMember extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $serviceGroupMemberId;
	protected string $serviceGroupId;
	protected string $serviceId;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupMemberId = $row->Field('service_group_member_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceId = $row->Field('service_id');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_members', [
			new DatabaseObjectProperty('serviceGroupMemberId', ['columnName' => 'service_group_member_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupMemberId' => $this->serviceGroupMemberId,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceId' => $this->serviceId,
		];
	}

	public function ServiceGroupMemberId(): string {
		return $this->serviceGroupMemberId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}
}

?>
