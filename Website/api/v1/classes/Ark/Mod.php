<?php

namespace Ark;

class Mod extends \BeaconAPI\Ark\Mod {
	public static function GetByWorkshopID(string $user_id, string $workshop_id): array {
		return static::Search([
			'user_id' => $user_id,
			'workshop_id' => $workshop_id
		], true);
	}
	
	public static function GetByConfirmedWorkshopID(string $workshop_id): array {
		return static::Search([
			'confirmed' => true,
			'workshop_id' => $workshop_id
		], true);
	}
	
	public static function GetByModID(string $mod_id): ?Mod {
		return static::Fetch($mod_id);
	}
	
	public static function GetAll(string $user_id): array {
		return static::Search(['user_id' => $user_id], true);
	}
	
	public static function GetForUserId(string $user_id): array {
		return static::Search([
			'user_id' => $user_id
		], true);
	}
	
	public static function GetOfficial(): array {
		return static::Search([
			'is_official' => true
		], true);
	}
	
	public static function GetLive(?string $since = null): array {
		$filters = [
			'confirmed' => true,
			'include_in_deltas' => true
		];
		if (is_null($since) !== true) {
			$filters['last_update'] = $since;
		}
		return static::Search($filters, true);
	}
	
	public static function GetPullMods(): array {
		return static::Search([
			'pull_url' => 'pull'
		], true);
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('mod/' . $this->workshop_id);
		$json['confirm_url'] = \BeaconAPI::URL('mod/' . $this->workshop_id . '?action=confirm');
		$json['engrams_url'] = \BeaconAPI::URL('engram?mod_id=' . $this->workshop_id);
		return $json;
	}
}

?>
