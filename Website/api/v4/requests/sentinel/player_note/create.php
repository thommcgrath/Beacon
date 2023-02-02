<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
		
	try {
		$note = Sentinel\PlayerNote::Create($user_id, BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($note);
	} catch (Exception $err) {
		BeaconAPI::ReplyError($err->getMessage(), null, 400);
	}
}

?>