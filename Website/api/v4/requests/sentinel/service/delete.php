<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
		
	$service = Sentinel\Service::GetByServiceID($context['pathParameters']['service_id']);
	if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionDelete)) {
		$service->Delete();
		BeaconAPI::ReplySuccess('', 204);
	} else {
		BeaconAPI::ReplyError('Service not found', null, 404);
	}
}

?>