<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Tribe extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $tribeId;
	protected string $tribeName;
	protected int $tribeNumber;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->tribeId = $row->Field('tribe_id');
		$this->tribeName = $row->Field('tribe_name');
		$this->tribeNumber = $row->Field('tribe_number');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'tribes',
			definitions: [
				new DatabaseObjectProperty('tribeId', ['columnName' => 'tribe_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('tribeName', ['columnName' => 'tribe_name', 'accessor' => 'tribes.name']),
				new DatabaseObjectProperty('tribeNumber', ['columnName' => 'tribe_number', 'accessor' => 'tribes.tribe_number']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'accessor' => 'services.service_id']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'accessor' => 'services.color']),
				new DatabaseObjectProperty('permissions', ['columnName' => 'permissions', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'service_permissions.permissions']),
			],
			joins: [
				'INNER JOIN sentinel.services ON (tribes.service_id = services.service_id)',
				'INNER JOIN sentinel.service_permissions ON (tribes.service_id = service_permissions.service_id AND service_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'tribeName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'serviceDisplayName':
			case 'tribeName':
			case 'tribeNumber':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'SEARCH');
		$parameters->AddFromFilter($schema, $filters, 'tribeName', 'SEARCH');
		$parameters->AddFromFilter($schema, $filters, 'tribeNumber');
	}

	public function jsonSerialize(): mixed {
		return [
			'tribeId' => $this->tribeId,
			'tribeName' => $this->tribeName,
			'tribeNumber' => $this->tribeNumber,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'permissions' => $this->permissions,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return false;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = DatabaseObject::kPermissionNone;
		if (($this->permissions & PermissionBits::Membership) === PermissionBits::Membership) {
			$permissions = $permissions | DatabaseObject::kPermissionRead;
		}
		if (($this->permissions & PermissionBits::ControlServices) === PermissionBits::ControlServices) {
			$permissions = $permissions | DatabaseObject::kPermissionUpdate | DatabaseObject::kPermissionDelete;
		}
		return $permissions;
	}
}

?>
