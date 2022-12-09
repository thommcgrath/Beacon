<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
	try {
		$group = Sentinel\ServiceGroup::Create($user_id, BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($group);
	} catch (Exception $err) {
		BeaconAPI::ReplyError($err->getMessage(), null, 400);
	}
}

?>