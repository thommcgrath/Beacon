<?php

function handleRequest(array $context): Response {
	$color_id = $context['pathParameters']['color_id'];
	$color = Ark\Color::GetForID($color_id);
	BeaconAPI::ReplySuccess($color);
}

?>