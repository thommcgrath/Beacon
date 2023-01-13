<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
	$service = Sentinel\Service::GetByServiceID($context['path_parameters']['service_id']);
	if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionDelete)) {
		$service->Delete();
		BeaconAPI::ReplySuccess('', 204);
	} else {
		BeaconAPI::ReplyError('Service not found', null, 404);
	}
}

?>