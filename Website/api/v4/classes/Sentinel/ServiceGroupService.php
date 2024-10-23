<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroupService extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $serviceGroupServiceId;
	protected string $serviceGroupId;
	protected string $serviceId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupServiceId = $row->Field('service_group_service_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->serviceId = $row->Field('service_id');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_services', [
			new DatabaseObjectProperty('serviceGroupServiceId', ['columnName' => 'service_group_service_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
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
			'serviceGroupServiceId' => $this->serviceGroupServiceId,
			'serviceGroupId' => $this->serviceGroupId,
			'serviceId' => $this->serviceId,
			'permissions' => $this->permissions,
		];
	}

	public function ServiceGroupServiceId(): string {
		return $this->serviceGroupServiceId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function Permissions(): int {
		return $this->permissions;
	}
}

?>
