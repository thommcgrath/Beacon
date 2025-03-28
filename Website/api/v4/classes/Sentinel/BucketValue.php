<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, Exception, JsonSerializable;

class BucketValue extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;

	protected string $bucketValueId;
	protected string $bucketId;
	protected string $bucketName;
	protected ?string $playerId;
	protected ?string $playerName;
	protected string $key;
	protected string $value;

	public function __construct(BeaconRecordSet $row) {
		$this->bucketValueId = $row->Field('bucket_value_id');
		$this->bucketId = $row->Field('bucket_id');
		$this->bucketName = $row->Field('bucket_name');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->key = $row->Field('key');
		$this->value = $row->Field('value');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'bucket_values',
			definitions: [
				new DatabaseObjectProperty('bucketValueId', ['columnName' => 'bucket_value_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('bucketId', ['columnName' => 'bucket_id', 'upsertConflict' => true]),
				new DatabaseObjectProperty('bucketName', ['columnName' => 'bucket_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'buckets.name']),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'required' => false, 'upsertConflict' => true]),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('key', ['upsertConflict' => true]),
				new DatabaseObjectProperty('value', ['upsertEdit' => true]),
			],
			joins: [
				'INNER JOIN sentinel.buckets ON (buckets.bucket_id = bucket_values.bucket_id)',
				'LEFT JOIN sentinel.players ON (players.player_id = bucket_values.player_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'key';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'key':
			case 'playerName':
			case 'bucketName':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'key');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'bucketName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'bucketId');
	}

	public function jsonSerialize(): mixed {
		return [
			'bucketValueId' => $this->bucketValueId,
			'bucketId' => $this->bucketId,
			'bucketName' => $this->bucketName,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'key' => $this->key,
			'value' => $this->value,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelServicesWrite;
		}
	}

	protected static function UserHasPermission(string $bucketId, string $userId): bool {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.bucket_permissions WHERE bucket_id = $1 AND user_id = $2;', $bucketId, $userId);
		return $rows->RecordCount() === 1;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['bucketId']) === false) {
			throw new Exception('Must include bucketId.');
		}

		$bucketId = $filters['bucketId'];
		if (static::UserHasPermission($bucketId, Core::UserId()) === false) {
			throw new Exception('You do not have access to this bucket.');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (isset($newObjectProperties['bucketId'])) {
			return static::UserHasPermission($newObjectProperties['bucketId'], $user->UserId());
		}

		return false;
	}

	public function GetPermissionsForUser(User $user): int {
		if (static::UserHasPermission($bucketId, $user->UserId())) {
			return self::kPermissionRead | self::kPermissionUpdate | self::kPermissionDelete;
		} else {
			return self::kPermissionNone;
		}
	}
}

?>
