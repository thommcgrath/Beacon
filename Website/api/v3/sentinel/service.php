<?php

require(dirname(__FILE__, 2) . '/loader.php');

BeaconAPI::Authorize(false);

$method = BeaconAPI::Method();
$object = BeaconAPI::ObjectID();
$user_id = BeaconAPI::UserID();
	
switch ($method) {
case 'GET':
	if ($object) {
		// Get a single service
		$service = Sentinel\Service::GetByServiceID($object);
		if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionView)) {
			BeaconAPI::ReplySuccess($service);
		} else {
			BeaconAPI::ReplyError('Service not found', null, 404);
		}
	} else {
		// List services
		$services = Sentinel\Service::GetUserServices($user_id, true);
		BeaconAPI::ReplySuccess($services);
	}
	break;
case 'POST':
	if ($object) {
		// Edit a single service
		$service = Sentinel\Service::GetByServiceID($object);
		if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionEdit)) {
			$service->Edit(BeaconAPI::JSONPayload());
			BeaconAPI::ReplySuccess($service);
		} else {
			BeaconAPI::ReplyError('Service not found', null, 404);
		}
	} else {
		// Create a service
		try {
			$service = Sentinel\Service::Create($user_id, BeaconAPI::JSONPayload());
			BeaconAPI::ReplySuccess($service);
		} catch (Exception $err) {
			BeaconAPI::ReplyError($err->getMessage(), null, 400);
		}
	}
	break;
case 'DELETE':
	if ($object) {
		// Delete a single service
		$service = Sentinel\Service::GetByServiceID($object);
		if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionDelete)) {
			$service->Delete();
			BeaconAPI::ReplySuccess('', 204);
		} else {
			BeaconAPI::ReplyError('Service not found', null, 404);
		}
	} else {
		BeaconAPI::ReplyError('Method not allowed', null, 405);
	}
	break;
default:
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

?>