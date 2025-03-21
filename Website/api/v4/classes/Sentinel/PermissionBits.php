<?php

namespace BeaconAPI\v4\Sentinel;

abstract class PermissionBits {
	const ControlServices = 1;
	const EditBuckets = 2;
	const EditGroup = 4;
	const EditScripts = 8;
	const EditServices = 16;
	const ManageBans = 32;
	const ManageBuckets = 64;
	const ManageScripts = 128;
	const ManageServices = 256;
	const ManageUsers = 512;
	const ShareBuckets = 1024;
	const ShareScripts = 2048;
	const ShareServices = 4096;
}

?>
