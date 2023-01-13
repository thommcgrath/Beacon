<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	
	$services = Sentinel\Service::GetUserServices($user_id, true);
	BeaconAPI::ReplySuccess($services);
}

?>