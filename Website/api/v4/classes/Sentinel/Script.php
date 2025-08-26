<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconEncryption, BeaconRecordSet, BeaconUUID, JsonSerializable;

class Script extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
		PreparePropertyValue as protected MDOPreparePropertyValue;
		InitializeProperties as protected MDOInitializeProperties;
		HookModified as protected MDOHookModified;
		SaveChildObjects as protected MDOSaveChildObjects;
	}
	use SentinelObject;

	const ScriptNamespace = '0ef457e1-331b-4d84-980c-9c890e83e083';

	const LanguageSimple = 'Simple';
	const LanguageJavaScript = 'JavaScript';
	const Languages = [
		self::LanguageSimple,
		self::LanguageJavaScript,
	];

	const ApprovalStatusProbation = 'Probation';
	const ApprovalStatusNeedsReview = 'Needs Review';
	const ApprovalStatusRejected = 'Rejected';
	const ApprovalStatusApproved = 'Approved';

	protected string $scriptId;
	protected string $userId;
	protected string $name;
	protected string $description;
	protected float $dateCreated;
	protected float $dateModified;
	protected string $communityStatus;
	protected int $permissions;
	protected string $latestRevisionId;
	protected string $approvalStatus;
	protected bool $approvalRequestSent;
	protected array $parameters;
	protected string $commonJavascript;
	protected array $events;

	public function __construct(BeaconRecordSet $row) {
		$this->scriptId = $row->Field('script_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->description = $row->Field('description');
		$this->dateCreated = floatval($row->Field('date_created'));
		$this->dateModified = floatval($row->Field('date_modified'));
		$this->communityStatus = $row->Field('community_status');
		$this->permissions = $row->Field('permissions');
		$this->latestRevisionId = $row->Field('latest_revision_id');
		$this->approvalStatus = $row->Field('approval_status');
		$this->parameters = json_decode($row->Field('parameters'), true);
		$this->commonJavascript = $row->Field('common_javascript');

		$this->events = [];
		$events = json_decode($row->Field('events'), true);
		foreach ($events as $event) {
			$filtered = [
				'language' => $event['language'],
				'context' => $event['context'],
				'code' => $event['code'],
			];

			switch ($event['context']) {
			case LogMessage::EventSlashCommand:
			case LogMessage::EventScriptCommand:
				$filtered['commandKeyword'] = $event['commandKeyword'];
				$filtered['commandArguments'] = $event['commandArguments'];
				break;
			case LogMessage::EventManualCharacterScript:
			case LogMessage::EventManualDinoScript:
			case LogMessage::EventManualServiceScript:
			case LogMessage::EventManualTribeScript:
				$filtered['menuText'] = $event['menuText'];
				break;
			case LogMessage::EventWebhook:
				$filtered['webhookId'] = $event['webhookId'];
				$filtered['webhookAccessKey'] = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($event['webhookAccessKey'])));
				break;
			}

			$this->events[] = $filtered;
		}
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'scripts',
			definitions: [
				new DatabaseObjectProperty('scriptId', ['columnName' => 'script_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('description', ['editable' => DatabaseObjectProperty::kEditableAlways, 'required' => false]),
				new DatabaseObjectProperty('dateCreated', ['columnName' => 'date_created', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'EXTRACT(EPOCH FROM GREATEST(%%TABLE%%.%%COLUMN%%, script_revisions.date_created))']),
				new DatabaseObjectProperty('communityStatus', ['columnName' => 'community_status', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('permissions', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'script_permissions.permissions']),
				new DatabaseObjectProperty('latestRevisionId', ['columnName' => 'latest_revision_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'script_revisions.script_revision_id']),
				new DatabaseObjectProperty('approvalStatus', ['columnName' => 'approval_status', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'script_revisions.approval_status']),
				new DatabaseObjectProperty('parameters', ['columnName' => 'parameters', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways, 'accessor' => 'script_revisions.parameters']),
				new DatabaseObjectProperty('commonJavascript', ['columnName' => 'common_javascript', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways, 'accessor' => 'script_revisions.common_javascript']),
				new DatabaseObjectProperty('events', ['required' => true, 'editable' => DatabaseObjectProperty::kEditableAlways, 'accessor' => 'COALESCE((SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(events_template))) FROM (SELECT script_events.language, script_events.context, script_events.code, script_revision_events.command_keyword AS "commandKeyword", script_revision_events.command_arguments AS "commandArguments", menu_text AS "menuText", webhook_id AS "webhookId", webhook_access_key AS "webhookAccessKey" FROM sentinel.script_events INNER JOIN sentinel.script_revision_events ON (script_revision_events.script_event_id = script_events.script_event_id) WHERE script_revision_events.script_revision_id = script_revisions.script_revision_id) AS events_template), \'[]\')']),
			],
			joins: [
				'INNER JOIN public.users ON (scripts.user_id = users.user_id)',
				'INNER JOIN sentinel.script_permissions ON (scripts.script_id = script_permissions.script_id AND script_permissions.user_id = %%USER_ID%%)',
				'INNER JOIN sentinel.script_revisions ON (scripts.script_id = script_revisions.script_id AND script_revisions.date_created = (SELECT MAX(date_created) FROM sentinel.script_revisions WHERE script_id = scripts.script_id))',
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
		$parameters->AddFromFilter($schema, $filters, 'name', 'WEBSEARCH');
		$parameters->clauses[] = 'scripts.deleted = FALSE';
	}

	public function jsonSerialize(): mixed {
		return [
			'scriptId' => $this->scriptId,
			'userId' => $this->userId,
			'name' => $this->name,
			'description' => $this->description,
			'dateCreated' => $this->dateCreated,
			'dateModified' => $this->dateModified,
			'communityStatus' => $this->communityStatus,
			'permissions' => $this->permissions,
			'latestRevisionId' => $this->latestRevisionId,
			'approvalStatus' => $this->approvalStatus,
			'parameters' => $this->parameters,
			'commonJavascript' => $this->commonJavascript,
			'events' => $this->events,
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

	public static function Create(array $properties): DatabaseObject {
		$scriptId = $properties['scriptId'] ?? BeaconUUID::v4();
		static::Write($scriptId, $properties);
		return static::Fetch($scriptId);
	}

	public function Edit(array $properties, bool $restoreDefaults = false): void {
		$currentValues = $this->jsonSerialize();
		$keys = ['name', 'description', 'events', 'parameters', 'commonJavascript'];
		foreach ($keys as $key) {
			if (array_key_exists($key, $properties) === false) {
				$properties[$key] = $currentValues[$key];
			}
		}
		static::Write($this->scriptId, $properties);
		$this->Refetch();
	}

	protected static function Write(string $scriptId, array $properties): void {
		$scriptName = trim($properties['name'] ?? '');
		$scriptDescription = trim($properties['description'] ?? '');
		$scriptEvents = $properties['events'] ?? [];
		$scriptParameters = $properties['parameters'] ?? [];
		$scriptCommonJavascript = $properties['commonJavascript'] ?? '';

		$database = BeaconCommon::Database();
		$hashParts = [
			$scriptId,
			json_encode($scriptParameters),
			$scriptCommonJavascript,
		];

		if (empty($scriptName)) {
			throw new APIException(message: 'Script must have a name.', code: 'emptyName');
		}

		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.scripts WHERE user_id = $1 AND name = $2 AND script_id != $3 AND deleted = FALSE) AS name_exists;', Core::UserId(), $scriptName, $scriptId);
		if ($rows->Field('name_exists') === true) {
			throw new APIException(message: 'The script name has already been used.', code: 'nameNotUnique');
		}

		$parameterMap = [];
		foreach ($scriptParameters as $definition) {
			$parameterMap[$definition['name']] = $definition;
		}

		$usesJavaScript = false;
		$needsReview = false;
		$privateFunctions = ['beacon.generateRandomBytes', 'beacon.generateUuidV4', 'beacon.generateUuidV5', 'beacon.generateUuidV7', 'beacon.hash', 'beacon.hmac', 'beacon.httpRequest'];
		if (empty($scriptCommonJavascript) === false) {
			foreach ($privateFunctions as $function) {
				if (str_contains($scriptCommonJavascript, $function)) {
					$needsReview = true;
					break;
				}
			}
		}

		$pendingEvents = [];
		foreach ($scriptEvents as $event) {
			$eventLanguage = trim($event['language'] ?? '');
			$eventContext = trim($event['context'] ?? '');
			$eventCode = trim($event['code'] ?? '');

			$usesJavaScript = $usesJavaScript || $eventLanguage === static::LanguageJavaScript;

			$eventId = BeaconUUID::v5($eventLanguage . ':' . $eventContext . ':' . $eventCode, static::ScriptNamespace);
			$hashParts[] = $eventId;

			if (in_array($eventContext, LogMessage::Events) === false) {
				throw new APIException(message: 'Context is not a valid context. See the documentation for correct values.', code: 'badContext');
			}

			if (in_array($eventLanguage, static::Languages) === false) {
				throw new APIException(message: 'Language is not a valid value. See the documentation for correct values.', code: 'badLanguage');
			}

			if ($needsReview === false && $eventLanguage === static::LanguageJavaScript) {
				foreach ($privateFunctions as $function) {
					if (str_contains($eventCode, $function)) {
						$needsReview = true;
						break;
					}
				}
			}

			$eventKeyword = null;
			$eventArguments = null;
			$eventMenuText = null;
			$eventWebhookId = null;
			$eventWebhookAccessKey = null;
			switch ($eventContext) {
			case LogMessage::EventSlashCommand:
			case LogMessage::EventScriptCommand:
				$eventKeyword = trim($event['commandKeyword'] ?? '');
				$eventArguments = $event['commandArguments'] ?? [];

				if (empty($eventKeyword)) {
					throw new APIException(message: 'Keyword should not be empty.', code: 'emptyKeyword');
				}

				foreach ($eventArguments as $parameterName) {
					if (array_key_exists($parameterName, $parameterMap) === false) {
						throw new APIException(message: "Command argument {$parameterName} is not present in parameters.", code: 'badCommandArguments', httpStatus: 400);
					}
				}

				$hashParts[] = $eventKeyword;
				break;
			case LogMessage::EventManualCharacterScript:
			case LogMessage::EventManualDinoScript:
			case LogMessage::EventManualServiceScript:
			case LogMessage::EventManualTribeScript:
				$eventMenuText = trim($event['menuText'] ?? '');
				if (empty($eventMenuText)) {
					throw new APIException(message: 'Menu text should not be empty.', code: 'emptyMenuText');
				}

				$hashParts[] = $eventMenuText;
				break;
			case LogMessage::EventWebhook:
				if (BeaconCommon::HasAllKeys($event, 'webhookId', 'webhookAccessKey')) {
					$eventWebhookId = $event['webhookId'];
					$eventWebhookAccessKey = BeaconCommon::Base64UrlDecode($event['webhookAccessKey']);
				} else {
					$eventWebhookId = BeaconUUID::v4();
					$eventWebhookAccessKey = BeaconEncryption::GenerateKey(256);
				}

				$hashParts[] = $eventWebhookId;
				$hashParts[] = $eventWebhookAccessKey;
				break;
			}

			$pendingEvents[] = [
				'scriptEventId' => $eventId,
				'language' => $eventLanguage,
				'context' => $eventContext,
				'code' => $eventCode,
				'commandKeyword' => $eventKeyword,
				'commandArguments' => $eventArguments,
				'menuText' => $eventMenuText,
				'webhookId' => $eventWebhookId,
				'webhookAccessKey' => $eventWebhookAccessKey,
				'webhookAccessKeyHash' => null,
			];
		}
		$revisionId = BeaconUUID::v5(implode("\n", $hashParts), static::ScriptNamespace);
		$approvalStatus = ($usesJavaScript === false ? static::ApprovalStatusApproved : ($needsReview ? static::ApprovalStatusNeedsReview : static::ApprovalStatusProbation));
		$sendApprovalRequest = false;

		try {
			$database->BeginTransaction();
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.script_revisions WHERE script_revision_id = $1) AS revision_exists;', $revisionId);
			if ($rows->Field('revision_exists') === false) {
				$database->Query('INSERT INTO sentinel.script_revisions (script_revision_id, script_id, parameters, common_javascript, approval_status) VALUES ($1, $2, $3, $4, $5);', $revisionId, $scriptId, json_encode($scriptParameters), $scriptCommonJavascript, $approvalStatus);
				foreach ($pendingEvents as $event) {
					$eventId = $event['scriptEventId'];
					$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.script_events WHERE script_event_id = $1) AS event_exists;', $eventId);
					if ($rows->Field('event_exists') === false) {
						$database->Query('INSERT INTO sentinel.script_events (script_event_id, language, context, code) VALUES ($1, $2, $3, $4);', $eventId, $event['language'], $event['context'], $event['code']);
					}

					if (is_null($event['webhookId']) === false) {
						$accessKey = $event['webhookAccessKey'];
						$event['webhookAccessKeyHash'] = BeaconCommon::Base64UrlEncode(hash('sha3-512', $accessKey, true));
						$event['webhookAccessKey'] = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSAEncrypt(BeaconEncryption::ExtractPublicKey(BeaconCommon::GetGlobal('Beacon_Private_Key')), $accessKey));
					}

					$database->Query('INSERT INTO sentinel.script_revision_events (script_revision_id, script_event_id, command_keyword, command_arguments, menu_text, webhook_id, webhook_access_key, webhook_access_key_hash) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);', $revisionId, $eventId, $event['commandKeyword'], is_null($event['commandArguments']) ? null : json_encode($event['commandArguments']), $event['menuText'], $event['webhookId'], $event['webhookAccessKey'], $event['webhookAccessKeyHash']);
					$sendApprovalRequest = true;
				}
			}

			$database->Query('INSERT INTO sentinel.scripts (script_id, user_id, name, description, deleted) VALUES ($1, $2, $3, $4, FALSE) ON CONFLICT (script_id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, date_modified = CURRENT_TIMESTAMP, deleted = FALSE;', $scriptId, Core::UserId(), $scriptName, $scriptDescription);
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw new APIException(message: $err->getMessage(), code: 'unhandledException');
		}

		if ($approvalStatus === static::ApprovalStatusNeedsReview && $sendApprovalRequest) {
			$fields = [
				[
					'title' => 'Script Name',
					'value' => $scriptName,
					'short' => false,
				],
				[
					'title' => 'Description',
					'value' => $scriptDescription,
					'short' => false,
				],
			];

			$attachment = [
				'title' => 'This script was submitted with the API',
				'text' => 'This code was flagged during submission because it contains restricted functions.',
				'fallback' => 'Unable to show response buttons.',
				'callback_id' => 'sentinel_script:' . $revisionId,
				'actions' => [
					[
						'name' => 'status',
						'text' => 'Approve',
						'type' => 'button',
						'value' => 'Approved',
						'confirm' => [
							'text' => 'Are you certain this script is safe to run?',
							'ok_text' => 'Approve',
						],
					],
					[
						'name' => 'status',
						'text' => 'Deny',
						'type' => 'button',
						'value' => 'Rejected',
						'confirm' => [
							'text' => 'Are you sure you want to block this script?',
							'ok_text' => 'Block',
						],
					],
				],
				'fields' => $fields,
			];

			BeaconCommon::PostSlackRaw(json_encode([
				'text' => 'A script needs to be reviewed',
				'attachments' => [$attachment],
			]));
		}
	}

	public function Delete(): void {
		try {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('UPDATE sentinel.scripts SET deleted = TRUE, date_modified = CURRENT_TIMESTAMP WHERE script_id = $1;', $this->scriptId);
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw new APIException(message: $err->getMessage(), code: 'unhandledException');
		}
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
