<?php

namespace BeaconAPI\v4\SDTD;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, DateTime, Exception, JsonSerializable;

class GenericObject extends DatabaseObject implements JsonSerializable {
	protected string $objectId;
	protected string $objectGroup;
	protected string $label;
	protected ?string $alternateLabel;
	protected int $minVersion;
	protected string $contentPackId;
	protected string $contentPackName;
	protected string $contentPackMarketplace;
	protected string $contentPackMarketplaceId;
	protected array $tags;
	protected int $lastUpdate;

	//const COLUMN_NOT_EXISTS = 'ae3eefbc-6dd0-4f92-ae3d-7cae5c6c9aee';

	protected function __construct(BeaconRecordSet $row) {
		$tags = substr($row->Field('tags'), 1, -1);
		if (strlen($tags) > 0) {
			$tags = explode(',', $tags);
		} else {
			$tags = [];
		}
		asort($tags);

		$this->objectId = $row->Field('object_id');
		$this->objectGroup = $row->Field('object_group');
		$this->label = $row->Field('label');
		$this->alternateLabel = $row->Field('alternate_label');
		$this->minVersion = intval($row->Field('min_version'));
		$this->contentPackId = $row->Field('content_pack_id');
		$this->contentPackName = $row->Field('content_pack_name');
		$this->contentPackMarketplace = $row->Field('content_pack_marketplace');
		$this->contentPackMarketplaceId = $row->Field('content_pack_marketplace_id');
		$this->tags = array_values($tags);
		$this->lastUpdate = round($row->Field('last_update'));
	}

