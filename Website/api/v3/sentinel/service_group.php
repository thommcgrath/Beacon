<?php

require(dirname(__FILE__, 2) . '/loader.php');

BeaconAPI::Authorize(false);

$method = BeaconAPI::Method();
$object = BeaconAPI::ObjectID();
$user_id = BeaconAPI::UserID();
	
switch ($method) {
case 'GET':
	if ($object) {
		// Get a single group
		$group = Sentinel\ServiceGroup::GetByGroupID($object);
		if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionView)) {
			BeaconAPI::ReplySuccess($group);
		} else {
			BeaconAPI::ReplyError('Service group not found', null, 404);
		}
	} else {
		// List groups
		$groups = Sentinel\ServiceGroup::GetForUserID($user_id);
		BeaconAPI::ReplySuccess($groups);
	}
	break;
case 'POST':
	if ($object) {
		// Edit a single group
		$group = Sentinel\ServiceGroup::GetByGroupID($object);
		if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionEdit)) {
			$group->Edit(BeaconAPI::JSONPayload());
			BeaconAPI::ReplySuccess($group);
		} else {
			BeaconAPI::ReplyError('Service group not found', null, 404);
		}
	} else {
		// Create a group
		try {
			$group = Sentinel\ServiceGroup::Create($user_id, BeaconAPI::JSONPayload());
			BeaconAPI::ReplySuccess($group);
		} catch (Exception $err) {
			BeaconAPI::ReplyError($err->getMessage(), null, 400);
		}
	}
	break;
case 'DELETE':
	if ($object) {
		// Delete a single group
		$group = Sentinel\ServiceGroup::GetByGroupID($object);
		if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionDelete)) {
			$group->Delete();
			BeaconAPI::ReplySuccess('', 204);
		} else {
			BeaconAPI::ReplyError('Service group not found', null, 404);
		}
	} else {
		BeaconAPI::ReplyError('Method not allowed', null, 405);
	}
	break;
default:
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

?>