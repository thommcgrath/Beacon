<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
		
	$service = Sentinel\Service::GetByServiceID($context['pathParameters']['service_id']);
	if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionView)) {
		BeaconAPI::ReplySuccess($service);
	} else {
		BeaconAPI::ReplyError('Service not found', null, 404);
	}
}

?>