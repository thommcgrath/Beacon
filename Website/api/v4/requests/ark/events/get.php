<?php

function handleRequest(array $context): Response {
	$event_id = $context['pathParameters']['event_id'];
	if (BeaconCommon::IsUUID($event_id)) {
		$event = Ark\Event::GetForUUID($event_id);
	} else {
		$event = Ark\Event::GetForArkCode($event_id);
	}
	BeaconAPI::ReplySuccess($event);
}

?>