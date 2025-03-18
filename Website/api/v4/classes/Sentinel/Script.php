<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, Exception, BeaconRecordSet, JsonSerializable;

class Script extends DatabaseObject implements JsonSerializable, Asset {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $scriptId;
	protected string $userId;
	protected string $username;
	protected string $name;
	protected string $context;
	protected array $contextParams;
	protected string $code;
	protected string $language;
	protected float $dateCreated;
	protected float $dateModified;
	protected ?array $visualRepresentation;
	protected bool $enabled;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->username = $row->Field('username');
		$this->name = $row->Field('name');
		$this->context = $row->Field('context');
		$this->contextParams = json_decode($row->Field('context_params'), true);
		$this->code = $row->Field('code');
		$this->language = $row->Field('language');
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
		$this->visualRepresentation = is_null($row->Field('visual_representation')) === false ? json_decode($row->Field('visual_representation'), true) : null;
		$this->enabled = $row->Field('enabled');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'scripts',
			definitions: [
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('username', ['columnName' => 'username', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('context', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('contextParams', ['columnName' => 'context_params', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('code', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('language', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('visualRepresentation', ['columnName' => 'visual_representation', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('enabled', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			],
			joins: [
				'INNER JOIN public.users ON (scripts.user_id = users.user_id)',
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
			case 'username':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'name', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'username', 'ILIKE');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = '$' . $parameters->AddValue($filters['userId']);
			$parameters->clauses[] = "scripts.script_id IN (SELECT asset_id FROM sentinel.asset_permissions WHERE user_id = {$userIdPlaceholder})";
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'username' => $this->username,
			'name' => $this->name,
			'context' => $this->context,
			'contextParams' => $this->contextParams,
			'code' => $this->code,
			'language' => $this->language,
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
			'visualRepresentation' => $this->visualRepresentation,
			'enabled' => $this->enabled,
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
		$filters['userId'] = Core::UserId();
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT editable FROM sentinel.asset_permissions WHERE asset_id = $1 AND user_id = $2;', $this->scriptId, $user->UserId());
		if ($rows->RecordCount() !== 1) {
			return self::kPermissionNone;
		}

		$permissions = self::kPermissionRead;
		if ($rows->Field('editable') === true) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		if (isset($properties['context']) && in_array($properties['context'], LogMessage::Events) === false) {
			throw new Exception('Context is not a valid context. See the documentation for correct values.');
		}
	}

	public function AssetId(): string {
		return $this->scriptId;
	}

	public function AssetType(): string {
		return 'Script';
	}

	public function AssetTypeMask(): int {
		return 1;
	}

	public function AssetName(): string {
		return $this->name;
	}
}

?>
