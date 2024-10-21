<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ServiceGroupUser extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $serviceGroupUserId;
	protected string $serviceGroupId;
	protected string $userId;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceGroupUserId = $row->Field('service_group_user_id');
		$this->serviceGroupId = $row->Field('service_group_id');
		$this->userId = $row->Field('user_id');
		$this->permissions = intval($row->Field('permissions'));
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'service_group_users', [
			new DatabaseObjectProperty('serviceGroupUserId', ['columnName' => 'service_group_user_id', 'primaryKey' => true, 'required' => false]),
			new DatabaseObjectProperty('serviceGroupId', ['columnName' => 'service_group_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('permissions', ['editable' => DatabaseObjectProperty::kEditableAlways]),
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('userId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'serviceGroupId');

		if (isset($filters['permissions'])) {
			$placeholder = $parameters->AddValue($filters['permissions']);
			$parameters->clauses[] = '(' . $schema->Accessor('permissions') . ' & $' . $placeholder . ') = $' . $placeholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceGroupUserId' => $this->serviceGroupUserId,
			'serviceGroupId' => $this->serviceGroupId,
			'userId' => $this->userId,
			'permissions' => $this->permissions,
		];
	}

	public function ServiceGroupUserId(): string {
		return $this->serviceGroupUserId;
	}

	public function ServiceGroupId(): string {
		return $this->serviceGroupId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Permissions(): int {
		return $this->permissions;
	}

	public function SetPermissions(int $permissions): void {
		$this->SetProperty('permissions', $permissions);
	}
}

?>
