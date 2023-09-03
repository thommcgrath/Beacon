<?php

BeaconAPI::Authorize();

function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
	
	$groups = Sentinel\ServiceGroup::GetForUserID($user_id);
	BeaconAPI::ReplySuccess($groups);
}

?>