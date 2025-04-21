<?php

namespace BeaconAPI\v4\Sentinel;

abstract class PermissionBits {
	const Membership = 1;
	const ControlServices = 2;
	const EditBuckets = 4;
	const EditGroup = 8;
	const EditScripts = 16;
	const EditServices = 32;
	const ManageBans = 64;
	const ManageBuckets = 128;
	const ManageScripts = 256;
	const ManageServices = 512;
	const ManageUsers = 1024;
	const ShareBuckets = 2048;
	const ShareScripts = 4096;
	const ShareServices = 8192;
}

?>
