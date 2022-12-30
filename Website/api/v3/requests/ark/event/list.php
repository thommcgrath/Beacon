<?php

function handle_request(array $context): void {
	$events = Ark\Event::GetAll();
	BeaconAPI::ReplySuccess($events);
}

?>