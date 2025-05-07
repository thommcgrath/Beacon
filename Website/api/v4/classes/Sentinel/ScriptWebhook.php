<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconEncryption, BeaconRecordSet, JsonSerializable;

class ScriptWebhook extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		InitializeProperties as protected MDOInitializeProperties;
	}

	protected string $scriptWebhookId;
	protected string $scriptId;
	protected string $scriptName;
	protected string $scriptContext;
	protected array $scriptParameters;
	protected string $userId;
	protected string $purpose;
	protected string $accessKey;
	protected string $accessKeyHash;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptWebhookId = $row->Field('webhook_id');
		$this->scriptId = $row->Field('script_id');
		$this->scriptName = $row->Field('script_name');
		$this->scriptContext = $row->Field('script_context');
		$this->scriptParameters = json_decode($row->Field('script_parameters'), true);
		$this->userId = $row->Field('user_id');
		$this->purpose = $row->Field('purpose');
		$this->accessKey = BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($row->Field('access_key')));
		$this->accessKeyHash = $row->Field('access_key_hash');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'script_webhooks',
			definitions: [
				new DatabaseObjectProperty('scriptWebhookId', ['columnName' => 'webhook_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id']),
				new DatabaseObjectProperty('scriptName', ['columnName' => 'script_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.name']),
				new DatabaseObjectProperty('scriptContext', ['columnName' => 'script_context', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.context']),
				new DatabaseObjectProperty('scriptParameters', ['columnName' => 'script_parameters', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'scripts.parameters']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('purpose', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('accessKey', ['columnName' => 'access_key', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
				new DatabaseObjectProperty('accessKeyHash', ['columnName' => 'access_key_hash', 'dependsOn' => ['accessKey'], 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			],
			joins: [
				'INNER JOIN sentinel.scripts ON (script_webhooks.script_id = scripts.script_id)',
				'INNER JOIN sentinel.script_permissions ON (scripts.script_id = script_permissions.script_id AND script_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'purpose';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'purpose':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'purpose', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'scriptId');
		$parameters->AddFromFilter($schema, $filters, 'userId');

		if (isset($filters['accessKey'])) {
			$accessKeyHash = BeaconCommon::Base64UrlEncode(hash('sha3-512', BeaconCommon::Base64UrlDecode($filters['accessKey']), true));
			$placeholder = $parameters->AddValue($accessKeyHash);
			$parameters->clauses[] = 'script_webhooks.access_key_hash = $' . $placeholder;
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptWebhookId' => $this->scriptWebhookId,
			'scriptId' => $this->scriptId,
			'scriptName' => $this->scriptName,
			'scriptContext' => $this->scriptContext,
			'scriptParameters' => $this->scriptParameters,
			'userId' => $this->userId,
			'purpose' => $this->purpose,
			'accessKey' => BeaconCommon::Base64UrlEncode($this->accessKey),
			'accessKeyHash' => $this->accessKeyHash,
			'triggerUrl' => 'https://' . BeaconCommon::APIDomain() . '/' . Core::ApiVersion() . '/sentinel/scriptWebhooks/' . $this->scriptWebhookId . '/trigger',
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (isset($newObjectProperties['scriptId']) === false) {
			return false;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT scripts.context, script_permissions.permissions FROM sentinel.scripts INNER JOIN sentinel.script_permissions ON (script_permissions.script_id = scripts.script_id) WHERE scripts.script_id = $1 AND script_permissions.user_id = $2;', $newObjectProperties['scriptId'], $user->UserId());
		if ($rows->RecordCount() === 0) {
			return false;
		}
		if (($rows->Field('permissions') & PermissionBits::Membership) !== PermissionBits::Membership) {
			return false;
		}
		$whitelist = ['serviceScriptRun', 'characterScriptRun', 'dinoScriptRun', 'tribeScriptRun'];
		if (in_array($rows->Field('context'), $whitelist) === false) {
			// We want to give the user a little more info
			throw new APIException(message: 'Script must have one of the following contexts: ' . implode(', ', $whitelist) . '.', code: 'invalidContext', httpStatus: 400);
		}

		return true;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$userId = $user->UserId();
		$scriptPermissions = Script::GetSentinelPermissions($this->scriptId, $userId);

		if ($scriptPermissions > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if ($userId = $this->userId) {
			$permissions = $permissions | self::kPermissionCreate | self::kPermissionUpdate | self::kPermissionDelete;
		}

		return $permissions;
	}

	protected static function InitializeProperties(array &$properties): void {
		static::MDOInitializeProperties($properties);

		$accessKey = BeaconEncryption::GenerateKey(256);
		$properties['accessKey'] = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $accessKey));
		$properties['accessKeyHash'] = BeaconCommon::Base64UrlEncode(hash('sha3-512', $accessKey, true));
	}

	public function Authorize(string $requestMethod, string $body, string $testHash): bool {
		$nonce = floor(time() / 30);
		$stringToSign = "{$requestMethod}\n{$nonce}\n{$body}";
		$computedSignature = hash_hmac('sha256', $stringToSign, $this->accessKey);
		return strtolower($computedSignature) === strtolower($testHash);
	}
}

?>
