<?php

abstract class BeaconAPI extends BeaconAPI\Core {
	public static function APIVersion() {
		return 'v2';
	}
	
	public static function UsesLegacyEncryption() {
		return false;
	}
}

?>
