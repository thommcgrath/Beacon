<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
	$service = Sentinel\Service::GetByServiceID($context['path_parameters']['service_id']);
	if ($service && $service->HasPermission($user_id, Sentinel\Service::PermissionEdit)) {
		$service->Edit(BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($service);
	} else {
		BeaconAPI::ReplyError('Service not found', null, 404);
	}
}

?>