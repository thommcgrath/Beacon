<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconPusher, BeaconRecordSet, Exception, JsonSerializable;

class BucketValue extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		HookModified As MDOHookModified;
	}

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
				new DatabaseObjectProperty('value', ['upsertEdit' => true, 'editable' => DatabaseObjectProperty::kEditableAlways]),
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
			case 'value':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'key', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'value', 'ILIKE');
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
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public static function AuthorizeListRequest(array &$filters): void {
		if (isset($filters['bucketId']) === false) {
			throw new Exception('Must include bucketId.');
		}

		$bucketId = $filters['bucketId'];
		if (Bucket::TestSentinelPermissions($bucketId, Core::UserId(), PermissionBits::Membership) === false) {
			throw new Exception('You do not have access to this bucket.');
		}
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (isset($newObjectProperties['bucketId']) && Bucket::TestSentinelPermissions($newObjectProperties['bucketId'], $user->UserId(), PermissionBits::Membership | PermissionBits::EditBuckets)) {
			return true;
		}

		return false;
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = 0;
		$bucketPermissions = Bucket::GetSentinelPermissions($this->bucketId, $user->UserId());
		if (($bucketPermissions & PermissionBits::Membership) > 0) {
			$permissions = $permissions | self::kPermissionRead;
		}
		if (($bucketPermissions & PermissionBits::EditBuckets) > 0) {
			$permissions = $permissions | self::kPermissionUpdate | self::kPermissionDelete;
		}
		return $permissions;
	}

	protected function HookModified(int $operation): void {
		$this->MDOHookModified($operation);
		BeaconPusher::SharedInstance()->TriggerEvent('sentinel.buckets.' . str_replace('-', '', $this->bucketId), 'value-updated', '', BeaconPusher::SocketIdFromHeaders());
	}
}

?>
