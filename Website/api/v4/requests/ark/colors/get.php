<?php

function handleRequest(array $context): APIResponse {
	$color_id = $context['pathParameters']['color_id'];
	$color = Ark\Color::GetForID($color_id);
	BeaconAPI::ReplySuccess($color);
}

?>