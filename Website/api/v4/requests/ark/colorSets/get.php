<?php

function handleRequest(array $context): APIResponse {
	$color_set_id = $context['pathParameters']['color_set_id'];
	$color_set = Ark\ColorSet::GetForUUID($color_set_id);
	BeaconAPI::ReplySuccess($color_set);
}

?>