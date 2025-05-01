<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, JsonSerializable;

class ServiceScript extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		PreparePropertyValue as protected MDOPreparePropertyValue;
	}

	protected string $serviceScriptId;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $scriptId;
	protected string $scriptName;
	protected string $scriptContext;
	protected string $scriptLanguage;
	protected array $parameterValues;
	protected ?int $revisionNumber;
	protected int $latestRevision;

	public function __construct(BeaconRecordSet $row) {
		$this->serviceScriptId = $row->Field('service_script_id');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->scriptContext = $row->Field('script_context');
		$this->scriptLanguage = $row->Field('script_language');
		$this->parameterValues = json_decode($row->Field('parameter_values'), true);
		$this->revisionNumber = $row->Field('revision_number');
		$this->latestRevision = $row->Field('latest_revision');
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
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('scriptName', ['columnName' => 'script_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.name']),
				new DatabaseObjectProperty('scriptContext', ['columnName' => 'script_context', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.context']),
				new DatabaseObjectProperty('scriptLanguage', ['columnName' => 'script_language', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.language']),
				new DatabaseObjectProperty('parameterValues', ['columnName' => 'parameter_values', 'required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('revisionNumber', ['columnName' => 'revision_number', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('latestRevision', ['columnName' => 'latest_revision', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.latest_revision']),
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
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
		$parameters->AddFromFilter($schema, $filters, 'scriptName', 'ILIKE');

		if (isset($filters['scriptContext'])) {
			$contexts = explode(',', $filters['scriptContext']);
			if (count($contexts) === 1) {
				$placeholder = $parameters->AddValue($contexts[0]);
				$parameters->clauses[] = $schema->Accessor('scriptContext') . ' = $' . $placeholder;
			} elseif (count($contexts) > 0) {
				$placeholders = [];
				foreach ($contexts as $context) {
					$placeholders[] = '$' . $parameters->AddValue($context);
				}
				$parameters->clauses[] = $schema->Accessor('scriptContext') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}

		if (isset($filters['scriptLanguage'])) {
			$languages = explode(',', $filters['scriptLanguage']);
			if (count($languages) === 1) {
				$placeholder = $parameters->AddValue($languages[0]);
				$parameters->clauses[] = $schema->Accessor('scriptLanguage') . ' = $' . $placeholder;
			} elseif (count($languages) > 0) {
				$placeholders = [];
				foreach ($languages as $language) {
					$placeholders[] = '$' . $parameters->AddValue($language);
				}
				$parameters->clauses[] = $schema->Accessor('scriptLanguage') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'serviceScriptId' => $this->serviceScriptId,
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'scriptContext' => $this->scriptContext,
			'scriptLanguage' => $this->scriptLanguage,
			'parameterValues' => (object) $this->parameterValues,
			'revisionNumber' => $this->revisionNumber,
			'latestRevision' => $this->latestRevision,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$userId = Core::UserId();
		if (isset($filters['serviceId'])) {
			if (Service::TestSentinelPermissions($filters['serviceId'], $userId)) {
				return;
			} else {
				throw new APIException(message: 'You do not have any permissions on the requested service.', code: 'forbidden', httpStatus: 403);
			}
		}
		if (isset($filters['scriptId'])) {
			if (Script::TestSentinelPermissions($filters['scriptId'], $userId)) {
				return;
			} else {
				throw new APIException(message: 'You do not have any permissions on the requested script.', code: 'forbidden', httpStatus: 403);
			}
		}

		// There's no way to know what they user wants to do here, so block it.
		throw new APIException(message: 'You must filter on serviceId or scriptId.', code: 'forbidden', httpStatus: 403);
	}

	// User must have Edit Services permission on the service, and Share Scripts permission on the script.
	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['serviceId']) === false || isset($newObjectProperties['scriptId']) === false || Service::TestSentinelPermissions($newObjectProperties['serviceId'], $user->UserId(), PermissionBits::ManageScripts) === false || Script::TestSentinelPermissions($newObjectProperties['scriptId'], $user->UserId(), PermissionBits::ShareScripts) === false) {
			return false;
		}
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$servicePermissions = Service::GetSentinelPermissions($this->serviceId, $userId);
		$scriptPermissions = Script::GetSentinelPermissions($this->scriptId, $userId);

		if ($servicePermissions > 0 || $scriptPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($servicePermissions & PermissionBits::ManageScripts) > 0) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
			if (($scriptPermissions & PermissionBits::ShareScripts) > 0) {
				$permissions = $permissions | self::kPermissionCreate;
			}
		}

		return $permissions;
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		$value = static::MDOPreparePropertyValue($definition, $value, $otherProperties);

		switch ($definition->PropertyName()) {
		case 'parameterValues':
			return json_encode((object) $value);
		}

		return $value;
	}
}

?>
