<?php

function handle_request(array $context): void {
	$color_id = $context['path_parameters']['color_id'];
	$color = Ark\Color::GetForID($color_id);
	BeaconAPI::ReplySuccess($color);
}

?>