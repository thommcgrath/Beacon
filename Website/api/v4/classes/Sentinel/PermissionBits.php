<?php

namespace BeaconAPI\v4\Sentinel;

abstract class PermissionBits {
	const ServiceRead = 1;
	const ServiceUpdate = 2;
	const ServiceDelete = 4;

	const ServiceGroupRead = 8;
	const ServiceGroupUpdate = 16;
	const ServiceGroupDelete = 32;
	const ServiceGroupUpdateContents = 64;
	const ServiceGroupUpdateUsers = 128;

	const ScriptRead = 256;
	const ScriptUpdate = 512;
	const ScriptDelete = 1024;
}

?>
