<?php

abstract class BeaconAPI extends \BeaconAPI\Core {
	protected static $version = 3;
	
	public static function APIVersion() {
		return 'v' . self::$version;
	}
	
	public static function UsesLegacyEncryption() {
		return false;
	}
	
	public static function Deletions(int $min_version = -1, \DateTime $since = null) {
		if ($since === null) {
			$since = new \DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = \BeaconCommon::MinVersion();
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT object_id, game_id, from_table, label, tag FROM public.deletions WHERE min_version <= $1 AND action_time > $2;', $min_version, $since->format('Y-m-d H:i:sO'));
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = [
				'object_id' => $results->Field('object_id'),
				'game' => $results->Field('game_id'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label'),
				'tag' => $results->Field('tag')
			];
			$results->MoveNext();
		}
		return $arr;
	}
}

?>
