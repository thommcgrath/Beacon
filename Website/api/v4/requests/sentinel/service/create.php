<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
	try {
		$service = Sentinel\Service::Create($user_id, BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($service);
	} catch (Exception $err) {
		BeaconAPI::ReplyError($err->getMessage(), null, 400);
	}
}

?>