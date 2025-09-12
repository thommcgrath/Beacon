<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconRecordSet;

class CommunityScript extends Script {
	protected string $username;
	protected string $usernameFull;
	protected ?bool $liked;

	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
		$this->username = $row->Field('username');
		$this->usernameFull = $row->Field('username_full');
		$this->liked = $row->Field('liked');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->AddJoin('INNER JOIN public.users ON (scripts.user_id = users.user_id)', 'users');
		$schema->AddJoin('LEFT JOIN sentinel.script_likes ON (script_likes.script_id = scripts.script_id AND script_likes.user_id = %%USER_ID%%)', 'likes');
		$schema->RemoveJoin('permissions');
		$schema->AddColumn(new DatabaseObjectProperty('permissions', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => '1']));
		$schema->AddColumn(new DatabaseObjectProperty('username', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']));
		$schema->AddColumn(new DatabaseObjectProperty('usernameFull', ['columnName' => 'username_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username_full']));
		$schema->AddColumn(new DatabaseObjectProperty('liked', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'script_likes.liked']));
		$schema->AddColumn(new DatabaseObjectProperty('description', ['editable' => DatabaseObjectProperty::kEditableAlways, 'required' => false, 'accessor' => '%%TABLE%%.description_html']));
		$schema->AddCondition("%%TABLE%%.community_status = 'Approved'");
		return $schema;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'ascending') ? 'ASC' : 'DESC';
		$sortColumn = 'communityRating';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'name':
			case 'communityRating':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		if (isset($filters['search'])) {
			$placeholder = $parameters->AddValue($filters['search']);
			$parameters->clauses[] = "(public.websearch(scripts.name, \${$placeholder}) OR public.websearch(scripts.preview, \${$placeholder}) OR public.websearch(scripts.description, \${$placeholder}))";
		} else {
			$parameters->AddFromFilter($schema, $filters, 'name', 'SEARCH');
			$parameters->AddFromFilter($schema, $filters, 'description', 'SEARCH');
			$parameters->AddFromFilter($schema, $filters, 'preview', 'SEARCH');
		}
	}

	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['username'] = $this->username;
		$json['usernameFull'] = $this->usernameFull;
		$json['liked'] = $this->liked;
		return $json;
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		return false;
	}

	public static function GetSentinelPermissions(string $objectId, string $userId): int {
		if (BeaconCommon::IsUUID($objectId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT EXISTS (SELECT 1 FROM sentinel.scripts WHERE script_id = $1 AND community_status = $2) AS exists;', $objectId, 'Approved');
		if ($rows->Field('exists') === true) {
			return PermissionBits::Membership | PermissionBits::ShareScripts;
		}
		return 0;
	}
}

?>
