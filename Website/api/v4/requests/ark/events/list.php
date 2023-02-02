<?php

function handleRequest(array $context): APIResponse {
	$events = Ark\Event::GetAll();
	BeaconAPI::ReplySuccess($events);
}

?>