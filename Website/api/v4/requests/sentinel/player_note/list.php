<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	
	$notes = Sentinel\PlayerNote::Search($_GET);
	BeaconAPI::ReplySuccess($notes);
}

?>