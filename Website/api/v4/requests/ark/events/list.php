<?php

function handleRequest(array $context): Response {
	$events = Ark\Event::GetAll();
	BeaconAPI::ReplySuccess($events);
}

?>