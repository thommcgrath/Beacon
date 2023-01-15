<?php

namespace BeaconAPI\Ark;

class Mod extends \BeaconAPI\DatabaseObject implements \JsonSerializable {
	protected $mod_id = '';
	protected $workshop_id = '';
	protected $user_id = '';
	protected $name = '';
	protected $confirmed = false;
	protected $confirmation_code = '';
	protected $pull_url = null;
	protected $last_pull_hash = null;
	protected $console_safe = false;
	protected $default_enabled = false;
	protected $min_version = 0;
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		$this->mod_id = $row->Field('mod_id');
		$this->workshop_id = abs($row->Field('workshop_id'));
		$this->user_id = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->confirmed = $row->Field('confirmed');
		$this->confirmation_code = $row->Field('confirmation_code');
		$this->pull_url = $row->Field('pull_url');
		$this->last_pull_hash = $row->Field('last_pull_hash');
		$this->console_safe = boolval($row->Field('console_safe'));
		$this->default_enabled = boolval($row->Field('default_enabled'));
		$this->min_version = intval($row->Field('min_version'));
	}
	
	public static function BuildDatabaseSchema(): \BeaconAPI\DatabaseSchema {
		return new \BeaconAPI\DatabaseSchema('ark', 'mods', [
			new \BeaconAPI\DatabaseObjectProperty('mod_id', ['primaryKey' => true]),
			'workshop_id',
			'user_id',
			new \BeaconAPI\DatabaseObjectProperty('name', ['editable' => \BeaconAPI\DatabaseObjectProperty::kEditableAlways]),
			'confirmed',
			'confirmation_code',
			new \BeaconAPI\DatabaseObjectProperty('pull_url', ['editable' => \BeaconAPI\DatabaseObjectProperty::kEditableAlways]),
			'last_pull_hash',
			'console_safe',
			'default_enabled',
			'min_version'
		]);
	}
	
	/*public static function SQLSchemaName(): string {
		return 'ark';
	}
	
	public static function SQLTableName(): string {
		return 'mods';
	}
	
	public static function SQLPrimaryKey(): string {
		return 'mod_id';
	}
	
	public static function SQLSortColumn(): string {
		return 'name';
	}
	
	public static function SQLColumns(): array {
		return [
			'mod_id',
			'ABS(workshop_id) AS workshop_id',
			'name',
			'confirmed',
			'confirmation_code',
			'pull_url',
			'last_pull_hash',
			'console_safe',
			'default_enabled',
			'min_version'
		];
	}*/
	
	public static function Fetch(string $uuid): ?static {
		if (\BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		} else {
			$mods = static::Search(['workshop_id' => $uuid]);
			if ($mods['totalResults'] === 1) {
				return $mods['results'][0];
			}
		}
	}
	
	protected static function BuildSearchParameters(\BeaconAPI\DatabaseSearchParameters $parameters, array $filters): void {
		$table = static::DatabaseSchema()->table();
			
		if (isset($filters['workshop_id'])) {
			$parameters->clauses[] = 'ABS(' . $table . '.workshop_id) = ABS($' . $parameters->placeholder++ . ')';
			$parameters->values[] = filter_var($filters['workshop_id'], FILTER_VALIDATE_INT);
		}
		
		if (isset($filters['mod_id']) && \BeaconCommon::IsUUID($filters['mod_id']) === true) {
			$parameters->clauses[] = $table . '.mod_id = $' . $parameters->placeholder++;
			$parameters->values[] = $filters['mod_id'];
		}
		
		if (isset($filters['user_id']) && \BeaconCommon::IsUUID($filters['user_id']) === true) {
			$parameters->clauses[] = $table . '.user_id = $' . $parameters->placeholder++;
			$parameters->values[] = $filters['user_id'];
		}
		
		if (isset($filters['confirmed'])) {
			$parameters->clauses[] = $table . '.confirmed = $' . $parameters->placeholder++;
			$parameters->values[] = filter_var($filters['confirmed'], FILTER_VALIDATE_BOOL);
		}
		
		if (isset($filters['is_official'])) {
			$parameters->clauses[] = $table . '.is_official = $' . $parameters->placeholder++;
			$parameters->values[] = filter_var($filters['is_official'], FILTER_VALIDATE_BOOL);
		}
		
		if (isset($filters['include_in_deltas'])) {
			$parameters->clauses[] = $table . '.include_in_deltas = $' . $parameters->placeholder++;
			$parameters->values[] = filter_var($filters['include_in_deltas'], FILTER_VALIDATE_BOOL);
		}
		
		if (isset($filters['console_safe'])) {
			$parameters->clauses[] = $table . '.console_safe = $' . $parameters->placeholder++;
			$parameters->values[] = filter_var($filters['console_safe'], FILTER_VALIDATE_BOOL);
		}
		
		if (isset($filters['last_update'])) {
			$parameters->clauses[] = $table . '.last_update > $' . $parameters->placeholder++;
			$parameters->values[] = $filters['last_update'];
		}
		
		if (isset($filters['min_version'])) {
			$parameters->clauses[] = $table . '.min_version < $' . $parameters->placeholder++;
			$parameters->values[] = $filters['min_version'];
		}
		
		if (isset($filters['pull_url'])) {
			if (filter_var($filters['pull_url'], FILTER_VALIDATE_URL)) {
				$parameters->clauses[] = $table . '.pull_url = $' . $parameters->placeholder++;
				$parameters->values[] = $filters['pull_url'];
			} else {
				$parameters->clauses[] = $table . '.pull_url IS NOT NULL';
			}
		}
		
		$parameters->allowAll = true;
		$parameters->orderBy = $table . '.name';
	}
	
	public function ModID(): string {
		return $this->mod_id;
	}
	
	public function WorkshopID(): string {
		return $this->workshop_id;
	}
	
	public function Name(): string {
		return $this->name;
	}
	
	public function Confirmed(): bool {
		return $this->confirmed;
	}
	
	public function ConfirmationCode(): string {
		return $this->confirmation_code;
	}
	
	public function PullURL(): ?string {
		return $this->pull_url;
	}
	
	public function LastPullHash(): ?string {
		return $this->last_pull_hash;
	}
	
	public function MinVersion(): int {
		return $this->min_version;
	}
	
	public function AttemptConfirmation(): bool {
		$workshop_item = \BeaconWorkshopItem::Load($this->workshop_id);
		if ($workshop_item === null) {
			return false;
		}
		if (\BeaconCommon::InDevelopment() || $workshop_item->ContainsString($this->confirmation_code)) {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('UPDATE ark.mods SET confirmed = TRUE WHERE mod_id = $1;', $this->mod_id);
			$database->Commit();
			$this->confirmed = true;
			return true;
		}
		
		return false;
	}
	
	public function Delete(): void {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ark.mods WHERE mod_id = $1;', $this->mod_id);
		$database->Commit();
	}
	
	public function jsonSerialize(): mixed {
		return [
			'mod_id' => $this->mod_id,
			'name' => $this->name,
			'console_safe' => $this->console_safe,
			'default_enabled' => $this->default_enabled,
			'workshop_id' => abs($this->workshop_id),
			'workshop_url' => \BeaconWorkshopItem::URLForModID($this->workshop_id),
			'confirmed' => $this->confirmed,
			'confirmation_code' => $this->confirmation_code,
			'resource_url' => '',
			'confirm_url' => '',
			'engrams_url' => '',
			'spawncodes_url' => \BeaconCommon::AbsoluteURL('/spawn/?mod_id=' . $this->workshop_id),
			'pull_url' => $this->pull_url,
			'min_version' => $this->min_version
		];
	}
}

?>
