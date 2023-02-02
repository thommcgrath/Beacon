<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	
	$groups = Sentinel\ServiceGroup::GetForUserID($user_id);
	BeaconAPI::ReplySuccess($groups);
}

?>