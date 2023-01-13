<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	
	$groups = Sentinel\ServiceGroup::GetForUserID($user_id);
	BeaconAPI::ReplySuccess($groups);
}

?>