	protected static function CustomVariablePrefix(): string {
		return 'object';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$prefix = static::CustomVariablePrefix();
		return new DatabaseSchema('sdtd', 'objects', [
			new DatabaseObjectProperty($prefix . 'Id', ['primaryKey' => true, 'columnName' => 'object_id']),
			new DatabaseObjectProperty($prefix . 'Group', ['accessor' => 'SUBSTRING(%%TABLE%%.tableoid::regclass::TEXT, 5)', 'columnName' => 'object_group', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('label', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('alternateLabel', ['columnName' => 'alternate_label', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('tags', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('minVersion', ['accessor' => 'GREATEST(%%TABLE%%.min_version, content_packs.min_version)', 'setter' => '%%PLACEHOLDER%%', 'columnName' => 'min_version', 'required' => false]),
			new DatabaseObjectProperty('contentPackId', ['accessor' => 'content_packs.content_pack_id', 'setter' => '%%PLACEHOLDER%%', 'columnName' => 'content_pack_id']),
			new DatabaseObjectProperty('contentPackName', ['accessor' => 'content_packs.name', 'columnName' => 'content_pack_name', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('contentPackMarketplace', ['accessor' => 'content_packs.marketplace', 'columnName' => 'content_pack_marketplace', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('contentPackMarketplaceId', ['accessor' => 'content_packs.marketplace_id', 'columnName' => 'content_pack_marketplace_id', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'editable' => DatabaseObjectProperty::kEditableNever])
		], [
			'INNER JOIN public.content_packs ON (%%TABLE%%.content_pack_id = content_packs.content_pack_id)'
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('label');
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->AddFromFilter($schema, $filters, 'contentPackMarketplace', '=');
		$prefix = static::CustomVariablePrefix();

		if (isset($filters['contentPackId'])) {
			if (is_array($filters['contentPackId'])) {
				$packs = $filters['contentPackId'];
			} else {
				$packs = explode(',', $filters['contentPackId']);
			}
			$packIds = [];
			foreach ($packs as $pack) {
				if (is_string($pack) && BeaconCommon::IsUUID($pack)) {
					$packIds[] = $pack;
				}
			}

			$clauses = [];
			if (count($packIds) > 1) {
				$clauses[] = $schema->Accessor('contentPackId') . ' = ANY(' . $schema->Setter('contentPackId', $parameters->placeholder++) . ')';
				$parameters->values[] = '{' . implode(',', $packIds) . '}';
			} else if (count($packIds) === 1) {
				$clauses[] = $schema->Comparison('contentPackId', '=', $parameters->placeholder++);
				$parameters->values[] = $packIds[array_key_first($packIds)];
			}
			if (count($clauses) > 0) {
				$parameters->clauses[] = '(' . implode(' OR ', $clauses) . ')';
			}
		}

		if (isset($filters['contentPackMarketplaceId'])) {
			if (is_array($filters['contentPackMarketplaceId'])) {
				$packs = $filters['contentPackMarketplaceId'];
			} else {
				$marketplaceId = str_replace('\\,', '73f2d6ad-0070-44df-8d9a-c8838da050d2', $filters['contentPackMarketplaceId']);
				$packs = explode(',', $marketplaceId);
			}
			for ($idx = 0; $idx < count($packs); $idx++) {
				$packs[$idx] = str_replace(['73f2d6ad-0070-44df-8d9a-c8838da050d2', '{', '}'], ['\\,', '\\{', '\\}'], $packs[$idx]);
			}

			$clauses = [];
			if (count($packs) > 1) {
				$clauses[] = $schema->Accessor('contentPackMarketplaceId') . ' = ANY(' . $schema->Setter('contentPackMarketplaceId', $parameters->placeholder++) . ')';
				$parameters->values[] = '{' . implode(',', $packs) . '}';
			} else if (count($packs) === 1) {
				$clauses[] = $schema->Comparison('contentPackMarketplaceId', '=', $parameters->placeholder++);
				$parameters->values[] = $packs[array_key_first($packs)];
			}
			if (count($clauses) > 0) {
				$parameters->clauses[] = '(' . implode(' OR ', $clauses) . ')';
			}
		}

		if (isset($filters[$prefix . 'Group'])) {
			$filterKey = $prefix . 'Group';
			$filterValue = $filters[$filterKey];
			$groups = [];
			if (str_contains($filterValue, ',')) {
				$groups = explode(',', $filterValue);
			} else {
				$groups = [$filterValue];
			}

			for ($idx = 0; $idx < count($groups); $idx++) {
				$groups[$idx] = trim($groups[$idx]);
			}

			if (count($groups) > 1) {
				$parameters->clauses[] = $schema->Accessor($filterKey) . ' = ANY(' . $schema->Setter($filterKey, $parameters->placeholder++) . ')';
				$parameters->values[] = '{' . implode(',', $groups) . '}';
			} else if (count($groups) === 1) {
				$group = $groups[array_key_first($groups)];
				$parameters->clauses[] = $schema->Comparison($filterKey, '=', $parameters->placeholder++);
				$parameters->values[] = $group;
			}
		}

		if (isset($filters['tag'])) {
			$parameters->clauses[] = $schema->Setter('tags', $parameters->placeholder++) . ' = ANY(' . $schema->Accessor('tags') . ')';
			$parameters->values[] = $filters['tag'];
		}

		if (isset($filters['tags'])) {
			$tags = explode(',', $filters['tags']);
			foreach ($tags as $tag) {
				$parameters->clauses[] = $schema->Setter('tags', $parameters->placeholder++) . ' = ANY(' . $schema->Accessor('tags') . ')';
				$parameters->values[] = $tag;
			}
		}

		if (isset($filters['label'])) {
			if (str_contains($filters['label'], '%')) {
				$parameters->clauses[] = $schema->Accessor('label') . ' LIKE ' . $schema->Setter('label', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('label', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['label'];
		}

		if (isset($filters['alternateLabel'])) {
			if (str_contains($filters['alternateLabel'], '%')) {
				$parameters->clauses[] = $schema->Accessor('alternateLabel') . ' LIKE ' . $schema->Setter('alternateLabel', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('alternateLabel', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['alternateLabel'];
		}
	}

	/*protected static function PreparePropertyValue(string $propertyName, DatabaseObjectProperty $definition, mixed $value, string &$setter): mixed {
		switch ($propertyName) {
		case 'tags':
			$tags = [];
			if (is_string($value)) {
				$tags = explode(',', $value);
			} else if (is_array($value)) {
				$tags = $value;
			}
			sort($tags);
			$setter = 'ARRAY(SELECT JSONB_ARRAY_ELEMENTS_TEXT(' . $setter . '))';
			return json_encode($tags);
			break;
		default:
			return parent::PreparePropertyValue($propertyName, $definition, $value, $setter);
		}
	}*/

	public function GetPermissionsForUser(User $user): int {
		return DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\ContentPack', objectId: $this->contentPackId, user: $user);
	}

	public static function CanUserCreate(User $user, ?array $newObjectProperties): bool {
		if (is_null($newObjectProperties) || isset($newObjectProperties['contentPackId']) === false) {
			return false;
		}

		return (DatabaseObjectAuthorizer::GetPermissionsForUser(className: '\BeaconAPI\v4\ContentPack', objectId: $newObjectProperties['contentPackId'], user: $user, options: DatabaseObjectAuthorizer::kOptionMustExist) & DatabaseObject::kPermissionCreate) === DatabaseObject::kPermissionCreate;
	}

	public static function LastUpdate(int $min_version = -1): DateTime {
		$database = BeaconCommon::Database();
		$schema = static::SchemaName();
		$table = static::TableName();

		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
		}

		$results = $database->Query('SELECT MAX(last_update) AS most_recent_change FROM ' . $schema . '.' . $table . ' WHERE min_version <= $1;', $min_version);
		if ($results->Field('most_recent_change') !== null) {
			$change_time = new DateTime($results->Field('most_recent_change'));
		} else {
			$change_time = new DateTime('2000-01-01');
		}

		if ($table == self::TableName()) {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM ' . $schema . '.deletions WHERE min_version <= $1;', $min_version);
		} else {
			$results = $database->Query('SELECT MAX(action_time) AS most_recent_delete FROM ' . $schema . '.deletions WHERE min_version <= $1 AND from_table = $2;', $min_version, $table);
		}
		if ($results->Field('most_recent_delete') !== null) {
			$delete_time = new DateTime($results->Field('most_recent_delete'));
		} else {
			$delete_time = new DateTime('2000-01-01');
		}
		return ($change_time >= $delete_time) ? $change_time : $delete_time;
	}

	public static function Deletions(int $min_version = -1, DateTime $since = null): array {
		if ($since === null) {
			$since = new DateTime('2000-01-01');
		}

		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
		}

		$database = BeaconCommon::Database();
		$columns = 'object_id, from_table AS from_table, label, min_version, action_time, tag';
		$mySchema = self::DatabaseSchema();
		$classSchema = static::DatabaseSchema();
		$schema = $classSchema->Schema();
		$table = $classSchema->Table();

		if ($schema === $mySchema->Schema() && $table === $mySchema->Table()) {
			$results = $database->Query("SELECT {$columns} FROM {$schema}.deletions WHERE min_version <= $1 AND action_time > $2;", $min_version, $since->format('Y-m-d H:i:sO'));
		} else {
			$results = $database->Query("SELECT {$columns} FROM {$schema}.deletions WHERE min_version <= $1 AND action_time > $2 AND from_table = $3;", $min_version, $since->format('Y-m-d H:i:sO'), $table);
		}
		$arr = [];
		while (!$results->EOF()) {
			$arr[] = [
				'objectId' => $results->Field('object_id'),
				'minVersion' => $results->Field('min_version'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label'),
				'tag' => $results->Field('tag')
			];
			$results->MoveNext();
		}
		return $arr;
	}

	public function jsonSerialize(): mixed {
		$prefix = static::CustomVariablePrefix();
		return [
			$prefix . 'Id' => $this->objectId,
			$prefix . 'Group' => $this->objectGroup,
			'label' => $this->label,
			'alternateLabel' => $this->alternateLabel,
			'contentPackId' => $this->contentPackId,
			'contentPackName' => $this->contentPackName,
			'contentPackMarketplace' => $this->contentPackMarketplace,
			'contentPackMarketplaceId' => $this->contentPackMarketplaceId,
			'tags' => $this->tags,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate
		];
	}

	public function PrimaryKey(): string {
		return $this->objectId;
	}

	public function UUID(): string {
		return $this->objectId;
	}

	public function ObjectId(): string {
		return $this->objectId;
	}

	public function ObjectGroup(): string {
		return $this->objectGroup;
	}

	public function Label(): string {
		return $this->label;
	}

	public function SetLabel(string $label): void {
		$this->label = $label;
	}

	public function AlternateLabel(): ?string {
		return $this->alternateLabel;
	}

	public function SetAlternateLabel(?string $alternateLabel): void {
		$this->alternateLabel = $alternateLabel;
	}

	public function MinVersion(): int {
		return $this->minVersion;
	}

	public function ContentPackId(): string {
		return $this->contentPackId;
	}

	public function ContentPackName(): string {
		return $this->contentPackName;
	}

	public function ContentPackMarketplace(): string {
		return $this->contentPackMarketplace;
	}

	public function ContentPackMarketplaceId(): string {
		return $this->contentPackMarketplaceId;
	}

	public static function NormalizeTag(string $tag): string {
		$tag = strtolower($tag);
		$tag = preg_replace('/[^\w]/', '', $tag);
		return $tag;
	}

	public function Tags(): array {
		return $this->tags;
	}

	public function AddTag(string $tag): void {
		$tag = self::NormalizeTag($tag);
		if (!in_array($tag, $this->tags)) {
			$this->tags[] = $tag;
		}
	}

	public function RemoveTag(string $tag): void {
		$tag = self::NormalizeTag($tag);
		if (in_array($tag, $this->tags)) {
			$arr = array();
			foreach ($this->tags as $current_tag) {
				if ($current_tag !== $tag) {
					$arr[] = $current_tag;
				}
			}
			$this->tags = $arr;
		}
	}

	public function IsTagged(string $tag): bool {
		return in_array(self::NormalizeTag($tag), $this->tags);
	}

	public static function DeleteObjects(string $object_id, string $user_id): bool {
		$database = BeaconCommon::Database();
		$escaped_schema = $database->EscapeIdentifier(static::SchemaName());
		$escaped_table = $database->EscapeIdentifier(static::TableName());

		$database->BeginTransaction();
		$results = $database->Query('SELECT content_packs.user_id, ' . $escaped_table . '.object_id FROM ' . $escaped_schema . '.' . $escaped_table . ' INNER JOIN public.content_packs ON (' . $escaped_table . '.content_pack_id = content_packs.content_pack_id) WHERE ' . $escaped_table . '.object_id = ANY($1) FOR UPDATE OF ' . $escaped_table . ';', '{' . $object_id . '}');
		$objects = array();
		while (!$results->EOF()) {
			if ($results->Field('user_id') !== $user_id) {
				$database->Rollback();
				return false;
			}
			$objects[] = $results->Field('object_id');
			$results->MoveNext();
		}
		if (count($objects) == 0) {
			$database->Rollback();
			return true;
		}
		$database->Query('DELETE FROM ' . $escaped_schema . '.' . $escaped_table . ' WHERE object_id = ANY($1);', '{' . implode(',', $objects) . '}');
		$database->Commit();
		return true;
	}

	public function GetPropertyValue(string $propertyName): mixed {
		$prefix = static::CustomVariablePrefix();
		switch ($propertyName) {
		case $prefix . 'Id':
			return $this->objectId;
		case $prefix . 'Group':
			return $this->objectGroup;
		default:
			return parent::GetPropertyValue($propertyName);
		}
	}
}

?>
