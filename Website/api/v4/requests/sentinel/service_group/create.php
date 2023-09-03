<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
		
	try {
		$group = Sentinel\ServiceGroup::Create($user_id, BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($group);
	} catch (Exception $err) {
		BeaconAPI::ReplyError($err->getMessage(), null, 400);
	}
}

?>