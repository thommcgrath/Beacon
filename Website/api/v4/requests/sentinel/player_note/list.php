<?php

BeaconAPI::Authorize();

function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
	
	$notes = Sentinel\PlayerNote::Search($_GET);
	BeaconAPI::ReplySuccess($notes);
}

?>