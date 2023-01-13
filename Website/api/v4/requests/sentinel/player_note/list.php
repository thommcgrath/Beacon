<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	
	$notes = Sentinel\PlayerNote::Search($_GET);
	BeaconAPI::ReplySuccess($notes);
}

?>