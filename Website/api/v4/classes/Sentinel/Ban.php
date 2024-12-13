<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{APIException, Application, Core, DatabaseObject, DatabaseObjectAuthorizer, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class Ban extends DatabaseObject implements JsonSerializable {
	protected string $banId;
	protected string $playerId;
	protected string $playerName;
	protected string $parentClass;
	protected string $parentId;
	protected string $parentName;
	protected ?int $expiration;
	protected string $issuerId;
	protected string $issuerName;
	protected string $issuerNameFull;
	protected string $issuerComments;

	public function __construct(BeaconRecordSet $row) {
		$this->banId = $row->Field('source_id');
		$this->playerId = $row->Field('player_id');
		$this->playerName = $row->Field('player_name');
		$this->parentClass = $row->Field('parent_class');
		$this->parentId = $row->Field('parent_id');
		$this->parentName = $row->Field('parent_name');
		$this->expiration = is_null($row->Field('expiration')) === false ? intval($row->Field('expiration')) : null;
		$this->issuerId = $row->Field('issued_by');
		$this->issuerName = $row->Field('issuer_name');
		$this->issuerNameFull = $row->Field('issuer_name_full');
		$this->issuerComments = $row->Field('issuer_comments');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'bans',
			definitions: [
				new DatabaseObjectProperty('banId', ['columnName' => 'source_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('playerId', ['columnName' => 'player_id', 'accessor' => '%%TABLE%%.%%COLUMN%%', 'setter' => "sentinel.get_player_id(%%PLACEHOLDER%%, TRUE)"]),
				new DatabaseObjectProperty('playerName', ['columnName' => 'player_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'players.name']),
				new DatabaseObjectProperty('parentClass', ['columnName' => 'parent_class', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(CASE %%TABLE%%.parent_table WHEN 'services' THEN 'Service' WHEN 'service_groups' THEN 'ServiceGroup' ELSE %%TABLE%%.parent_table END)"]),
				new DatabaseObjectProperty('parentId', ['columnName' => 'parent_id']),
				new DatabaseObjectProperty('parentName', ['columnName' => 'parent_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
				new DatabaseObjectProperty('expiration', ['columnName' => 'expiration', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('issuerId', ['columnName' => 'issued_by']),
				new DatabaseObjectProperty('issuerName', ['columnName' => 'issuer_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'users.username']),
				new DatabaseObjectProperty('issuerNameFull', ['columnName' => 'issuer_name_full', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => "(users.username || '#' || LEFT(users.user_id::TEXT, 8))"]),
				new DatabaseObjectProperty('issuerComments', ['columnName' => 'issuer_comments']),
			],
			joins: [
				'INNER JOIN public.users ON (bans.issued_by = users.user_id)',
				'INNER JOIN sentinel.players ON (bans.player_id = players.player_id)',
			],
			options: DatabaseSchema::OptionDistinct,
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'parentName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'username':
			case 'parentName':
			case 'expiration':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->AddFromFilter($schema, $filters, 'issuerId');
		$parameters->AddFromFilter($schema, $filters, 'issuerName', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'issuerNameFull', 'LIKE');
		$parameters->AddFromFilter($schema, $filters, 'parentId');
		$parameters->AddFromFilter($schema, $filters, 'parentClass');
		$parameters->AddFromFilter($schema, $filters, 'parentName');
		$parameters->AddFromFilter($schema, $filters, 'playerId');
		$parameters->AddFromFilter($schema, $filters, 'playerName', 'LIKE');

		if (isset($filters['userId'])) {
			$userIdPlaceholder = '$' . $parameters->AddValue($filters['userId']);
			$servicePermissionPlaceholder = '$' . $parameters->AddValue(Service::kPermissionControl);
			$serviceGroupPermissionPlaceholder = '$' . $parameters->AddValue(ServiceGroup::kPermissionUpdate);
			$parameters->clauses[] = "bans.parent_id IN (SELECT service_id FROM sentinel.service_permissions WHERE user_id = {$userIdPlaceholder} AND (permissions & {$servicePermissionPlaceholder}) = {$servicePermissionPlaceholder} UNION SELECT service_group_id FROM sentinel.service_group_permissions WHERE user_id = {$userIdPlaceholder} AND (permissions & {$serviceGroupPermissionPlaceholder}) = {$serviceGroupPermissionPlaceholder})";
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'banId' => $this->banId,
			'playerId' => $this->playerId,
			'playerName' => $this->playerName,
			'parentClass' => $this->parentClass,
			'parentId' => $this->parentId,
			'parentName' => $this->parentName,
			'expiration' => $this->expiration,
			'issuerId' => $this->issuerId,
			'issuerName' => $this->issuerName,
			'issuerNameFull' => $this->issuerNameFull,
			'issuerComments' => $this->issuerComments,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelServicesRead;
		$requiredScopes[] = Application::kScopeUsersRead;
	}

	public static function AuthorizeListRequest(array &$filters): void {
		$filters['userId'] = Core::UserId();
	}
}

?>
