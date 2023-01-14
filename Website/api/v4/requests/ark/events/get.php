<?php

function handle_request(array $context): void {
	$event_id = $context['path_parameters']['event_id'];
	if (BeaconCommon::IsUUID($event_id)) {
		$event = Ark\Event::GetForUUID($event_id);
	} else {
		$event = Ark\Event::GetForArkCode($event_id);
	}
	BeaconAPI::ReplySuccess($event);
}

?>