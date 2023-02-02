<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	
	$services = Sentinel\Service::GetUserServices($user_id, true);
	BeaconAPI::ReplySuccess($services);
}

?>