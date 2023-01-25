<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseCommonWriterObject, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconRecordSet, BeaconWorkshopItem;

class Mod extends DatabaseObject implements \JsonSerializable {
	use DatabaseCommonWriterObject;
	
	protected $modId = '';
	protected $workshopId = '';
	protected $userId = '';
	protected $name = '';
	protected $isConfirmed = false;
	protected $confirmationCode = '';
	protected $pullUrl = null;
	protected $lastPullHash = null;
	protected $isConsoleSafe = false;
	protected $isDefaultEnabled = false;
	protected $minVersion = 0;
	protected $isOfficial = false;
	protected $isIncludedInDeltas = false;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->modId = $row->Field('mod_id');
		$this->workshopId = abs($row->Field('workshop_id'));
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->isConfirmed = filter_var($row->Field('confirmed'), FILTER_VALIDATE_BOOL);
		$this->confirmationCode = $row->Field('confirmation_code');
		$this->pullUrl = $row->Field('pull_url');
		$this->lastPullHash = $row->Field('last_pull_hash');
		$this->isConsoleSafe = filter_var($row->Field('console_safe'), FILTER_VALIDATE_BOOL);
		$this->isDefaultEnabled = filter_var($row->Field('default_enabled'), FILTER_VALIDATE_BOOL);
		$this->minVersion = intval($row->Field('min_version'));
		$this->isOfficial = filter_var($row->Field('is_official'), FILTER_VALIDATE_BOOL);
		$this->isIncludedInDeltas = filter_var($row->Field('include_in_deltas'), FILTER_VALIDATE_BOOL);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'mods', [
			new DatabaseObjectProperty('modId', ['primaryKey' => true, 'columnName' => 'mod_id']),
			new DatabaseObjectProperty('workshopId', ['columnName' => 'workshop_id', 'accessor' => 'ABS(%%TABLE%%.%%COLUMN%%)', 'setter' => 'ABS(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('isConfirmed', ['columnName' => 'confirmed']),
			new DatabaseObjectProperty('confirmationCode', ['columnName' => 'confirmation_code']),
			new DatabaseObjectProperty('pullUrl', ['columnName' => 'pull_url', 'editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('lastPullHash', ['columnName' => 'last_pull_hash']),
			new DatabaseObjectProperty('isConsoleSafe', ['columnName' => 'console_safe']),
			new DatabaseObjectProperty('isDefaultEnabled', ['columnName' => 'default_enabled']),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'is_official']),
			new DatabaseObjectProperty('isIncludedInDeltas', ['columnName' => 'include_in_deltas'])
		]);
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		} else {
			$mods = static::Search(['workshopId' => $uuid], true);
			if (count($mods) === 1) {
				return $mods[0];
			}
		}
		return null;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$table = $schema->table();
		
		$parameters->AddFromFilter($schema, $filters, 'userId', '=');
		$parameters->AddFromFilter($schema, $filters, 'isConfirmed', '=');
		$parameters->AddFromFilter($schema, $filters, 'isOfficial', '=');
		$parameters->AddFromFilter($schema, $filters, 'isIncludedInDeltas', '=');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
			
		if (isset($filters['workshopId'])) {
			$workshopId = filter_var($filters['workshopId'], FILTER_VALIDATE_INT);
			if ($workshopId !== false) {
				$workshopIdProperty = $schema->Property('workshopId');
				$parameters->clauses[] = $schema->Comparison('workshopId', '=', $parameters->placeholder++);
				$parameters->values[] = $workshopId;
			}
		}
		
		if (isset($filters['modId']) && BeaconCommon::IsUUID($filters['modId']) === true) {
			$parameters->clauses[] = $schema->Comparison('modId', '=', $parameters->placeholder++);
			$parameters->values[] = $filters['modId'];
		}
		
		if (isset($filters['pullUrl'])) {
			$pullUrl = filter_var($filters['pullUrl'], FILTER_VALIDATE_URL);
			if ($pullUrl !== false) {
				$parameters->clauses[] = $schema->Comparison('pullUrl', '=', $parameters->placeholder++);
				$parameters->values[] = $pullUrl;
			} else {
				$parameters->clauses[] = $schema->Accessor('pullUrl') . ' IS NOT NULL';
			}
		}
		
		$parameters->allowAll = true;
		$parameters->orderBy = $schema->Accessor('name');
	}
	
	public static function CheckClassPermission(?User $user, array $members, int $desiredPermissions): bool {
		if ($desiredPermissions === DatabaseObject::kPermissionCreate || $desiredPermissions === DatabaseObject::kPermissionRead) {
			return true;
		}
		
		// This is incomplete
		return false;
	}
	
	public function ModID(): string {
		return $this->modId;
	}
	
	public function WorkshopID(): string {
		return $this->workshopId;
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function Name(): string {
		return $this->name;
	}
	
	public function Confirmed(): bool {
		return $this->isConfirmed;
	}
	
	public function ConfirmationCode(): string {
		return $this->confirmationCode;
	}
	
	public function PullURL(): ?string {
		return $this->pullUrl;
	}
	
	public function LastPullHash(): ?string {
		return $this->lastPullHash;
	}
	
	public function MinVersion(): int {
		return $this->minVersion;
	}
	
	public function AttemptConfirmation(): bool {
		$workshop_item = BeaconWorkshopItem::Load($this->workshopId);
		if ($workshop_item === null) {
			return false;
		}
		if (BeaconCommon::InDevelopment() || $workshop_item->ContainsString($this->confirmationCode)) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('UPDATE ark.mods SET confirmed = TRUE WHERE mod_id = $1;', $this->modId);
			$database->Commit();
			$this->isConfirmed = true;
			return true;
		}
		
		return false;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'modId' => $this->modId,
			'workshopId' => abs($this->workshopId),
			'name' => $this->name,
			'workshopUrl' => BeaconWorkshopItem::URLForModID($this->workshopId),
			'isConfirmed' => $this->isConfirmed,
			'isConsoleSafe' => $this->isConsoleSafe,
			'isDefaultEnabled' => $this->isDefaultEnabled,
			'isIncludedInDeltas' => $this->isIncludedInDeltas,
			'isOfficial' => $this->isOfficial,
			'confirmationCode' => $this->confirmationCode,
			'resourceUrl' => Core::URL('ark/mods/' . $this->modId),
			'confirmUrl' => Core::URL('ark/mods/' . $this->modId . '/checkConfirmation'),
			'engramsUrl' => Core::URL('ark/mods/' . $this->modId . '/engrams'),
			'spawncodesUrl' => BeaconCommon::AbsoluteURL('/spawn/?modId=' . $this->workshopId),
			'pullUrl' => $this->pullUrl,
			'minVersion' => $this->minVersion
		];
	}
}

?>
