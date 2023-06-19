<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, BeaconWorkshopItem, JsonSerializable;

class ContentPack extends DatabaseObject implements JsonSerializable {
	protected string $contentPackId;
	protected int $steamId;
	protected string $userId;
	protected string $name;
	protected bool $isConfirmed;
	protected string $confirmationCode;
	protected bool $isConsoleSafe;
	protected bool $isDefaultEnabled;
	protected int $minVersion;
	protected int $lastUpdate;
	protected bool $isOfficial;
	protected bool $isIncludedInDeltas;
	protected bool $isApp;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->contentPackId = $row->Field('mod_id');
		$this->steamId = abs($row->Field('workshop_id'));
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->isConfirmed = filter_var($row->Field('confirmed'), FILTER_VALIDATE_BOOL);
		$this->confirmationCode = $row->Field('confirmation_code');
		$this->isConsoleSafe = filter_var($row->Field('console_safe'), FILTER_VALIDATE_BOOL);
		$this->isDefaultEnabled = filter_var($row->Field('default_enabled'), FILTER_VALIDATE_BOOL);
		$this->minVersion = intval($row->Field('min_version'));
		$this->lastUpdate = round($row->Field('last_update'));
		$this->isOfficial = filter_var($row->Field('is_official'), FILTER_VALIDATE_BOOL);
		$this->isIncludedInDeltas = filter_var($row->Field('include_in_deltas'), FILTER_VALIDATE_BOOL);
		$this->isApp = filter_var($row->Field('is_app'), FILTER_VALIDATE_BOOL);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('ark', 'mods', [
			new DatabaseObjectProperty('contentPackId', ['primaryKey' => true, 'columnName' => 'mod_id']),
			new DatabaseObjectProperty('steamId', ['columnName' => 'workshop_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('isConfirmed', ['columnName' => 'confirmed']),
			new DatabaseObjectProperty('confirmationCode', ['columnName' => 'confirmation_code']),
			new DatabaseObjectProperty('isConsoleSafe', ['columnName' => 'console_safe']),
			new DatabaseObjectProperty('isDefaultEnabled', ['columnName' => 'default_enabled']),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			New DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'is_official']),
			new DatabaseObjectProperty('isIncludedInDeltas', ['columnName' => 'include_in_deltas']),
			new DatabaseObjectProperty('isApp', ['columnName' => 'is_app'])
		]);
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		} else {
			$packs = static::Search(['steamId' => $uuid], true);
			if (count($packs) === 1) {
				return $packs[0];
			}
		}
		return null;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$table = $schema->table();
		
		$parameters->AddFromFilter($schema, $filters, 'userId', '=');
		$parameters->AddFromFilter($schema, $filters, 'isConfirmed', '=');
		$parameters->AddFromFilter($schema, $filters, 'isOfficial', '=');
		$parameters->AddFromFilter($schema, $filters, 'isIncludedInDeltas', '=');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
			
		if (isset($filters['steamId'])) {
			$steamId = filter_var($filters['steamId'], FILTER_VALIDATE_INT);
			if ($steamId !== false) {
				$steamIdProperty = $schema->Property('steamId');
				$parameters->clauses[] = $schema->Comparison('steamId', '=', $parameters->placeholder++);
				$parameters->values[] = $steamId;
			}
		}
		
		if (isset($filters['contentPackId']) && BeaconCommon::IsUUID($filters['contentPackId']) === true) {
			$parameters->clauses[] = $schema->Comparison('contentPackId', '=', $parameters->placeholder++);
			$parameters->values[] = $filters['contentPackId'];
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
	
	public function ContentPackId(): string {
		return $this->contentPackId;
	}
	
	public function SteamId(): string {
		return $this->steamId;
	}
	
	public function SteamUrl(): string {
		if ($this->isApp) {
			return "https://store.steampowered.com/app/{$this->steamId}";
		} else {
			return "https://steamcommunity.com/sharedfiles/filedetails/?id={$this->steamId}";
		}
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
	
	public function MinVersion(): int {
		return $this->minVersion;
	}
	
	public function IsApp(): bool {
		return $this->isApp;
	}
	
	public function IsIncludedInDeltas(): bool {
		return $this->isIncludedInDeltas;
	}
	
	public function IsOfficial(): bool {
		return $this->isOfficial;
	}
	
	public function AttemptConfirmation(): bool {
		if ($this->isApp) {
			return true;
		}
		
		$workshop_item = BeaconWorkshopItem::Load($this->steamId);
		if (is_null($workshop_item)) {
			return false;
		}
		if (BeaconCommon::InDevelopment() || $workshop_item->ContainsString($this->confirmationCode)) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('UPDATE ark.mods SET confirmed = TRUE WHERE mod_id = $1;', $this->contentPackId);
			$database->Commit();
			$this->isConfirmed = true;
			return true;
		}
		
		return false;
	}
	
	public function jsonSerialize(): mixed {
		return [
			'contentPackId' => $this->contentPackId,
			'steamId' => $this->steamId,
			'steamUrl' => $this->SteamUrl(),
			'name' => $this->name,
			'isApp' => $this->isApp,
			'isConfirmed' => $this->isConfirmed,
			'isConsoleSafe' => $this->isConsoleSafe,
			'isDefaultEnabled' => $this->isDefaultEnabled,
			'isIncludedInDeltas' => $this->isIncludedInDeltas,
			'isOfficial' => $this->isOfficial,
			'confirmationCode' => $this->confirmationCode,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate
		];
	}
}

?>
