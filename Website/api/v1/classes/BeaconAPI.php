<?php

abstract class BeaconAPI extends BeaconAPI\Core {
	protected static $version = 1;
		
	public static function APIVersion() {
		return 'v' . self::$version;
	}
}

?>
