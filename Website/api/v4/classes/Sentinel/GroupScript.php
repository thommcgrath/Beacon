<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRabbitMQ, BeaconRecordSet, JsonSerializable;

class GroupScript extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		PreparePropertyValue as protected MDOPreparePropertyValue;
	}

	const kOriginDirect = 'Direct';
	const kOriginCommunity = 'Community';

	protected string $groupScriptId;
	protected string $groupId;
	protected string $scriptId;
	protected string $scriptName;
	protected int $permissionsMask;
	protected array $parameterValues;
	protected ?string $revisionId;
	protected ?float $revisionDate;
	protected string $origin;

	public function __construct(BeaconRecordSet $row) {
		$this->groupScriptId = $row->Field('group_script_id');
		$this->groupId = $row->Field('group_id');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->permissionsMask = $row->Field('permissions_mask');
		$this->parameterValues = json_decode($row->Field('parameter_values'), true);
		$this->revisionId = $row->Field('revision_id');
		$this->revisionDate = $row->Field('revision_date');
		$this->origin = $row->Field('origin');
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
				new DatabaseObjectProperty('permissionsMask', ['columnName' => 'permissions_mask', 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('parameterValues', ['columnName' => 'parameter_values', 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('revisionId', ['columnName' => 'revision_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('revisionDate', ['columnName' => 'revision_date', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways, 'accessor' => 'EXTRACT(EPOCH FROM script_revisions.date_created)']),
				new DatabaseObjectProperty('origin', ['required' => false]),
			],
			joins: [
				'INNER JOIN sentinel.scripts ON (scripts.script_id = group_scripts.script_id)',
				'LEFT JOIN sentinel.script_revisions ON (group_scripts.revision_id = script_revisions.script_revision_id)',
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
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'groupId');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
		$parameters->AddFromFilter($schema, $filters, 'scriptName', 'ILIKE');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupScriptId' => $this->groupScriptId,
			'groupId' => $this->groupId,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'permissionsMask' => $this->permissionsMask,
			'parameterValues' => (object) $this->parameterValues,
			'revisionId' => $this->revisionId,
			'revisionDate' => $this->revisionDate,
			'origin' => $this->origin,
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
		if (isset($filters['groupId'])) {
			if (Group::TestSentinelPermissions($filters['groupId'], $userId)) {
				return;
			} else {
				throw new APIException(message: 'You do not have any permissions on the requested group.', code: 'forbidden', httpStatus: 403);
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
		throw new APIException(message: 'You must filter on groupId or scriptId.', code: 'forbidden', httpStatus: 403);
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		if (isset($newObjectProperties['groupId']) === false || isset($newObjectProperties['scriptId']) === false) {
			return false;
		}

		if (Group::TestSentinelPermissions($newObjectProperties['groupId'], $user->UserId(), PermissionBits::ManageScripts) === false) {
			return false;
		}

		if (Script::TestSentinelPermissions($newObjectProperties['scriptId'], $user->UserId(), PermissionBits::ShareScripts)) {
			$newObjectProperties['origin'] = self::kOriginDirect;
		} elseif (CommunityScript::TestSentinelPermissions($newObjectProperties['scriptId'], $user->UserId(), PermissionBits::ShareScripts)) {
			$newObjectProperties['origin'] = self::kOriginCommunity;
		} else {
			return false;
		}

		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$groupPermissions = Group::GetSentinelPermissions($this->groupId, $userId);
		$scriptPermissions = Script::GetSentinelPermissions($this->scriptId, $userId);

		if ($groupPermissions > 0 || $scriptPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($groupPermissions & PermissionBits::ManageScripts) > 0) {
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
