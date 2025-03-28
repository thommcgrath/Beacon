<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, Exception, JsonSerializable;

class ServiceScript extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected $serviceScriptId;
	protected $serviceId;
	protected $serviceDisplayName;
	protected $serviceColor;
	protected $serviceOwnerId;
	protected $scriptId;
	protected $scriptName;
	protected $scriptOwnerId;
	protected $scriptContext;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceScriptId = $row->Field('service_script_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->serviceOwnerId = $row->Field('service_owner_id');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->scriptOwnerId = $row->Field('script_owner_id');
		$this->scriptContext = $row->Field('script_context');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'service_scripts',
			definitions: [
				new DatabaseObjectProperty('serviceScriptId', ['columnName' => 'service_script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.color']),
				new DatabaseObjectProperty('serviceOwnerId', ['columnName' => 'service_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'services.user_id']),
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('scriptName', ['columnName' => 'script_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.name']),
				new DatabaseObjectProperty('scriptOwnerId', ['columnName' => 'script_owner_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.user_id']),
				new DatabaseObjectProperty('scriptContext', ['columnName' => 'script_context', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.context']),
			],
			joins: [
				'INNER JOIN sentinel.scripts ON (service_scripts.script_id = scripts.script_id)',
				'INNER JOIN sentinel.services ON (service_scripts.service_id = services.service_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'scriptName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'scriptName':
			case 'serviceDisplayName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceOwnerId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
		$parameters->AddFromFilter($schema, $filters, 'scriptName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'scriptOwnerId');
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceScriptId' => $this->serviceScriptId,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'serviceOwnerId' => $this->serviceOwnerId,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'scriptOwnerId' => $this->scriptOwnerId,
			'scriptContext' => $this->scriptContext,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$userId = Core::UserId();
		if (isset($filters['scriptId'])) {
			// Ensure that the user has permission on this script before listing all services for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $filters['scriptId'], $userId, PermissionBits::EditServices);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}
		if (isset($filters['serviceId'])) {
			// Ensure that the user has permission on this server before listing all scripts for it
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $filters['serviceId'], $userId, PermissionBits::EditServices);
			if ($rows->RecordCount() === 0) {
				throw new Exception('Forbidden');
			}
			return;
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new Exception('You must filter on scriptId or serviceId.');
	}

	// User must have Edit Services permission on the service, and Share Scripts permission on the script.
	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['scriptId']) === false || isset($newObjectProperties['serviceId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['serviceId'], $user->UserId(), PermissionBits::EditServices);
		if ($rows->RecordCount() !== 1) {
			return false;
		}

		$rows = $database->Query('SELECT 1 FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $newObjectProperties['scriptId'], $user->UserId(), PermissionBits::ShareScripts);
		return $rows->RecordCount() === 1;
	}

	public function GetPermissionsForUser(User $user): int {
		$userId = $user->UserId();
		if ($this->scriptOwnerId === $userId || $this->serviceOwnerId = $userId) {
			return self::kPermissionRead | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		$database = DatabaseCommon::Database();
		$rows = $database->Query('SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $this->serviceId, $userId, PermissionBits::EditServices);
		if ($rows === 0) {
			return self::kPermissionNone;
		}

		$rows = $database->Query('SELECT 1 FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2 AND (permissions & $3) > 0;', $this->scriptId, $userId, PermissionBits::ShareScripts);
		if ($rows === 0) {
			return self::kPermissionNone;
		}

		return self::kPermissionRead | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
	}
}

?>
