<?php

namespace BeaconAPI\Ark;

class Mod implements \JsonSerializable {
	protected $mod_id = '';
	protected $workshop_id = '';
	protected $name = '';
	protected $confirmed = false;
	protected $confirmation_code = '';
	protected $pull_url = null;
	protected $last_pull_hash = null;
	protected $console_safe = false;
	protected $default_enabled = false;
	protected $min_version = 0;
	
	public function ModID() {
		return $this->mod_id;
	}
	
	public function WorkshopID() {
		return $this->workshop_id;
	}
	
	public function Name() {
		return $this->name;
	}
	
	public function Confirmed() {
		return $this->confirmed;
	}
	
	public function ConfirmationCode() {
		return $this->confirmation_code;
	}
	
	public function PullURL() {
		return $this->pull_url;
	}
	
	public function LastPullHash() {
		return $this->last_pull_hash;
	}
	
	public function MinVersion() {
		return $this->min_version;
	}
	
	public function AttemptConfirmation() {
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
	
	public function Delete() {
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM ark.mods WHERE mod_id = $1;', $this->mod_id);
		$database->Commit();
	}
	
	protected static function GetFromResults(\BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$mods = array();
		while (!$results->EOF()) {
			$mod = self::GetFromResult($results);
			if ($mod !== null) {
				$mods[] = $mod;
			}
			$results->MoveNext();
		}
		return $mods;
	}
	
	protected static function GetFromResult(\BeaconRecordSet $results) {
		$mod = new static();
		$mod->mod_id = $results->Field('mod_id');
		$mod->workshop_id = $results->Field('workshop_id');
		$mod->name = $results->Field('name');
		$mod->confirmed = $results->Field('confirmed');
		$mod->confirmation_code = $results->Field('confirmation_code');
		$mod->pull_url = $results->Field('pull_url');
		$mod->last_pull_hash = $results->Field('last_pull_hash');
		$mod->console_safe = boolval($results->Field('console_safe'));
		$mod->default_enabled = boolval($results->Field('default_enabled'));
		$mod->min_version = intval($results->Field('min_version'));
		return $mod;
	}
	
	public static function GetByWorkshopID(string $user_id, string $workshop_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('user_id = $1 AND ABS(workshop_id) = ANY($2)'), $user_id, '{' . $workshop_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetByConfirmedWorkshopID(string $workshop_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('confirmed = TRUE AND ABS(workshop_id) = ANY($1)'), '{' . $workshop_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetByModID(string $mod_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('mod_id = $1'), $mod_id);
		$arr = self::GetFromResults($results);
		if (count($arr) == 1) {
			return $arr[0];
		}
	}
	
	public static function GetAll(string $user_id) {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('user_id = $1'), $user_id);
		return self::GetFromResults($results);
	}
	
	public static function GetLive($since = null) {
		$sql =  'ark.mods.confirmed = TRUE AND ark.mods.include_in_deltas = TRUE';
		
		$database = \BeaconCommon::Database();
		if (is_null($since)) {
			$results = $database->Query(self::BuildSQL($sql));
		} else {
			$results = $database->Query(self::BuildSQL($sql . ' AND last_update > $1'), $since->format('Y-m-d H:i:sO'));
		}
		return self::GetFromResults($results);
	}
	
	public static function GetPullMods() {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('confirmed = TRUE AND pull_url IS NOT NULL'));
		return self::GetFromResults($results);
	}
	
	public static function GetConfirmedMods() {
		$database = \BeaconCommon::Database();
		$results = $database->Query(self::BuildSQL('confirmed = TRUE AND workshop_id IS NOT NULL AND workshop_id > 0'));
		return self::GetFromResults($results);
	}
		
	protected static function BuildSQL(string $clause = '') {
		$sql = 'SELECT mod_id, workshop_id, name, confirmed, confirmation_code, pull_url, last_pull_hash, console_safe, default_enabled, min_version FROM ark.mods';
		if ($clause !== '') {
			$sql .= ' WHERE ' . $clause;
		}
		$sql .= ' ORDER BY name;';
		return $sql;
	}
	
	public function jsonSerialize() {
		return array(
			'mod_id' => $this->mod_id,
			'name' => $this->name,
			'console_safe' => $this->console_safe,
			'default_enabled' => $this->default_enabled,
			'workshop_id' => abs($this->workshop_id),
			'workshop_url' => \BeaconWorkshopItem::URLForModID($this->workshop_id),
			'confirmed' => $this->confirmed,
			'confirmation_code' => $this->confirmation_code,
			'resource_url' => \BeaconAPI::URL((\BeaconAPI::GetAPIVersion() >= 3 ? '/ark' : '') . '/mod/' . $this->workshop_id),
			'confirm_url' => \BeaconAPI::URL((\BeaconAPI::GetAPIVersion() >= 3 ? '/ark' : '') . '/mod/' . $this->workshop_id . '?action=confirm'),
			'engrams_url' => \BeaconAPI::URL((\BeaconAPI::GetAPIVersion() >= 3 ? '/ark' : '') . '/engram?mod_id=' . $this->workshop_id),
			'spawncodes_url' => \BeaconCommon::AbsoluteURL('/spawn/?mod_id=' . $this->workshop_id),
			'pull_url' => $this->pull_url,
			'min_version' => $this->min_version
		);
	}
}

?>