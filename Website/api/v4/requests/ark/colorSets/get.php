<?php

function handle_request(array $context): void {
	$color_set_id = $context['path_parameters']['color_set_id'];
	$color_set = Ark\ColorSet::GetForUUID($color_set_id);
	BeaconAPI::ReplySuccess($color_set);
}

?>