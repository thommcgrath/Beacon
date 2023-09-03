<?php

BeaconAPI::Authorize();

function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
	
	$services = Sentinel\Service::GetUserServices($user_id, true);
	BeaconAPI::ReplySuccess($services);
}

?>