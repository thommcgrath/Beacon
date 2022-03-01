<?php

abstract class BeaconAPI extends \BeaconAPI\Core {
	protected static $version = 3;
	
	public static function APIVersion() {
		return 'v' . self::$version;
	}
	
	public static function SetAPIVersion(int $version) {
		self::$version = $version;
	}
	
	public static function GetAPIVersion() {
		return self::$version;
	}
	
	public static function UsesLegacyEncryption() {
		return false;
	}
}

?>
