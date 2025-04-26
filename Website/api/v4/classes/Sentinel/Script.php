<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Script extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
		PreparePropertyValue as protected MDOPreparePropertyValue;
		InitializeProperties as protected MDOInitializeProperties;
	}
	use SentinelObject;

	const LanguageSimple = 'Simple';
	const LanguageJavaScript = 'JavaScript';
	const Languages = [
		self::LanguageSimple,
		self::LanguageJavaScript,
	];

	protected string $scriptId;
	protected string $userId;
	protected string $name;
	protected string $context;
	protected array $parameters;
	protected string $code;
	protected string $language;
	protected float $dateCreated;
	protected float $dateModified;
	protected bool $enabled;
	protected int $permissions;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->context = $row->Field('context');
		$this->parameters = json_decode($row->Field('parameters'), true);
		$this->code = $row->Field('code');
		$this->language = $row->Field('language');
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
		$this->enabled = $row->Field('enabled');
		$this->permissions = $row->Field('permissions');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'scripts',
			definitions: [
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('context', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('parameters', ['columnName' => 'parameters', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('code', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('language', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('enabled', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('permissions', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'script_permissions.permissions']),
			],
			joins: [
				'INNER JOIN public.users ON (scripts.user_id = users.user_id)',
				'INNER JOIN sentinel.script_permissions ON (scripts.script_id = script_permissions.script_id AND script_permissions.user_id = %%USER_ID%%)'
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'name';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'name':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');

		if (isset($filters['language'])) {
			$languages = explode(',', $filters['language']);
			if (count($languages) === 1) {
				$placeholder = $parameters->AddValue($languages[0]);
				$parameters->clauses[] = $schema->Accessor('language') . ' = $' . $placeholder;
			} elseif (count($languages) > 0) {
				$placeholders = [];
				foreach ($languages as $language) {
					$placeholders[] = '$' . $parameters->AddValue($language);
				}
				$parameters->clauses[] = $schema->Accessor('language') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}

		if (isset($filters['context'])) {
			$contexts = explode(',', $filters['context']);
			if (count($contexts) === 1) {
				$placeholder = $parameters->AddValue($contexts[0]);
				$parameters->clauses[] = $schema->Accessor('context') . ' = $' . $placeholder;
			} elseif (count($contexts) > 0) {
				$placeholders = [];
				foreach ($contexts as $context) {
					$placeholders[] = '$' . $parameters->AddValue($context);
				}
				$parameters->clauses[] = $schema->Accessor('context') . ' IN (' . implode(', ', $placeholders) . ')';
			}
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'name' => $this->name,
			'context' => $this->context,
			'parameters' => $this->parameters,
			'code' => $this->code,
			'language' => $this->language,
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
			'enabled' => $this->enabled,
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
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		if (is_null($user)) {
			return self::kPermissionNone;
		} elseif ($user->UserId() === $this->userId) {
			$scriptPermissions = $this->permissions;
		} else {
			$scriptPermissions = static::GetSentinelPermissions($this->scriptId, $user->UserId());
		}

		$permissions = 0;
		if (($scriptPermissions & PermissionBits::Membership) > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($scriptPermissions & PermissionBits::EditScripts) > 0) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MDOInitializeProperties($properties);
		$properties['userId'] = Core::UserId();
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['context']) && in_array($properties['context'], LogMessage::Events) === false) {
			throw new APIException(message: 'Context is not a valid context. See the documentation for correct values.', code: 'badContext');
		}

		if (isset($properties['language']) && in_array($properties['language'], static::Languages) === false) {
			throw new APIException(message: 'Language is not a valid value. See the documentation for correct values.', code: 'badLanguage');
		}
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		$value = static::MDOPreparePropertyValue($definition, $value, $otherProperties);

		switch ($definition->PropertyName()) {
		case 'parameters':
			return json_encode($value);
		}

		return $value;
	}

	public static function GetSentinelPermissions(string $objectId, string $userId): int {
		if (BeaconCommon::IsUUID($objectId) === false || BeaconCommon::IsUUID($userId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2;', $objectId, $userId);
		if ($rows->RecordCount() === 0) {
			return 0;
		}
		return $rows->Field('permissions');
	}
}

?>
