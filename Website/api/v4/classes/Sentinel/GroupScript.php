<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, Exception, JsonSerializable;

class GroupScript extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		PreparePropertyValue as protected MDOPreparePropertyValue;
	}

	protected string $groupScriptId;
	protected string $groupId;
	protected string $scriptId;
	protected string $scriptName;
	protected string $scriptContext;
	protected string $scriptLanguage;
	protected int $permissionsMask;
	protected array $parameterValues;

	public function __construct(BeaconRecordSet $row) {
		$this->groupScriptId = $row->Field('group_script_id');
		$this->groupId = $row->Field('group_id');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->scriptContext = $row->Field('script_context');
		$this->scriptLanguage = $row->Field('script_language');
		$this->permissionsMask = $row->Field('permissions_mask');
		$this->parameterValues = json_decode($row->Field('parameter_values'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'group_scripts',
			definitions: [
				new DatabaseObjectProperty('groupScriptId', ['columnName' => 'group_script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('groupId', ['columnName' => 'group_id']),
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id']),
				new DatabaseObjectProperty('scriptName', ['columnName' => 'script_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.name']),
				new DatabaseObjectProperty('scriptContext', ['columnName' => 'script_context', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.context']),
				new DatabaseObjectProperty('scriptLanguage', ['columnName' => 'script_language', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.language']),
				new DatabaseObjectProperty('permissionsMask', ['columnName' => 'permissions_mask', 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('parameterValues', ['columnName' => 'parameter_values', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN sentinel.scripts ON (scripts.script_id = group_scripts.script_id)',
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
			case 'scriptContext':
			case 'scriptLanguage':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
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
			'groupScriptId' => $this->groupScriptId,
			'groupId' => $this->groupId,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'scriptContext' => $this->scriptContext,
			'scriptLanguage' => $this->scriptLanguage,
			'permissionsMask' => $this->permissionsMask,
			'parameterValues' => (object) $this->parameterValues,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['groupId']) === false || Group::TestUserPermissions($filters['groupId'], Core::UserId()) === false) {
			throw new Exception('Forbidden');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		// We don't need to approve, only reject.
		if (isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['scriptId']) || Group::TestUserPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageScripts) === false || Script::TestUserPermissions($newObjectProperties['scriptId'], $user->UserId(), PermissionBits::ShareScripts) === false) {
			return false;
		}
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$groupPermissions = Group::GetUserPermissions($this->groupId, $userId);
		$scriptPermissions = Script::GetUserPermissions($this->scriptId, $userId);

		if ($groupPermissions > 0 || $scriptPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($groupPermissions & PermissionBits::ManageScripts) > 0 && ($scriptPermissions & PermissionBits::ShareScripts) > 0) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
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
